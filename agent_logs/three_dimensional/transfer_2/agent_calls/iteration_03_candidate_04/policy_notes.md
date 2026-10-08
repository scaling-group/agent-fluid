# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts and the two informative inherited rollouts use
  direct uniform still-water initialization (`U_infinity=[0,0,0]`), no
  cylinders, and no prewarm.  Their motion and wakes are therefore generated
  by the fish rather than imposed advection.
- Both rows of every sampled combined keyframe sheet were inspected.  The
  transferred seed (`solver_e1a03f18d808`) and response-release child
  (`solver_dc5e319e8345`) show sustained translation, a coherent alternating
  mid-plane wake, and compact three-dimensional Lambda2 structures.  They
  reduce distance from `12.328L` to `4.780L` and `4.660L`, respectively, but
  then sweep below the target and exit the lower boundary at about `27.5T`
  and `28.4T`.  The useful mechanism is the traveling-wave carrier; the
  repeated failure is route-scale steering.
- The assigned parent (`solver_a1d9e06dfe8a`) is not a better control
  template despite its numerically higher score.  Its globally slower,
  soft-limited carrier retains a clean wake but redirects upward: closest
  approach is only `8.752L`, and it exits the upper boundary at `14.911T`.
  The sampled progress-gated cadence child (`solver_914f6830b5c6`) preserves
  the lower-exit topology and worsens closest approach to `5.347L`.  Thus
  neither global slowing nor late cadence relief supplies the missing turn.
- The inherited logs sharpen the actuator-polarity diagnosis.  An always-on
  line-of-sight mean-curvature controller with a `12 deg` bound
  (`solver_dc5bdf69e4ab`) turns upward almost immediately and reaches only
  `12.206L`.  More decisively, a course-released controller whose initial
  negative tail tangent is less than `0.5 deg` (`solver_ef181490e554`) still
  curls upward, reaches only `12.083L`, and exits at `8.618T`.  Its top-down
  and oblique rows show a translating fish and a developing wake during the
  redirect, so the failure is excessive persistent yaw authority rather than
  loss of propulsion.  Together with the seed's positive-tangent/downward
  association, these completed results establish the actuator polarity but
  also falsify always-on static curvature at both tested magnitudes.
- On the useful response-release trajectory, body-frame bearing grows from
  about `+0.23 rad` at `8T` to `+0.56` at `12T`, `+0.71` at `14T`, and
  `+0.87` at `16T`, while distance continues to close.  The legacy controller
  nevertheless maintains the mean-curvature branch whose sampled cycle-mean
  tail tangent is associated with the later downward sweep.  Its seven-state
  yaw history spans only about `0.0385T`; the evaluated yaw-response release
  changed neither termination class nor reversal count.  A geometry-scale
  off-axis signal is therefore a better veto trigger than another subcycle
  derivative gain.

## Policy hypothesis

Restore the response-release child's demonstrated `0.55T`, `28 deg`
joint-state carrier and its existing bounded steering stack.  Add exactly one
new controller mechanism at the actuator translation: once normalized
body-frame target geometry is materially off-axis, compare the sign of the
requested cycle-mean tail tangent with the signed lateral target error and
smoothly withdraw only the polarity contradicted by the two inherited
upper-turn experiments.  Leave the mean curvature unchanged near the
centerline, never reverse it from this branch, and leave the direct
half-cycle/rate steering available to reorient the fish.  This preserves the
deep early approach while preventing the legacy mean-bend path from continuing
to steer away as the target moves far to one side.

Expected evidence is the seed/response child's coherent wake and early
distance reduction followed by a trajectory that bends toward the target
before the `4.660L` closest-approach epoch.  Falsify the mechanism if it causes
the inherited immediate upper-exit topology, retains the lower exit without a
meaningful closest-approach or termination improvement, destroys the coherent
traveling wake, or increases the already clipping-dominated actuation.  Static
checks and recorded-state replay can establish polarity, boundedness, and
branch selectivity only; they are not CFD evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological burst redirect
source_mechanism: preserve the propulsive rhythm while a bounded mean-curvature redirect is released when observed target-response evidence contradicts it
transferable_invariant: separate the traveling-wave carrier from route steering and withdraw a signed steering bias when persistent normalized target error shows that bias has the wrong response polarity
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target bearing and vector angle to gate only the contradicted sign of the existing cycle-mean tail tangent while retaining the state-feedback carrier and two-joint direct steering
falsification: reject the transfer if the early deep approach or coherent wake is lost, if either sampled upper-turn topology appears, or if the same lower-boundary exit persists without meaningful semantic improvement

## Pre-evaluation checks

- Replaying the candidate and evaluated response-release policy on recorded
  response-child states gives identical actions through `10T`.  The new gate
  then reduces the reconstructed mean tail tangent from about `9.95` to
  `7.31 deg` at `12T`, `10.19` to `3.79 deg` at `14T`, and `10.34` to
  `0.41 deg` at `16T`.  The branch does nothing to an equally off-axis
  correct-polarity mean tangent and remains finite across a grid of mirrored
  target, yaw-rate, and joint states.
- Full recorded-state replay leaves raw acceleration-envelope exposure at
  `98.0%` for both policies while reducing mean summed absolute command from
  `110.59` to `106.47 rad/T^2`.  This establishes that the new tail branch
  does not algebraically worsen inherited clipping on those states; it does
  not claim to solve head-command saturation or predict the new trajectory.
  Formal CFD remains deferred to EvE.
- The reusable-guidance semantic check, lightweight Julia policy contract,
  direct 57-field parameter-schema audit, finite-state branch checks, and
  solver editable-boundary check pass.  The configured check-runner agent was
  invoked but its pinned model was unavailable, so its three prescribed
  no-CFD commands were executed directly and separately.
