defmodule ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSessionTest do
  use ExUnit.Case
  use ExMachina

  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession
  alias ElixirInterviewStarter.Factory

  describe "process/1" do
    test "creates the CalibrationSession for the provided data" do
      user_email = "test@example.com"
      session_id = "session_123"

      expected_response =
        Factory.build(:calibration_session,
          user_email: user_email,
          session_id: session_id
        )

      response =
        CreateCurrentUserSession.process(%{
          user_email: user_email,
          session_id: session_id,
          user_has_ongoing_calibration_session: nil,
          precheck_1_message: nil,
          precheck_1_succeeded: nil
        })

      assert response == expected_response
    end
  end
end
