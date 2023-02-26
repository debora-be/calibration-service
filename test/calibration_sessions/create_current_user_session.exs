defmodule ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSessionTest do
  use ExUnit.Case

  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession

  describe "process/1" do
    test "creates the CalibrationSession for the provided data" do
      user_email = "test@example.com"
      session_id = "session_123"
      expected_response = %{
        user_email: user_email,
        session_id: session_id,
        user_has_ongoing_calibration_session: false,
        precheck_1_succeeded: true,
        user_has_ongoing_calibration_session_that_just_finished_precheck1: true,
        precheck_2_succeeded: true,
        calibration_succeeded: true
      }

      response = CreateCurrentUserSession.process(user_email, session_id)

      assert response == expected_response
    end


end
