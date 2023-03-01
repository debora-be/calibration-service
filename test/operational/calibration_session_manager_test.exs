defmodule ElixirInterviewStarter.Operational.CalibrationSessionManagerTest do
  use ExUnit.Case
  use ExMachina

  import Mox

  alias ElixirInterviewStarter
  alias ElixirInterviewStarter.{CalibrationSession, Factory}
  alias ElixirInterviewStarter.CalibrationSessions.CreateCurrentUserSession

  alias ElixirInterviewStarter.Operational.CalibrationSessionManager

  alias ElixirInterviewStarter.Operational.GenServer

  @user_email "test@example.com"

  describe "start/1" do
    test "returns an error if there's already a session going on for the current user" do
      expect(ElixirInterviewStarter, :start, fn session_id ->
        assert session_id == self()

        {:error,
          "The session for email was not created - another session has already been started for this user"}
      end)

      assert {:error, _} = ElixirInterviewStarter.start(@user_email)
    end
  end

  # describe "start/1" do
  #   # test "creates a new calibration session and starts precheck 1" do
  #   #   expected_response =
  #   #     Factory.build(:calibration_session,
  #   #       user_email: @user_email,
  #   #       session_id: self()
  #   #     )

  #   #   response = ElixirInterviewStarter.start(@email)

  #   #   assert response == expected_response
  #   # end

  #   # test "returns an error if the CalibrationSession cannot be created" do

  #   #   expected_response = {:error, "The session for test@example.com was not created"}

  #   #   response = CalibrationSession.start(@email)

  #   #   assert expected_response == response
  #   # end

  #   test "returns an error if there's already a session going on for the current user" do
  #     expect(ElixirInterviewStarterMock, :start, fn session_id ->

  #     assert session_id == self()

  #     {:error,
  #       "The session for email was not created - another session has already been started for this user"}
  #   end)


  #     assert {:error, _} = ElixirInterviewStarter.start(@user_email)


  #     # expected_response_1 =
  #     #   Factory.build(:calibration_session,
  #     #     user_email: @user_email,
  #     #     session_id: self()
  #     #   )

  #     # response_1 = ElixirInterviewStarter.start(@user_email)
  #     # response_2 = ElixirInterviewStarter.start(@user_email)
  #     # assert response_1 == {:ok, expected_response_1}
  #     # assert response_2 == expected_response_2
  #   end
  # end
end
