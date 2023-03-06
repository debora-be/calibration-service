defmodule ElixirInterviewStarter.Operational.BringTogether do
  @moduledoc """
  Brings together the `CalibrationSession` with the provided attributes, updating the schema/server state.
  """

  @spec process(struct(), map()) :: struct()
  @doc """
  Brings together the `CalibrationSession` with the provided attributes.
  """
  def process(calibration_session, attrs) do
    Map.merge(calibration_session, attrs)
  end
end
