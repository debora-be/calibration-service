defmodule ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSessionTest do
  use ExUnit.Case
  use ExMachina

  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession

  describe "process/1" do
    test "creates the CalibrationSession for the provided data" do
      user_email = "test@example.com"
      session_id = "session_123"
    end
      expected_response =  Factory.params_for(:calibration_session,
      user_email: user_email,
      session_id: session_id
    )

      response = CreateCurrentUserSession.process(user_email, session_id)

      assert response == expected_response
    end
end
