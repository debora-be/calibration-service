defmodule ElixirInterviewStarter.Operational.CalibrationSessionManager do
  @moduledoc """
  See `README.md` for instructions on how to approach this technical challenge.
  """
  alias ElixirInterviewStarter.CalibrationSession

  alias ElixirInterviewStarter.CalibrationSessions.{
    CreateCurrentUserSession,
    UpdateCurrentUserSession
  }

  alias ElixirInterviewStarter.DeviceMessages

  alias ElixirInterviewStarter.Operational.GenServer

  # @callback start(user_email :: String.t()) :: {:ok, CalibrationSession.t()} | {:error, String.t()}
  @doc """
  Creates a new `CalibrationSession` for the provided user, starts a `GenServer` process
  for the session, and starts precheck 1.

  If the user already has an ongoing `CalibrationSession`, returns an error.

  When precheck_1 is ready, the `GenServer` process will receive a message and update the data from `CalibrationSession`.
  """
  def start(user_email) do
    elixir_interview_starter_impl()
    with {:ok, session_id} <- GenServer.start_link(),
         false <- user_has_ongoing_calibration_session?(user_email),
         %{"precheck1" => true} <- start_precheck_1(user_email) do
      initial_calibration_session =
        CreateCurrentUserSession.process(%{
          user_email: user_email,
          session_id: session_id,
          user_has_ongoing_calibration_session: false,
          precheck_1_succeeded: false
        })

      send(self(), {:update_struct, initial_calibration_session})

      updated_calibration_session =
        receive_message_from_initial_calibration_session(initial_calibration_session)

      {:ok, updated_calibration_session}
    else
      _ ->
        {:error,
         "The session for #{user_email} was not created - another session has already been started for this user"}
    end
  end

  @spec receive_message_from_initial_calibration_session(initial_calibration_session :: Map.t()) ::
          Map.t()
  @doc """
  Send and receive the message from the `GenServer` process; if is everything ok,
  updates the struct with the final data from precheck_1.
  """
  def receive_message_from_initial_calibration_session(session) do
    case send(self(), {:update_struct, session}) do
      {:update_struct, session} ->
        Map.merge(session, %{
          user_has_ongoing_calibration_session: true,
          precheck_1_succeeded: true
        })

      _ ->
        {:error, "There is no message for this device"}
    end
  end

  @spec start_precheck_1(user_email :: String.t()) :: Map.t() | Map.t()
  @doc """
  Starts the precheck 1 step of the ongoing `CalibrationSession` for the provided user.
  If the user has already an ongoing `CalibrationSession`, the `CalibrationSession` cannot continue.
  """
  def start_precheck_1(user_email) do
    send(self(), {:update_struct, "startPrecheck1"})
    {processing_time, _} = :timer.tc(fn -> DeviceMessages.send(user_email, "startPrecheck1") end)

    if processing_time < 30_000 do
      %{"precheck1" => true}
    else
      %{"precheck1" => false}
    end
  end

  @callback start_precheck_2(user_email :: String.t()) ::
              {:ok, map()} | {:error, String.t()}
  @doc """
  Starts the precheck 2 step of the ongoing `CalibrationSession` for the provided user.

  If the user has no ongoing `CalibrationSession`, their `CalibrationSession` is not done
  with precheck 1, or their calibration session has already completed precheck 2, returns
  an error.
  """
  def start_precheck_2(user_email) do
    case user_has_ongoing_calibration_session_that_just_finished_precheck1?() do
      true ->
        send(self(), {:update_struct, "startPrecheck2"})

        {processing_time, _} =
          :timer.tc(fn -> DeviceMessages.send(user_email, "startPrecheck2") end)

        if processing_time < 30_000 do
          checked_calibration_session =
            UpdateCurrentUserSession.process(%{
              user_email: user_email,
              session_id: self(),
              user_has_ongoing_calibration_session: true,
              precheck_1_succeeded: true,
              user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
              precheck_2_succeeded: true,
              calibration_succeeded: false
            })

          send(self(), {:update_struct, checked_calibration_session})

          {:ok, complete_calibration_session} = start_calibration(user_email)

          {:ok, complete_calibration_session}
        else
          {:error,
           "Please verify if the cartridge is inserted and the device is submerged in water and restart the process"}
        end

      false ->
        {:error,
         "The user #{user_email} has no ongoing calibration session, please restart the process"}
    end
  end

  @spec start_calibration(user_email :: String.t()) :: map()
  @doc """
  After all the prechecks are done, the calibration session is started.
  """
  def start_calibration(user_email) do
    {processing_time, _} = :timer.tc(fn -> DeviceMessages.send(user_email, "calibrate") end)

    if processing_time < 100_000 do
      send(self(), {:update_struct, %{"calibrated" => true}})

      complete_calibration_session =
        UpdateCurrentUserSession.process(%{
          user_email: user_email,
          session_id: self(),
          user_has_ongoing_calibration_session: true,
          precheck_1_succeeded: true,
          user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
          precheck_2_succeeded: true,
          calibration_succeeded: true
        })

      send(self(), {:update_struct, complete_calibration_session})

      {:ok, complete_calibration_session}
    else
      %{"calibrated" => false}
    end
  end

  @doc """
  Retrieves the ongoing `CalibrationSession` for the provided user, if they have one.
  """
  def get_current_session do
    session = Process.get()
    calibration_session = Enum.fetch(session, 1)

    {:ok, calibration_session}
  end

  @doc """
  Returns `true` if the user has an ongoing `CalibrationSession`, `false` otherwise.
  """
  def user_has_ongoing_calibration_session?(user_email) do
    user_email in Process.list()
  end

  @doc """
  Returns `true` if the user has an ongoing `CalibrationSession` that just finished precheck 1, `false` otherwise.
  """
  def user_has_ongoing_calibration_session_that_just_finished_precheck1? do
    self() in Process.list()
  end

  defp elixir_interview_starter_impl() do
    Application.get_env(
      :elixir_interview_starter,
      ElixirInterviewStarter
    )
  end
end
