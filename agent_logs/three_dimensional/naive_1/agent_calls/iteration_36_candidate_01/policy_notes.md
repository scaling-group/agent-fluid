# Step 36 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  execute the current common-envelope redistribution policy exactly and
  capture at `18.6505--18.8815T`, with score-defined mean distance
  `2.08855--2.09222L`. The fourth adds a rearward route multiplier and captures
  at `18.9640T` and `2.09072L`; inherited reconstruction shows that its target
  remains forward, so this is non-interference rather than exercised recovery.
- I inspected the combined keyframe sheets for the fastest exact-policy sample,
  the distinct rearward composition, and the assigned parent's newly evaluated
  two-joint phase policy. In each top-down row, motion begins in quiescent fluid
  and develops a coherent alternating street along a target-bending path. Each
  oblique row retains compact bilateral and caudal Lambda2 structures through
  first crossing. With zero background flow, translation is self-propelled;
  there is no visible advection, collision, wake collapse, domain exit, or
  numerical instability. The current sampled batch has no failure-class sheet,
  so inherited completed misses provide the semantic failure contrast rather
  than relabelling a capture as a failure.
- The assigned parent's new equal anterior/posterior displacement-phase blend
  preserves both wake views and capture at `18.8485T`, but worsens mean distance
  to `2.10603L`, outside the clean anterior-phase carrier's completed
  `2.09042--2.09898L` band. It changes the route throughout the episode: at
  `4T/8T/12T/16T` its headings are about
  `0.499/0.294/0.359/0.367 rad`, versus
  `0.337/0.513/0.045/0.671 rad` for a clean carrier capture. Its modestly lower
  rate contact (`10.33%/14.30%` versus `11.00%/14.96%`) is not useful relief
  because route integral worsens; posterior displacement is therefore not
  supported as a vote that retimes steering.
- The inherited guidance records two executable-equivalent redistribution
  misses at `0.81206L` and `1.25093L`, followed by downward/left exits despite
  energetic wakes. In contrast, removing that second phase allocation has six
  completed captures with no known miss. Velocity phase prediction,
  observation filtering, posterior-specific gait allocation, rate barriers,
  terminal compounds, and stacked recovery already have completed negative
  evidence and are not reopened.

## Structured bookshelf transfer

The inherited logs explicitly document the prior three-consecutive-iteration
stagnation trigger, so the shelf was re-consulted. The newest posterior-phase
test supplies fresh negative evidence; the shelf is used only to identify the
carrier and steering invariants that should survive it.

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and robotic-fish closed-loop asymmetric-flapping control
source_mechanism: preserve a directed posterior-lagged traveling bend while normalized target geometry applies bounded curvature on an observed useful beat half
transferable_invariant: keep the coordinated propulsive carrier and let target geometry own turn sign while one observed joint-state phase allocates a small positive steering modulation
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body envelopes, duty ratios, exact vortex phases, world coordinates, and task-specific routes
policy_translation: remove the current phase-dependent redistribution of common amplitude relief; retain anterior-displacement half-cycle steering, geometry-owned common relief, non-inverting response release, differential mean curvature, posterior lag, and final acceleration projection; do not let lagged posterior displacement vote on steering phase
falsification: reject if capture or either coherent wake row is lost, the downward near-miss/left-exit topology recurs, mean distance leaves the completed 2.09042--2.09898L clean-carrier band without a distinct benefit, or actuator contact or planar loads materially worsen
```

## Exactly one candidate hypothesis

Materialize the geometry-scheduled anterior-displacement-phase carrier by
removing only the current phase-dependent redistribution of common amplitude
relief. Target geometry continues to own turn sign; correcting yaw may release
but never invert the request; centered anterior displacement supplies the
clock-free useful-half-cycle signal; and the posterior-lagged traveling wave
and exact acceleration projection remain unchanged.

This is one structural ablation from the current prefill, not scalar-only gain
tuning. It also declines the assigned parent's falsified posterior phase vote.
It adds no recovery, terminal, velocity/flow/force residual, posterior-only
allocation, rate barrier, explicit time, step, world coordinate, mutable state,
or memorized phase. Formal CFD occurs after handoff, so no outcome is claimed
for this unevaluated candidate.
