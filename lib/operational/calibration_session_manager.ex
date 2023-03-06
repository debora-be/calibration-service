defmodule ElixirInterviewStarter.Operational.CalibrationSessionManager do
  @moduledoc """
  This module is responsible for managing the state of the `CalibrationSession` for a given user.
  """

  alias ElixirInterviewStarter.CalibrationSession
  alias ElixirInterviewStarter.CalibrationSessions.UpdateCurrentUserSession, as: UpdateSession
  alias ElixirInterviewStarter.DeviceMessages
  alias ElixirInterviewStarter.Operational.{Calibrate, Server, StartPrecheck1}

  @behaviour ElixirInterviewStarterBehaviour

  @type user_email :: String.t()

  @precheck_2_message "startPrecheck2"

  @spec start(user_email) :: {:ok, struct()} | {:error, String.t()}
  @doc """
  Creates a new `CalibrationSession` for the provided user, starts a `GenServer` process
  for the session, and starts precheck 1.

  If the user already has an ongoing `CalibrationSession`, returns an error.

  When precheck_1 is ready, the `GenServer` process will receive a message and update the data from `CalibrationSession`.
  """
  def start(user_email) do
    elixir_interview_starter_impl()

    case StartPrecheck1.process(user_email) do
      {:ok, "Precheck_1 realized"} ->
        get_current_session(user_email)

      {:error, _} ->
        {:error,
         "The session for #{user_email} was not created - another session has already been started for this user"}
    end
  end

  # @spec start_precheck_2(user_email) :: {:ok, %CalibrationSession{}} | {:error, String.t()}
  @doc """
  Starts the precheck 2 step of the ongoing `CalibrationSession` for the provided user.

  If the user has no ongoing `CalibrationSession`, their `CalibrationSession` is not done
  with precheck 1, or their calibration session has already completed precheck 2, returns
  an error.
  """
  def start_precheck_2(user_email) do
    case get_current_session(user_email) do
      {:ok,
       %CalibrationSession{
         session_id: pid,
         precheck_1_succeeded: true,
         precheck_2_succeeded: nil
       }} ->
        calibration_session = %{
          user_email: user_email,
          session_id: pid,
          user_has_ongoing_calibration_session: true,
          precheck_1_message: "startPrecheck1",
          precheck_1_succeeded: true,
          user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
          precheck_2_message: @precheck_2_message,
          precheck_2_succeeded: true,
          user_has_ongoing_calibration_session_that_just_finished_precheck_2: nil,
          calibration_message: nil,
          calibration_succeeded: nil
        }

        DeviceMessages.send(user_email, @precheck_2_message)

        calibration_session
        |> UpdateSession.process()
        |> Server.precheck()
        |> Calibrate.process()

      nil ->
        {:error,
         "The user #{user_email} has no ongoing calibration session, please restart the process"}

      _ ->
        {:error,
         "The user #{user_email} has an ongoing calibration session, but it is not ready for starting the Calibration, please restart the Device"}
    end
  end

  @spec get_current_session(user_email) :: {:ok, struct()} | nil
  @doc """
  Retrieves the ongoing `CalibrationSession` for the provided user_email, if they have one.
  """
  def get_current_session(user_email) do
    case Server.get() do
      current_session = %CalibrationSession{
        user_email: ^user_email
      } ->
        {:ok, current_session}

      _ ->
        nil
    end
  end

  @spec user_has_ongoing_calibration_session?(user_email) :: boolean()
  @doc """
  Returns `true` if the user has an ongoing `CalibrationSession`, `false` otherwise.
  """
  def user_has_ongoing_calibration_session?(user_email) do
    case get_current_session(user_email) do
      {:ok, %CalibrationSession{precheck_1_succeeded: true}} ->
        true

      _ ->
        false
    end
  end

  defp elixir_interview_starter_impl() do
    Application.get_env(
      :elixir_interview_starter,
      ElixirInterviewStarter
    )
  end
end
