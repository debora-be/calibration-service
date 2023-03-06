defmodule ElixirInterviewStarter.Operational.Server do
  @moduledoc """
  Server is a behaviour for implementing servers in Elixir.
  """
  use GenServer

  alias ElixirInterviewStarter.CalibrationSession

  @doc """
  Starts the API client which creates the `GenServer` process with `%CalibrationSession{}` as state.
  """
  def start_link(%CalibrationSession{} = state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  GenServer.init/1 callback
  """
  @impl true
  def init(state), do: {:ok, state}

  @spec get() :: map()
  @doc """
  Gets the current state of the server; has a timeout of 30 seconds.
  """
  def get, do: GenServer.call(__MODULE__, :get, 30_000)

  @spec calibrate(map()) :: map()
  @doc """
  Merges the current state of the server with the given map; has a timeout of 100 seconds.
  """
  def calibrate(attrs),
    do: GenServer.call(__MODULE__, {:calibrate, attrs}, 100_000)

  @spec precheck(map()) :: map()
  @doc """
  Merges the current state of the server with the given map; has a timeout of 30 seconds.
  """
  def precheck(attrs),
    do: GenServer.call(__MODULE__, {:precheck, attrs}, 30_000)

  @doc """
  GenServer.handle_call/3 callback, which handles the `:get` and `:precheck` calls.
  """
  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:calibrate, attrs}, _from, state) do
    new_state = Map.merge(state, attrs)

    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call({:precheck, attrs}, _from, state) do
    new_state = Map.merge(state, attrs)

    {:reply, new_state, new_state}
  end
end
