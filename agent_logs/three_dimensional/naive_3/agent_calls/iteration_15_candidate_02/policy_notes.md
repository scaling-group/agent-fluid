# Candidate diagnosis and hypothesis

## Evidence read before editing

All sampled and inherited diagnostics confirm direct uniform still-water
initialization (`U_infinity=(0,0,0)`) with no prewarm and no cylinders. I
inspected the combined sheets for the strongest sampled response-selected
posterior brake (`solver_563a0d75514e`), the prefilled joint-phase
counterbend (`solver_cb10b3fc3e7f`), and the assigned parent's evaluated
response-selected counterstroke (`solver_ef4b74242942`), including both the
top-down mid-plane vorticity row and the oblique body/Lambda2 row from release
through termination. Each fish self-propels along the same diagonal approach,
leaves a sustained alternating planar wake and compact three-dimensional
vortex chain, turns nearly vertically below the target, and remains powered
to a lower-boundary exit near `31T`. None is advected, collides, loses wake
coherence, or becomes numerically unstable.

The sampled response-selected posterior brake remains the strongest current
finite mechanism: it reaches `2.385L` with mean distance `8.436L`, compared
with `2.443/8.443L` for the unmodified alignment-gated carrier and `2.512L`
for the joint-phase counterbend. The assigned parent's subsequent reversal of
the authority removed by that brake is a completed negative result: it
worsens minimum/mean distance to `2.585/8.474L` and preserves the same lower
exit. Its anterior/posterior command-clamp fractions (`0.745/0.349`) remain
close to the brake's (`0.747/0.356`), and its sheet retains the coherent long
wake, so the regression is not explained by wake collapse or a gross new
saturation regime. It rejects another posterior counterstroke fraction or
posterior-equilibrium reallocation as the next test.

At the brake's minimum near `17.87T`, full body-frame target-direction error
is about `1.38 rad`, closure is about `0.014 L/T`, speed remains `0.705U`, and
heading rate is error-growing at `2.19 rad/T`. Across all four current samples
inside `3L`, heading rate is locked to anterior joint velocity with
`|r|=0.992--0.998`, while anterior acceleration is clamped for about `75%` of
the full trace. The posterior brake therefore selects a useful body-response
half-cycle but acts on the actuator that is not carrying the dominant yaw
phase. The unresolved mechanism is to interrupt that error-growing anterior
phase without weakening cruise or the corrective half-cycle.

## Policy hypothesis

Start from the sampled `2.385L` response-selected posterior brake. Preserve
its state-feedback carrier, target-relative mean curvature, alignment
envelope, posterior lag, approach/direction gate, posterior brake, and command
reserve. Under only the same near-target, large-direction-error,
error-growing-yaw gate, add a bounded damping impulse against anterior joint
velocity. This is a sensor-selected phase brake: it directly shortens the
anterior half-cycle that the completed trajectories identify with wrong-way
yaw, while the corrective half-cycle and all far-field actuation retain the
evidenced carrier exactly.

Expected evidence is unchanged diagonal cruise and coherent wake followed by
reduced wrong-way yaw and cross-track transit near the target. Capture, a
useful new termination class, or a minimum materially below `2.385L` without
worse broad progress supports the mechanism. Falsify it if far-field motion
changes, the wake shortens or collapses, anterior clamp residence rises
materially, a tight curl appears, or the same lower-exit/minimum topology
persists.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric turning
source_mechanism: measured directional response briefly damps or resets only the oscillator phase that is carrying the body away from the commanded turn
transferable_invariant: preserve the traveling-wave limit cycle but use signed target error and measured body response to interrupt only an error-growing actuation half-cycle
nontransferable_details: published gains, clock-driven CPG phase, robot geometry, species-specific kinematics, dimensional frequencies, prescribed burst timing, and task routes
policy_translation: normalized body-frame target direction and distance plus measured heading rate select a bounded damping term opposing anterior joint velocity inside the existing two-joint state-feedback carrier
falsification: reject if cruise changes, wake coherence degrades, anterior saturation increases materially, or closest approach and the powered lower-exit topology do not improve over the 2.385L response brake
```

## Evaluation boundary

The new candidate receives CFD evaluation only after this worker exits.
Contract, symmetry, and bounded-action probes below can validate only the
implementation, not the hydrodynamic hypothesis.

## Implemented candidate and pre-CFD checks

The candidate implements only the response-selected anterior phase brake
described above on top of the sampled posterior brake. Every active threshold,
scale, brake magnitude, carrier quantity, and command bound is returned by
`target_policy_params`.

At a representative state reconstructed near the best sampled minimum, the
new mechanism changes anterior acceleration from `10.960` to
`19.204 rad/T^2` while leaving posterior acceleration exactly unchanged at
`-0.305 rad/T^2`. At the same direction and joint state but `8L` distance, the
anterior difference is only `0.0059 rad/T^2`, confirming approach locality.
The mirrored state negates both commands to floating-point tolerance. A
deterministic `10,935`-state sweep spanning joint angles, joint rates, target
directions, distances, and yaw rates produced finite commands within the
configured bound. The mandated guidance-semantic, Julia policy-contract,
parameter-schema, and solver-boundary checks pass. These are implementation
checks only; formal CFD was not run.
