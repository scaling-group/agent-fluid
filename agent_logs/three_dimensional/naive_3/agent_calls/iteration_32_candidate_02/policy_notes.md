# Closing-miss curvature bridge candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase 2 experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows in every combined
  keyframe sheet. Each fish self-propels and retains a coherent curved
  alternating planar wake with compact three-dimensional structures. The
  misses are stable powered trajectory errors, not advection, wake collapse,
  collision, domain exit, or numerical instability.
- The sampled terminal course hold remains the strongest useful trajectory:
  `1.241/4.157/2.082L` minimum/mean/final distance and about `0.47T` inside
  `1.25L`. Its visual sheet shows repeated return loops folding progressively
  toward the target. At its late minimum, speed is `0.669U`, target-ray/course
  error is `1.692 rad`, course dot is `-0.121`, predicted straight-course miss
  distance is `1.232L`, and useful yaw is only about `0.13 rad/T`; commands are
  modest and the anterior wave remains active.
- The assigned parent's joint-state C-bend release is a completed negative
  result. It reaches only `2.215/3.859/3.416L` minimum/mean/final distance and
  repeats a broad coherent orbit. At its minimum both joints are nearly parked
  around `(-0.356,-0.379) rad`, despite the release mechanism. The sampled
  rear-centerline selector and low-activity wave restart likewise reach only
  `2.366L` and `2.369L`, with `3.502L` and `3.455L` final distance. Thus
  selector replacement, quiet-bend unbending, and low-activity anterior
  restart all displace the useful `1.241L` return without changing the stable
  powered-loop termination class.
- A kinematic audit of the useful scaffold identifies an untested handoff,
  rather than an authority deficit. On its later closing returns, the target
  is already behind while course dot is still positive: at `42.135T`, distance
  is `1.643L`, course dot is `0.575`, and the constant-course miss estimate is
  `1.344L`; at `68.904T`, the corresponding values are `1.730L`, `0.501`, and
  `1.497L`. The existing nonclosing response is then intentionally off and the
  terminal course hold is only partially engaged. By the closest point, the
  course is already receding. This supports testing anticipation from relative
  motion before another bend-release, burst, scalar radius, or amplitude edit.

## Policy hypothesis

Return to the sampled terminal-course-hold scaffold and preserve its
oscillator, bearing curvature, posterior brake, phase modulation,
geometry-released C-turn, course-response reserve, continuous terminal hold,
wave envelope, curvature bounds, and command reserve. Add one bounded timing
mechanism without new authority: estimate constant-course miss distance as
`distance * abs(sin(target-ray/course error))`. Only when the target is fully
behind, remains nearby and closing, and that predicted miss is large, blend
the already owned response curvature in before the nonclosing/terminal gates
would do so. Release continuously as closure ends or the projected miss
shrinks. The carrier and both joint equilibria remain otherwise unchanged.

Support requires preservation of the coherent first return plus capture, a
pass below `1.241L`, longer residence inside `1.25L`, or a smaller late return
with improved final/mean distance and comparable command/load residence.
Reject if the target-ahead first return changes materially, wake coherence or
traveling-wave activity degrades, clamp/load residence rises, or the same
noncapturing orbit remains. Frozen replay can establish localization and
boundedness but cannot establish coupled-flow improvement.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and continuous approach control
source_mechanism: relative target motion schedules bounded maneuver authority while retaining the posteriorly lagged propulsive rhythm
transferable_invariant: preserve the evidenced traveling-wave carrier and engage an existing turn continuously from observed closing-miss geometry before closest approach, then release it with measured closure
nontransferable_details: published CPG gains, dimensional beat frequency, species-specific envelopes, joint count, exact vortex phase, capture radius, target coordinates, clocked stages, and prescribed paths
policy_translation: normalized body-frame target and velocity vectors form course dot and constant-course miss distance; existing target-behind, terminal-distance, and speed weights gate the unchanged two-joint response curvature
falsification: reject if the target-ahead return changes, the wake or wave degrades, action/load margins worsen, or closest, near-target, mean, and final distance do not improve over the 1.241L scaffold
```

## Evaluation boundary

The candidate's coupled CFD outcome is unavailable until this worker exits.
Only dry contract checks and frozen-state replay are used here; no formal CFD
is run in this workspace.

## Implemented candidate and non-CFD probes

The candidate implements only the proposed closing-miss bridge on the sampled
`1.241L` course-hold scaffold. Four owned normalized thresholds describe
closing-course and projected-miss transitions. The bridge is a multiplicative
gate on the existing response weight: it adds no curvature, wave amplitude,
drive, posterior lag, or command authority, and it uses no history, clock,
world coordinate, target identity, mutable state, route, or file access.

A derived-observation replay over all `18182` states of the completed scaffold
shows the intended localization. Across target-ahead states, maximum-joint
candidate/scaffold action difference is `0.000027/0.0105 rad/T^2` mean/maximum;
beyond `3L` it is `0.000636/0.0234 rad/T^2`. At the target-ahead `2.466L`
first return, the difference is below displayed precision. At the evidenced
target-behind closing return (`42.135T`, `1.643L`, course dot `0.575`, projected
miss `1.344L`), bridge weight is `0.401` and maximum-joint action difference is
`6.398 rad/T^2`, still far below the command reserve. At the completed
scaffold's receding `1.241L` minimum, bridge weight has released to `0.0008`
and action difference is `0.0051 rad/T^2`. Because compact trajectory rows do
not reproduce the simulator's pre/post-step observation alignment exactly,
these are locality and scale probes, not coupled dynamics or CFD predictions.

All `48` direct parameter references are returned by
`target_policy_params()`, with no unused returned fields. Mirrored target,
velocity, joint, and yaw probes negate both actions with zero observed
residual. Representative cruise, zero-speed, and terminal states are finite
and respect the `+/-28 rad/T^2` reserve; the nominal recovery
curvature-plus-wave envelope is `38.6 deg`, below the `45 deg` joint limit.
The mandated guidance materiality/schema check, lightweight Julia policy
contract, and solver editable-boundary check pass. A duplicate rendering of
the assigned parent in the workspace `README.md` was removed so the mandated
checker can resolve its single parent. No formal CFD was run.
