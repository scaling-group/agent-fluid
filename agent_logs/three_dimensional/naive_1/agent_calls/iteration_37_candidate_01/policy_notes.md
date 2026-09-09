# Step 37 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  execute the prefilled common-envelope redistribution policy and capture at
  `18.7165--18.8815T` with score-defined mean distance
  `2.08855--2.09266L`. The distinct clean anterior-displacement-phase policy
  captures at `18.6010T` and `2.09042L`.
- I inspected every sampled combined keyframe sheet and the assigned parent's
  post-handoff clean-policy sheet from release through capture. Each top-down
  row begins in quiescent fluid, develops a coherent alternating street, and
  bends toward the target. Each oblique row retains compact bilateral and
  caudal Lambda2 structures through first crossing. Translation is therefore
  self-propelled rather than background advection; no sheet shows collision,
  wake collapse, domain exit, or numerical instability. This batch has no
  failure-class sheet, so inherited completed near-miss/left-exit evidence is
  the semantic failure boundary rather than relabelling a capture.
- Sampled trajectory metrics corroborate the visible equivalence: acceleration
  contact spans about `60.85--61.00%`/`72.95--73.27%`, rate contact
  `10.94--11.20%`/`14.91--15.10%`, peak planar force
  `0.03065--0.03259`, and peak yaw moment `0.01600--0.01656`.
  Redistribution is not actuator relief. Its two inherited
  executable-equivalent misses remain a semantic robustness concern even
  though all three current samples capture.
- The assigned parent's newly completed clean ablation adds a seventh known
  capture but broadens its repeatability boundary: `19.0795T` and mean
  distance `2.10426L`, outside the previously stated
  `18.6010--18.9585T`/`2.09042--2.09898L` band. Its coherent two-view wake,
  `60.97%`/`73.13%` acceleration contact, `11.07%`/`14.70%` rate contact,
  `0.03106` peak planar force, and `0.01616` peak moment show route variation,
  not propulsion failure or demand relief. Thus neither clean steering nor
  redistribution has established performance dominance; the clean controller
  has the stronger completed capture record.
- Inherited optimizer notes close velocity phase prediction, posterior-state
  phase voting, observation filtering, posterior-only gait allocation, rate
  barriers, terminal compounds, and stacked recovery. The candidate therefore
  separates steering phase from propulsion-envelope phase instead of reopening
  those mechanisms.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and closed-loop robotic-fish asymmetric-flapping control
source_mechanism: preserve a directed posterior-lagged traveling bend while target geometry adds bounded mean and observed-half-cycle curvature
transferable_invariant: keep the coordinated propulsive carrier distinct from target-signed steering so an observed joint phase can allocate curvature without retiming carrier amplitude
nontransferable_details: published gains, dimensional cadence, species or robot kinematics and envelopes, duty ratios, exact vortex phases, world coordinates, and task-specific routes
policy_translation: remove phase-dependent redistribution of the common amplitude relief; retain body-lateral route sign, non-inverting correcting-yaw release, anterior-displacement half-cycle steering, common geometry-owned relief, posterior lag, and final acceleration projection
falsification: reject if capture or either coherent wake row is lost, the inherited downward near-miss/left-exit topology recurs, or arrival, distance integral, actuator contact, or planar loads leave completed clean-policy spread without a compensating semantic benefit

## Exactly one candidate hypothesis

Materialize one clean geometry-scheduled policy by removing only the prefill's
phase-dependent redistribution of common amplitude relief. Target geometry
continues to own turn sign, correcting yaw may release but never invert the
request, centered anterior displacement supplies the clock-free useful-beat
signal, and the posterior-lagged traveling wave remains unchanged.

This is a structural separation of propulsion and steering, not scalar-only
gain tuning. It adds no recovery, terminal schedule, velocity/flow/force
residual, posterior phase vote, rate barrier, explicit time, step, world
coordinate, mutable state, or memorized route. Formal CFD occurs after handoff,
so no outcome is claimed for this unevaluated candidate.
