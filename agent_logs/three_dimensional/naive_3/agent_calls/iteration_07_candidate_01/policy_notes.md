# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations are finite direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no instability.
  The motion in both visual rows is therefore self-propulsion rather than
  advection or an initialization artifact.
- I inspected the combined top-down-vorticity and oblique-Lambda2 sheets for
  the strongest sampled carrier (`2.443L` minimum at `17.869T`) and the
  informative slip-gated posterior-phase failure (`2.822L` at `17.072T`). Both
  sustain long alternating three-dimensional wakes and visible propulsion from
  release through the pass. Both also take the same broad route: approach from
  the upper right, pass below the target while still translating downward,
  rotate onto a near-vertical powered track, and leave the lower boundary.
  The phase edit changes the late body orientation but neither destroys the
  wake nor creates the missing redirect.
- Scalar and trace evidence agree with the sheets. The parent has mean distance
  `8.443L`, exits at `31.097T`, and is best at `2.443L`; full-direction
  posterior gating is nearly neutral at `2.494L`, while distance-only carrier
  relief (`2.845L`, mean `8.525L`) and amplitude-normalized slip-gated phase
  modulation (`2.822L`, mean `8.508L`, exit `29.964T`) are worse and retain the
  lower-exit class. The sampled phase mechanism is therefore a concrete
  negative result, not evidence that a coherent wake alone improved control.
- On the parent's inbound `8L` and `6L` crossings the full target direction is
  only about `0.095/0.119 rad`, but the velocity direction is about
  `-0.629/-0.618 rad`, producing roughly `0.72 rad` velocity-to-target course
  error at `0.91U`. At the `2.443L` minimum, course error is about `1.21 rad`
  while speed remains `0.685U`. This mismatch appears before the miss even
  though the body-axis target error is small. The anterior acceleration is
  already clamped for about `74.6%` of parent samples, whereas the posterior is
  clamped for about `35.4%`, so the evidence supports testing a bounded
  posterior low-frequency steering channel rather than more anterior effort.
- The assigned parent guidance rejects another static-curvature or scalar-drive
  sweep. Inherited logs also reject direction-gated posterior half-cycle
  asymmetry and a response-gated stronger C-bend; a separate inherited worker
  proposed anterior sideslip compensation, but no sampled CFD result for that
  proposal is present here. This candidate does not claim that unobserved
  result and instead isolates course feedback in the posterior mean target.

## Policy hypothesis

Preserve the parent's `7 deg` bearing/yaw-rate anterior mean-curvature reflex,
alignment-gated joint-state oscillator, posterior traveling wave, and command
reserve. Add one mechanism: after translational speed is established, compute
the wrapped difference between full body-frame target direction and measured
body-frame velocity direction, and map it to a small bounded posterior mean
offset. This asks the tail's available low-frequency channel to correct the
actual course while leaving anterior cruise steering and oscillator phase
unchanged. The speed gate makes startup direction-free, and the construction is
reflection equivariant.

Expected evidence is the parent's coherent early wake plus a shallower inbound
course by `8--16T`, a closest approach below `2.443L`, and preferably capture or
a new useful termination/trajectory class. Falsify the mechanism if it damages
early distance progress, suppresses the alternating wake, increases posterior
joint/command-limit residence or load peaks, produces a tight curl, or repeats
the powered lower exit in the established `2.4--2.9L` miss band.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and robotic-fish tail-offset turning models
source_mechanism: preserve a propulsive oscillator while measured direction error commands a bounded low-frequency tail bias
transferable_invariant: established-speed velocity-to-target course error can drive a bounded posterior mean offset while measured joint state supplies the traveling-wave phase
nontransferable_details: published gains, dimensional frequencies, robot geometry, species kinematics, clocked CPG phase, exact vortex timing, and task-specific routes
policy_translation: wrap full target direction minus body-frame velocity direction, fade it at low speed, and add its bounded response only to the posterior mean target around the evidenced two-joint carrier
falsification: reject if early progress or wake coherence worsens, posterior saturation or loads grow materially, the route curls, closest approach does not beat 2.443L, or the powered lower-boundary exit persists
```

## Implemented candidate and dry validation

The implementation retains the parent carrier verbatim except for the bounded
posterior mean offset. Replaying completed parent observations through that
static feedback map (not a new hydrodynamic rollout) requests about
`3.33/3.35 deg` at the inbound `8L/6L` crossings, releases to `1.88 deg` at
`4L`, and requests `3.32 deg` at the prior minimum. Thus the new channel stays
below its `4 deg` cap and does not silently alter carrier phase or amplitude.

The mandated guidance, lightweight-policy, and solver-boundary checks pass, as
do all `324` repository tests. Synthetic mirrored target, velocity, bearing,
yaw-rate, joint, and joint-rate states produce sign-mirrored finite commands;
zero-speed and zero-target-distance edge states remain finite; all direct
`params.FIELD` references are owned by `target_policy_params`; and extreme dry
states remain within the configured command clamp. Formal CFD remains deferred
to the evaluator.
