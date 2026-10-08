# Candidate wake-policy notes

## Evidence diagnosis before policy edit

The assigned parent is `solver_5ffb922d9b74`, with guidance inherited from
`optimizer_3c464cc18cae`.  Its optimizer note proposed a sub-limit
state-feedback carrier plus turn-rate-closed posterior mean curvature.  The
current evidence now includes that rollout, the common naive seed
`solver_5c7c5c0e3ed9`, and two sibling mean-curvature variants
`solver_3a74301ccb21` and `solver_c1d44a6099d6`.

All four evaluations satisfy the direct-uniform still-water contract:
`U_infinity=0`, no cylinders, and no prewarm.  In the combined keyframe
sheets, both the top-down vorticity row and oblique Lambda2 row show genuine
self-propulsion and a coherent three-dimensional caudal wake.  They also show
the same control failure: after modest leftward motion, the body and wake bend
into a tight upward arc immediately before the upper virtual-boundary exit.
The moving-window shifts follow that motion; they do not explain the body
rotation.

The unbiased seed is still the strongest finite sample: it reaches
`12.078L` at `6.358T`, then exits at `8.547T` with final distance
`12.380L` and score `-14.825`.  It is actuator-distorted, with either joint
within about 0.4% of the `260 deg/T` speed cap on 56/1554 samples and a raw
acceleration beyond `1800 deg/T^2` on 811/1554 samples.  However, removing
that saturation did
not fix steering.  The posterior-bias candidates `solver_3a74301ccb21` and
the assigned parent have no sampled speed or acceleration clipping, yet exit
at `8.916T` and `9.080T`, with respective minima/finals of
`12.226/13.084L` and `12.296/13.405L`.  The shared/anterior curvature
variant `solver_c1d44a6099d6` is worst at `12.235/13.829L`, score
`-16.465`, and again reaches the speed cap.  Thus actuator headroom is
necessary but insufficient, while scalar changes to static mean curvature
have not changed the termination class or useful trajectory topology.

The trace gives a more specific steering clue.  Across the unbiased seed,
negative anterior-joint half-cycles coincide with negative mean yaw moment and
negative mean yaw acceleration, while positive half-cycles have the opposite
sign.  The initial target bearing is only about `+0.155 rad`; by each
target-aware candidate's closest approach it has already crossed negative
(`-0.114` to `-0.330 rad`), after which the mean-bend response does not
reverse the broad curl.  This supports changing the actuation primitive rather
than increasing another curvature gain.

## Policy hypothesis

Use the unsaturated `0.90T`, `18 deg` anterior carrier observed in
`solver_3a74301ccb21`, but remove static mean curvature.  Convert bounded
body-frame bearing into a small desired yaw-rate ratio and compare it with
gait-normalized measured yaw rate.  The bounded error selectively reinforces
only the anterior half-stroke moving toward the requested turn side; the other
half-stroke keeps the unmodified oscillator acceleration.  The posterior joint
continues to follow the same lagged traveling-bend target, so steering changes
beat asymmetry without erasing alternation or prescribing a clock phase.

The candidate should preserve the coherent wake while reversing steering
authority promptly when bearing changes sign, remain below the acceleration
envelope, outlive the approximately `9T` upper exit, and sustain distance
decrease beyond the sampled `12.078L` minimum.  Falsify it if the body still
forms the same upward curl, if bearing remains negative after its first
crossing instead of returning toward zero, if the wake or forward progress
collapses, or if joint speed/acceleration clipping recurs materially.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: target feedback strengthens the turn-useful half-cycle of an otherwise alternating propulsive gait
transferable_invariant: steering authority can be created by bounded phase-selective asymmetry while preserving the traveling wave and reversing the favored side when body-frame target error reverses
nontransferable_details: published gains, dimensional cadence, clock-driven CPG phase, robot or species kinematics, exact vortex phase, and task-specific routes
policy_translation: infer half-cycle from anterior joint velocity, map bounded body-frame bearing and gait-normalized yaw response to a bounded turn error, and add acceleration only while the joint moves toward that error's requested side; retain the posterior state-feedback lag
falsification: reject if the upper-boundary curl and negative-bearing overshoot persist, target progress does not beat the seed minimum, propulsion loses its alternating 3D wake, or actuator clipping returns
```
