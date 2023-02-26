defmodule ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession do
  @moduledoc """
   Creates a new `CalibrationSession` for the provided user.
  """

  alias ElixirInterviewStarter.CalibrationSession

  @doc """
  Saves the given data in the struct.
  """
  def process(user_email, session_id) do
    %CalibrationSession{
      user_email: user_email,
      session_id: session_id,
      user_has_ongoing_calibration_session: false,
      precheck_1_succeeded: true,
      user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
      precheck_2_succeeded: true,
      calibration_succeeded: true
    }
  end
end
