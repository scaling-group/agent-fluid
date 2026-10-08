# Divergence-retained approach-turn candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver examples are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm.  The strongest completed policy is the axis-selective v43
  parent: it captures at `17.75400 T`, score `-0.07917`, and total/observed
  distance integrals `1.96508/1.34990 L`.  Its mean/max speed,
  any-joint acceleration-limit residence, and peak normalized planar
  force/moment are `0.7168/0.9603 L/T`, `44.14%`, and
  `0.03225/0.01609`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows for
  that parent and the reproduced full-axial comparator from release through
  capture.  Both actively self-propel along smooth target-signed arcs; compact
  startup structures develop into coherent alternating posterior wakes, with
  no passive advection, collision, boundary exit, wake collapse, or visible
  instability.  The approach-cadence sample has the same organized top-down
  row but a black oblique row, so it cannot establish a 3D-wake improvement.
- Three reproduced whole-launch axial gates capture later at `17.89700 T` and
  worsen the total/observed integrals to `1.97313/1.35927 L`.  They are closer
  by `0.0050/0.0195 L` at `2/4 T`, but the axis-selective parent leads by
  `0.0378/0.0720/0.0929/0.0909 L` at `8/10/12/16 T`.  The inherited
  energy-conditioned bridge also regresses to score `-0.08764` and integrals
  `1.97361/1.35867 L`; its early lead changes the route substantially without
  producing a new wake topology.  More launch authority is therefore not the
  next test.
- Response-retained approach cadence reaches the capture boundary only
  `0.0055 T` earlier than the parent but slightly worsens total integral to
  `1.96640 L` and score to `-0.08082`; its observed integral improves by only
  `0.000051 L`, maximum speed is unchanged, acceleration-limit residence rises,
  and its oblique sheet is unreadable.  This does not establish proximity-only
  cadence withdrawal as the limiting mechanism.
- Reconstructed parent observations instead isolate a late steering mismatch.
  Mean de-gaited bearing grows from `0.235 rad` over `12-14 T` to `0.432`,
  `0.486`, and `0.581 rad` over `14-16`, `16-17`, and `17 T` to capture, while
  mean closing remains `0.862`, `0.796`, `0.746`, and `0.695 L/T`.  The fish
  still captures, but it crosses with an increasingly off-axis target while
  the distance approach gate attenuates the already target-signed request.
  Head acceleration is at its limit for `37.98%` of the rollout versus only
  `6.16%` posterior residence, so this edit retains the existing allocated
  request rather than increasing the carrier or adding direct load feedback.

## One-candidate policy hypothesis

Materialize the completed axis-selective v43 parent as the single candidate.
Preserve its state-feedback carrier, total-speed base launch, axial-gated
phase-even energy residual, selective crossflow pose confidence, geometric
redirect, half-cycle steering, cadence scheduling, and carrier-first spillover.
Change only approach arbitration: when de-gaited bearing is outside the
existing centerline band, its windowed trend is moving farther from zero, and
the unscaled steering request has the target-correcting sign, continuously
retain part of the existing approach turn authority.  Proximity, bearing
excess, and divergence set the bounded retention; contraction or a wrong-sign
request releases it without a clock or route stage.

The intended signature is contraction rather than continued growth of late
de-gaited bearing, capture before `17.754 T`, and total/observed integrals below
`1.96508/1.34990 L`, while preserving the readable coherent two-view wake and
the parent's speed, acceleration-residence, force, and moment envelope.  The
new candidate's formal CFD occurs only after this worker exits; none of those
outcomes is claimed here.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish direction tracking
source_mechanism: apply bounded target-signed curvature while a large directional error remains unresolved, then release the burst when observed geometry contracts
transferable_invariant: proximity does not imply turn completion; retain existing steering authority only while normalized body-frame target angle is outside its centerline band and moving farther from zero
nontransferable_details: published gains, dimensional maneuver timing, species or robot kinematics, exact vortex phase, full-body curvature envelopes, and task-specific routes
policy_translation: blend the existing two-joint target-turn approach gain toward full authority using normalized de-gaited bearing excess, windowed bearing divergence, proximity, and target-correcting request sign; do not alter carrier phase, mean redirect selection, or actuator bounds
falsification: reject if late bearing does not contract, capture or distance integrals regress, the target-signed arc oversteers, the alternating two-view wake degrades, or speed, acceleration-limit residence, normalized force, or yaw moment materially exceeds the completed parent envelope
```

## Evidence boundary

All reported outcomes and visual claims come from completed sampled CFD, the
assigned parent guidance, sampled optimizer results, and inherited optimizer
notes.  The policy proposed here has no same-worker CFD evidence.

## No-CFD implementation audit

- Frozen-trace reconstruction against the completed parent is byte-equal
  outside the `2.1 L` approach region.  The new retention first activates at
  about `16.115 T`, reaches `0.627`, raises mean approach gain from
  `0.861` to `0.879` over `16-17 T` and from `0.667` to `0.770` thereafter,
  and changes projected acceleration by at most `3.670 rad/T^2`.  These are
  localization checks on a completed trace, not closed-loop performance.
- The single candidate is
  `dogfish_target_control_v45_divergence_retained_approach_turn`, with SHA-256
  `9f3aa906cde677633eb41c0f95da4a3e939c0e542fac6eb06989b32ae6144e78`.
  All `66` distinct direct `params.FIELD` references resolve against fields
  returned by `target_policy_params()`.  Synthetic divergent, contracting,
  and mirrored-direction states confirm that the gate selects divergence,
  releases on contraction, and keeps finite actions inside the componentwise
  acceleration bound.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account.  Its three prescribed commands were
  run locally and separately: the material-guidance check, lightweight Julia
  policy contract, and solver editable-boundary check all pass.  The duplicate
  rendered assigned-parent marker in `README.md` was removed so the required
  guidance comparison identifies exactly one parent.  No formal CFD was run.
