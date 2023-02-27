defmodule ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession do
  @moduledoc """
   Creates a new `CalibrationSession` for the provided user.
  """

  alias ElixirInterviewStarter.CalibrationSession

  @doc """
  Saves the given data in the struct.
  """
  def process(%{
        user_email: user_email,
        session_id: session_id,
        user_has_ongoing_calibration_session: user_has_ongoing_calibration_session,
        precheck_1_succeeded: precheck_1_succeeded
      }) do
    %CalibrationSession{
      user_email: user_email,
      session_id: session_id,
      user_has_ongoing_calibration_session: user_has_ongoing_calibration_session,
      precheck_1_succeeded: precheck_1_succeeded
    }
  end
end
