# Candidate wake-policy notes

## Inherited rollout diagnosis

The sampled `solver_19f251537923` rollout is valid direct-uniform still water
with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The combined visual
sheet shows self-propulsion rather than advection: an alternating, coherent
mid-plane wake and paired three-dimensional Lambda2 structures develop behind
the fish. The useful finite portion is the diagonal approach through roughly
`16.5T`; the failure portion is the continuing clockwise/downward arc after
that closest approach. Lateral oscillation remains propulsive, but the mean
turn is not arrested when the target crosses to the other side of the body.

The scalar and trajectory evidence agrees. Distance falls from `12.328L` to
`6.138L` at `16.505T`, then rises to `10.460L` before a lower-boundary exit at
`26.147T`. From closest approach to termination, heading rises from `0.747` to
`1.383 rad` and measured heading rate rises from `0.211` to `1.571 rad/T`,
while the body-frame target geometry requests the opposite turn sign. The local flow
remains small (about `(-0.023, 0.007)U` at exit), so a wake-crossflow rejection
term is not supported by this still-water failure. The organized wake and
roughly `0.8U` terminal speed argue against replacing or broadly retuning the
propulsive oscillator.

## Policy hypothesis

Preserve the inherited target-geometry steering, state-feedback oscillator,
posterior lag, and cadence scheduling. Add one new feedback path: map the
bounded difference between measured recent yaw rate and the target-directed
yaw-rate request directly into posterior mean curvature. This separates turn
arrest from half-cycle steering, supplies corrective curvature when the fish
continues rotating away after an overshoot, and releases continuously once the
measured yaw response matches the requested response. Consume the evaluator's
already normalized `distance_L`, `target_body_L`, `velocity_body_U`, and
`moment_z_L2` directly rather than restoring a cell-scale `L` adapter. The rate scale is set
near the observed onset of the failed post-pass rotation, not copied from a
source. The candidate is falsified if it destroys the alternating wake,
materially delays the early distance decrease, produces sustained joint-limit
behavior/load spikes, or retains the same closest-approach-then-lower-exit
topology without reducing the post-pass yaw growth.

```text
bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish CPG steering and response-gated fish redirects
source_mechanism: measured directional response modulates a bounded mean-curvature component while the rhythmic carrier continues
transferable_invariant: separate the propulsive rhythm from a response-feedback steering residual that vanishes when requested and measured turn rates agree
nontransferable_details: published gains, clock-driven CPG phases, robot linkage geometry, species-specific C-start kinematics, exact waveforms, and task routes
policy_translation: normalize recent yaw rate in rad/T, compare it with the bounded body-frame target-derived yaw-rate request, and add the saturated error only to the two-joint posterior mean-curvature target
falsification: reject if early target progress or wake coherence collapses, joint/load saturation becomes persistent, or positive yaw still grows after the target-line overshoot and the fish repeats the lower-boundary exit
```
