# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The four sampled solver examples are duplicate evaluations of the same v33
  policy: their candidate and combined keyframe hashes match, and each reports
  direct uniform still-water initialization, zero cylinders, capture at
  `23.8425T`, score `-0.535091`, mean/distance-integral `2.433543L`, and final
  distance `0.746165L`. They provide one strong finite trajectory, not four
  independent controller comparisons.
- In the top-down row, the fish moves under its own actuation from quiescent
  water, turns onto a curved target-directed route, and leaves an alternating,
  spatially ordered vortex street through capture. In the oblique Lambda2 row,
  compact paired structures persist behind the body rather than dispersing or
  showing passive advection. The late body remains visibly bent and laterally
  active as the head reaches the capture sphere.
- The trajectory cross-check supports that visual diagnosis. Inside `3L`, v33
  has mean/peak absolute yaw rate `1.680/3.185 rad/T`, mean target-line
  cross-track speed `0.228U`, and peak absolute yaw moment `0.01373`. It reaches
  capture with yaw rate still rising to `1.380 rad/T`; its smooth projected
  commands remain about `31.4 rad/T^2`, while anterior/posterior velocity-cap
  exposure is `14.3%/5.7%`. Thus propulsion and broad routing are successful,
  but terminal oscillatory yaw remains consequential and command headroom is
  not evidence that more correction is desirable.
- No distinct failed keyframe is present in the sampled solver set. The
  informative failure contrast therefore comes from inherited completed
  evidence: opposite-sign static posture replacements produced weak-wake upper
  exits and severe posterior angle-limit exposure, while later cue/observer,
  damping, moment, and fixed allocation interventions often reduced a yaw
  diagnostic but traded away capture speed or distance integral. In particular,
  the inherited v35 result improved terminal yaw/slip yet regressed score from
  `-0.535091` to `-0.535811` and arrival from `23.8425T` to `23.8975T`. This
  rejects wholesale carrier changes and offline decorrelation as the objective.

## Policy hypothesis

Retain v33's target-course feedback, coherent traveling-wave carrier, smooth
command projection, posterior lag, and phase-selected anterior counter-
curvature. Add one compatible actuator mechanism: within the existing `3L`
terminal excess-yaw gate, reduce only the posterior tracking spring on the
observed tail-bend half-cycle that supports the excess yaw. Keep posterior
damping and the opposite half-cycle unchanged. This is a drive-authority
asymmetry, not another posterior counter-tangent or a fixed redistribution of
course curvature.

Expected result: a gentle phase-selected relief should reduce the terminal
posterior impulse, yaw/moment, and velocity-cap exposure without weakening the
opposite power stroke or changing the far/middle trajectory. Falsify it if the
alternating wake loses coherence, capture is lost, arrival or distance integral
regresses beyond v33-scale variation, peak yaw/moment rises, or joint-limit
exposure worsens.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: half-cycle amplitude or duty-ratio asymmetry biases turning impulse while retaining a rhythmic carrier
transferable_invariant: use a small observed-phase-selective actuation asymmetry to change net impulse without replacing the propulsive traveling wave
nontransferable_details: published gains, clock-defined phase, hardware-specific duty ratios, species kinematics, exact vortex phase, and task routes
policy_translation: infer phase from normalized two-joint tail tangent, infer excess yaw from body-frame target geometry and yaw feedback, and softly reduce posterior tracking authority only on the terminal yaw-supporting half-cycle
falsification: reject if capture or v33-scale arrival and distance integral regress, if wake coherence or the opposite power stroke weakens, or if terminal yaw, moment, or joint-envelope exposure fails to improve
