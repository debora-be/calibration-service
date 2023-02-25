defmodule ElixirInterviewStarter.CalibrationSession do
  @moduledoc """
  A struct representing an ongoing calibration session, used to identify who the session
  belongs to, what step the session is on, and any other information relevant to working
  with the session.
  """
  use GenServer

  @type t() :: %__MODULE__{
    user_email: String.t(),
    user_has_ongoing_calibration_session: boolean,
    precheck_1_succeeded: boolean,
    user_has_ongoing_calibration_session_that_just_finished_precheck1: boolean,
    precheck_2_succeeded: boolean,
    calibration_succeeded: boolean
  }

  defstruct [
    :user_email,
    :user_has_ongoing_calibration_session,
    :precheck_1_succeeded,
    :user_has_ongoing_calibration_session_that_just_finished_precheck1,
    :precheck_2_succeeded,
    :calibration_succeeded
  ]
end
