# Signed-work half-cycle protection candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. Because the cohort
  contains no failed termination, the informative failure is the latest
  mechanism regression rather than loss of capture.
- I inspected both the top-down mid-plane-vorticity row and the oblique
  body/Lambda2 row from release through termination for the strongest finite
  sample `solver_1d05d22ea1fe`, the assigned prefill
  `solver_f997a0c1ad0f`, and the lower-score byte-identical carrier-release
  repeat `solver_0e82a9e35a2a`. All three fish self-propel from blank quiescent
  water on a shallow target-directed arc. Their alternating caudal vortices
  and compact three-dimensional structures remain coherent; none shows
  advection, collision, domain exit, wake collapse, or instability. The
  prefill alone shows the longer terminal hook implied by its extra terminal
  frames, so propulsion and target sign should be preserved while its
  response-release edit should not.
- Metrics falsify releasing the extra velocity-course redirect merely because
  yaw has the requested sign. The prefill captures at `16.247T` with a
  `1.82240L` distance integral and `13.363L` head path, versus
  `15.939T/1.82008L/13.107L` for the range-specific approach-coupled carrier.
  Prefill late (`distance < 2L`) mean absolute yaw rate is `0.269 rad/T`
  versus `0.106 rad/T`, anterior mean command is `17.34` versus
  `16.66 rad/T^2`, and peak planar-force/yaw-moment coefficients are
  `0.03520/0.01783` versus `0.03477/0.01715`. This agrees with inherited logs:
  same-sign yaw and course/closure gates repeatedly changed the terminal hook
  without reducing the actuator cost. Restore the sampled full redirect and
  the approach restoration of carrier coupling rather than tuning that gate.
- A separate boundary survives all four samples. Anterior residence above
  90/99% of the joint-rate limit remains `17.50--17.70%` and
  `11.93--12.18%`, despite different carrier and redirect release mechanisms.
  The inherited response-gated half-cycle test likewise left these costs
  inside the unmodified range. Thus yaw response is not a selective proxy for
  costly half-cycle work; a new test must operate on signed joint work itself.

## One-candidate policy hypothesis

Use the sampled `dogfish3d_approach_restored_carrier_coupling_v1` controller as
the carrier: preserve its corrected body-frame target vector, distance/closing
drive relief, velocity-course redirect, full posterior handoff, range-specific
reversal release, bounds, and public two-joint state-feedback contract. Add one
mechanism only. Decompose the existing joint-phase half-cycle asymmetry into
its exact anterior and posterior acceleration increments. At the already
normalized joint-rate envelope, use the existing smooth rate and power scales
to withdraw only the part of those increments that performs positive joint
work; pass negative-work half-cycle reversal, baseline mean curvature,
velocity-course redirect, and both traveling-carrier phases unchanged.

Expected signature: retain the sampled `15.94--16.17T` short-path capture
class and coherent wake while materially reducing anterior greater-than-99%
rate residence or mean command. Falsify if capture, the `4/2/1L` milestones,
distance integral, or head path leave the sampled carrier-coupled range; if
command/rate residence does not improve beyond repeat variation; or if joint
margin, terminal yaw/slip, force/moment peaks, finite action, or either wake
view deteriorates. The candidate's CFD result occurs only after this worker
exits and is not claimed as evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG asymmetric flapping and reactive traveling-wave propulsion
source_mechanism: preserve a phase-coherent propulsive rhythm while allocating the steering-heavy half-cycle through observed joint state and actuator work direction
transferable_invariant: auxiliary half-cycle steering need not inject outward work near the rate envelope; retain its negative-work reversal and the underlying traveling carrier
nontransferable_details: published gains, oscillator frequencies, robot or species kinematics, duty ratios, full-body waveforms, exact vortex phases, and task-specific coordinates or routes
policy_translation: decompose the existing joint-phase asymmetry into exact two-joint acceleration increments and smoothly attenuate only their positive-work portions with normalized joint rate and power, leaving target steering, carrier phase, and approach handoff intact
falsification: reject if rate residence or command does not materially improve without leaving the repeat-supported capture, timing, integral, path, load, joint-margin, terminal-course, finite-action, and coherent two-view wake class
