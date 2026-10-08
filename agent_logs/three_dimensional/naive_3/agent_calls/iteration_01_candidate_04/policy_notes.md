# Candidate wake-policy notes

## Evidence diagnosis

- Assigned-parent guidance identifies the common seed as a target-blind,
  joint-state Van der Pol carrier with a lagged posterior target. No inherited
  optimizer notes are present in this workspace, so the sampled seed rollout is
  the only completed candidate evidence used here.
- The rollout satisfies the experiment contract: direct uniform still-water
  initialization at `U_infinity=(0,0,0)`, no cylinders, no prewarm, and a
  moving-window trajectory that terminates `left_domain` at `8.547T`.
- In the top-down sheet, the carrier builds a coherent alternating wake and
  moves under its own actuation, but it never establishes target-directed
  travel. It crosses the target centerline near `4T`, continues turning, hooks
  sharply upward-left after about `6T`, and exits through the upper boundary.
  The target distance improves only from `12.328L` to a best `12.078L` at
  `6.358T`, then worsens to `12.380L`.
- The oblique Lambda2 row confirms that the posterior bend produces a real 3D
  wake rather than passive advection; the late compact vortex train follows
  the same hooked body path visible from above. There is no external wake to
  reject in this still-water, zero-cylinder rollout.
- Quantitatively, target bearing changes from about `+0.19 rad` early, through
  zero around `4T`, to about `-1.44 rad`, while the drive-only policy has no
  target input. Speed rises to `0.636U` and absolute yaw rate reaches
  `2.792 rad/T`, so the failure is uncontrolled turning rather than absent
  motion. About one third of raw commands exceed the acceleration envelope,
  although joint-rate saturation occupies less than `2.5%` of samples; adding
  drive gain would therefore be a poorly isolated response to this failure.

## Policy hypothesis

Preserve the observed state-feedback traveling bend exactly and add one
target-geometry steering mechanism: a bounded mean posterior curvature derived
from body-frame bearing. A short bearing-trend lead reduces curvature as the
target centerline is being crossed, while a `12 deg` cap prevents steering from
replacing the propulsive oscillation. This should make the initial small
corrective turn, reverse its sign after an overshoot, retain the coherent wake,
and avoid the upper-boundary hook. The later CFD evaluation should reject the
hypothesis if the bearing still diverges, the wake/thrust collapses, command
clipping materially increases, or termination remains an early domain exit
without materially better target progress.

bookshelf_consulted: true
source_domain: robotic-fish target turning with mean-curvature or tail-beat bias, paired with classical traveling-wave propulsion
source_mechanism: retain a phase-lagged propulsive bend and superimpose a bounded average curvature from observed direction error
transferable_invariant: rhythmic thrust and slow target-directed curvature can be separated, with steering sign and magnitude closed around body-frame target geometry
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: keep the seed oscillator and lag unchanged; add a bounded bias to the posterior target from bearing plus a short observed bearing-window trend
falsification: reject if target bearing does not remain bounded and recover after centerline crossing, or if distance progress, wake coherence, saturation, or termination class fails to improve
