# Phase-even posterior turn-shape promotion

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  No termination failure exists in this sample.  The
  assigned parent is therefore the informative mechanism-level negative
  comparator: its axial-confident posterior approach wave captures at
  `17.74850 T`, score `-0.07899`, and total/observed distance integrals
  `1.96493/1.34985 L`, essentially matching the completed v43 base outside a
  terminal-only change.
- The completed phase-even posterior turn-shape sample is the only material
  semantic improvement.  It captures at `17.64401 T`, score `-0.07419`, and
  total/observed integrals `1.95985/1.34371 L`: `0.10450 T` earlier and
  `0.00508/0.00614 L` lower than the assigned parent.  It is closer at every
  `2 T` checkpoint through `12 T`; it gives back only `0.0071/0.0106 L` at
  `14/16 T` before the earlier capture.  The v43 base and the ungated
  posterior approach-thrust sibling capture at `17.75400/17.74850 T` with
  total integrals `1.96508/1.96520 L`, confirming that another approach-local
  propulsion term is not the useful distinction.
- I inspected the combined release-to-capture sheets for the phase-even winner
  and assigned parent, including both the top-down mid-plane vorticity row and
  oblique body/Lambda2 row.  Both show active self-propulsion along the same
  smooth target-signed arc.  A compact release disturbance develops into a
  coherent alternating posterior street, and the oblique view retains compact
  paired caudal wake structures through capture; neither sheet shows passive
  advection, collision, reversal, domain exit, or visible wake breakdown.
  Thus the winner improves the route without needing a new wake topology.
- The metric cross-check supports the visual comparison.  Relative to the
  assigned parent, the phase-even controller changes mean/max speed only from
  `0.71699/0.96031` to `0.71993/0.96625 L/T`, moves residence from the
  anterior joint to available posterior authority
  (`37.96/6.23%` to `35.97/8.10%`), lowers any-joint residence from `44.19%`
  to `43.83%`, and leaves peak normalized planar force/moment unchanged at
  `0.03225/0.01609`.  This is evidence for a state-to-actuator steering
  translation, not for greater carrier amplitude, cadence, or terminal thrust.

## One-candidate policy hypothesis

Promote the completed phase-even posterior turn-shape controller as the sole
candidate.  Remove the assigned parent's approach-only posterior propulsion
residual and preserve the sampled winner byte-for-byte: retain the established
carrier, target sensing, crossflow pose confidence, redirect, launch governor,
half-cycle steering, carrier-first spillover, and componentwise projection;
add only its bounded posterior turn-shape residual.  The residual multiplies
the ordinary bounded body-frame turn command by an absolute normalized
anterior-joint velocity envelope and releases during the large-error redirect.
It therefore asks the posterior joint to express target-signed curvature when
the traveling carrier is dynamically active, without adding a clock, route,
world-frame cue, or scalar-only carrier retune.

The next CFD evaluation should reproduce capture near `17.644 T`, total and
observed distance integrals no worse than `1.95985/1.34371 L`, the organized
two-view wake, and the sampled speed/action/load envelope.  Reject promotion
if the earlier launch-to-middle lead or capture does not reproduce, if either
integral returns to the parent band, if the target-signed arc or alternating
wake is lost, or if posterior saturation, speed, force, or moment grows
materially.  The current candidate's formal CFD occurs only after this worker
exits; the completed sampled rollout is prior evidence, not a same-worker
result.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive swimming and sensor-modulated robotic-fish wave-shape steering
source_mechanism: preserve a traveling carrier while expressing bounded turning through posterior wave shape during observed carrier motion
transferable_invariant: when coherent propulsion and a correct-sign route request persist but anterior steering authority is occupied, couple target-signed posterior curvature to a reflection-even observed joint-motion envelope
nontransferable_details: published gains, dimensional frequency or amplitude, species and robot kinematics, exact vortex phases, clocked CPG phase, and task-specific routes
policy_translation: multiply the bounded normalized body-frame turn command by absolute anterior joint velocity normalized by carrier frequency and amplitude, release it during the existing large-error redirect, convert the small posterior target-angle residual to acceleration, and retain carrier-first componentwise projection
falsification: reject if the completed early-route and integral gains do not reproduce, capture or target-signed curvature regresses, posterior saturation or normalized loads grow materially, mirrored target commands do not mirror the residual, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

Outcome and visual claims above come from the assigned parent, sampled solver
results, assigned parent guidance, and inherited optimizer notes.  No formal
CFD was run in this worker.

## No-CFD implementation audit

- The sole candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`,
  byte-identical to the completed winning sample.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact non-CFD commands were then
  run locally and separately.  The material guidance/notes check, lightweight
  Julia policy contract, and solver editable-boundary check all pass.  The
  guidance check first exposed an inherited duplicate assigned-parent marker
  in the rendered workspace `README.md`; removing only the first duplicate
  marker left one unambiguous assigned parent and made the check pass.
- The Julia contract confirms the public parameter/state-feedback interface
  returns two finite accelerations.  The deterministic guidance check also
  accepts the parameter schema, and the boundary check confirms that the
  candidate policy is the only solver file changed.  No CFD was run.
