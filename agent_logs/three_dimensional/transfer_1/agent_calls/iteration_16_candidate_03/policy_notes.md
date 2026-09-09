# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled and inherited rollout used direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. The
  motion in both visual rows is therefore self-propulsion, not advection.
- I inspected both the top-down vorticity and oblique Lambda2 rows for all four
  sampled captures and the two inherited projected-miss repeat failures. The
  three byte-identical `dogfish3d_intercept_guarded_speed_reserve_v1` runs
  capture at `0.7466--0.7494L` and `18.2050--18.6010T`; each lays down a
  coherent alternating street and compact paired 3D structures through the
  crossing. The repeat failures preserve the same wake class, pass below the
  target at `1.6366L` and `1.7680L`, turn downward, and leave the lower domain.
  Missing thrust, wake collapse, collision, and numerical instability do not
  distinguish success from failure.
- The assigned-parent guidance establishes the three-repeat speed-reserve
  policy as the useful baseline and rejects saturation-first total-command
  governors: a governor reduced speed-limit residence but missed at `1.3877L`
  while acceleration clipping and the alternating wake remained. Earlier
  half-cycle, phase-lag, and static-curvature realizations also regressed, so
  they are not repeated here.
- The inherited `dogfish3d_speed_reserve_projected_miss_turn_v1` first captured
  at `0.7477L` and `18.5405T`, but two exact-byte repeats then missed at
  `1.6366L` and `1.7680L` and exited below. The signed projected-miss command
  replaced achieved-course steering throughout the last `2L`; its one capture
  is therefore threshold-fragile evidence, not a mechanism to tune or stack.
- On the three repeat-supported baseline traces, projected miss near `1L`
  spans about `0.143L`, `0.685L`, and `0.905L`. A recorded-trace projection of
  a magnitude-only hold gate (active below `1.5L`, only while approaching and
  projected inside `0.65L`) is zero on both inherited repeat failures, zero at
  the edge-of-disk baseline crossing with `0.729L` projected miss, and active
  only on already capture-compatible portions of the other two traces. This is
  a static trace check, not a CFD outcome.

## Candidate mechanism and falsification

Retain the repeat-supported traveling bend, cadence, achieved-course route
servo, response/LOS/intercept release, and sparse outward-carrier reserve.
Add one terminal capture-corridor hold: when range is below `1.5L`, the
velocity is aligned toward the target, and the body-frame target/velocity
cross product predicts a closest pass strictly inside the `0.75L` disk,
smoothly relieve at most 30% of the additive steering residual. Never attenuate
the carrier, replace the signed route command, reverse an action, or alter
far/middle behavior. The mechanism should reduce late course chasing on an
already safe intercept while retaining full correction on an edge or growing
miss.

Expected test: preserve capture and the coherent terminal wake across the
baseline trajectory variability, with unchanged behavior outside `1.5L` and
full steering whenever projected miss is at least `0.65L` or approach
alignment is weak. A useful improvement would maintain the capture class while
reducing unnecessary terminal steering or advancing a centered crossing; the
new CFD evaluation occurs only after this worker exits.

Falsification: reject the hold if it loses any capture, worsens the
`18.205--18.601T` arrival envelope, weakens the alternating wake, increases
loads or saturation, produces coasting, or changes an edge-of-corridor path.
If falsified, revert to the exact three-repeat speed-reserve bytes and do not
widen the hold corridor or increase relief.

bookshelf_consulted: true
source_domain: robotic-fish terminal capture and position-hold control over a rhythmic propulsive carrier
source_mechanism: preserve propulsion while sensed approach geometry reduces excess terminal steering only after a safe intercept is established
transferable_invariant: separate far route acquisition from a bounded near-target hold, and keep the traveling wave active while terminal steering authority follows current interception geometry
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact gait or vortex phase, learned routes, and task-specific paths
policy_translation: form projected miss and approach alignment from normalized body-frame target and velocity, then use a smooth inside-disk gate to relieve only the additive two-joint steering residual below 1.5 body lengths
falsification: reject if capture repeatability, arrival, wake coherence, loads, or saturation regress, or if the gate changes a projected edge miss rather than only an already safe approach

## Non-CFD verification

- Static schema inventory finds all 49 direct `params.FIELD` references in the
  51-field object returned by `target_policy_params`; only metadata fields
  `version` and `control_period` are intentionally unused by arithmetic.
- Replaying the controller algebra on the three baseline traces makes the new
  steering term exactly unchanged at and beyond `1.5L`. It changes
  `121/153/124` terminal rows, with maximum additive-steering differences of
  about `3.07/2.52/3.34 rad/T^2`; it changes zero rows on either inherited
  projected-miss failure trace. These are counterfactual trace projections,
  not closed-loop CFD predictions.
- The workspace-documented Julia wrapper passes the finite two-joint contract.
  A mirrored-state check negates both returned joint accelerations to numerical
  precision, and direct boundary checks make the hold gate exactly zero at its
  `1.5L` range boundary and `0.65L` projected-miss boundary.
- The formal semantic guidance-delta and solver editable-boundary checks pass.
  No CFD was run.
