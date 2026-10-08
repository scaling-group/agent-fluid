# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=[0,0,0]`, no cylinders or prewarm), so their translation and
  wake are self-generated rather than imposed advection.  The prefilled
  transferred parent (`solver_e1a03f18d808`) forms a strong alternating
  mid-plane wake and compact three-dimensional Lambda2 structures, reduces
  distance from `12.328L` to `4.780L`, then continues below the target and
  exits the lower boundary at `27.495T` with distance back at `9.709L`.
- Both rows of the combined sheets for the strongest finite sample and the
  most contrasting failure were inspected and cross-checked against their
  metrics, diagnostics, and trajectories.  The off-axis mean-curvature
  release sample (`solver_045019f39c2a`) preserves the coherent carrier,
  improves closest approach to `4.141L`, and delays the lower exit to
  `32.197T`, but its late frames still show an unrecovered diagonal sweep
  below the target.  The globally slower, soft-limited sample
  (`solver_a1d9e06dfe8a`) has a visibly weaker, cleaner wake yet redirects
  upward, reaches only `8.752L`, and exits above at `14.911T`.  Propulsion is
  therefore useful, while global cadence reduction and steering withdrawal
  alone do not supply the missing route-scale redirect.
- The response-gated sample (`solver_dc5e319e8345`) likewise retains the
  alternating wake but changes the parent's `4.780/9.709L` minimum/final
  distances only to `4.660/9.604L` and exits below at `28.369T`.  Inherited
  logs report about `98%` exposure to at least one raw acceleration command
  beyond the actuator envelope and show that the seven-state yaw window is
  only about `0.0385T`; another yaw-release gain or late cadence gate would
  repeat mechanisms already falsified by completed rollouts.
- The inherited static-curvature and course-release failures bound actuator
  polarity but not a safe redirect: negative mean tail tangent turned upward
  too early even below `0.5 deg`, whereas the legacy positive mean tangent is
  associated with the late downward sweep.  The latest off-axis veto proves
  that smoothly withdrawing the contradicted tangent is beneficial but
  insufficient.  The remaining evidence-backed opening is to use the
  released posterior-wave authority asymmetrically across the observed joint
  cycle, without increasing the carrier magnitude or adding a static route.

## Policy hypothesis

Start from `solver_045019f39c2a`, the sampled policy with the deepest approach
and latest exit.  Retain its joint-state oscillator, posterior lag, direct
turn feedback, and wrong-polarity mean-curvature release.  Add exactly one new
actuator mechanism: while that release is active, identify the posterior
target-wave half-cycle opposing the signed turn command from current joint
state and continuously attenuate only that half-cycle.  The complementary
half-cycle is unchanged, so this creates bounded turning asymmetry upstream
of acceleration clipping without increasing the instantaneous carrier target.
The gate is dormant near the initial centerline and whenever the existing
mean-curvature polarity is not contradicted.

Expected evidence is trajectory and wake agreement with the strongest sample
through the early approach, followed by a course bend toward the target before
the post-`4.141L` distance increase.  Falsify the mechanism if it causes the
sampled early upper-exit topology, destroys the coherent alternating wake,
increases raw acceleration-envelope exposure, or preserves the lower exit
without a meaningfully better closest approach, termination class, or useful
trajectory.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG turning
source_mechanism: produce a turn by reducing the propulsive half-cycle that opposes the requested bend while preserving the complementary traveling-wave half-cycle
transferable_invariant: route correction can be allocated as bounded phase-selective asymmetry from observed joint phase and normalized body-frame target error instead of a persistent static bend
nontransferable_details: published gains, motor dynamics, clock-driven CPG phase, species-specific kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: when the existing off-axis polarity veto releases a contradicted mean tail tangent, use signed turn request and the observed posterior target-wave side to attenuate only the opposing half-cycle inside the two-joint state-feedback carrier
falsification: reject the transfer if early progress or wake coherence is lost, clipping burden increases, the sampled upper-turn topology appears, or the same lower-boundary exit persists without semantic or trajectory improvement

## Pre-evaluation checks

- Replaying both policies over all `5854` recorded states of the strongest
  sampled rollout leaves the new branch inactive through `10T`; it first
  activates at `10.626T`, is active on `21.7%` of states, and has maximum
  opposing-half-cycle attenuation `0.474` under its `0.68` bound.  At the
  `12T` and `14T` checkpoints, where the inherited curvature release is
  `0.269` and `0.636`, the branch changes only the posterior command by about
  `-9.97` and `-21.51 rad/T^2`, respectively.
- On that fixed recorded-state replay, exposure to at least one raw command
  above `1800 deg/T^2` changes from `98.14%` to `97.75%`, tail-only exposure
  from `77.28%` to `77.26%`, and mean summed absolute command from `104.98` to
  `103.38 rad/T^2`; the maximum raw command is unchanged.  This establishes
  selectivity, boundedness, and no algebraic increase in the inherited
  clipping burden on sampled states.  It cannot predict the closed-loop
  trajectory, and formal CFD remains deferred to EvE after this worker exits.
- The configured check-runner was invoked but its pinned model was unavailable.
  Its three prescribed no-CFD commands were therefore run directly and pass:
  material reusable-guidance delta, lightweight Julia policy contract, and
  solver editable-boundary audit.  A separate deterministic audit confirms
  that all `58` direct `params.FIELD` references are present among the `60`
  fields returned by `target_policy_params()`.
