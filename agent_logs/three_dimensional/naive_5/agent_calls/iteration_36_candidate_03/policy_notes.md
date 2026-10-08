# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial
  moving-window transport. All terminate in capture with zero angle, speed,
  or applied-acceleration contacts. Their combined sheets were inspected from
  release through capture in both the top-down vorticity/body row and the
  oblique body/Lambda2 row. Each fish is visibly self-propelled, carries an
  orderly alternating wake, and retains a compact coherent three-dimensional
  wake through the same target-side terminal hook. There is no passive
  advection, boundary interaction, wake breakup, numerical instability, or
  moving-window-induced body rotation. The nearly unchanged visual topology
  makes trajectory response, rather than carrier strength, the useful
  discriminator.
- The assigned phase-rejected posterior recovery (`solver_2515fae158ed`) is
  the informative mechanism failure despite its finite scalar tie-break over
  the sideslip parent (`solver_7c8c0623a821`). It changes score from
  `-0.595593` to `-0.594833`, mean distance from `2.497592L` to `2.497000L`,
  arrival from `25.9160T` to `25.9105T`, and crossing depth from `0.749162L`
  to `0.748269L`. But its intended full-beat response does not improve: over
  `18--24T`, mean normalized course error is `0.5518` versus `0.5520`, while
  mean projected miss is slightly worse at `1.7971L` versus `1.7967L`.
  Peak planar force/yaw moment remains in the same modest regime
  (`0.01893/0.01011` versus `0.01902/0.01016`). The phase-rejected geometry
  estimate remains a useful persistent-error qualifier, but directly driving
  a posterior reaction half-cycle from it is falsified as course recovery.
- The strongest response comparison is the independently sampled
  adverse-moment residual (`solver_9660f26c87c3`). Relative to the same
  sideslip parent, it arrives at `25.8335T`, lowers mean distance to
  `2.496768L`, and reduces the `20--24T` mean normalized course error and
  projected miss from `0.5704/1.5677L` to `0.5553/1.5254L`. It retains zero
  actuator contacts and slightly lower peak planar force/yaw moment
  (`0.01890/0.01003`). Its capture depth (`0.749181L`) and unchanged two-view
  route remain a finite fixed-pose result, not a semantic clearance gain, but
  they support measured adverse yaw moment as a bounded fast response gate.
  They do not support moment choosing route side or another scalar increase.
- The no-recovery redirect (`solver_cd2b31e85ca6`) provides the common
  baseline: it captures at `25.9710T`, mean distance `2.498175L`, with the
  same coherent wake and load regime. Thus the sampled differences are not
  propulsion or stability effects, and the new test must preserve the
  redirect, traveling bend, terminal controller, coupled governor, and
  viability guards.

## Policy hypothesis

Preserve the assigned carrier and every established navigation and safety
mechanism, but remove the ineffective direct posterior reaction half-cycle.
Retain its phase-rejected body-frame course error only as the persistent route
qualifier. Inside the closing `1.75--4.5L` middle corridor, let target/course
geometry own the correction side and use measured yaw moment only to detect a
beat phase whose hydrodynamic response opposes that side. On that adverse
phase, add one small same-sign two-joint half-cycle residual so the response is
temporary curvature rejection rather than another posterior-lag scalar.
Aligned, low-error, helpful-moment, far, non-closing, redirect-dominated, and
capture-corridor states pass through continuously.

The falsifiable expectation is lower full-beat course error and projected miss
over `20--24T`, at least the assigned parent's capture, coherent two-view wake,
and zero actuator contacts, without exceeding the sampled
`0.0191/0.0102` planar-force/yaw-moment regime. Reject the mechanism if moment
phase merely reproduces the shallow-hook cluster, if the target-owned route is
reversed, if arrival or middle progress regresses, or if wake, loads, or
actuator viability degrade.

bookshelf_consulted: true
source_domain: wake-interaction sensing, elongated-body reactive propulsion, and sensor-modulated robotic-fish CPG control
source_mechanism: separate persistent geometric route error from fast alternating hydrodynamic disturbance, then use a bounded phase-selective residual without replacing the traveling-wave carrier
transferable_invariant: target geometry must own turn side while measured adverse load only qualifies when a small curvature correction is useful; preserve posterior-lag propulsion outside that response phase
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, clock phase, exact vortex phase, source wake geometry, and prescribed routes
policy_translation: phase-rejected normalized body-frame course error and closing middle distance qualify the route, measured normalized yaw moment gates an adverse phase, and joint-state phase shapes a bounded same-sign two-joint residual
falsification: reject on unchanged or worse full-beat course error/projected miss, lost or slower capture, route-side reversal, incoherent wake, actuator contact, or peak load above the sampled parent regime

## Non-CFD audit after the policy edit

- All 62 direct `params.FIELD` references are owned by the returned 62-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations within the `30 rad/T^2` policy envelope.
- A deterministic 4,374-state grid spanning both lateral reflections,
  negative/zero/positive closing speed, far/middle/near target states,
  helpful/adverse/zero moment, and beyond-limit joint angles and rates remains
  finite and bounded. Paired reflected states have zero numerical command
  error.
- Re-evaluating the assigned parent and candidate on 4,711 reconstructed
  parent-trace states changes 1,135 post-guard command pairs, including 456 by
  more than `0.05 rad/T^2`; the largest separation is
  `0.73823 rad/T^2`. Activation is confined to `18.876--25.119T` and
  `4.499--1.102L`, while the candidate's peak frozen-state command remains the
  parent's `29.65805 rad/T^2`. This establishes a material bounded
  middle-response test, not CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its three prescribed commands were
  therefore run directly: the material-guidance check, exact lightweight
  Julia contract check, and solver editable-boundary check all pass. The
  rendered `README.md` initially duplicated the assigned-parent marker;
  removing only the first duplicate marker restored the guidance check without
  changing the assigned parent or evidence. No formal CFD was run.
