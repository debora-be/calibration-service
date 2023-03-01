defmodule ElixirInterviewStarter do
  alias ElixirInterviewStarter.Operational.CalibrationSessionManager, as: Manager

  @behaviour ElixirInterviewStarterBehaviour

  @impl ElixirInterviewStarterBehaviour
  defdelegate start(user_email),
    to: Manager,
    as: :start

  @impl ElixirInterviewStarterBehaviour
  defdelegate start_precheck_2(user_email),
    to: Manager,
    as: :start_precheck_2

  @impl ElixirInterviewStarterBehaviour
  defdelegate get_current_session(),
    to: Manager,
    as: :get_current_session
end
