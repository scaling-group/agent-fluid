# Candidate diagnosis and hypothesis

## Evidence diagnosis before editing

All four sampled rollouts are valid direct-uniform still-water episodes and
terminate in capture. The combined sheets show self-propelled translation from
release, a coherent alternating top-down vortex street, compact paired
Lambda2 structures in the oblique row, continued target-directed turning, and
no wake collapse, passive advection, collision, boundary exit, or instability
before capture. The best scalar example (`solver_625a1e7347f1`) and the slowest
sample (`solver_3ca4e16bfde3`) have the same useful wake topology, so scalar
separation is a controller-timing and actuator-use question rather than a
propulsion-survival question. The diagnostics confirm zero background flow,
direct uniform initialization, and local-flow RMS of only `0.01816--0.01843U`.

The inherited response-reversing half-cycle candidate captures at `18.931T`
with action-limit occupancy `44.77%/76.09%`, action RMS `25.22/28.86`, and
force/moment RMS `0.01357/0.00707`. Ungated coefficient-norm-preserving phase
rotation captures later at `18.997T`, while a phase gate driven by previous
posterior action captures at `18.892T`. Predicted-saturation recruitment is
the strongest sampled mechanism: it captures at `18.799T`, improves score to
`-0.14330`, and reduces occupancy to `41.54%/73.96%`, action RMS to
`24.58/28.62`, and force/moment RMS to `0.01315/0.00684`. The assigned-parent
guidance and inherited optimizer logs agree that all these phase variants
retain capture and that more clipped mean curvature is contraindicated.

## Policy hypothesis

Start from predicted-saturation recruitment, not the weaker prefilled
half-cycle. Add one constraint-aware allocation semantic: calculate the
bounded response-reversing posterior phase proposal, compare its instantaneous
posterior acceleration demand with the unmodulated response-reversing demand,
and smoothly accept only the portion that opens acceleration headroom. This
keeps the completed LOS-rate distributed C-bend and coherent carrier exactly
available, while preventing phase steering from spending scarce authority on
a locally worse command. It is not scalar gain tuning; it changes how two
compatible rhythmic commands are allocated under the physical envelope.

Expected evidence: retain capture and both coherent wake rows, remain within
the sampled `18.799--18.997T` phase-variant arrival band, and improve on the
best sampled `41.54%/73.96%` limit occupancy or `0.01315/0.00684` force/moment
RMS without worsening mean distance. Reject the allocation rule if it loses
capture, breaks wake coherence, slows beyond `18.997T`, or merely reproduces
clipping/load while suppressing useful steering.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual control over low-dimensional rhythmic commands
source_mechanism: sensor feedback modulates a stable propulsive rhythm while bounded residual allocation preserves the base gait
transferable_invariant: preserve the coherent joint-state oscillator and allocate steering through bounded observed-response timing, accepting residual authority only where the actuator envelope can express it
nontransferable_details: published gains, clock phases, species kinematics, full-body CPG networks, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame LOS and yaw response with observed joint phase; recruit coefficient-norm-preserving posterior phase modulation near predicted clipping and blend it back toward the evaluated half-cycle command when it does not open instantaneous acceleration headroom
falsification: reject if capture or wake coherence is lost, arrival leaves the sampled phase-variant band, or posterior occupancy and force/moment RMS fail to improve without a mean-distance benefit
