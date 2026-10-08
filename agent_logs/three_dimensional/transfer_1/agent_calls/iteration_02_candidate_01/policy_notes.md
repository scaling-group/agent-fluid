# Capture-turn hold candidate

## Evidence and visual diagnosis

- All four sampled rollouts report `uniform_direct`, zero background velocity,
  no cylinders, and no prewarm. Their motion is therefore self-propelled, not
  imposed advection.
- The transferred seed (`solver_2f352671b105`) forms a coherent alternating
  mid-plane vortex street and discrete three-dimensional Lambda2 structures.
  Its body speed reaches `0.87U` while sampled local flow stays below `0.03U`.
  It closes from `12.33L` to `4.78L`, but its wake and path curve downward as
  target bearing opens to more than `1.1 rad`; it exits at the lower boundary.
- The shared mean-curvature test (`solver_6f966e269bf4`, also present in the
  assigned parent's inherited result log) visibly curls upward almost at
  release, never develops the long productive wake of the seed, improves only
  to `12.28L`, and exits near its start at `7.71T`. This falsifies replacing the
  parent's steering structure with an always-active whole-wave curvature
  reference, even though shared curvature is a plausible abstract primitive.
- The velocity-lead redirect (`solver_d6318c8ad9e3`) retains an alternating
  wake but follows a broad downward arc, reaches only `7.33L`, and exits the
  lower boundary. A body-velocity lead is therefore not reused here.
- The prefilled response-gated redirect (`solver_8556f8eb9ecb`) is the strongest
  finite sample. It retains a coherent alternating top-down wake and paired
  oblique Lambda2 structures, and improves minimum distance to `2.46L`.
  Immediately before the miss, however, it is still moving at about `0.94U`;
  at `24.23T` the target is nearly abeam in body coordinates
  (`target_body ≈ (0.01,-2.46)L`) rather than in a capture corridor. Raw joint
  acceleration exceeds the `1800 deg/T^2` envelope in about `96%` of trace
  rows, so more additive steering acceleration is not credible unused
  authority. It passes above the target, builds distance again, and exits the
  left boundary.

## Policy hypothesis

Preserve the response-gated parent's far-field oscillator, posterior lag,
target-sign redirect, and half-cycle steering. Add one continuous
`capture-turn hold` mechanism: only when normalized target range is short and
body-frame angular misalignment is large, blend oscillator cadence toward a
bounded lower floor while leaving target-signed steering active. This should
create turning time and reduce drive-dominated clipping before the target
becomes abeam, without coasting on an aligned approach or altering the useful
far-field trajectory. The mechanism uses no clock, world coordinate, or case
identity.

Falsification: reject the transfer if early distance closure or the coherent
wake deteriorates before the hold gate activates; if minimum distance does not
beat `2.46L`; if the target again becomes abeam outside the `0.75L` capture
radius; or if lower near-target cadence does not materially reduce raw action
clipping while the gate is active.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor feedback continuously reallocates rhythmic propulsion and turning authority as range and alignment change
transferable_invariant: preserve a propulsive rhythm far away, but reduce excess drive while persistent near-target misalignment requires turning time
nontransferable_details: published CPG gains, dimensional frequencies, species kinematics, exact vortex phases, and task-specific routes
policy_translation: combine normalized body-frame distance and target angle into a smooth capture-hold gate that lowers joint-state oscillator cadence while retaining bounded target-signed redirect feedback
falsification: reject if the far-field wake or closure worsens, the prior abeam miss remains outside 0.75L, or near-target saturation is not relieved
