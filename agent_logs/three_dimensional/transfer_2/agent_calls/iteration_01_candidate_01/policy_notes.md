# Candidate diagnosis and hypothesis

## Assigned-parent evidence

- The sampled rollout is a valid direct-uniform still-water episode:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and 323 lossless moving-window
  shifts. It is therefore evidence about self-propulsion and steering rather
  than ambient advection.
- Both keyframe rows show a strong, coherent alternating wake and sustained
  forward travel. The fish reduces head-target distance from `12.3277L` to
  `6.1797L`, so propulsion should be preserved. It then passes below the target,
  continues toward the lower virtual boundary, and terminates `left_domain` at
  `26.1800T` with distance `10.5957L` and center `y=0.7976L`.
- The top-down sheet shows increasingly broad body rotation while the target
  moves from nearly ahead to the positive body-bearing side. The oblique
  Lambda2 row confirms a genuinely three-dimensional but coherent wake; there
  is no external wake event that explains the course loss.
- Cross-checking `trajectory.csv` shows body-frame target bearing starts at
  about `+0.155 rad`, reaches roughly `+1.3 rad` around closest approach, and
  remains positive at exit. Over settled joint cycles, realized mean tail
  tangent (`phi1+phi2`) rises to about `+0.16 rad` while per-cycle heading drift
  is also positive. That is the wrong closed-loop sign: positive bearing needs
  negative heading motion under this evaluator's body-frame convention.
  Joint rates also touch the `260 deg/T` envelope during roughly one quarter
  of many settled cycles, so adding more undifferentiated acceleration is not
  the appropriate first test.

## Policy hypothesis

Preserve the parent's state-feedback traveling wave, target geometry, yaw-rate
feedback, approach scheduling, and bounded half-cycle actuator. Correct only
the semantic map from signed turn request to mean posterior curvature: a
negative request must create negative rather than positive mean tail tangent,
and the positive/recovery branches must be corrected consistently. This is a
single controller-mechanism test, not a cadence or amplitude gain sweep. The
implementation also removes the parent's resolution field and consumes
`distance_L`/`target_body_L` directly; the lateral-velocity coefficient is
converted reciprocally so this contract normalization does not add a second
control change.

Expected result: positive target bearing should produce negative cycle-mean
heading drift, keep the target nearer the body centerline, improve on the
`6.1797L` closest approach, and avoid the lower-boundary exit without destroying
the coherent propulsive wake. Falsify the translation if cycle-mean heading
continues to drift with bearing, if the closest approach is not improved, or if
the sign correction collapses propulsion or increases limit residence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish turning
source_mechanism: target-driven bounded mean-curvature bias superposed on a traveling posterior-lag gait
transferable_invariant: steer a propulsive rhythm by mapping persistent body-frame target error to a bounded signed average bend while retaining posterior lag
nontransferable_details: published gains, species kinematics, dimensional cadence, exact vortex phase, and any fixed route or world-frame turn direction
policy_translation: retain the joint-state oscillator and posterior lag, but correct the signed turn-request-to-tail-curvature map using the observed 3D bearing and heading conventions
falsification: reject if positive body bearing does not yield negative cycle-mean heading response, distance progress does not improve, or wake coherence and actuator-limit residence worsen
