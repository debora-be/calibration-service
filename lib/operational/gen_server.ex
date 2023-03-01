defmodule ElixirInterviewStarter.Operational.GenServer do
  @moduledoc """
  GenServer is a behaviour for implementing servers in Elixir.
  """
  use GenServer

  alias ElixirInterviewStarter.CalibrationSession

  alias ElixirInterviewStarter.DeviceMessages

  @doc """
  Starts the API client which creates the `GenServer` process with `%CalibrationSession{}` as state.
  """
  def start_link() do
    GenServer.start_link(__MODULE__, %CalibrationSession{}, name: __MODULE__)
  end

  def get, do: GenServer.call(__MODULE__, :get)

  @doc """
  Fills the %CalibrationSession{} with the initial data from precheck_1.
  """
  def update_struct(attrs), do: GenServer.call(__MODULE__, {:update_struct, attrs})

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:update_struct, attrs}, _from, state) do
    new_state = Map.merge(state, attrs)

    {:reply, new_state, new_state}
  end
end
