defmodule ElixirInterviewStarterBehaviour do
  @moduledoc """
  This is the behaviour that the ElixirInterviewStarter module must implement.
  """

  @type user_email :: String.t()

  @callback start(user_email) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback start_precheck_2(user_email) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback get_current_session(user_email) ::
              {:ok, CalibrationSession.t()} | nil
end
