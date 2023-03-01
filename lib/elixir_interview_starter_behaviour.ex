defmodule ElixirInterviewStarterBehaviour do
  @moduledoc """
  This is the behaviour that the ElixirInterviewStarter module must implement.
  """

  @callback start(user_email :: String.t()) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback start_precheck_2(user_email :: String.t()) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback get_current_session() ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}
end
