# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, finite dynamics, and `left_domain`
  termination. Their combined sheets include both the top-down vorticity row
  and oblique body/Lambda2 row.
- The top-down and oblique views show self-propelled motion and a coherent
  alternating wake in every sample. The scalar leader ends at `20.034T` with
  score `-7.405`, but its comparatively straight upper-going track only reaches
  `4.650L`. This is not evidence for more propulsion.
- The assigned parent visibly keeps the alternating wake while producing a
  late return arc. It improves the closest approach to `2.319L` at `18.032T`
  and survives to `27.227T`, but exits at the upper boundary with final
  distance `8.534L`. The two other sampled approach branches reach `2.703L`
  and `2.664L`, then follow the same left/upper-exit topology.
- At the parent's closest approach, the head is `(8.489,11.762)L`, the target
  displacement is therefore `(0.511,-2.262)L`, and world velocity is
  `(-0.956,-0.579)L/T`. In the body frame the target pursuit angle is about
  `-0.722 rad`, while the translational course angle is about `+0.526 rad`:
  the body is turning but momentum still carries it across the target line in
  the opposite lateral direction. The `2.581 rad/T` instantaneous yaw rate
  also shows that the missing capability is not simply more yaw authority.
- The parent occupies the hard-rate neighborhood for roughly `12%` on each
  joint and has a coherent but high-speed pass. A sampled bend-release branch
  lowers that occupancy on joint 1 but worsens closest approach to `2.664L`.
  Broad target-plane hold reaches `2.703L` with the largest sampled lateral
  force and yaw-moment peaks. Those results argue against a general brake,
  bend-only release, or unconditional proximity hold.
- The assigned parent's inherited score log contains a later finite branch at
  `2.211L` minimum distance, `7.950L` final distance, and the same
  `left_domain` termination. Because that inherited log has no policy or
  multimodal trace, it is evidence that the miss persists, but not evidence
  for attributing the scalar change to a particular mechanism.

## Policy hypothesis

Preserve the parent's full-circle target geometry, phase-compensated yaw, and
traveling-bend carrier. During the approach only, compare the normalized
body-frame velocity direction with the target direction. Blend the parent's
raw lateral-velocity correction into this course error, and let a large
course mismatch retain redirect authority and carrier relief even when the
instantaneous body bearing transiently looks aligned. This tests whether
closed-loop response should be judged by actual translation rather than by
beat-scale posture.

Expected improvement: the fish should begin correcting the cross-target
course before the `2.3L` pass, reach below the inherited `2.211L` minimum, or
replace the upper-boundary exit with a meaningfully different recovery while
preserving the coherent alternating wake. Falsify the mechanism if it repeats
the left/upper exit without a closer pass, removes pre-approach progress, or
raises load peaks or joint-limit occupancy above the parent.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop rhythm modulation and biological burst redirect
source_mechanism: sustain strong bounded curvature for large directional error and release it only when the observed locomotion response recovers
transferable_invariant: gate rhythmic steering by target-direction error and actual response rather than elapsed time or a fixed maneuver phase
nontransferable_details: published controller gains, robot duty ratios, species-specific C-start kinematics, exact vortex phase, and task routes
policy_translation: use the wrapped angle between normalized body-frame target and velocity vectors to blend approach steering and retain redirect reserve in the two-joint state-feedback carrier
falsification: reject if the same left/upper exit remains without beating the inherited 2.211L pass, or if wake coherence, loads, or rate-limit occupancy worsen
