defmodule ElixirInterviewStarter.Operational.CalibrationSessionManagerTest do
  use ExMachina
  use ExUnit.Case

  import Mox

  alias ElixirInterviewStarter.Operational.GenServer
  alias ElixirInterviewStarter
  alias ElixirInterviewStarter.Factory

  @user_email "test@example.com"

  describe "start/1" do
    test "creates a new calibration session and starts precheck_1" do
      expect(ElixirInterviewStarter, :start, fn user_email ->
        user_email == @user_email

        calibration_session =
          {:ok,
           Factory.build(:calibration_session,
             user_email: @user_email,
             session_id: self()
           )}
      end)

      assert {:ok, calibration_session} = ElixirInterviewStarter.start(@user_email)
    end

    test "returns an error if there's already a session going on for the current user" do
      expect(ElixirInterviewStarter, :start, fn user_email ->
        user_email == @user_email

        {:error,
         "The session for email was not created - another session has already been started for this user"}
      end)

      assert {:error, _} = ElixirInterviewStarter.start(@user_email)
    end
  end
end
