# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the policy edit

All sampled episodes report direct uniform initialization at
`U_infinity=(0,0,0)`, with no prewarm or cylinders. Motion in both keyframe
rows is therefore self-propelled. `solver_19f251537923` is the strongest
finite trajectory: it sustains an alternating top-down vortex street and
paired three-dimensional Lambda2 structures while reducing range from
`12.328L` to `6.138L`. It then continues below the target, reopens range to
`10.460L`, and exits the lower boundary at `26.147T`; local flow remains small
near exit. This is useful propulsion followed by failed turn arrest.

The assigned parent `solver_a8731015fd6e` preserves the same `0.55T`, `28deg`
traveling-bend carrier but applies geometry-only posterior mean curvature.
Its line-of-sight error changes sign by about `5T`, yet heading continues from
`0.435rad` at `4.004T` to `-1.074rad` at `9.003T`. The keyframes show only a
short developing wake before the fish curls upward; range improves by just
`0.450L` and then regresses before an upper-boundary exit. The response-led
sibling `solver_d94c4664e94e` has the same topology and a worse `12.030L`
closest approach. The scalar-best `solver_97bc3c03d55b` uses a raw recent-yaw
loop and makes monotonic progress to `9.175L`, but it still rotates into an
upper exit at `11.132T`; its larger compact curvature loop does not establish
controlled pursuit.

Inherited optimizer logs provide three relevant negative controls. A direct
raw-yaw arrest residual around the dense controller degraded the `6.138L`
closest approach to `9.319L` and ended at `16.264L`. A reduced-carrier
half-cycle asymmetry reached only `12.233L`, and the strong-carrier
geometry-gated half-cycle candidate reached `12.100L`; both exited the upper
boundary near `8.5T`. Another scalar change to these failed paths is not
supported.

The evaluator's yaw history is only eight steps, approximately `0.04T`, versus
the `0.55T` carrier period. The sampled traces show why raw yaw feedback is
misleading: instantaneous heading rate correlates with anterior joint velocity
at `-0.908` in the parent, `-0.900` in `solver_d94c4664e94e`, and `-0.912` in
the inherited strong-carrier half-cycle result. Separate one-variable fits give
nearly consistent beat components of `-0.475`, `-0.457`, and `-0.448` times
`phi_dot[1]`. This supports conditioning the measured yaw response on observed
joint phase before using it for slow turn arrest.

## One candidate hypothesis

Preserve the parent's joint-state oscillator and posterior phase lag. Replace
geometry-only mean curvature with a bounded response loop whose measured turn
rate is first compensated by the evidenced anterior-velocity beat component.
Compare that phase-conditioned residual with a bounded body-frame LOS-derived
target turn rate, and map only the error to posterior mean curvature. This is a
single sensor-modulated steering mechanism: the propulsive carrier remains
unchanged, while feedback is prevented from treating its predictable
beat-scale yaw as route error. All observations are normalized and
reflection-equivariant; there is no clock, route, coordinate, or mutable
memory.

Falsification: reject the mechanism if the alternating wake weakens, early
range progress fails to beat the parent's `11.878L` minimum, the
phase-conditioned residual retains carrier-scale oscillation, or the fish
again crosses the target line and exits a boundary without arresting yaw. Also
reject persistent angle/rate/acceleration limiting or materially larger load
spikes.

```text
bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish CPG direction tracking
source_mechanism: condition a bounded steering residual on the observed locomotor phase while leaving the rhythmic carrier intact
transferable_invariant: separate predictable carrier-synchronous body response from the slower target-directed response before applying feedback steering
nontransferable_details: published CPG gains, robot linkage geometry, dimensional cadence, clock-driven phase, species kinematics, exact wake phase, and task-specific routes
policy_translation: estimate the carrier-synchronous yaw component from normalized anterior joint velocity, subtract it from measured body yaw rate, compare the residual with a normalized body-frame LOS turn request, and apply the bounded error only as posterior mean curvature
falsification: the transfer fails if wake coherence or parent-relative progress is lost, the compensated yaw remains beat-dominated, saturation becomes persistent, or the upper/lower boundary-exit arc recurs
```

## Non-CFD contract checks

The prescribed finite two-joint policy check passes. A separate mirrored-state
probe (target lateral component, heading rate, both joint angles, and both
joint velocities all sign-reflected) produced exactly negated accelerations,
confirming reflection equivariance. The same probe verified that the response
used by guidance is `heading_rate + 0.47 * phi_dot[1]`. These checks establish
only schema validity, finiteness, symmetry, and execution of the intended
phase subtraction; they do not establish wake quality, turn arrest, target
progress, or actuator/load histories without the later CFD evaluation.
