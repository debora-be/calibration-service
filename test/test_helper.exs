ExUnit.start()

{:ok, _} = Application.ensure_all_started(:ex_machina)
Application.ensure_all_started(:mox)

Mox.defmock(ElixirInterviewStarter,
  for: ElixirInterviewStarterBehaviour
)

# Application.put_env(
#   :elixir_interview_starter,
#   :start,
#   ElixirInterviewStarterMock
# )
