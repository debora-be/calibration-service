defmodule ElixirInterviewStarter.CalibrationSession do
  @moduledoc """
  A struct representing an ongoing calibration session, used to identify who the session
  belongs to, what step the session is on, and any other information relevant to working
  with the session.
  """

  @type t() :: %__MODULE__{
          user_email: String.t(),
          session_id: String.t(),
          user_has_ongoing_calibration_session: boolean,
          precheck_1_message: String.t(),
          precheck_1_succeeded: boolean,
          user_has_ongoing_calibration_session_that_just_finished_precheck1: boolean,
          precheck_2_message: String.t(),
          precheck_2_succeeded: boolean,
          calibration_message: String.t(),
          calibration_succeeded: boolean
        }

  defstruct [
    :user_email,
    :session_id,
    :user_has_ongoing_calibration_session,
    :precheck_1_message,
    :precheck_1_succeeded,
    :user_has_ongoing_calibration_session_that_just_finished_precheck1,
    :precheck_2_message,
    :precheck_2_succeeded,
    :calibration_message,
    :calibration_succeeded
  ]
end
