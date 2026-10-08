# Posterior joint-viability braking candidate

## Visual diagnosis and completed evidence

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Translation is
  therefore controller-generated rather than ambient advection or a
  moving-window artifact.
- All sampled policies capture and their compact sheets are visually almost
  indistinguishable at keyframe cadence. In both the top-down row and the
  oblique row, the best-scoring sampled policy retains a coherent alternating
  vorticity street and three-dimensional Lambda2 structures through the
  approach. Peak body speed is `1.329U`, while peak measured local flow is
  only `0.0315U`, which supports preserving the self-propelled traveling
  carrier, target-ray/velocity-course observation, and posterior acceleration
  allocation.
- The useful current contrast is a terminal safety failure rather than a
  termination-class failure. The assigned parent's fixed `8 deg` soft brake
  preserves capture at `18.271T` and reduces the coincident terminal force and
  yaw-moment peaks from `0.20756/0.09276` to `0.17183/0.07699`, about `17%`.
  However, it still reaches exactly `-45 deg`, retains the same 13 samples at
  or beyond `44 deg`, and does not materially change posterior raw
  acceleration exceedance (`46.42%` versus `46.43%`). Thus its load-reduction
  claim partially survives, but its explicit no-contact claim is falsified.
- State/action alignment explains the failure. The soft guard first changes
  the command at `18.188T`, with posterior angle `-43.05 deg`, outward speed
  `2.13 rad/T`, and only `1.95 deg` of angle margin. Even maximum legal inward
  acceleration then needs about `4.15 deg` to stop. The zero-buffer physical
  stopping envelope is already crossed at `18.166T`; adding a normalized 5%
  angle-envelope buffer detects the unsafe state at `18.144T`, `-37.20 deg`,
  while distance is already `0.794L`. A fixed spatial guard blended from zero
  therefore reacts too weakly despite having nominally started earlier.
- The inherited optimizer logs predicted that the parent edit would affect
  only five terminal samples and required both contact and terminal loads to
  fall. The completed result confirms that isolation but shows why a replay
  over recorded states was insufficient: feedback changes the intervening
  states, and a margin-only gate does not encode whether the remaining angle
  is dynamically stoppable. Earlier inherited failures also rule out treating
  this as a request for more curvature, anterior gain asymmetry, held bends,
  or broad carrier relief.

## Policy hypothesis written before the solver edit

Preserve the completed capture controller's full-quadrant normalized target
ray, measured body-frame velocity course, speed gate, zero-centered anterior
oscillator, posterior lag and damping, nominal curvature, distance-conditioned
acceleration reserve, and physical limits. Replace only the posterior fixed
width soft guard with a joint-state viability envelope. Normalize remaining
angle margin by the existing joint envelope and compare it with the minimum
stopping distance implied by observed outward joint speed and the existing
acceleration limit. If stopping distance plus a small fractional angle buffer
exceeds remaining margin, use the bounded posterior channel for maximum inward
braking; otherwise leave the demonstrated allocated command unchanged.

This is a new state-dependent constraint mechanism, not a wider guard gain or
another curvature scalar. It should remain dormant over the broad approach,
activate near `18.144T` in the parent trajectory rather than after the state is
already nonviable, and release as soon as posterior motion is inward. The
expected signature is capture with the alternating wake intact, no posterior
angle-limit contact, and lower terminal force/moment peaks than the unbraked
capture. Falsify it if capture or the sub-`1L` trajectory is lost, intervention
occurs outside the terminal joint-risk states, applied limit occupancy becomes
persistent, the posterior wave fails to resume after inward reversal, or angle
contact and terminal loads do not both improve over the fixed-guard parent.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve a productive traveling carrier while observations gate a bounded terminal correction instead of replacing the gait
transferable_invariant: when broad rhythmic propulsion already reaches the target, constrain only the dynamically unsafe joint motion and release the constraint when the measured risk clears
nontransferable_details: published gains, linkage geometry, species-specific envelopes, dimensional cadence, clock phase, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint carrier; compare posterior angle margin with the normalized stopping distance from posterior angle velocity and apply bounded inward acceleration only outside that viability envelope
falsification: reject if capture or coherent shedding is lost, intervention is not terminal and sparse, posterior hard-limit contact remains, or force and yaw-moment peaks do not improve over the fixed-width brake
```
