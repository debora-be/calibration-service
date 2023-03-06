defmodule ElixirInterviewStarter.Operational.Calibrate do
  @moduledoc """
  After all the prechecks are done, does the calibration process.
  """

  alias ElixirInterviewStarter.CalibrationSessions.UpdateCurrentUserSession, as: UpdateSession
  alias ElixirInterviewStarter.DeviceMessages
  alias ElixirInterviewStarter.Operational.Server

  @calibration_message "calibrate"

  @spec process(struct()) :: {:ok, struct()}
  @doc """
  After all the prechecks are done, the calibration process is started.
  """
  def process(prechecked_calibration_session) do
    prechecked_calibration_session = %{
      user_email: prechecked_calibration_session.user_email,
      session_id: prechecked_calibration_session.session_id,
      user_has_ongoing_calibration_session: true,
      precheck_1_message: "startPrecheck1",
      precheck_1_succeeded: true,
      user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
      precheck_2_message: "startPrecheck2",
      precheck_2_succeeded: true,
      user_has_ongoing_calibration_session_that_just_finished_precheck_2: true,
      calibration_message: @calibration_message,
      calibration_succeeded: true
    }

    DeviceMessages.send(
      prechecked_calibration_session.user_email,
      @calibration_message
    )

    complete_calibration_session =
      prechecked_calibration_session
      |> UpdateSession.process()
      |> Server.calibrate()

    {:ok, complete_calibration_session}
  end
end
