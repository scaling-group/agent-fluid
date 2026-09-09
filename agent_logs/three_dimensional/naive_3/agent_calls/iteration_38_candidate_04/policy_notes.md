# Force-selected posterior impulse candidate

## Evidence diagnosis before the policy edit

- Every sampled rollout reports direct uniform initialization in still water
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected the top-down mid-plane-vorticity
  and oblique body/Lambda2 rows. The four current samples self-propel through
  coherent three-dimensional wakes, but all form broad return loops and miss
  at `2.215--2.439L`; the late sheets show a nearly stationary common negative
  C-bend despite continued translation near `0.68U`. Advection, wake collapse,
  collision, boundary exit, and instability do not explain the failure.
- The inherited two-sided anterior activity regulator remains the useful
  scaffold. Its visibly tighter active-wake return reaches
  `1.175/4.041/3.243L` minimum/mean/final distance, stays inside `1.25L` for
  about `2.35T`, and retains mean anterior/posterior absolute velocity near
  `0.775/0.360 rad/T` inside `2L`. At its minimum, speed is `0.683U`, course
  error is `1.682 rad`, course dot is `-0.111`, and joint state remains a
  moving counterphase transition (`phi_dot=(-0.394,+0.260) rad/T`) with modest
  action. The miss is therefore tangential translation during an active wave,
  not insufficient scalar drive or a missing static bend.
- Current assigned-parent and sampled inherited results close simpler rhythmic
  repairs. A useful-half-cycle anterior pulse reaches only `1.702L`; anterior
  duty asymmetry and a stronger radial regulator reach `2.362L` and `1.366L`;
  a paired counterphase burst produces more yaw but only `1.192L`; and
  response-triggered equilibrium release reaches `1.177L` while shortening
  near-target residence and worsening mean distance to `4.087L`. Most
  importantly, a phase-balanced posterior activity regulator regresses to
  `2.173/3.868/3.547L` and parks at its minimum with joint velocities only
  `0.00096/0.00265 rad/T`. Do not retune an activity floor, posterior damping,
  phase lag, or another geometry-selected half-cycle.
- Hydrodynamic response provides a distinct measured selector on the exact
  `1.175L` trace. Inside `1.5L`, the median absolute target-ray/course error is
  `1.639 rad`. The signed body-force component that rotates translational
  course toward the target predicts reduction of that error over the next
  `0.055T` and `0.11T` with correlations about `0.93` and `0.78`; its scale is
  roughly `-0.0053` to `+0.0062` over close states. Helpful impulse appears on
  about `61%` of those states and is associated most strongly with negative
  posterior velocity, while both anterior half-cycles remain present. This
  establishes force as a response/phase observation, not causality from the
  new action or a promise of coupled improvement.

## Policy hypothesis

Restore the completed `1.175L` phase-balanced controller exactly, including
its continuous body-frame course hold, moving C-turn equilibria, two-sided
anterior energy law, posterior target and lag, brake, wave envelope, and
command limit. Add one compact mechanism only to joint 2: compute whether the
measured normalized body force is currently rotating translational course
toward the target ray. Under the existing target-behind terminal selector,
add bounded velocity-odd energy to the posterior joint only while that
measured impulse is helpful. The term follows measured posterior motion, moves
no equilibrium, copies no force magnitude into a route command, and vanishes
for unhelpful force, missing terminal geometry, or zero joint velocity.

The intended transition is response-selected posterior emphasis: preserve the
phase-balanced carrier, reinforce only a tail stroke already producing inward
course rotation, and release immediately when the hydrodynamic response stops
helping. Support requires capture, a pass below `1.175L`, longer residence
inside `1.25L`, or a tighter final loop while retaining active joint motion,
the coherent first return, and comparable force/load and clamp residence.
Reject it if the fast force signal amplifies loads or switching, changes the
first return, produces yaw without inward course rotation, parks either joint,
broadens the wake/orbit, or fails to improve the near-target and final-distance
statistics over the exact phase-balanced scaffold.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish sensor modulation combined with elongated-body posterior reactive propulsion
source_mechanism: preserve a feedback-stabilized traveling bend while measured hydrodynamic response selects bounded posterior emphasis on a currently useful stroke
transferable_invariant: use fast response only as a phase selector inside a slow body-frame route command, and add energy without moving the established mean bend or copying an exact vortex phase
nontransferable_details: published gains, dimensional beat frequencies, robot duty ratios, species-specific kinematics, full-body joint counts, exact vortex phases, target coordinates, capture radius, and prescribed routes
policy_translation: normalized target-ray/course error defines the needed course-rotation sign; normalized body force confirms an inward impulse, and measured posterior velocity turns that confirmation into a bounded reflection-equivariant joint-2 energy term under the existing terminal geometry gate
falsification: reject if cruise or the first return changes, loads or switching rise materially, force-selected work creates another parked bend or yaw-only response, wake coherence degrades, or closest approach, near-target residence, mean distance, and final distance fail to improve over the 1.175L phase-balanced scaffold
```

## Evaluation boundary

The new coupled CFD result becomes evidence only after this worker exits.
Frozen-trace replay and deterministic probes can establish selector scale,
locality, boundedness, parameter ownership, and reflection symmetry, but cannot
establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate restores the completed phase-balanced policy and adds three
owned force-response parameters plus one joint-2 velocity-odd term. It changes
no course or distance gate, curvature, equilibrium, anterior oscillator or
energy law, posterior mean, nominal lag, wave authority, brake, wave envelope,
or command limit. It contains no time, step count, hidden state, world
coordinate, target identity, route, randomness, file access, or mutable state.

Exact Julia replay over all `18182` completed scaffold states leaves anterior
action bit-for-bit identical. Posterior action changes by only
`0.0000211/0.00138 rad/T^2` mean/maximum beyond `3L`, and by
`0.0576/0.413 rad/T^2` inside `1.5L`; the full-trace maximum is
`0.454 rad/T^2`. The term is active on the `61.3%` of close states with
measured helpful course-turning force, performs nonnegative joint-space work
on every replayed state, and is zero at the parent's minimum because the
instantaneous force there is not helpful. Base and candidate frozen clamp
fractions remain exactly `0.2264/0.1030`, all actions are finite, and a
full-trace lateral reflection probe has zero numerical residual. All direct
parameter references name fields returned by `target_policy_params()`.
These probes establish bounded response selection, locality, work sign, and
equivariance only; no formal CFD was run.
