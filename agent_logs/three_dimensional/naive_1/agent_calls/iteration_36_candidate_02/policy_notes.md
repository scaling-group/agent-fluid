# Step 36 multi-wake target-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three
  execute the prefilled common-envelope redistribution policy byte-for-byte
  and capture at `18.6505--18.8815T`, with score-defined mean distance
  `2.08855--2.09222L`. The fourth adds a rearward-only route multiplier,
  captures at `18.9640T` and `2.09072L`, and does not establish recovery
  because inherited reconstruction keeps the target forward.
- I inspected the combined keyframe sheets for the best-integral sampled
  redistribution capture, the fastest sampled capture, the rearward variant,
  and the inherited clean and two-joint-phase captures. Their top-down rows
  begin in quiescent water and develop coherent alternating vortex streets
  along smooth target-bending paths. Their oblique rows retain compact
  bilateral and caudal Lambda2 structures through first crossing. With zero
  background flow, translation is self-propelled and the lateral beat remains
  productive; none shows collision, wake collapse, domain exit, or numerical
  instability. The sampled and inherited sheets available in this workspace
  are all capture class, so the assigned-parent records of executable-
  equivalent downward near misses provide the failure boundary rather than
  relabelling a successful visual as a failure.
- The assigned-parent guidance reports that the same redistribution executable
  has also missed at `0.81206L` and `1.25093L`, then bent downward and exited
  left despite energetic wakes. By contrast, six completed clean-envelope
  rollouts capture at `18.6010--18.9585T` with mean distance
  `2.09042--2.09898L`. This supports separating target-signed half-cycle
  curvature from phase-dependent modulation of the propulsive envelope, even
  though redistribution has the better best-case distance integral.
- The latest inherited architectural test replaces anterior displacement phase
  with an equal blend of centered anterior and sign-adjusted posterior
  displacement. It preserves both coherent wake views and captures at
  `18.8485T`, but mean distance worsens to `2.10603L`, outside both the clean
  and sampled redistribution bands. Its slightly lower rate contact
  (`10.39%/14.30%`) and posterior acceleration contact (`72.05%`) do not
  compensate for the route-integral loss. Posterior state therefore remains
  useful as the lagged thrust joint, not as an equal steering-phase authority.
- Existing negative evidence closes pointwise rate barriers, direct velocity
  residuals, target-axis observation filtering, posterior-specific gait
  allocation, terminal compounds, and stacked recovery/arbitration. Adding
  one of those channels would not be an evidence-led transfer.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and robotic-fish closed-loop asymmetric-flapping control
source_mechanism: preserve a posterior-lagged traveling bend while normalized target geometry applies bounded curvature on an observed useful beat half
transferable_invariant: keep the coordinated carrier and let body-frame target geometry own turn sign while anterior joint displacement provides a clock-free steering phase
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body waveforms, exact vortex phases, world coordinates, and task-specific routes
policy_translation: retain bounded body-lateral route feedback, non-inverting correcting-yaw release, anterior-displacement half-cycle curvature, common geometry-owned mean amplitude relief, posterior lag, and final acceleration projection; remove phase-dependent drive-envelope redistribution and do not give posterior displacement equal steering-phase authority
falsification: reject if capture or either coherent wake row is lost, the downward near-miss/left-exit topology recurs, mean distance leaves the completed clean `2.09042--2.09898L` class without a distinct benefit, or limit contact and planar loads materially worsen

## Exactly one candidate hypothesis

The prefill stacks two beat-phase allocations: a supported positive scale on
target-signed differential curvature and a second phase-dependent
redistribution of the common drive-envelope relief. The candidate removes only
the second allocation. Target geometry continues to own route sign,
correcting yaw may release but never invert steering, anterior displacement
remains the evidenced clock-free phase signal, and the common mean relief,
posterior-lagged traveling wave, and exact acceleration projection are
unchanged.

Expected result: retain capture and both coherent wake views in the completed
clean-envelope class while avoiding the redistribution architecture's known
semantic misses. This is a structural ablation, not scalar-only gain tuning.
It adds no clock, velocity/flow residual, terminal or recovery branch, world
coordinate, mutable state, or memorized route. Formal CFD occurs after
handoff, so no result is claimed for this unevaluated candidate.
