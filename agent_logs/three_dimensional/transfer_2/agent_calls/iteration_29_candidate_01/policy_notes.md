# Evidence-selected coupled terminal phase-allocation candidate

## Visual diagnosis before candidate selection

- All four current solver examples are byte-identical v41 rollouts.  Each
  satisfies the direct-uniform still-water contract (`U_infinity=[0,0,0]`, no
  cylinders or prewarm), captures at `24.640015T` and `0.748356L`, has mean
  distance `2.347937L` and score `-0.448328283`, and performs 284 inertial
  moving-window shifts.  Repetition establishes deterministic nominal
  behavior, not four independent mechanisms or held-out generalization.
- The combined v41 sheet was inspected from release through capture in both
  views.  The top-down row begins wake-free, shows self-propelled diagonal
  motion with a coherent alternating mid-plane vortex street, and finishes
  with a compact transverse hook into the target disk.  The oblique row shows
  compact three-dimensional Lambda2 structures persisting through the hook;
  there is no passive advection, out-of-plane escape, numerical breakup, or
  collision-like load event.  The trace agrees: peak absolute planar
  body-force/yaw-moment coefficients are `0.02303/0.03169/0.01559`, neither
  joint occupies a hard stop, and total exact-rate exposure is `13.839%`.
- No current sample has a failed termination.  The most informative distinct
  sampled regression is the completed posterior-only terminal-routing
  variant.  Its top-down and oblique sheets retain the same coherent wake and
  route class, but it captures later at `24.673016T`, worsens final distance
  from `0.748356L` to `0.748776L`, mean distance from `2.347937L` to
  `2.348364L`, and score from `-0.448328283` to `-0.448772903`.  It supplies
  no load or rate improvement: peak force/moment coefficients remain
  `0.02339/0.03172/0.01559`, total exact-rate exposure rises slightly to
  `13.955%`, and raw acceleration-envelope exposure stays near `73.5%`.
- The assigned parent records the complementary terminal redistribution
  negative: reclaiming safety-filtered posterior effort through anterior
  stroke headroom crosses one integration row earlier but worsens final/mean
  distance to `0.749001/2.348455L`, raises raw acceleration exceedance, and
  consumes most of the capture margin.  Inherited logs also show that broader
  reference-velocity feedforward and dual-joint rate barriers change the far
  route and lose capture.  Together these results identify coupled, localized
  phase allocation as the useful boundary and contradict another terminal
  split, residual, or scalar tune.

## Candidate hypothesis

Keep the current v41 controller byte-identical as this workspace's exactly one
candidate.  Preserve its observed-state anterior phase anchor, lagged
posterior traveling wave, normalized body-frame predicted-miss corridor,
steering-priority envelope, posterior stopping-stroke reserve, and posterior
rate coast.  Its extra collision-course residual remains coupled across both
joints and is spent only on the lagged-wave half-cycle aligned with the signed
target-derived request.

This is completed-evidence selection, not a same-worker CFD claim or scalar
gain edit.  The post-exit evaluation should reproduce capture, the coherent
wake and far route, zero joint hard-stop occupancy, and the low load class.
Reject the selection if nominal replication is lost.  Separately reject the
phase gate or coupled split on reflected or perturbed poses if either withdraws
necessary corrective steering; fixed-pose replication cannot establish that
generalization.

bookshelf_consulted: true
source_domain: Lighthill tail-emphasized reactive swimming plus asymmetric and sensor-modulated robotic-fish turning
source_mechanism: preserve an anterior phase anchor and lagged posterior traveling bend while allocating bounded sensory steering within a compatible observed half-cycle
transferable_invariant: retain posterior lag and state-inferred phase, but place a bounded target-derived correction according to the empirically successful coupled actuator response rather than assuming posterior exclusivity
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, full-body envelopes, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame collision-course residual, lagged-wave phase gate, coupled joint shares, and posterior safety filters; do not adopt another residual, scalar, or authority redistribution
falsification: reject if capture, far-route locality, coherent wake, zero joint hard-stop occupancy, or the low-load class fails to repeat, or if held-out reflections or pose perturbations show that the phase gate or coupled split removes required route correction

## Pre-evaluation validation

- The selected candidate and all four current sampled policies have LF
  SHA-256 `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`;
  the four trajectories and combined keyframe sheets are also byte-identical.
  The policy is therefore the one replicated completed mechanism, not a new
  same-worker CFD result.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Its three declared no-CFD commands were
  run directly and separately after removing the duplicate assigned-parent
  marker from the rendered workspace README.  Reusable-guidance semantics,
  the Julia public contract, and the solver editable-boundary audit pass; the
  contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
