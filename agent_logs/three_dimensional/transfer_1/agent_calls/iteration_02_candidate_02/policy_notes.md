# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and finite dynamics. Every rollout ended
  `left_domain`; none captured the target.
- The prefill and the strongest sampled candidate retain the transferred
  state-feedback oscillator and posterior lag. Their top-down rows show a
  coherent alternating vortex street and their oblique Lambda2 rows show
  compact three-dimensional wake structures through termination. They are
  self-propelled, not advected: the prefill closes from `12.328L` to `6.127L`
  and the course-residual candidate to `6.067L` before both reopen to about
  `10.5L` and cross the lower boundary near `26T`.
- The two direct mean-curvature replacements are informative failures. Their
  weaker or simplified steering destroys the useful route without producing a
  numerical failure: closest approach is only `12.272L` and `12.206L`, and the
  top-down and oblique sheets show an early clockwise/upward curl into the
  upper boundary after only `9.09T` and `7.79T`. The demonstrated carrier and
  its coupled steering paths should therefore be preserved.
- The speed-gated target-versus-velocity course residual is a real but small
  semantic improvement, not a solved mechanism. Relative to the prefill it
  improves score from `-12.163` to `-12.103` and closest approach by `0.060L`,
  and at `4T` reduces the signed target-course mismatch magnitude from about
  `0.91` to `0.31 rad`. By `8T` the mismatch has regrown to about `0.79 rad`;
  by `16T` it is about `1.31 rad`, heading is `1.286 rad`, and the rollout
  retains the same long downward turn and lower-boundary termination. Raising
  the course gain alone is therefore not supported.
- The inherited optimizer note explicitly proposes direct yaw-rate braking or
  a different steering actuator after this unchanged topology. Local crossflow
  remains only order `0.001--0.008U` during the useful and terminal phases, so
  a wake-rejection term is not the next missing capability.

## Candidate hypothesis

Use the best sampled course-aware controller as the scaffold. Add one compact
response-gated yaw brake to the posterior lag target: compute the normalized
body-frame target-versus-velocity course error, detect only measured recent yaw
whose sign is making that error worse, and add a small bounded mean posterior
tangent opposing that wrong-way yaw. This bypasses the inherited centerline
attenuation only during the observed turn reversal; correct-sign yaw, rest,
and the ordinary propulsive cycle receive no brake.

Expected test: preserve the coherent alternating wake and early distance
closure, but arrest the post-`8T` positive-yaw reversal so the course mismatch
does not grow through `1 rad` and the fish avoids the lower-boundary topology.
Reject the mechanism if closest approach regresses beyond `6.127L`, the wake
or speed collapses, either joint is driven into persistent saturation, the
brake reinforces wrong-way yaw, or termination remains the same long lower
exit.

## Non-CFD signal replay

Reconstructing the candidate gate on the two long sampled trajectories gives
the intended selectivity. On the course-residual trajectory it is zero at
`4T`, `8T`, and `12T` while recent yaw has the correcting negative sign, then
reaches about `-0.97` at `16T`, `20T`, and `24T` when positive yaw is worsening
the positive course error. The bounded request is active on about `36%` of
logged steps and never exceeds unit magnitude, corresponding to at most the
owned `4.5 deg` posterior-mean correction. This replay checks signal sign and
gating only; it is not CFD evidence that the brake will alter the trajectory.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: preserve a propulsive rhythm while a bounded observed-error redirect is released when the measured turning response is no longer wrong-way
transferable_invariant: separate the carrier from a small state-feedback correction that acts only when achieved yaw worsens achieved course relative to the body-frame target
nontransferable_details: published gains, robot or species geometry, dimensional cadence, exact vortex phase, prescribed C-start timing, and any world-frame route
policy_translation: retain the joint-state oscillator and posterior lag; form target and velocity angles from normalized body-frame observations and add an opposite-signed bounded posterior mean tangent only when course_error times recent_yaw_rate is positive
falsification: reject if early closure or wake coherence degrades, commands remain persistently saturated, the correction has the wrong yaw sign, or the same lower-boundary turn topology remains
