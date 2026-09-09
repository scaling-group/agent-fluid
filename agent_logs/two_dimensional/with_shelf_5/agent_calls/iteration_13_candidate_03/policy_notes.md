# Multi-Wake Candidate Notes

## Inherited evidence

- The assigned prefill and three sampled solver policies are byte-identical.
  Each
  reaches the `0.75L` target in `43.9505` released time with mean distance
  `2.1391L`, RMS relative crossflow `0.2111`, RMS lateral force `49.44`, RMS
  moment `701.26`, and both joint-rate and acceleration caps reached.
- The only distinct sampled policy adds a `0.35` normalized anterior
  phase-lead to the existing half-cycle selector. It retains the same visible
  route and success but arrives slightly later (`43.9780`), raises RMS
  crossflow to `0.2136`, RMS force to `53.18`, RMS moment to `736.58`, and
  increases command energy from `53082.6` to `53191.1`. A phase shift is
  therefore a measured negative direction, not a basis for another lead or
  gain adjustment.
- The assigned parent's inherited notes proposed a phase-selective posterior
  rate projection. Its completed rollout retained the direct target capture
  at `44.0605` and reduced RMS force/moment to `46.71/677.72` versus the
  unguarded carrier, so the projection was a real load mechanism. However, it
  is dominated by the earlier phase-indiscriminate alignment-gated projection,
  which reached at `44.0220` with lower force/moment `44.86/663.89`. Adding the
  nonpreferred-half selector therefore weakened, rather than improved, the
  arrival/load tradeoff.
- The assigned guidance also records that the alignment-gated outward
  posterior-rate projection reduced RMS force/moment to `44.86/663.89` with a
  small capture delay to `44.0220`, whereas restricting it to the `2.5L`
  terminal neighborhood erased its effect. Together, the inherited logs and
  sampled solver results rule out another phase or range threshold refinement.

## Visual diagnosis

The shared prewarm sheet shows the same held fish and fully developed,
interacting four-cylinder streets used by every candidate. After release, the
successful carrier makes one decisive downward-left redirect, straightens,
and traverses the wake corridor into the target without a visible collision,
wrong-way excursion, or repeated yaw reversal. Its alternating body wake and
mean relative streamwise flow (`0.1129`) show active propulsion rather than
mere advection. Both the phase-lead sample and the assigned parent's
phase-selective projection are visually indistinguishable from the carrier at
the six-frame resolution, so their measured arrival and load differences are
decisive. The large wake structures do not produce a visible route-control
failure; indiscriminate crossflow rejection would risk cancelling useful
motion.

## Policy hypothesis

Keep the carrier's target-bearing mean curvature, target-favored half-cycle
steering, lagged posterior target, and reversal equations unchanged. Add one
response-conditioned gait transition: preserve full oscillator amplitude
during the large-bearing redirect, then smoothly reduce the carrier amplitude
after normalized body-frame bearing aligns. This tests a different actuator
primitive from the dominated phase selectors while applying load relief in the
aligned transit regime where prior projection evidence was effective. Reject
the mechanism if formal CFD loses the direct route or target capture,
materially delays arrival beyond the parent's `44.0605`, or fails to improve
force, moment, effort, or saturation evidence relative to that parent.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish CPG control
source_mechanism: sensor-conditioned transition from high-authority redirect to a lower-amplitude propulsive rhythm
transferable_invariant: retain full bounded gait authority while target error is large, then continuously release into a lower-load cruise envelope after observed alignment
nontransferable_details: published gains, clock phase, robot morphology, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing to scale the state-feedback oscillator amplitude while leaving target curvature, posterior lag, and reversal commands structurally unchanged
falsification: reject if capture or direct-route topology degrades, arrival exceeds the assigned parent, or force, moment, effort, and saturation do not improve

## Pre-evaluation verification

The required guidance semantic check and solver boundary check pass. Static
schema comparison found all `14` direct `params.FIELD` references among the
`14` fields returned by `target_policy_params()`. An algebraic sweep of `2835`
states spanning range, bearing, both joint limits, and both rate limits found
finite actions; the combined approach/cruise amplitude scale stayed in
`[0.675,1]`, and the cruise scale at `20 deg` bearing was `0.999807`, preserving
the large-error carrier to within `0.02%`. The prescribed Julia include check
could not execute because this workspace has no `julia` executable. No formal
CFD was run.
