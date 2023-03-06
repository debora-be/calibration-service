defmodule ElixirInterviewStarter.Operational.Calibrate do
  @moduledoc """
  After all the prechecks are done, does the calibration process.
  """

  alias ElixirInterviewStarter.CalibrationSession

  alias ElixirInterviewStarter.DeviceMessages

  alias ElixirInterviewStarter.Operational.Server

  @calibration_message "calibrate"

  @spec process(map()) :: {:ok, %CalibrationSession{}} | {:error, String.t()}
  @doc """
  After all the prechecks are done, the calibration process is started.
  """
  def process(prechecked_calibration_session) do
    DeviceMessages.send(
      prechecked_calibration_session.user_email,
      @calibration_message
    )

    complete_calibration_session =
      prechecked_calibration_session
      |> Map.merge(%{
        calibration_message: @calibration_message,
        calibration_succeeded: true
      })
      |> Server.calibrate()

    {:ok, complete_calibration_session}
  end
end
