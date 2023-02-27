defmodule ElixirInterviewStarter.CalibrationSessions.UpdateCurrentUserSession do
  @moduledoc """
   Updates the current `CalibrationSession` for the provided user.
  """

  alias ElixirInterviewStarter.CalibrationSession

  @doc """
  Saves the given data in the struct.
  """
  def process(%{
        user_email: user_email,
        session_id: session_id,
        user_has_ongoing_calibration_session: user_has_ongoing_calibration_session,
        precheck_1_succeeded: precheck_1_succeeded,
        user_has_ongoing_calibration_session_that_just_finished_precheck1:
          user_has_ongoing_calibration_session_that_just_finished_precheck1,
        precheck_2_succeeded: precheck_2_succeeded,
        calibration_succeeded: calibration_succeeded
      }) do
    %CalibrationSession{
      user_email: user_email,
      session_id: session_id,
      user_has_ongoing_calibration_session: user_has_ongoing_calibration_session,
      precheck_1_succeeded: precheck_1_succeeded,
      user_has_ongoing_calibration_session_that_just_finished_precheck1:
        user_has_ongoing_calibration_session_that_just_finished_precheck1,
      precheck_2_succeeded: precheck_2_succeeded,
      calibration_succeeded: calibration_succeeded
    }
  end
end
