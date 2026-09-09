# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and its inherited worker note establish that
  the common naive oscillator/posterior-lag carrier self-propels in valid
  direct-uniform still water, but its uncontrolled turn exits the upper
  boundary at `8.602T`. All four sampled rollouts use `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and finite dynamics, so their trajectory
  differences are usable controller evidence.
- Both rows of every combined keyframe sheet were inspected. The naive case
  `solver_35fea652543a` develops a coherent alternating top-down and oblique 3D
  wake but curls upward, with only `12.070L` closest approach. The reduced-drive
  `10 deg` curvature case `solver_b0180f8d5568` makes a tight U-turn and loses
  route progress (`12.324L` minimum, `15.380L` final). The `14 deg` split-bias
  case `solver_b8ee16f26af1` likewise turns upward with a short, weak wake
  (`12.291L` minimum, `13.409L` final). These failures show that more static
  bend plus scalar carrier reduction is not an evidenced solution.
- `solver_6f1e6108928b` is the strongest finite comparator. Its restrained
  `7 deg` mean-curvature reflex preserves a long coherent vortex chain and
  travels left and down toward the target, reducing distance from `12.328L` to
  `4.067L` and surviving to `24.893T`. The visual route and trace then agree on
  the failure: near `14--16T` the target moves far off the body axis (computed
  bearing about `1.0--1.3 rad`) while the fish continues translating below it;
  distance rises and the fish exits the lower boundary at speed. This is
  self-propelled cross-track overshoot, not passive advection, lost wake
  coherence, numerical instability, or a moving-window artifact.
- The strong controller's raw commands reach about `84/110 rad/T^2`, and both
  joint rates touch the `260 deg/T` envelope. Any extension should preserve its
  useful carrier/curvature topology while reducing propulsive authority during
  gross misalignment and bounding commands below the episode acceleration
  limit; adding more unbounded curvature is contradicted by the other samples.

## Policy hypothesis

Retain the strong sample's joint-state oscillator, posterior lag, bounded
body-frame bearing-to-mean-curvature map, and yaw-rate release. Add one
state-dependent gait mechanism: smoothly attenuate only the posterior
traveling-wave component as absolute target bearing grows, while retaining the
posterior mean curvature. This separates turning authority from thrust: a
misaligned fish can redirect without continuing the evidenced cross-track
overshoot, and the full posterior wave returns continuously when bearing is
small. Explicit final acceleration bounds provide deterministic actuator reserve
but are not the navigation mechanism.

Expected evidence is the same correct-sign left/down approach and coherent 3D
wake as `solver_6f1e6108928b`, followed by smaller cross-track speed, shrinking
bearing, and closest approach below `4.067L` instead of a lower-boundary exit.
Falsify the translation if the initial wake or progress collapses, the fish
repeats either tight U-turn topology, bearing remains large while it crosses
below the target, or command limiting produces persistent joint-rate residence.

```text
bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG turning and biological burst-redirect control
source_mechanism: retain bounded mean bend while reducing propulsive rhythm during large direction error, then restore the posterior beat after alignment
transferable_invariant: body-frame misalignment should continuously trade posterior thrust for turning authority without erasing the joint-state phase carrier
nontransferable_details: published CPG gains, clocked phases, robot geometry, species-specific burst kinematics, dimensional beat settings, exact vortex phases, and task-specific routes
policy_translation: absolute normalized bearing smoothly gates only the lagged posterior wave around the evidenced bounded mean-curvature reflex; measured yaw rate releases curvature and both accelerations are explicitly bounded
falsification: reject if target progress or the alternating wake collapses, the same large-bearing lower-boundary overshoot remains, a tight U-turn replaces it, or actuator-limit residence does not improve
```
