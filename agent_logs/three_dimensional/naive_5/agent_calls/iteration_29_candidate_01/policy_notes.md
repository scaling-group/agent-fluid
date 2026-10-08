# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled rollouts use direct uniform still-water initialization with
  `U_infinity=(0,0,0)` and terminate in capture.  The assigned parent reaches
  `0.748792L` at `26.3615T` with mean distance `2.519735L`; the strongest
  sampled translation-side variant reaches `0.748338L` at `26.2460T` with
  mean distance `2.518971L`.  The course-priority and posterior-modulation
  samples lie in the same narrow capture cluster.  The inherited scalar-only
  `0.749383L` result has no policy, trajectory, visual, or load artifact and
  therefore cannot support a controller retune.
- In both the strongest sampled sheet and the assigned-parent sheet, the
  top-down row shows self-propulsion, an alternating coherent wake through
  `8/16/24T`, and the same late hook into the capture circle.  Their oblique
  rows show compact three-dimensional Lambda2 structures carried behind the
  fish without wake breakup or passive background advection.  There is no
  sampled termination failure; the informative negative comparison is that
  response-gated carrier relief preserves this topology while delaying the
  parent relative to the strongest sample.
- Trace checks agree with the images.  Every sample has zero angle, speed, and
  acceleration contacts; the assigned parent peaks at about `0.01883` planar
  force coefficient and `0.00979` yaw-moment coefficient and still crosses at
  about `0.645L/T`.  Thus neither more terminal authority nor less carrier
  energy is supported.  Inherited trace analysis instead isolates an observer
  mismatch in the `4.5--1.75L` band: folded-bearing rate plus recent turn
  flips at gait frequency with about `3.18 rad/T` RMS magnitude, whereas the
  body-frame translational target-line rate is persistent and about
  `0.144 rad/T`.  The sampled translation policy changed only steering side,
  retained history-derived response magnitude, and remained visually
  milliscale-equivalent.

## Policy hypothesis

Preserve the assigned carrier, redirect, response-deficit channel, coordinated
soft acceleration envelope, and joint viability guards.  Make one semantic
observer change: blend from short-history target-line rate to the normalized
body-frame translational invariant `(velocity x target)/distance^2` as the
target comes within the evidenced middle-approach band and speed makes course
observable.  Use that single blended rate for both response side and response
magnitude.  Startup, far travel, and low-speed states remain exact history
fallbacks.  This should reject tail-beat contamination without adding
authority or scalar gain, preserve the coherent wake and zero-contact envelope,
and change the middle/late route more than the sampled side-only observer did.

Falsify the mechanism if evaluation loses capture or wake coherence, produces
angle/rate/acceleration contact or materially larger loads, creates sustained
under-response, or again yields only the same shallow milliscale late-hook
topology.  In the latter case, later workers should not retune the blend or
terminal residual; they should seek a separately observed route-response
variable.

## Non-CFD validation

- The lightweight policy contract and editable-boundary checks pass, and every
  direct parameter reference is owned by `target_policy_params()`.
- Mirrored body-frame target, velocity, joint, and yaw states produce mirrored
  commands.  Far states and low-speed states exactly reproduce the assigned
  parent, while a confident near state activates the translated observer.
- Replaying the assigned-parent recorded states through both policy functions
  changes `1004/4793` command rows (`482` by more than `0.1 rad/T^2`), with a
  maximum component change of `2.704 rad/T^2`.  The maximum candidate command
  remains `29.726 rad/T^2` and the translation confidence reaches `0.921`.
  This establishes meaningful bounded engagement, not a CFD outcome.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated rhythmic control and wake-control observer separation
source_mechanism: separate slow persistent route geometry from fast alternating body or flow response before modulating a propulsive rhythm
transferable_invariant: when translation is observable, use persistent inertial target-line rotation consistently for steering side and response magnitude while retaining a safe fallback
nontransferable_details: published CPG gains, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: smoothly blend a short-history line-of-sight rate toward the normalized body-frame translational line-of-sight rate, then feed that one bounded rate to the existing anterior half-cycle response residual
falsification: reject if capture or coherent propulsion is lost, actuator or load exposure rises, response becomes persistently weak, or the route remains milliscale-equivalent
