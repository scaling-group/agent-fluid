# Capture-cone response-residual candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations use contract-valid direct-uniform still water
  (`U_infinity=0`, no cylinders, no prewarm), and there are only two distinct
  policies and combined keyframe sheets. In both top-down vorticity rows and
  oblique body/Lambda2 rows, the fish self-propels with a coherent alternating
  body-attached wake, follows the same broad leftward route, and turns sharply
  downward through the target. The moving window follows the fish; neither
  capture is flow advection or wake collapse.
- The unguarded line-of-sight policy captures at `0.749769L` and `27.6045T`
  but touches the `45 deg` posterior boundary three times, has `1183/10038`
  joint samples at the speed cap and `1878/10038` commands at the acceleration
  clamp, and reaches peak planar force/yaw moment near `0.03397/0.01548`.
  The assigned symmetric stopping-guard parent preserves the visible route
  and captures at `0.749992L` and `27.7695T`, removes angle contact, lowers
  speed-cap and acceleration-clamp counts to about `1126/10098` and
  `1700/10098`, and lowers peak planar force/yaw moment to about
  `0.02212/0.01041`. Its slightly better score (`-0.709920` versus
  `-0.710392`) is consistent with a slightly lower mean distance, not a new
  route.
- Capture remains geometrically thin. At the parent's terminal sample the
  center speed is about `0.639L/T`, the center-velocity projected miss is
  `0.744L`, and the head-distance history closes at only about `0.074L/T`.
  Thus the successful target crossing is nearly tangential and retains little
  margin to the `0.75L` radius even though joint angles have ample terminal
  headroom. The evidence does not support more propulsion, a posterior pulse,
  or another joint-limit threshold.
- No sampled failure keyframe exists in this rendered workspace: every
  available sheet is a capture and duplicate sheets byte-match. The inherited
  failure digest is used only as a secondary contrast. It reports coherent,
  high-speed left-domain pass-bys clustered near `0.828--0.831L` and a failed
  instantaneous projected-intercept hold at `1.096L`; therefore a binary
  steering release based on one velocity sample or another terminal waveform
  is specifically unsupported.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, large-error two-joint redirect,
terminal miss veto, inertial line-of-sight response, and symmetric stopping
guard. Add one capture-cone response residual through only the already
calibrated anterior half-cycle channel. Inside the existing approach and miss
gates, compare history-window closing speed normalized by observed body speed
with a modest positive closing-ratio request; add steering on the established
course-error side only for the measured deficit. This is a continuous
state-response test, not a binary projected-intercept hold, terminal brake, or
gain-only retune, and it leaves posterior traveling-wave timing unchanged.

The falsifiable expectation is retained capture and coherent low-load
propulsion with an earlier, more radial target crossing, without restoring
joint contact or materially increasing speed/acceleration-cap residence,
force, or moment. Reject the mechanism if capture is lost, the terminal
closing ratio does not increase, the broad route changes outside `1.75L`, the
same near-tangential topology remains, or actuator/load exposure worsens.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish-target capture control
source_mechanism: preserve a productive rhythmic carrier while bounded state feedback supplies only the observed terminal course-response deficit
transferable_invariant: near a capture set, retain propulsion and established turn direction while adding only enough phase-selective steering to restore positive radial closure when measured trajectory geometry remains tangent
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, robot linkage geometry, exact vortex phases, world coordinates, capture routes, and paper-specific terminal thresholds
policy_translation: normalized body-frame target and velocity form projected miss; history-window distance closure divided by body speed forms a dimensionless radial-response measure; smooth approach, miss, response-deficit, phase, speed, and joint-headroom gates add a bounded joint-1 residual on the calibrated turn side
falsification: reject if the formal rollout loses capture, fails to increase radial closure, changes the far coherent route, touches a joint boundary, or materially raises saturation residence or hydrodynamic loads

## Non-CFD implementation audit

- The required guidance-semantic check, lightweight Julia contract, and solver
  editable-boundary check pass. The configured check-runner was invoked first,
  but its pinned model is unavailable on this account, so its three prescribed
  commands were run directly and separately. No CFD was run.
- A synthetic state outside the approach corridor produces exactly the sampled
  parent's two actions, as does a near-target state whose window closing ratio
  already exceeds the request. A near-target tangential-deficit state changes
  only joint 1 from `2.7191` to `3.6141 rad/T^2`; joint 2 remains exactly
  unchanged. Reflecting target/velocity lateral components, bearing, turn
  rates, joint angles, and joint velocities negates both outputs to numerical
  precision, and both commands remain bounded.
- All `42` directly referenced parameter fields are returned by
  `target_policy_params()`. These checks establish locality, activation,
  reflection equivariance, boundedness, and schema coverage only; they do not
  predict the pending formal CFD result.
