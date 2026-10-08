# Candidate diagnosis and hypothesis

## Evidence diagnosis

All four sampled solver rollouts and the assigned parent's completed rollout
use direct `uniform_direct` initialization in still water
(`U_infinity=[0,0,0]`) with zero cylinders, and all terminate in capture. In
the combined sheets, each top-down row shows self-propelled target approach
behind a coherent alternating red/blue street; the fish is not advected. Each
oblique row shows compact three-dimensional Lambda2 structures continuing from
the caudal region through approach without wake collapse, out-of-plane escape,
or numerical breakup. The trajectories and wakes remain visually
indistinguishable at sheet resolution, so the informative differences are in
the synchronized joint/yaw histories rather than gross topology.

The v24 continuous target-course brake captures at `23.831520T`, with mean
distance `2.434073L`, peak yaw `3.208 rad/T`, inside-`3L` mean absolute yaw
`1.684 rad/T`, and both joint-speed caps reached. The sampled v29 posterior
half-cycle counter-tangent captures slightly earlier at `23.793020T` and has a
slightly lower mean distance (`2.433953L`), but it increases peak yaw to
`3.289 rad/T`, inside-`3L` mean absolute yaw to `1.706 rad/T`, peak moment
coefficient from `0.01409` to `0.01512`, and leaves speed-cap exposure at
`11.60%/4.53%` (`14.38%/5.66%` above 99% of cap); its scalar score is also
slightly worse. Thus the added posterior tangent is a concrete negative
result, not terminal damping.

The assigned parent's inherited v27 rollout supplies the complementary result.
Its posterior half-cycle phase-lag modulation lowers peak and near-field yaw to
`2.925` and `1.584 rad/T`, but capture slows to `23.925022T`, mean distance
worsens to `2.434841L`, and exact speed-cap exposure remains `11.56%/4.67%`
(`14.32%/5.77%` above 99% of cap). Together v27 and v29 show that terminal
posterior lag and tangent changes trade yaw
against arrival without relieving the shared actuator symptom. The repeated
near-limit projected commands and exact `4.537856 rad/T` speed peaks indicate
that hard velocity clipping, not insufficient static curvature, is the next
distinct mechanism to test.

## Policy hypothesis

Return to the captured v24 target-course bend by removing v29's ineffective
posterior counter-tangent, and preserve its oscillator, redirect release,
target-relative course residual, and smooth acceleration projection. Add one
actuator-layer outward-work barrier: once either observed joint speed enters a
normalized band near its known speed envelope, smoothly attenuate only a
command whose sign would increase that speed magnitude. A command that brakes
or reverses the joint passes unchanged. Because command and joint-rate signs
both reverse under lateral reflection, their product and the attenuation are
reflection-even while the guarded command remains reflection-odd. This uses no
clock, route state, or case identity and should avoid clipped velocity plateaus
without globally weakening the traveling wave.

Support requires stable capture with the coherent alternating wake, arrival no
slower than the inherited v27 result (`23.925T`), and a material reduction from
the roughly `11.5%/4.6%` exact speed-cap exposure without worsening the v24
peak/near-field yaw pair. Falsify the mechanism if capture or wake coherence is
lost, mean distance worsens materially, the speed caps remain occupied, or
reduced propulsion merely delays the same trajectory.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve posteriorly lagged wave propulsion while modulating oscillator energy with observed actuator state rather than prescribing a new route or clocked gait
transferable_invariant: protect the traveling-wave phase relationship by removing only state-synchronous effort that pushes an actuator farther into saturation, while preserving reversal effort
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: use normalized joint speed and the reflection-even product of joint rate with projected acceleration to apply a smooth two-joint outward-work barrier; retain body-frame target feedback and pass braking commands unchanged
falsification: reject if capture, arrival, or wake coherence regresses, or if joint-speed exposure, terminal yaw, transverse motion, and loads do not improve without a new saturation elsewhere
