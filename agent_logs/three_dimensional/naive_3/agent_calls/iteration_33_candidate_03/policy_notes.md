# Phase-balanced terminal wave-energy candidate

## Evidence diagnosis before the policy edit

- The four sampled solver evaluations and the assigned parent's inherited CFD
  evaluation all satisfy the frozen experiment contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `horizon` termination at `100T`. I inspected
  the top-down mid-plane-vorticity and oblique body/Lambda2 rows of all five
  combined keyframe sheets. Every policy visibly self-propels and leaves a
  coherent alternating planar wake with compact three-dimensional structures;
  passive advection, collision, domain exit, wake collapse, and numerical
  instability do not explain the misses.
- The completed terminal course hold (`solver_6eb170b0d70a`) remains the unique
  useful near-target scaffold. It reaches `1.241/4.157/2.082L`
  minimum/mean/final distance, spends about `0.47T` inside `1.25L`, and at its
  closest pass retains anterior/posterior joint velocity of about
  `-0.260/0.108 rad/T`. Across all states inside `2L`, its mean absolute joint
  velocities are about `1.057/0.409 rad/T`. Its top-down return is visibly
  tighter than the broad concentric loops of the sampled descendants, while
  the oblique row retains a compact traveling Lambda2 wake through the return.
- The three sampled static or signed-restart descendants remain concrete
  negative controls. Rear-centerline selector replacement
  (`solver_b5de8ff4a388`), joint-state equilibrium unbend
  (`solver_a6820a0af3d7`), and fixed-sign low-activity restart
  (`solver_2cc56ad90762`) reach only `2.366`, `2.215`, and `2.369L` and settle
  into the same powered common C-bend with almost no joint motion near their
  minima. They retain coherent wakes, so the failure is a stable controller-
  hydrodynamic attractor rather than loss of propulsion or stability.
- The assigned parent's velocity-aligned anterior half-cycle pulse is now also
  a completed negative result. Its inherited CFD result reaches
  `1.702/3.921/3.574L` minimum/mean/final distance. Although its mean distance,
  clamp residence, and RMS load are lower than the course-hold scaffold, it
  never enters `1.5L`; inside `2L` mean absolute joint velocities collapse to
  about `0.028/0.028 rad/T`, and the late top-down and oblique frames show the
  same broad low-activity orbit as the static descendants. A pulse that is
  quadratic near zero velocity and energizes only the requested-sign
  half-cycle therefore does not preserve the active terminal wave, despite its
  small and localized frozen-trace delta. Do not retune that pulse amplitude,
  velocity scale, or terminal radius.

## Policy hypothesis

Return to the completed `solver_6eb170b0d70a` course-hold scaffold and preserve
its bearing curvature, geometry-released C-turn, course-response reserve,
continuous terminal hold, posterior brake and lag modulation, equilibria,
wave envelope, and command limit. Add one distinct limit-cycle mechanism:
under the existing target-behind terminal selector, measure phase-plane wave
activity about the already commanded anterior equilibrium. When that activity
falls below a bounded target, add a smoothly saturated acceleration with the
same sign as measured anterior velocity on **both** half-cycles. This is linear
near zero velocity, so it changes the damping stability of the parked bend,
but is odd in joint velocity and adds no mean curvature or preferred turn side.
The unchanged posterior lag propagates any recovered anterior oscillation.

Support requires preservation of the coherent first return plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a materially tighter
final loop with active joint motion and comparable clamp/load residence. Reject
the mechanism if the first return changes, phase-balanced work still converges
to a parked bend, the wake becomes disorganized, clamp/load residence rises,
or closest, near-target, mean, and final-distance statistics do not improve.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator CPG locomotion and closed-loop robotic-fish direction tracking
source_mechanism: stabilize rhythmic amplitude with state feedback while slow target geometry selects the maneuver, preserving a traveling anterior-to-posterior wave rather than replacing it with a static bend
transferable_invariant: when a maneuver-specific equilibrium suppresses an otherwise useful carrier, restore phase-balanced limit-cycle energy about that moving equilibrium and keep route selection separate from fast rhythmic state
nontransferable_details: published gains, dimensional frequencies, robot duty ratios, species-specific envelopes, full-body joint counts, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-behind and target-ray/course weights gate a normalized anterior phase-plane activity deficit; an odd bounded velocity feedback injects zero-mean energy on both measured half-cycles and the unchanged posterior lag carries the wave through the two-joint contract
falsification: reject if cruise or the first return changes, the joints still park, the terminal orbit expands, wake coherence or load margins degrade, or near-target and final-distance statistics fail to improve over the 1.241L course-hold scaffold
```

## Evaluation boundary

The current candidate's coupled CFD result is available only after this worker
exits. Frozen completed trajectories can establish selector locality,
phase-balance, boundedness, reflection equivariance, parameter ownership, and
action scale, but cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed terminal course-hold policy and adds
four owned parameters for one phase-plane activity regulator. The existing
target-behind and terminal course weights localize it; normalized activity is
measured about the moving anterior equilibrium, and a saturated odd function
of normalized anterior velocity supplies positive incremental mechanical work
on both half-cycles. No equilibrium, curvature magnitude, course or distance
threshold, posterior target, lag, brake, oscillator envelope, or command limit
is changed. The policy contains no clock, step count, hidden state, world
coordinate, target identity, route, randomness, file access, or mutable state.

Reconstruction and replay over all `18182` states of the completed `1.241L`
course-hold trace changes maximum-joint action by only
`0.000021/0.001412 rad/T^2` mean/maximum beyond `3L`, but by
`0.410/0.680 rad/T^2` inside `1.5L`. At the scaffold's `1.241L` minimum, frozen
action changes from about `(0.970,0.868)` to `(0.474,0.868) rad/T^2`; the
posterior action is exactly unchanged because the regulator changes neither
anterior state nor the posterior target in frozen replay. Across every replay
state, the anterior action delta times measured anterior velocity is
nonnegative, establishing phase-balanced positive work rather than a signed
curvature residual. These frozen probes establish locality and a material,
bounded terminal action only; they do not predict the coupled trajectory.

All `48` direct parameter references are returned by
`target_policy_params()`. Full replay remains finite and within the declared
`+/-28 rad/T^2` command reserve, and reflecting target, velocity, joint, and yaw
signals negates both actions with zero observed residual. The lightweight
policy contract and solver editable-boundary checks pass. No formal CFD was
run.
