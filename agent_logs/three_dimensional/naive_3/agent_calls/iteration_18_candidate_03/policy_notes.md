# Wake-policy candidate notes

## Evidence and visual diagnosis

The assigned parent is `optimizer_9fd6ec32bfa9`; its inherited completed log
records a `0.820L` near miss followed by `left_domain`, while the prefilled
anterior half-cycle candidate `solver_eaa778e34ed6` reached only `4.859L` and
also exited left. The sampled phase-compensated course controller
`solver_b7827355cb30` similarly retained a coherent wake but regressed to
`4.459L`. Its top-down row shows a broad pass above the target followed by a
leftward divergence, and its oblique row shows alternating three-dimensional
vortex structures throughout; this is a steering-allocation failure, not loss
of propulsion or still-water advection. The approach-hold sample
`solver_53a6ee05b4ed` reached `3.592L`, but its late top-down hook coincides
with visibly weakened shedding rather than capture.

The strong finite comparison is `solver_3f1368fbcb76`. In both the top-down
and oblique rows it maintains a coherent alternating wake and bends the route
into the capture circle at `18.265T`; the rollout reports `capture`,
`0.7498L` final distance, `2.136L` mean scored distance, `1.329U` peak body
speed, and only `0.032U` peak local flow. Its anterior joint remains within
`26.3 deg`, while the posterior reaches the `45 deg` boundary. Raw
acceleration-envelope exceedance is about `51/46%`, materially lower at the
posterior joint than the `67%` phase-cancellation failure. Direct uniform
initialization and zero background velocity are confirmed in every sampled
diagnostic.

## Candidate hypothesis

Adopt the sampled posterior acceleration-reserve architecture without adding
another unevaluated terminal gain or observation. Preserve the zero-centered
anterior oscillator, posterior traveling-wave lag, full-quadrant body-frame
target bearing, and speed-gated wrapped velocity-course error. Within the
observed terminal-distance band, decompose posterior carrier and mean-turn
accelerations and soft-bound them so steering retains a fixed share of the
existing physical envelope. This is an architecture change from the assigned
half-cycle prefill and does not raise the actuator limit. The new evaluation
should reproduce capture while retaining alternating shedding; falsify the
hypothesis if it loses the sub-`1L` path, fails to capture, raises posterior
limit occupancy above the unallocated course family, or destroys the coherent
three-dimensional wake.

bookshelf_consulted: true
source_domain: robotic-fish CPG path following and residual control
source_mechanism: modulate a low-dimensional rhythmic carrier with bounded sensor-feedback steering rather than replacing it with raw high-frequency action
transferable_invariant: preserve the propulsive phase scaffold and keep target-directed corrective work observable and available inside a bounded actuation envelope
nontransferable_details: published gains, robot morphology, learned routes, clock-driven phase, duty ratios, and species-specific kinematics
policy_translation: use normalized body-frame bearing and measured velocity course for the turn request, then allocate the posterior acceleration envelope between the lagged carrier and mean-curvature residual only near the target
falsification: reject if the candidate loses alternating wake coherence, does not reproduce sub-`1L` approach and capture, or increases posterior saturation relative to the sampled unallocated course failures
