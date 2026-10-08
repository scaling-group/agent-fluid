# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`) and terminate in capture.  The two replicated v27
  common-mode policies are identical in scalar metrics and visible trajectory:
  `23.6390 T`, mean distance `2.44217 L`, peak speed `0.8100 L/T`, `48.21%`
  any-joint acceleration-limit residence, and peak planar force/yaw moment
  `0.02974/0.01484`.
- The prefilled v28 gait-frame target projection is the strongest finite
  example.  It captures at `20.5315 T`, lowers mean distance to `2.18697 L`,
  and leads the v27 route by `0.93/1.77/2.23 L` at `8/12/16 T`.  Its gain is
  not load-free: peak speed is `0.8944 L/T`, acceleration-limit residence is
  `46.29%`, and peak force/moment is `0.03056/0.01525`.
- The v28 posterior-wave-start comparison is the informative regression.  It
  initially leads at `2 T` but stays visually straighter through the middle,
  captures only at `24.2220 T`, has mean distance `2.42365 L`, and raises peak
  force/moment to `0.03442/0.01717`.  This agrees with inherited guidance and
  logs that launch-specific excitation and aligned low-speed cadence are not
  the remaining route mechanism.
- In both keyframe rows the fish is self-propelled rather than advected.  The
  top-down row shows an alternating signed wake and the oblique row shows
  coherent three-dimensional posterior structures.  The v28 projection bends
  the world trajectory toward the target by `12--16 T` without destroying that
  wake; the posterior-wave-start variant remains nearly straight longer and
  turns late.  No prewarm or cylinder wake is present.

## Residual diagnosis

The existing v28 controller removes a head-joint carrier estimate from yaw,
bearing trend, and proportional target pose while keeping the large-error
redirect on raw body-frame geometry.  Reconstructing the same normalized
target angle from every sampled `trajectory.csv` shows that this is useful but
incomplete.  After the existing `+0.40*q1_centered` pose correction, its
within-beat standard deviation is `0.0546`, `0.0479`, `0.0707`, and `0.0546`
rad across the four samples.  The remaining residual is consistently explained
by the observed posterior tangent `q1+q2` (least-squares coefficient magnitude
`0.22--0.27`).  Likewise, after the existing head-rate correction, a bounded
posterior-tangent-rate term with evidence-scale coefficient `0.13` reduces the
reconstructed fast yaw-rate standard deviation from `0.511/0.422/0.694/0.511`
to `0.262/0.227/0.405/0.262 rad/T`.  These are offline observation
decompositions, not claims about the unevaluated candidate's CFD outcome.

## Policy hypothesis

Extend the existing gait-frame common-mode rejection from anterior joint phase
to a two-joint carrier observation.  Add a small posterior-tangent contribution
to the carrier pose and rate estimates, subtracting the known redirect-commanded
posterior mean from the pose estimate so deliberate C-bend curvature is not
classified as oscillation.  Keep raw geometry for redirect sign/gating, retain
the evaluated posterior-lag carrier and carrier-first target residual allocation,
and do not add thrust or globally retune gains.  The expected effect is less
beat-locked countersteering and earlier/cleaner closure while preserving the
v28 wake topology.

Falsify this hypothesis if formal evaluation loses capture, fails to improve
the `20.5315 T`/`2.18697 L` route, reverses the target-signed arc, destroys the
alternating two-view wake, or materially exceeds the v28 speed, saturation,
force, or moment envelope.  A later held-out pose must also retain the observed
joint/rigid-body phase relation; otherwise the posterior correction should not
be generalized.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and phase-aware steering
source_mechanism: separate the rhythmic locomotor carrier from the slower sensor-driven steering residual using observed gait state
transferable_invariant: slow target geometry should not countersteer against a fast, repeatable carrier-phase component that is observable in joint state
nontransferable_details: published CPG gains, oscillator phases, species kinematics, body envelopes, dimensional cadence, and prescribed routes
policy_translation: augment the normalized body-frame gait pose and yaw-rate estimates with bounded posterior tangent state while preserving raw-geometry redirect and two-joint carrier-first actuation
falsification: reject if capture or distance integral regresses, the target arc or coherent wake is lost, loads or limit residence materially exceed v28, or held-out data lack the posterior-phase correlation
