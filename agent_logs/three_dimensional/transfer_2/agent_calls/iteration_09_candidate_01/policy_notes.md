# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled evaluations are finite captures from direct uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their
  top-down rows show self-propelled targetward arcs behind coherent alternating
  wakes; their oblique rows show compact three-dimensional caudal structures
  without wake breakup, collision, domain-exit precursors, or passive
  advection.
- `solver_7b0034b927d0` is the strongest sampled trajectory. Adding
  state-derived half-cycle route shaping to the terminal course redirect moved
  capture from `20.971T` to `20.207T`, reduced the distance integral from
  `2.16674L` to `2.11794L`, and improved score from `-0.27435` to `-0.22712`.
  At `16T`, `18T`, and `20T` it was at `3.649L`, `2.399L`, and `0.908L`,
  versus `4.048L`, `2.873L`, and `1.467L` for the unmodified redirect. Peak
  anterior/posterior angles remained `0.534/0.590 rad`, below the
  `0.785 rad` hard limit, and peak body-force/moment coefficients remained
  near `0.023/0.013`. The wake images agree that this is productive steering,
  not a scoring artifact.
- The middle-field course gate is the informative lower-performing structural
  comparison: it also captured, but merely starting the same course redirect
  farther out reached only `20.653T`, `2.16524L`, and `-0.27336`. The sampled
  line-of-sight lead is a smaller but independent positive result: on the
  otherwise unmodified redirect it reached `20.471T`, `2.16055L`, and
  `-0.26940`, while lowering mean absolute commands from `(18.67,18.02)` to
  `(17.89,17.26) rad/T^2`. This supports measured route rotation, not a wider
  distance gate or a higher actuator limit, as the compatible next signal.
- The half-cycle sample changes the useful middle trajectory while the
  line-of-sight lead acts through the established approach-gated C-bend. Their
  roles are therefore separable: state-derived joint phase allocates route
  steering during propulsion, while measured target-ray rotation leads the
  terminal redirect. The inherited logs show that the redirect itself was the
  semantic capture mechanism after `2.58L` and `1.73L` misses, so neither the
  carrier nor its full target-to-velocity course error should be replaced.

## One-candidate hypothesis

Use the best sampled half-cycle controller as the carrier and add the evaluated
line-of-sight rotation term only to its existing terminal redirect signal.
Reconstruct inertial target-ray rotation from recent body-frame bearing rate
plus recent yaw rate, gate it by measured closing, and pass it through the
same bounded head-bias and posterior-curvature map. Preserve the target-vector
course error, joint-state phase, posterior lag, distance/closing drive relief,
and `31 rad/T^2` soft command envelope.

Expected signature: preserve the coherent far-field wake and the half-cycle
sample's earlier targetward course, then reduce residual target-ray rotation
inside the last `2L`. Prefer capture earlier than `20.207T` or a lower distance
integral than `2.11794L`. Reject the combination if capture or the distance
integral regresses outside the current captured spread, the terminal arc
chatters or oversteers, the alternating/3D wake loses coherence, joint-angle
residence appears above 90% of its hard limit, or command, force, and moment
histories worsen materially.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking combined with target-conditioned CPG half-cycle turning
source_mechanism: measured directional response leads a bounded terminal bend while joint-state half-cycle asymmetry preserves propulsive route steering
transferable_invariant: separate propulsive phase allocation from slow observed route rotation, and blend both continuously into a bounded target-relative turn without replacing the traveling wave
nontransferable_details: published gains and duty ratios, dimensional update rates, clock phase, species-specific kinematics, world-frame paths, exact vortex phases, and task-specific routes
policy_translation: retain normalized anterior-joint velocity as the half-cycle signal; during normalized body-frame closing approach add bearing-rate-plus-yaw-rate line-of-sight rotation to target-to-velocity course error before the existing two-joint C-bend map
falsification: reject if the sampled half-cycle capture timing or integral regresses, terminal steering oscillates, wake coherence is lost, or command, joint, force, and moment limits worsen
