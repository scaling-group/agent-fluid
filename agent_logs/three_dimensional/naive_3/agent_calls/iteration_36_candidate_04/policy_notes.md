# Terminal response-gated posterior-wave candidate

## Evidence diagnosis before the policy edit

All four sampled solver evaluations and the inherited completed evaluations
use direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and `horizon`
termination. I inspected both the top-down mid-plane-vorticity and oblique
body/Lambda2 rows in the combined keyframe sheets. Every fish self-propels and
leaves a coherent alternating wake with compact three-dimensional structures;
advection, wake collapse, collision, domain exit, and numerical instability do
not explain the misses.

The sampled terminal course hold reaches `1.241/4.158/2.082L`
minimum/mean/final distance and visibly makes the tightest return among the
four sampled policies. The rear-centerline selector, joint-state unbend, and
fixed-sign restart reach only `2.366`, `2.215`, and `2.369L` and form broad
powered loops around a nearly stationary negative C-bend. The inherited
phase-balanced carrier is the one completed semantic improvement: it reaches
`1.175/4.041/3.243L`, remains inside `1.25L` for about `2.35T`, and preserves
near-target mean absolute anterior/posterior velocity near
`0.775/0.360 rad/T`. Its wake stays coherent, but each close pass remains
tangential: at the `1.175L` minimum, speed is about `0.683U`, course error is
`1.682 rad`, course dot is `-0.111`, and heading rate is only about
`-0.06 rad/T`.

The inherited negative controls close several tempting repetitions. A
requested-sign anterior half-cycle pulse reaches only `1.702L` and parks both
joints. Adding an anterior duty asymmetry to the active carrier regresses to
`2.362L` and the same parked broad loop. A direct target-ray-rate anterior
residual reaches `2.201L`; a radial energy-gain variant reaches `1.366L`; and a
posterior lag response reaches `1.276L`. None captures, and the last two also
worsen final distance to `3.047L` and `2.881L` relative to the `1.241L` course
hold. Thus activity is necessary but anterior energy shaping, direct residual
acceleration, and weak posterior phase shifting do not supply the missing
inward turn.

## Policy hypothesis

Restore the completed `1.175L` phase-balanced carrier without changing its
course-hold geometry, moving equilibria, anterior energy regulator, posterior
lag, braking, wave envelope, curvature limits, or command reserve. Add one
bounded response-gated posterior amplitude mechanism. When the existing
terminal course gate is active, use the sign of body-frame target-ray/course
error as the requested turn and measured heading rate only as a gait-half-cycle
selector. Smoothly strengthen the posterior traveling-wave component while
the observed yaw already reduces that course error; leave the other half-cycle
and both mean bends unchanged.

This separates the persistent geometric request from fast measured response,
places steering authority in the tail wave rather than the failed anterior
energy channel, and preserves positive energy on both anterior half-cycles.
Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a tighter final return while retaining the coherent first approach,
active joint motion, and comparable clamp/load residence. Falsify the mechanism
if the first return changes, either joint parks, useful yaw does not increase,
the wake or orbit broadens, clamp/load residence rises materially, or closest,
near-target, mean, and final-distance evidence do not improve together.

```text
bookshelf_consulted: true
source_domain: asymmetric robotic-fish flapping and sensor-modulated CPG direction tracking
source_mechanism: apply bounded target-directed half-cycle asymmetry inside an intact feedback-stabilized traveling-wave carrier
transferable_invariant: preserve the rhythmic carrier and mean turn command, then strengthen only a measured gait half-cycle whose observed body response advances the persistent route correction
nontransferable_details: published gains, duty ratios, clock phase, dimensional frequency, species kinematics, full-body waveforms, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-ray/course error supplies turn demand; measured heading rate selects a useful yaw half-cycle; the selected weight scales only the posterior state-feedback wave within the two-joint contract
falsification: reject if the first return moves, either joint parks, useful terminal yaw fails to rise, wake or orbit expands, loads/clamps worsen, or closest approach, residence, mean, and final distance do not improve over the 1.175L scaffold
```

## Evaluation boundary

The coupled CFD outcome becomes available only after this worker exits.
Frozen completed traces can establish parameter ownership, locality,
reflection equivariance, boundedness, and action scale, but cannot establish
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the completed `1.175L` phase-balanced policy and
adds two owned parameters for one response-gated posterior-wave scale. It does
not change the anterior action, either joint equilibrium, curvature, distance
or course threshold, base lag, brake, oscillator, wave envelope, or
`+/-28 rad/T^2` command reserve. It uses no time, step count, hidden state,
world coordinate, target identity, route, randomness, file access, or mutable
state.

Exact Julia replay over all `18182` states of the completed parent changes
posterior action by only `0.000098/0.00562 rad/T^2` mean/maximum beyond `3L`,
but by `0.283/1.269 rad/T^2` inside `1.5L`; anterior action is identical. Inside
`1.25L`, the posterior delta is `0.253/0.942 rad/T^2` mean/maximum. Lateral
reflection of target, velocity, yaw, and joint state negates both actions with
zero sampled residual. These frozen probes establish locality, bounded action,
and reflection equivariance only; they do not predict the coupled trajectory.

All `50` direct parameter references name the `50` fields returned by
`target_policy_params()`. The required guidance, lightweight Julia contract,
and solver editable-boundary checks pass. No formal CFD was run.
