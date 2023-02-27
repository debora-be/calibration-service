defmodule ElixirInterviewStarter.Factory do
  @moduledoc """
  This module contains functions that help us create parameters for testing data.
  """
  use ExMachina

  alias ElixirInterviewStarter.CalibrationSession

  def calibration_session_factory do
    %CalibrationSession{
      user_email: nil,
      session_id: nil,
      user_has_ongoing_calibration_session: nil,
      precheck_1_succeeded: nil,
      user_has_ongoing_calibration_session_that_just_finished_precheck1: nil,
      precheck_2_succeeded: nil,
      calibration_succeeded: nil
    }
  end
end
