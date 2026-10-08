# Posterior braking-reserve replication candidate

## Evidence diagnosis before the policy edit

- The four sampled solver results are byte-identical course-preview policies
  and therefore replicate one mechanism rather than four distinct ones.  All
  satisfy the frozen contract: direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders or prewarm, finite dynamics, and inertial
  moving-window transport.  Each captures at `24.5795T`, minimum/final
  distance `0.746968L`, and mean distance `2.36044L`.
- Both rows of the sampled capture keyframe sheet were inspected.  The
  top-down row starts wake-free, then shows self-propelled translation, a
  coherent alternating mid-plane wake along the diagonal approach, and a
  target-directed redirect immediately before capture.  The oblique row shows
  compact three-dimensional Lambda2 structures persisting through that
  redirect.  The motion is not passive advection or a numerical wake breakup.
- The sampled capture is actuator-limited: the posterior joint occupies the
  `45 deg` hard stop for `23.383%` of its trace, any joint occupies the
  `260 deg/T` rate limit for `15.149%`, raw acceleration exceeds the actuator
  envelope in `72.835%` of samples, and peak absolute body-frame planar
  force/yaw-moment coefficients are `0.269/0.178/0.143`.
- The assigned-parent logs supply an evidence-backed improvement.  The v32
  posterior braking reserve preserves the same visible coherent-wake route and
  captures at `24.6290T`, `0.748702L`, with mean distance `2.36161L`; it
  eliminates sampled posterior hard-stop occupancy and reduces peak force and
  moment coefficients to `0.0241/0.0303/0.0149`.  Its rate-limit and raw
  acceleration exposure remain `15.163/73.046%`, so it is stroke/load relief,
  not a general saturation cure.
- The v33 keyframe failure was inspected in both views and cross-checked
  against its trace.  It initially retains the coherent self-generated wake,
  but curls above the capture circle and exits the upper boundary at
  `37.2735T`; minimum/final distance are `0.9332/6.9418L`.  A sibling rate
  barrier has the same semantic failure at `36.7510T` and
  `0.8484/7.2108L`.  Although the two barriers reduce any-joint exact-rate
  occupancy to `0.236%` and `0%`, their early intervention in the traveling
  carrier destroys the successful route.  They do not support another global
  rate-limit filter or scalar retune.

## Policy hypothesis

Materialize the completed v32 controller as the one downstream candidate.
Preserve the sampled course preview, steering-priority allocation, and
state-feedback anterior-to-posterior traveling wave.  Add only its evaluated,
mirror-equivariant posterior braking reserve: use posterior angle, outward
rate, the owned stroke band, and the owned acceleration envelope to replace an
insufficient near-boundary command with bounded inward deceleration.  Leave
unconstrained and already-inward motion unchanged.  This selects the strongest
completed semantic improvement and rejects the two completed v33 carrier-rate
barriers rather than speculating past contradictory CFD evidence.

Expected evidence is capture near `24.63T`, the established diagonal route and
coherent three-dimensional wake, zero sampled posterior hard-stop occupancy,
and the v32 low-load class.  Falsify the replication if capture is lost, the
far trajectory changes materially, posterior hard-stop occupancy returns, or
peak planar force/moment leaves the `0.031`-scale class.  Do not interpret
unchanged raw acceleration or joint-rate exposure as a failure of this
stroke-specific mechanism.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive swimming
source_mechanism: preserve a phase-lagged traveling wave while proprioceptive feedback protects finite posterior stroke needed for reactive thrust
transferable_invariant: modify only a constraint-conflicted portion of the posterior rhythm with bounded inward recovery while leaving unconstrained wave propagation unchanged
nontransferable_details: published gains, dimensional cadence, motor models, species kinematics, full-body envelopes, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior joint position and outward rate with the owned stroke and acceleration envelopes to apply a mirror-equivariant braking reserve to joint two
falsification: reject if capture, far-path topology, coherent wake, zero posterior hard-stop occupancy, or the inherited low-load class is lost

## Pre-evaluation validation

- The materialized candidate is byte-identical to the completed v32 policy
  associated with the inherited capture evidence; this is evidence selection,
  not a claim about the new post-exit evaluation.
- The required public-contract smoke state returns two finite accelerations,
  and all `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`.
- The guidance semantic check and solver editable-boundary audit pass.  The
  configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account; its three declared no-CFD checks were therefore
  run directly and separately.  No formal CFD was run.
