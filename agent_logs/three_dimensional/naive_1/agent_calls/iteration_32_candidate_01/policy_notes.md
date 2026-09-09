# Step 32 wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four current samples satisfy the frozen evaluation contract: direct
  uniform initialization in still water at `U_infinity=(0,0,0)`, no cylinders
  or prewarm, and capture termination. Three execute the prefilled half-cycle
  envelope-redistribution policy exactly. They capture at
  `18.6505--18.8815T`, with mean distance `2.08855--2.09222L`; the fourth adds
  a rearward-only route multiplier, captures at `18.9640T` and `2.09072L`, and
  does not test recovery because the successful route keeps the target ahead.
- I inspected the combined keyframe sheets for the best-score current capture
  and the distinct rearward-route sample. From release to capture, their
  top-down rows develop coherent alternating streets along a target-bending
  path, while their oblique rows retain compact bilateral/caudal Lambda2
  structures. With zero background flow, the translation is self-propelled;
  lateral motion remains part of the productive traveling bend, and neither
  view shows collision, wake collapse, or instability.
- The most informative inherited failure executes the same redistribution
  bytes as the three current captures. Its two-view wake remains energetic,
  but the top-down route bends progressively below the target: it approaches
  only to `1.25093L` at `19.1345T`, then exits left at `32.6370T` and
  `9.94426L`. At `16T` it is already lower and more over-rotated than the
  captures (`center_y=10.55L`, heading error `-0.314rad`, versus
  `10.76--11.05L` and `-0.284-- -0.202rad`), so rearward recovery would act
  after the useful intervention point. Its acceleration contact
  (`64.27%/70.48%`), rate contact (`9.22%/10.57%`), and peak planar loads
  (`0.0152/0.0274`, moment `0.01564`) also show no load or instability event
  that could explain away the missed route.
- This is a second known executable-equivalent redistribution miss, after the
  inherited `0.81206L` near miss. In contrast, the simpler geometry-scheduled
  half-cycle carrier has three completed captures at `18.6505--18.7550T` and
  mean distance `2.09340--2.09542L`. Its slightly worse distance integral is
  less important than testing whether removing the disputed allocation
  restores repeatable semantic capture.
- The assigned parent's cruise-aligned `6%` posterior-lag boost captures at
  `18.7825T`, but mean distance worsens to `2.10021L` versus the current
  redistribution band. Acceleration contact (`60.79%/73.35%`), rate contact
  (`10.95%/14.73%`), peak force (`0.01635/0.0280`), and peak moment (`0.01625`)
  remain comparable. This completed result does not support more posterior
  lag as either performance or demand relief.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and closed-loop CPG gait modulation
source_mechanism: apply target-signed steering on an observed useful beat half while preserving a coordinated posterior-lagged traveling wave
transferable_invariant: retain the target-owned positive half-cycle steering factor and coherent traveling-bend carrier, but remove an additional envelope allocation when repeated semantics show that it can change route topology without wake collapse
nontransferable_details: published gains, dimensional cadence, robot geometry, clock phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-lateral route sign, one-sided correcting-yaw release, displacement-only half-cycle curvature steering, common geometry-owned mean amplitude relief, posterior lag, and final acceleration projection; delete only the phase-dependent redistribution of that relief
falsification: reject the ablation if it loses capture or either coherent wake row, reproduces a downward near-miss/left-exit topology, or fails to return to the established geometry-scheduled `2.09340--2.09542L` mean-distance band; do not claim success from lower clipping alone

## Single candidate hypothesis

The prefilled controller conflates two beat-phase mechanisms: a positive
target-signed curvature factor and a separate redistribution of the common
amplitude-relief envelope. Current and inherited evidence supports the first
only within the displacement-only, non-inverting response-release package,
whereas two executable-equivalent misses now contradict robust semantics for
the second. The candidate therefore removes only envelope redistribution and
keeps the observed-phase steering factor, mean relief, mean-curvature shares,
posterior lag, and exact acceleration projection unchanged.

This is a one-mechanism structural ablation, not scalar-only gain tuning. It
adds no recovery channel, terminal schedule, velocity/flow residual, posterior
allocation, hidden clock, world coordinate, target identity, mutable state, or
memorized route. Formal CFD runs after this worker exits, so the hypothesized
robustness improvement is not claimed as current evidence.
