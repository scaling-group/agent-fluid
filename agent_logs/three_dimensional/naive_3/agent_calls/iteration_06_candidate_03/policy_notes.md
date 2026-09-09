# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance, sampled rollouts, and inherited optimizer log
  all describe direct-uniform quiescent initialization: `U_infinity=(0,0,0)`,
  no cylinders, no prewarm snapshot, and finite dynamics. Motion in the sheets
  is therefore self-propulsion rather than advection or an initialization
  artifact.
- I inspected both rows of the combined sheets for the best sampled finite
  policy (`2.443L` minimum at `17.869T`) and the most informative failures: the
  `12 deg` response redirect (`2.729L`) and the inherited posterior half-cycle
  asymmetry (`3.661L`). The best policy's top-down row retains an alternating,
  coherent vortex chain from release through the pass, and its oblique row
  shows a long three-dimensional Lambda2 trail rather than wake collapse. It
  reaches target height near `16T` but keeps a steep downward translation,
  passes below the target, and leaves the lower boundary at `31.097T`.
- The diagnostics agree with the images. For the best policy, anterior and
  posterior command clamps are occupied for about `74.6%` and `35.4%` of
  samples, respectively. At closest approach the velocity is approximately
  `(-0.628,-0.272)U`; transformed by the logged body heading, this contains a
  substantial lateral component while the target ray is already strongly
  lateral. The route has accumulated cross-track translation before the
  distance-only hold can act. Increasing equilibrium curvature to `12 deg`
  keeps the wake but worsens the pass, so more static bend is not supported.
- The inherited direction-gated posterior half-cycle asymmetry is a concrete
  negative result. Its sheet still shows an alternating wake, but the world
  trail steepens earlier; minimum distance degrades from `2.443L` to `3.661L`,
  mean distance rises from `8.443L` to `9.001L`, and the same lower exit arrives
  earlier at `27.539T`. Later workers should not retry that asymmetry without a
  materially different signal or actuator construction.

## Policy hypothesis

Retain the best sampled `7 deg` bearing/yaw-rate mean-curvature reflex,
alignment gate, joint-state oscillator, command reserve, and posterior wave
amplitude. Add one actuator mechanism: compare measured body-frame lateral
velocity with a bounded desired lateral velocity derived from the normalized
body-frame target ray, then use only the magnitude of that slip residual to
retard the posterior state-phase relation. Renormalize the joint-state basis so
this rotates the posterior phase without silently becoming another amplitude
or drive-gain schedule. The signed mean curvature still supplies turn side,
while the even slip gate preserves reflection equivariance.

The expected useful change is a shallower cross-track route by `8--16T`, the
same coherent far-field wake, and a closest approach below `2.443L`, ideally a
capture or at least a termination other than another powered lower exit.
Falsify the mechanism if the initial route or wake coherence deteriorates,
command/rate-limit residence grows, the phase change increases downward slip,
or the `2.443L`/lower-exit topology is not improved.

```text
bookshelf_consulted: true
source_domain: elongated-body tail-kinematics theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an anterior propulsive rhythm while feedback modulates posterior wave phase to change the hydrodynamic response
transferable_invariant: persistent normalized body-frame slip relative to the target ray can gate a bounded posterior phase change while measured joint state supplies oscillator phase
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot geometry, exact vortex phases, amplitude ratios, and task-specific routes
policy_translation: rotate and renormalize the posterior target's joint-angle/joint-rate basis as an even bounded function of target-ray lateral-velocity residual, retaining signed mean-curvature steering
falsification: reject if the coherent wake or far-field propulsion is lost, cross-track drift grows, closest approach does not beat 2.443L, the lower exit persists unchanged, or actuator saturation and loads worsen
```
