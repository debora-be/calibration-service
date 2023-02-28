defmodule ElixirInterviewStarter do

  alias ElixirInterviewStarter.CalibrationSessions.CalibrationSessionManager, as: Manager

  defdelegate start(user_email),
  to: Manager,
  as: :start

  defdelegate start_precheck_2(user_email),
  to: Manager,
  as: :start_precheck_2

  defdelegate get_current_session(),
  to: Manager,
  as: :get_current_session
end
