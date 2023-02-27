defmodule ElixirInterviewStarterTest do
  use ExUnit.Case
  use ExMachina

  alias ElixirInterviewStarter
  alias ElixirInterviewStarter.{CalibrationSession, Factory}
  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession

  @user_email "test@example.com"

  describe "start/1" do
    test "creates a new calibration session and starts precheck 1" do
      assert {:ok, session_id} = ElixirInterviewStarter.start_link(CalibrationSession)

      expected_response =
        Factory.build(:calibration_session,
          user_email: @user_email,
          session_id: session_id,
          user_has_ongoing_calibration_session: false,
          precheck_1_succeeded: false
        )

      response =
        CreateCurrentUserSession.process(%{
          user_email: @user_email,
          session_id: session_id,
          user_has_ongoing_calibration_session: false,
          precheck_1_succeeded: false
        })

      assert response == expected_response
    end

    test "returns an error if the CalibrationSession cannot be created" do
      assert {:ok, session_id} = ElixirInterviewStarter.start_link(CalibrationSession)

      expected_response = {:error, "The session for test@example.com was not created"}

      response =
        CreateCurrentUserSession.process(%{
          user_email: @user_email,
          session_id: session_id,
          user_has_ongoing_calibration_session: true,
          precheck_1_succeeded: false
        })

      assert expected_response = response
    end
  end
end
