# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=[0,0,0]`, no prewarm, no cylinders, and no instability. I
  inspected the combined sheets for the strongest finite sample and the most
  informative failure, including every top-down vorticity frame and oblique
  body/Lambda2 frame. Both fish self-propel along the same diagonal approach,
  leave a long alternating mid-plane wake with compact three-dimensional
  structures, pass laterally by the target, turn downward, and remain powered
  to the lower boundary. The defect is post-miss recovery, not advection,
  collision, wake collapse, or insufficient cruise propulsion.
- The sampled course-selected posterior phase-lag modulation is the strongest
  current first pass: relative to the response-selected posterior brake it
  improves minimum distance from `2.385L` to `2.326L`, improves the recorded
  trajectory mean from `6.772L` to `6.725L`, and delays the first near-target
  target-behind crossing from `17.963T` to `18.650T`. At its minimum the fish
  still travels at `0.687U`, target-ray/course mismatch is `1.088 rad`, and
  anterior/posterior command-clamp residence remains about `0.749/0.355`.
  It then recedes to `3.155L` by `21T` and `4.777L` by `24T`, finally exiting
  low at `31.741T`; phase shaping improves the pass but does not recover.
- The sampled anterior duty action (`2.433L`) and response-gated equilibrium
  S-bend (`2.536L`) preserve the same wake and lower exit. The assigned parent
  logs close three more branches without semantic improvement: course-selected
  differential equilibrium bending reaches `2.469L`; a target-behind
  anterior-only damping hold reaches `2.293L` but exits earlier at `29.76T`
  while post-miss speed rises rather than falls; and a target-behind
  differential burst redirect with posterior-wave attenuation reaches
  `2.499L` and still exits low. These results contradict another curvature,
  duty, phase-gain, or single-joint damping adjustment.

## Policy hypothesis

Use the sampled `2.326L` phase-lag policy as the unchanged inbound carrier and
add one post-overshoot mechanism: a geometrically selected whole-wave hold.
Normalized longitudinal target geometry, measured closing speed, and distance
must agree that a nearby target is behind and receding. Only then add bounded
joint-rate dissipation to both joints. Damping the measured anterior oscillator
and posterior follower together should let the traveling bend decay without an
abrupt posterior-target rescale; the existing mean-curvature feedback remains
available to reorient the body. The hold releases continuously when the target
is no longer behind, is closing again, or is far away. It has no clock, route,
world coordinate, or mutable stage.

Support requires unchanged inbound progress and wake, followed by capture, a
new finite termination class, or a visibly returning second approach. Falsify
the mechanism if it changes the first pass, raises command/load residence,
coasts without reorientation, loses wake coherence before overshoot, or
retains the same powered lower exit. A scalar minimum-distance change without
post-miss recovery is not support.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach control
source_mechanism: geometrically confirmed overshoot invokes a bounded whole-gait hold while target-directed mean steering remains active
transferable_invariant: distinguish productive inbound propulsion from receding post-overshoot propulsion and dissipate the complete measured traveling rhythm only in the latter state
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, prescribed hold durations, exact vortex phases, capture radii, and task-specific routes
policy_translation: normalized body-frame longitudinal target fraction, normalized distance, and measured closing speed gate equal-sign joint-rate damping on the two-joint state-feedback carrier; the existing target curvature and posterior phase lag are unchanged inbound
falsification: reject if the first pass or cruise wake changes, actuator or load residence rises, the body fails to reorient, or capture, a returning approach, and the lower-exit class all remain unchanged
```

## Evaluation boundary

The candidate receives formal coupled CFD only after this worker exits.
Controller replay and contract checks can establish gating, boundedness,
reflection equivariance, and inbound locality, but cannot establish a new
hydrodynamic trajectory.

## Implemented candidate and non-CFD probes

The candidate starts from the sampled `2.326L` posterior phase-lag policy and
adds only the shared semantic hold gate and equal joint-rate damping described
above. Replaying candidate and baseline algebra on the completed phase-lag
trajectory changes either command by at most `0.0061 rad/T^2` before its
minimum (mean maximum-joint difference `1.1e-5 rad/T^2`). The reconstructed
hold weight is `0.00028` immediately before minimum, rises to `0.53` at the
`18.650T` target-behind crossing, and reaches `0.98` by `21T` as the fish
recedes. At the stored `21T` state the posterior command changes by
`6.68 rad/T^2`; the anterior command is already at the common `28 rad/T^2`
reserve. This confirms activation semantics, not a coupled state response.

Replayed anterior/posterior clamp residence is `0.7482/0.3551`, versus
`0.7477/0.3552` for the baseline on the same stored states. A mirrored
post-overshoot probe negates both commands with zero floating-point residual,
and an extreme finite probe remains finite within `+/-28 rad/T^2`. The
lightweight policy contract, parameter schema, editable-boundary audit, and all
`324` repository non-CFD assertions pass. Formal CFD was not run.
