ExUnit.start()

{:ok, _} = Application.ensure_all_started(:ex_machina)
Application.ensure_all_started(:mox)

Mox.defmock(ElixirInterviewStarter,
  for: ElixirInterviewStarterBehaviour
)
