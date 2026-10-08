# Phase-even posterior turn-shape promotion

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  The assigned parent is the useful negative comparator:
  its axial-confident posterior approach wave captures at `17.74850 T`, score
  `-0.07899`, and total/observed distance integrals `1.96493/1.34985 L`,
  essentially preserving the preceding v43 route outside a terminal-only
  change.
- Three byte-identical sampled copies of the phase-even posterior turn-shape
  controller reproduce capture at `17.64401 T`, score `-0.07419`, and
  total/observed integrals `1.95985/1.34371 L`.  Relative to the assigned
  parent, this is `0.10450 T` earlier and `0.00508/0.00614 L` lower.  The
  phase-even rollout is closer at every `2 T` checkpoint through `12 T`, gives
  back only `0.0071/0.0106 L` at `14/16 T`, and then captures earlier; this is
  a route-level improvement rather than only a deeper terminal sample.
- I inspected the combined release-to-capture sheets for a reproduced
  phase-even rollout and the assigned parent, including the top-down mid-plane
  vorticity rows and oblique body/Lambda2 rows.  Both show active propulsion
  along the same smooth target-signed arc.  Their compact release disturbance
  develops into a coherent alternating posterior street, and the oblique
  views retain compact paired caudal structures through capture.  Neither
  shows passive advection, collision, reversal, domain exit, or wake collapse,
  so the useful distinction is steering allocation rather than a new wake
  topology.
- The trace cross-check supports that diagnosis.  Relative to the assigned
  parent, the phase-even controller changes mean/max speed only from
  `0.71699/0.96031` to `0.71993/0.96625 L/T`, shifts limit residence from the
  anterior joint into available posterior authority (`37.96/6.23%` to
  `35.97/8.10%`), lowers any-joint residence from `44.19%` to `43.83%`, and
  leaves peak normalized planar force/moment at `0.03225/0.01609`.  Its final
  heading error is more oblique than the earlier v43 base (`0.2910` versus
  `0.0518 rad`), so the evidence supports faster first-crossing capture, not
  terminal alignment or holding.

## One-candidate policy hypothesis

Promote the completed phase-even posterior turn-shape controller as the sole
candidate.  Remove the assigned parent's approach-only posterior propulsion
residual and preserve the sampled winner byte-for-byte: retain the carrier,
target sensing, selective crossflow pose confidence, large-error redirect,
launch governor, half-cycle steering, carrier-first spillover, and
componentwise projection.  The distinguishing residual multiplies the bounded
ordinary body-frame turn command by a reflection-even normalized anterior
joint-motion envelope and releases during the large-error redirect.  It uses
posterior authority to express target-signed curvature while the carrier is
active, without adding a clock, world-frame route, exact wake phase, or scalar
carrier retune.

The next CFD evaluation should reproduce capture near `17.644 T`, total and
observed integrals no worse than `1.95985/1.34371 L`, the organized two-view
wake, and the sampled speed/action/load envelope.  Reject promotion if the
early-to-middle closure lead or capture fails to reproduce, either integral
returns to the parent band, the target-signed arc or alternating wake is lost,
or posterior saturation, speed, force, or moment grows materially.  The
current candidate's formal CFD occurs only after this worker exits; completed
sampled rollouts are prior evidence, not a same-worker result.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive swimming and sensor-modulated robotic-fish wave-shape steering
source_mechanism: preserve a traveling carrier while expressing bounded turning through posterior wave shape during observed carrier motion
transferable_invariant: when coherent propulsion and a correct-sign route request persist but anterior steering authority is occupied, couple target-signed posterior curvature to a reflection-even observed joint-motion envelope
nontransferable_details: published gains, dimensional frequency or amplitude, species and robot kinematics, exact vortex phases, clocked CPG phase, and task-specific routes
policy_translation: multiply the bounded normalized body-frame turn command by absolute anterior joint velocity normalized by carrier frequency and amplitude, release it during the existing large-error redirect, convert the small posterior target-angle residual to acceleration, and retain carrier-first componentwise projection
falsification: reject if the reproduced early-route and integral gains disappear, capture or target-signed curvature regresses, posterior saturation or normalized loads grow materially, mirrored target commands do not mirror the residual, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

Outcome and visual claims above come from the assigned parent, sampled solver
results, assigned-parent guidance, and inherited optimizer notes.  No formal
CFD was run in this worker.

## No-CFD implementation audit

- The sole candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`,
  byte-identical to all three completed winning samples.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact non-CFD commands were then
  run locally and separately.  The material guidance/notes check, lightweight
  Julia policy contract (including the parameter-schema guard), and solver
  editable-boundary check all pass.
- The Julia contract returns two finite accelerations from the representative
  state, and the boundary check confirms that the candidate policy is the only
  solver file changed.  No formal CFD was run.
