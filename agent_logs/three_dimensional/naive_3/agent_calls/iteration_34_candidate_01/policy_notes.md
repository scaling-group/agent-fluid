# Phase-balanced asymmetric terminal-energy candidate

## Evidence diagnosis before the policy edit

- All four sampled solver evaluations and both completed assigned-parent
  evaluations satisfy the frozen Phase 2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  the top-down mid-plane-vorticity and oblique body/Lambda2 rows of the sampled
  `solver_6eb170b0d70a` tight return, the prefilled
  `solver_b5de8ff4a388` failure, and both assigned-parent keyframe sheets.
  Every fish visibly self-propels and retains a coherent alternating planar
  wake with compact three-dimensional structures. Passive advection, wake
  collapse, collision, domain exit, and numerical instability do not explain
  the misses.
- The sampled terminal course hold (`solver_6eb170b0d70a`) remains the useful
  geometric scaffold: it reaches `1.241/4.158/2.082L` minimum/mean/final
  distance and spends about `0.47T` inside `1.25L`. At its minimum it is still
  moving at `0.669U` with course error `1.692 rad`, course dot `-0.121`, and
  anterior/posterior joint velocity about `-0.260/0.108 rad/T`. Its tight
  return and compact oblique wake contrast with the broad low-activity loops
  of the rear-centerline selector (`2.366L`), equilibrium unbend (`2.215L`),
  and fixed-sign restart (`2.369L`). Those three sampled descendants preserve
  propulsion but settle near a common negative C-bend, so static equilibrium
  edits and zero-velocity signed restarts remain closed.
- The assigned parent's requested-sign half-cycle pulse is another concrete
  negative result: it reaches only `1.702/3.921/3.574L`, never enters `1.5L`,
  and collapses mean absolute joint velocity inside `2L` to about
  `0.028/0.028 rad/T`. Its acceleration vanishes quadratically near zero
  joint velocity and cannot destabilize the parked bend; retuning its pulse
  amplitude, velocity scale, or terminal radius is unsupported.
- The later assigned-parent phase-balanced energy regulator is the first new
  semantic improvement. It reaches `1.175/4.041/3.243L`, remains inside
  `1.25L` for about `2.35T` and inside `1.5L` for about `6.62T`, and preserves
  mean absolute joint velocity of about `0.775/0.360 rad/T` inside `2L`.
  Relative to the `1.241L` course hold, anterior/posterior clamp residence
  falls from about `0.329/0.102` to `0.227/0.103`, while force and moment RMS
  also fall. At its closest pass the fish is still moving at `0.683U` with
  course error `1.682 rad`, course dot `-0.111`, active joint velocity
  `-0.394/0.260 rad/T`, and ample command reserve. The visual and numeric
  evidence therefore supports the phase-balanced regulator as the new
  scaffold, but the still-tangential miss and worse final distance show that
  sustaining the rhythm alone does not supply enough inward steering.

## Policy hypothesis

Preserve the completed phase-balanced terminal-energy policy, including its
course-hold geometry, moving C-turn equilibrium, two-sided low-activity energy
injection, posterior lag, braking, wave envelope, and command limit. Add one
compatible dynamic steering mechanism within the same regulator: smoothly
increase the velocity-aligned anterior energy only on the measured half-cycle
already moving into the requested body-frame course correction. Both
half-cycles retain positive, velocity-odd energy feedback, so the parked bend
remains locally destabilized; the useful half-cycle receives a modest duty
asymmetry without adding a static curvature shift or a fixed-sign impulse.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while retaining active terminal joint motion,
the coherent first approach, and comparable clamp/load residence. Reject the
mechanism if the first return changes, either half-cycle again parks, the
asymmetry expands the orbit or wake, load/clamp residence rises materially, or
minimum, near-target residence, mean, and final distance fail to improve over
the phase-balanced parent.

```text
bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping combined with sensor-modulated coupled-oscillator direction tracking
source_mechanism: use target-directed half-cycle duty asymmetry inside a feedback-stabilized rhythmic carrier rather than replacing the carrier with a static bend
transferable_invariant: preserve phase-balanced energy on both measured joint-velocity half-cycles, then strengthen only the half-cycle whose existing motion advances the requested turn
nontransferable_details: published gains, dimensional frequency, robot duty ratio, species-specific amplitude envelope, clocked CPG phase, full-body joint count, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-ray/course error supplies the turn sign; normalized anterior velocity supplies phase, and their reflection-invariant product smoothly biases the existing bounded two-sided energy term while the unchanged posterior state-feedback lag propagates the bend
falsification: reject if cruise or the first return changes, either half-cycle loses active motion, the orbit or wake expands, command/load margins worsen, or closest approach, near-target residence, and final-distance evidence do not improve over the 1.175L parent
```

## Evaluation boundary

The candidate's coupled CFD result becomes available only after this worker
exits. Frozen completed trajectories can establish selector locality,
reflection equivariance, bounded action delta, positive work on both
half-cycles, and parameter ownership, but cannot establish hydrodynamic
improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed phase-balanced parent and adds two
owned parameters for one useful-half-cycle duty modulation. The unselected
half-cycle is identical to the parent; the selected energy term rises smoothly
to at most `1.75` times the parent's bounded term. No equilibrium, curvature,
distance/course gate, posterior target, lag, brake, wave envelope, oscillator,
or `+/-28 rad/T^2` command reserve changes. The policy contains no time, step
count, hidden state, world coordinate, target identity, route, randomness,
file access, or mutable state.

Replay over all `18182` completed parent states changes anterior action by
only `0.0000054/0.000594 rad/T^2` mean/maximum beyond `3L`, but by
`0.0477/0.375 rad/T^2` inside `1.5L`. At the parent's `1.175L` minimum, the
reconstructed anterior/posterior action changes from about
`(5.853,0.282)` to `(5.740,0.282) rad/T^2` while anterior velocity is
`-0.394 rad/T`; the incremental action therefore performs positive work in
the already requested half-cycle. The posterior action is exactly unchanged
in frozen replay.

All `50` direct parameter references are among the `50` fields returned by
`target_policy_params()`. Full replay stays finite and inside the command
reserve, incremental action times anterior velocity is nonnegative on every
state, and reflected target, velocity, joint, and yaw signals negate both
actions with zero sampled residual. These probes establish locality,
boundedness, positive-work sign, and reflection equivariance only; they do not
predict the coupled trajectory. No formal CFD was run.
