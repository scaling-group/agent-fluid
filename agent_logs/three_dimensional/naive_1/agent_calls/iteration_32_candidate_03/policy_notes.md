# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled examples satisfy the frozen contract: direct uniform
  initialization in still water at `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three are
  executable-identical half-cycle envelope-redistribution runs. They capture
  at `18.6505--18.8815T`, with mean distance `2.08855--2.09222L`; the fourth
  adds a rearward-only multiplier that is inactive on its captured route and
  finishes at `18.9640T` with mean distance `2.09072L`.
- I inspected all four sampled combined sheets and the inherited completed
  cruise-lag and exact-redistribution-failure sheets from release through
  termination. Every sheet begins in visibly quiescent water. The sampled
  captures and cruise-lag capture develop a coherent target-bending
  alternating top-down street and compact caudal Lambda2 structures. Their
  translation is self-propelled, lateral motion remains part of the productive
  traveling bend, and neither wake row collapses before capture.
- The inherited exact-redistribution miss is the informative failure. It has
  the same executable SHA and parameters as three sampled captures, retains an
  energetic two-view wake, but starts curving below the target after about
  `16T`, reaches only `1.25093L` at `19.1345T`, and exits left at `32.6370T`
  and `9.94426L`. This is a route-reliability failure, not passive advection,
  weak propulsion, collision, or instability. It is also a second inherited
  executable-equivalent miss after the prior `0.81206L` result, so the earlier
  robustness falsification boundary has now been crossed.
- Metrics agree with that diagnosis. The three sampled captures contact the
  anterior/posterior acceleration limit on `60.85--61.00%`/`72.97--73.27%`
  of rows and the rate limit on `11.01--11.07%`/`14.88--15.07%`; the miss has
  comparable peak planar loads (`0.01520/0.02740`, moment `0.01564`) and even
  lower rate contact, so neither wake energy nor demand relief predicts route
  success. A completed `6%` cruise-aligned posterior-lag modulation also keeps
  both wake rows and captures at `18.7825T`, but worsens mean distance to
  `2.10021L` and score to `-0.21262`; stronger aligned tail lag is therefore
  not the recovery mechanism.
- A first-approach reconstruction gives a pre-overshoot signal that is distinct
  from instantaneous body yaw. Course alignment is the normalized dot product
  of the body-frame target vector and body-frame translational velocity. The
  exact miss is below `0.75` alignment on `21.6%` of rows between `2--3L` and
  `78.1%` below `2L`; all three sampled captures have `0%` such rows between
  `2--3L`. This signal measures loss of target-directed translation without
  using a world route. It will not add velocity directly to route curvature,
  because inherited transverse-velocity residuals already fail that boundary.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping control and terminal capture scheduling
source_mechanism: preserve the posterior-lagged traveling-wave carrier, but separate broad target steering from an approach regime that removes a nonessential gait modulation when accumulated course displacement appears
transferable_invariant: a bounded approach-recovery mode should retain target-owned mean curvature and the coordinated traveling wave while withdrawing only an opportunistic phase allocation that can compete with recovery
nontransferable_details: published gains, dimensional frequencies, robot geometry, species-specific envelopes, prescribed clock phase, exact vortex phases, and task-specific routes
policy_translation: inside a normalized `3L` approach envelope, form bounded course alignment from `target_body_L` and `velocity_body_U`; only when alignment falls below the evidenced capture band, smoothly fade the half-cycle amplitude-relief redistribution toward the already capture-class geometry-scheduled carrier, while leaving displacement-only phase steering, non-inverting response release, mean curvature, and posterior lag unchanged
falsification: reject if capture or either coherent wake row is lost, if a miss still develops after course alignment falls, if normal captures leave the established arrival and mean-distance bands without a robustness benefit, or if actuator/load contact worsens materially
```

## Single-candidate policy hypothesis

Add one course-qualified approach-recovery arbitration to the current
redistribution controller. It computes no new steering sign and never adds a
velocity residual to curvature. Far from the target, or whenever translation
remains target-aligned, the candidate is exactly the parent. During a near
approach with poor normalized course alignment, it continuously withdraws only
`half_cycle_relief_redistribution`, falling back toward the simpler
geometry-scheduled common envelope that has repeated capture evidence. The
target-signed curvature shares, correcting-yaw release, displacement-only
half-cycle steering, posterior lag, mean amplitude relief, and final
acceleration projection are unchanged.

The expectation is non-interference on the common capture trajectory and an
earlier, phase-neutral recovery response on the newly evidenced miss topology.
The `3L` onset and `0.75` course floor are normalized evidence boundaries for
this test, not transferred gains. Formal CFD occurs after this worker exits;
no same-worker improvement is claimed here.
