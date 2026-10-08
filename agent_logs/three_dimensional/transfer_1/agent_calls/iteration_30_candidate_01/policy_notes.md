# Phase-even posterior turn-shape replication candidate

## Completed evidence and visual diagnosis before editing

- All four assigned samples are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  The phase-even posterior turn-shape controller is the only material
  semantic improvement over the assigned v43 parent: it captures at
  `17.64401 T` rather than `17.75400 T`, improves score from `-0.07917` to
  `-0.07419`, and lowers total/observed distance integrals from
  `1.96508/1.34990 L` to `1.95985/1.34371 L`.
- The phase-even controller is closer than v43 by `0.0075-0.0508 L` at every
  `2 T` checkpoint from `2-12 T` and by `0.0327 L` at `17 T`, although it
  trails by `0.0068/0.0110 L` at `14/16 T`.  Thus its benefit is a route-wide
  closed-loop change with an intermediate tradeoff, not merely a deeper final
  discrete sample.  The posterior-allocated and axial-confident approach-wave
  alternatives capture only one solver step earlier than v43 and change the
  observed integral by less than `0.00005 L`; neither supplies a comparable
  mechanism-level gain.
- I inspected every combined sheet from release to termination.  The v43 and
  phase-even top-down rows show active self-propulsion on smooth target-signed
  arcs: compact startup vorticity develops into an organized alternating
  posterior street without reversal, collision, domain exit, or wake collapse.
  Their readable oblique rows show compact paired Lambda2 structures following
  the caudal region through approach.  The posterior-allocated sample has the
  same organized top-down topology but a black oblique row, an evidence/render
  failure that cannot support a comparative 3D-wake claim.
- The improved phase-even route raises mean/max speed only from
  `0.7168/0.9603` to `0.7199/0.9662 L/T` and leaves peak normalized planar
  force/moment unchanged at `0.03225/0.01609`.  Any-joint acceleration-limit
  residence falls from `44.21%` to `43.98%` because anterior residence falls
  from `38.04%` to `36.16%`, while posterior residence rises from `6.16%` to
  `8.14%`.  This supports posterior steering allocation but does not support a
  claim of generic actuator relief.

## One-candidate policy hypothesis

Materialize the completed v46 phase-even controller as the sole candidate and
preserve its v43 target sensing, selective crossflow pose confidence,
state-feedback carrier, redirect, launch governor, cadence, half-cycle
steering, and componentwise actuator projection.  Its one architectural
difference from the assigned parent is a bounded posterior turn-shape
residual: multiply the odd target-derived turn command by the absolute
normalized anterior-joint velocity, release it during the existing large-error
redirect, convert that small posterior target angle to acceleration, and
allocate it after the posterior carrier.  This uses observed carrier motion
instead of a clock or exact vortex phase and gives target steering a posterior
path when anterior carrier authority is frequently occupied.

The candidate deliberately reproduces the one completed positive mechanism
rather than stacking an unvalidated approach or load gate.  Its next rollout
tests reproducibility: expect capture near or before `17.644 T`, total/observed
integrals no worse than `1.95985/1.34371 L`, the organized two-view wake, and
the completed `0.9663 L/T`, `0.03225`, and `0.01609` maximum speed/force/moment
envelope.  Reject the mechanism as fragile if the improvement does not
reproduce, if posterior saturation grows without integral/arrival benefit, or
if another pose or wake loses target-signed curvature, capture, or coherent
propulsion.  The candidate's CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive mechanics and robotic-fish phase-lag or wave-shape steering
source_mechanism: express bounded target-signed steering through posterior traveling-wave shape while preserving the propulsive carrier
transferable_invariant: when a coherent carrier closes the target but anterior authority is occupied, couple a small posterior curvature residual to an even observed carrier-motion envelope and an odd body-frame turn request
nontransferable_details: published gains, dimensional cadence, species or robot curvature envelopes, full-body kinematics, exact vortex phases, open-loop oscillator phase, and task-specific routes
policy_translation: normalize absolute anterior joint velocity by the state-feedback carrier scale, multiply it by the bounded body-frame turn command, release it under the existing geometric redirect, and allocate the resulting posterior angle-acceleration residual after the posterior carrier
falsification: reject if the arrival and distance-integral improvement fails to reproduce, the target-signed arc or capture is lost, posterior saturation or normalized loads grow materially, mirrored target commands do not mirror the residual, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

All reported outcomes and visual claims come from the assigned parent,
sampled completed CFD, inherited guidance, and inherited optimizer notes.  No
same-worker CFD result is claimed for this replication candidate.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`,
  byte-identical to the completed positive sample.  Its only architectural
  change from the assigned v43 parent is the phase-even posterior turn-shape
  residual and its carrier-first allocation.
- All `66` distinct direct `params.FIELD` references resolve against fields
  returned by `target_policy_params()`.  The lightweight Julia contract check
  returns two finite accelerations, and the solver editable-boundary check
  passes.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account.  Its three exact non-CFD checks were therefore
  run locally and separately; the material-guidance, policy-contract, and
  editable-boundary checks all pass.  The guidance check first exposed and then
  passed after removal of a duplicated assigned-parent marker in the rendered
  workspace `README.md`.  No formal CFD was run.
