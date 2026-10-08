# Target-ray-rate terminal feedforward candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite traces, and capture termination. Three samples reproduce the
  assigned-parent policy hash and complete trajectory exactly. They are the
  strongest finite reference: capture at `16.93205T`, score `-0.20004481`,
  mean distance `2.08513L`, and final distance `0.74389L`.
- I inspected both rows of the combined keyframe sheet for the replicated
  parent and the view-specific top-down and oblique sheets for the informative
  bidirectionally arbitrated sibling. From release through capture, both show
  a continuous target-directed translation, an alternating red/blue
  top-down street, and compact caudal three-dimensional Lambda2 structures.
  Neither shows passive drift, a held-joint coast, wake collapse, collision,
  or boundary exit. The traces agree: peak fish speed is about `1.391U` while
  peak sampled local flow is only `0.03270U`.
- The bidirectional sibling first departs from the replicated trajectory near
  `14.383T` and `3.861L`, where it suppresses part of the established
  anterior-to-posterior donor channel. It captures `0.006T` earlier and has a
  visually indistinguishable wake, but worsens score/mean/final distance to
  `-0.200966/2.08585L/0.74483L` and raises terminal yaw-rate peak from
  `4.4430` to `4.4536 rad/T`. Preserve the parent's one-sided signed-load
  allocation; intact shedding and a tiny arrival change do not validate
  mirrored arbitration.
- The inherited step-33/34 collision-corridor releases also retained capture
  but regressed to `-0.204337/2.08858L` and
  `-0.202941/2.08746L` score/mean distance. The step-35 agreement-gated yaw
  amplifier then changed only terminal samples and came closer, yet its
  completed score/final distance still regressed to
  `-0.200362/0.74420L`. Thus neither withdrawing target-course steering nor
  increasing its magnitude from yaw rate alone improves the replicated
  capture.
- The parent terminal trace provides a distinct, point-consistent observation.
  With the adapter's head-relative bearing convention, matched-window
  `turn_rate_recent - bearing_window_rate` isolates inertial target-ray rate:
  body rotation cancels instead of being mistaken for sightline motion. Inside
  `2.25L` its absolute value averages about `0.285 rad/T` and reaches
  `0.582 rad/T`, while the instantaneous body yaw rate reaches `4.443 rad/T`.
  This separates slow intercept geometry from the much larger beat-scale yaw
  response that defeated direct damping.

## Single-candidate policy hypothesis

Preserve the replicated parent's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course feedback, posterior
acceleration reserve, C1 acceleration envelope, high-onset positive-power
speed guards, target-signed measured-yaw work allocation, and posterior
stopping-risk projection. Add one small terminal feedforward term to the
already assembled steering signal. At reliable swimming speed and only inside
a smooth near-target gate, use the matched-window target-ray rate to rotate the
velocity-course request with the moving sightline. Because positive controller
bearing is defined around the head-facing body `-x` axis, the correction is
opposite the inertial ray-rate sign. It may strengthen or relax a steering
half-cycle, but cannot suppress the carrier or bypass any mechanical guard.

The expected effect is a cleaner intercept with capture, equal or lower mean
and crossing distance, and no increase in terminal yaw or loads. Falsify the
mechanism if it loses capture or coherent alternating shedding, changes the
broad route outside `2.25L`, fails to beat `-0.200045/2.08513L`, touches a
joint limit, exceeds the parent's `0.5993 rad` posterior excursion or
`0.0370/0.0184` force/moment envelope without a semantic gain, or merely
duplicates the failed direct-yaw amplifier.

```text
bookshelf_consulted: true
source_domain: biological terminal approach and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while bounded target-relative sensor feedback updates the direction command
transferable_invariant: separate target-ray motion from oscillatory body yaw and correct the intercept with a bounded observation-rate residual without withdrawing propulsion
nontransferable_details: published gains, dimensional rates, species-specific kinematics, full-body CPG networks, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: combine normalized matched-window `turn_rate_recent` and body-frame `bearing_window_rate` to estimate target-ray rotation; add one bounded distance- and speed-gated residual to the existing two-joint velocity-course steering signal while retaining carrier phase and every allocation/safety layer
falsification: reject if broad-route equivalence, capture, or alternating three-dimensional shedding is lost; if arrival, distance integral, crossing depth, terminal yaw, joint viability, posterior angle, or force/moment loads regress relative to the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying only the new observation formula over the replicated parent's 3,079
recorded states changes 222 terminal samples from `15.718T` and `2.243L`
through capture, and zero samples at or beyond the parameter-owned `2.25L`
boundary. The gated steering increment peaks at `0.02469 rad`, below its
`0.03 rad` bound; it strengthens the current steering sign in 86 samples and
relaxes it in 136. This confirms a non-inert target-ray-rate feedforward test,
not the inherited same-sign yaw amplifier or a broad-route carrier edit. It
does not evolve the body or fluid and is not evidence for the unevaluated
candidate's CFD outcome.
