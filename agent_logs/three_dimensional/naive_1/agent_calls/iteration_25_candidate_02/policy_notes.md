# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned solver examples satisfy the frozen evidence contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. I
  inspected the combined top-down vorticity and oblique body/Lambda2 rows for
  the best sampled capture, the prefilled broadside-reserve capture, and the
  inherited compound failure, then cross-checked them against scores,
  diagnostics, trajectories, executable policy diffs, assigned-parent
  guidance, and inherited optimizer notes.
- The two executable-identical half-cycle envelope-redistribution samples are
  genuinely self-propelled: their top-down streets remain alternating and
  target-bending, while their oblique caudal structures stay compact through
  capture. They capture at `18.8265--18.8815T` and reproduce mean distance
  `2.08855--2.08896L`, below the geometry-scheduled carrier's inherited
  `2.09340--2.09542L` band. Their rate contact (`11.01--11.07%` anterior,
  `14.88--14.93%` posterior), acceleration contact (`60.85--61.00%`,
  `72.97--73.27%`), and peak planar load (`0.03066--0.03171`) do not establish
  actuator relief.
- The prefilled broadside-reserve sample also preserves both coherent wake
  rows and captures at `18.7055T`, mean distance `2.09386L`. Its normalized
  body-lateral gate first activates at `17.7045T` and `1.5945L`, peaks at only
  `0.03851` curvature request near `0.9645L`, then releases before capture.
  This proves that a separate forward-qualified reserve can be exercised
  without destroying the reliable geometry-scheduled carrier, but does not
  establish a distance-integral or demand improvement.
- The new inherited semantic failure is the direct composition of those two
  capture-compatible mechanisms. Its top-down street remains energetic and
  the oblique row retains compact caudal structures, yet it first enters the
  broadside sector at `12.5950T` and `6.0626L`, reaches only `1.90495L`, turns
  away, and exits left at `31.1905T` with final/mean distances
  `9.45478/8.67423L`. This is route-allocation failure rather than wake
  collapse or instability. Lower rate contact (`9.59%/11.53%`) is not useful
  relief because capture is lost; acceleration contact remains high
  (`64.24%/70.96%`) and peak planar force/moment rise to `0.03411/0.01741`.
  The result rejects simultaneous envelope redistribution and broadside
  reserve, not either isolated mechanism.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and biological burst redirect
source_mechanism: observed direction error continuously hands control priority from cruise rhythm allocation to a bounded redirect, then measured response releases the redirect
transferable_invariant: do not superpose two capture-compatible gait modifiers when they compete for the same two joints; use normalized body-frame geometry to arbitrate them while preserving the traveling wave
nontransferable_details: published gains, robot geometry, species-specific C-start kinematics, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: on the prefilled broadside-reserve carrier, admit the sampled common-envelope half-cycle redistribution only in the forward-aligned sector and smoothly reduce it to zero by the inherited broadside onset; beyond that boundary retain only geometry-scheduled relief plus the existing target-signed curvature reserve and response release
falsification: reject if capture or either coherent wake row is lost, the same broadside-to-left-exit topology recurs, the redistribution mean-distance benefit disappears without a robustness or route benefit, or actuator contact and planar loads materially exceed the isolated-carrier bands
```

## Single-candidate policy hypothesis

Add one geometry-authoritative arbitration mechanism to the prefilled
broadside-reserve carrier. Reintroduce the sampled half-cycle envelope
redistribution, but multiply it by a smooth cruise-sector gate that falls from
one on the target axis to zero at the existing `0.55` broadside onset. The
broadside reserve remains zero through that handoff and starts only after the
redistribution has fully released, so the two modifiers cannot be active
together. The common mean amplitude relief, target-owned curvature sign,
displacement-only half-cycle steering, correcting-yaw release, posterior lag,
damping, and exact acceleration projection remain unchanged.

This is one state-feedback arbitration architecture, not scalar-only gain
tuning. It translates only normalized body-frame target direction and observed
joint displacement into the two-joint contract; it adds no time, route,
coordinate, target identity, instantaneous velocity residual, posterior-only
allocation, or pointwise rate barrier. Formal CFD occurs only after this worker
exits. Accept the candidate only if capture and both wake views survive; credit
the combination further only if it also retains the isolated redistribution's
distance-integral band or changes the inherited compound-failure topology.
