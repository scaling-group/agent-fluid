# Collision-course carrier-reserve candidate

## Visual diagnosis before the policy edit

- The four sampled solver policies, combined keyframe sheets, and evaluations
  are byte-identical v41 replications.  They satisfy the frozen evidence
  contract: direct uniform still water (`U_infinity=[0,0,0]`), no cylinders or
  prewarm, and the L64 inertial moving window.  Each captures at
  `24.640015T`, with minimum/final distance `0.748356L`, mean distance
  `2.347937L`, score `-0.448328283`, and 284 moving-window shifts.
- Both rows of the combined sheet were inspected from release to capture.  In
  the top-down row the fish self-propels along a smooth diagonal approach,
  lays down a coherent alternating wake, then makes a bounded transverse hook
  into the capture circle; the zero background flow rules out advection.  The
  oblique Lambda2 row shows compact three-dimensional vortex structures
  following the body without out-of-plane escape or numerical breakup.  The
  lateral oscillation remains productive rather than becoming a stationary
  side-to-side wiggle.
- The assigned-parent v42 posterior-only allocation and the sampled v42
  stroke-headroom redistribution sheets retain the same visible route and
  coherent wake class, so their scalar differences must be read from the
  metrics.  Moving the terminal residual wholly posterior slows capture to
  `24.673016T`, raises mean distance to `2.348364L`, and worsens score to
  `-0.448772903`.  Dynamically transferring the posterior share anteriorly
  reaches the radius one tick sooner (`24.634514T`) but worsens mean/final
  distance to `2.348455/0.749001L` and score to `-0.448985838`.  Together they
  show that v41's coupled steering share is worth preserving; neither extreme
  redistribution creates a better useful trajectory.
- No termination-failure keyframe is present in the current samples or the
  rendered inherited candidate logs.  The most informative available failure
  boundary is therefore the inherited audited reference-velocity experiment:
  widespread posterior phase feedforward separated the far route by `8T`,
  missed at `0.993183L`, and exited left at `37.1470T` despite a coherent wake
  and lower rate-limit occupancy.  The inherited dual-joint rate barriers
  produced the same pass-and-turn failure class.  These negatives prohibit a
  far-route cadence change, synthesized phase feedforward, or another attempt
  to improve saturation statistics at the expense of the captured path.

## Policy hypothesis

Preserve v41's anterior state-feedback oscillator, lagged posterior traveling
wave, coupled phase-selected terminal steering, normalized body-frame
collision-course corridor, steering-priority envelope, posterior stroke
braking, rate coast, and every established route-scale gain.  Add one bounded
allocation mechanism: recover a small carrier-frequency reserve only inside
the existing near-target region, while the fish has positive closing speed and
its body-frame constant-velocity projected miss is already inside the smooth
safe corridor.  This spends authority on forward progress instead of moving
the successful terminal steering residual between joints.  The gate vanishes
on the far route, outside the corridor, at low course speed, and when approach
reverses.

This is a collision-course-conditioned propulsion allocation test, not a
global cadence-gain tune.  It introduces no clock, fixed direction, task
identity, mutable state, or memorized route.  Expected evidence is exact
pre-terminal noninterference followed by retained capture with an earlier
arrival or lower distance integral, while the coherent wake, zero posterior
hard-stop occupancy, roughly `13%` exact-rate class, and low force/moment
class remain intact.  Falsify it if the far commands change, projected miss
leaves the inherited corridor, capture or terminal margin regresses, raw
acceleration exposure materially rises, or wake/load/rate classes worsen.  Its
CFD result will only be available to a later worker and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill-style tail-reactive propulsion and sensor-modulated robotic-fish CPG approach control
source_mechanism: preserve an established anterior-to-posterior traveling bend and schedule bounded propulsive authority from observed task geometry instead of replacing the rhythm or prescribing a route
transferable_invariant: once normalized body-frame velocity predicts a safe closing intercept, retain the proven steering pattern and allocate a small bounded reserve to the existing state-feedback carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body envelopes, Strouhal targets, exact vortex phases, the numerical capture radius, and task-specific routes
policy_translation: multiply a new owned carrier-reserve gain by the existing near-range, positive-closing, course-speed, and projected-miss-corridor gates, then add it to oscillator frequency scale without changing route steering or far-field commands
falsification: reject if capture, far-route locality, coherent wake, zero posterior hard-stop occupancy, terminal miss corridor, or low-load and rate classes are lost, or if arrival and distance integral do not improve over v41

## Pre-evaluation validation

- A pure-function audit reconstructed the policy observations along all `4480`
  sampled v41 trajectory rows.  Every candidate command is finite.  The edit
  changes `270` states, first at `22.263998T` and `1.850649L`; all preceding
  states are command-identical to v41.  Maximum same-state command differences
  are `0.50775/0.50746 rad/T^2`, only about `1.6%` of the owned
  `31.41593 rad/T^2` acceleration envelope.  The collision-course gate peaks
  at `0.57514`, so the owned `0.018` reserve adds at most about `1.04%` to
  frequency scale on this trace.  This confirms locality and boundedness, not
  coupled hydrodynamic improvement.
- An isolated lateral reflection leaves the new collision-course gate exactly
  unchanged.  Its resulting carrier perturbation inherits the seed's existing
  sign-asymmetric route gains, so no stronger full-policy reflection claim is
  made; the added observation and gate themselves choose no world-frame side.
- The public contract returns exactly two finite accelerations for the
  configured smoke state.  All `88` direct `params.FIELD` references resolve
  among the `90` fields returned by `target_policy_params()`, including the new
  reserve gain.  The reusable-guidance semantic check and solver editable-
  boundary check both pass.  The configured check-runner was invoked, but its
  pinned `gpt-5.4-mini` model is unsupported on this account; its three
  declared checks were therefore also run directly and separately, and all
  pass.  No formal CFD was run.
