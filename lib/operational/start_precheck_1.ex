defmodule ElixirInterviewStarter.Operational.StartPrecheck1 do
  @moduledoc """
  Starts the precheck_1 step of the ongoing `CalibrationSession` for the provided user.
  """

  alias ElixirInterviewStarter.CalibrationSession
  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession
  alias ElixirInterviewStarter.DeviceMessages

  alias ElixirInterviewStarter.Operational.{CalibrationSessionManager, Server}

  @type user_email :: String.t()

  @precheck_1_message "startPrecheck1"

  @spec process(user_email) :: {:ok, String.t()} | {:error, String.t()}
  @doc """
  Starts the precheck_1 step of the ongoing `CalibrationSession` for the provided user.
  If the user has already an ongoing `CalibrationSession`, the `CalibrationSession` cannot continue.
  """
  def process(user_email) do
    with {:ok, pid} = Server.start_link(%CalibrationSession{}),
         false <- CalibrationSessionManager.user_has_ongoing_calibration_session?(user_email) do
      initial_data = %{
        user_email: user_email,
        session_id: pid,
        user_has_ongoing_calibration_session: false,
        precheck_1_message: @precheck_1_message,
        precheck_1_succeeded: true
      }

      DeviceMessages.send(user_email, @precheck_1_message)

      initial_data
      |> CreateCurrentUserSession.process()
      |> Server.precheck()

      {:ok, "Precheck_1 realized"}
    else
      _ -> {:error, "The Precheck_1 could not be completed; please restart the device"}
    end
  end
end
