defmodule ElixirInterviewStarter.Operational.StartPrecheck1 do
  @moduledoc """
  Starts the precheck_1 step of the ongoing `CalibrationSession` for the provided user.
  """

  alias ElixirInterviewStarter.CalibrationSession
  alias ElixirInterviewStarter.DeviceMessages

  alias ElixirInterviewStarter.Operational.{BringTogether, CalibrationSessionManager, Server}

  @type user_email :: String.t()

  @precheck_1_message "startPrecheck1"

  @spec process(user_email) :: {:ok, struct()} | map()
  @doc """
  Starts the precheck_1 step of the ongoing `CalibrationSession` for the provided user.
  If the user has already an ongoing `CalibrationSession`, the `CalibrationSession` cannot continue.
  """
  def process(user_email) do
    with {:ok, pid} = Server.start_link(%CalibrationSession{}),
         false <- CalibrationSessionManager.user_has_ongoing_calibration_session?(user_email) do
      DeviceMessages.send(user_email, @precheck_1_message)

      initial_calibration_session =
        %CalibrationSession{}
        |> BringTogether.process(%{
          user_email: user_email,
          session_id: pid,
          user_has_ongoing_calibration_session: false,
          precheck_1_message: @precheck_1_message,
          precheck_1_succeeded: true
        })

      {:ok, initial_calibration_session}
    else
      _ -> %{"precheck1" => false}
    end
  end
end
