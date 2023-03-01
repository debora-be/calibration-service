defmodule ElixirInterviewStarterBehaviour do
  @callback start(user_email :: String.t()) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback start_precheck_2(user_email :: String.t()) ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}

  @callback get_current_session() ::
              {:ok, CalibrationSession.t()} | {:error, String.t()}
end
