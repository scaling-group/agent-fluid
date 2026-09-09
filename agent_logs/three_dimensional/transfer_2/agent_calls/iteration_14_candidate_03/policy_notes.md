# Evidence-led intercept-corridor replication candidate

## Visual diagnosis before the policy edit

- All four sampled episodes satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, no prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
  They reach the `0.75L` boundary in `19.701--19.723T`, so the weakest sample
  is only an informative control underperformer rather than a semantic failure.
- Both rows of the combined keyframe sheets for the highest-scoring sample
  (`solver_12a0e2e3745e`) and lowest-scoring sample
  (`solver_86d4118b6d89`) were inspected from release through termination.
  Their top-down rows show self-propelled motion with a coherent alternating
  wake and a bounded late target arc, not background advection or wasteful
  lateral wandering. Their oblique rows retain compact three-dimensional
  Lambda2 structures along the track with no collision, wake collapse, or
  numerical instability. The two paths are visually close; scalar and trace
  diagnostics are needed to discriminate them.
- The sampled comparison isolates the useful composition. The prefilled plain
  LOS-led half-cycle controller captures at `19.706T`, mean distance
  `2.10594L`, and score `-0.21598`. Projected-miss geometry alone captures at
  `19.723T/2.10565L/-0.21601`, and anterior release triggered by yaw response
  captures at `19.701T/2.10634L/-0.21675`; neither establishes an improvement.
  Combining range-aware projected miss with a smooth intercept corridor that
  releases only anterior redirect captures at `19.701T`, lowers mean distance
  to `2.10438L`, and gives the batch-best score `-0.21449`.
- The combined sample also stays inside the established physical class: peak
  planar force and yaw-moment coefficients are `0.02297/0.01285`, joint angles
  stay below `0.583 rad`, and maximum smooth commands remain below `30.73
  rad/T^2`. Its cost is higher mean absolute commands (`18.53/17.32` versus
  the parent's `18.20/17.02 rad/T^2`), and it still arrives with positive yaw
  rate (`0.482 rad/T`). Those are falsification boundaries, not evidence for
  adding another unevaluated terminal gate.
- Inherited logs show that identical-policy repeats can move from
  `19.706T/-0.21598` to `19.888T/-0.22270`, while full yaw-response release,
  phase-scaling posterior redirect, LOS-coherence gating, carrier-relief/course
  coupling, and an independent `8L--2L` course window all failed to beat that
  repeat band. The current positive result is therefore promising but needs a
  controlled replication before it should be treated as portable.

## One-candidate hypothesis

Replace the prefill with the sampled range-aware intercept-corridor controller
unchanged. It preserves the state-feedback carrier, posterior lag,
fore/aft-aware normalized body-frame target vector, distance/closing drive
relief, route half-cycle steering, LOS-rate lead, continuous posterior
redirect, and smooth command bounds. Its one combined mechanism blends course
angle with projected miss and releases only transient anterior redirect after
the observed velocity course enters a body-length-normalized target corridor.

Expected signature: reproduce capture with the same coherent top-down and
oblique wake class, retain the approximately `0.023/0.013` force/moment class
and joint margin, and confirm an arrival or distance-integral improvement
beyond the inherited repeat band without further increasing mean command or
near-bound residence. Falsify the mechanism if the repeat falls back into the
plain-controller band, loses capture, restores the sharper terminal hook,
causes premature coasting or chatter, or worsens command headroom, joint
margin, loads, or either wake view. A failed replication should send later
workers back to the plain LOS-led scaffold or to a genuinely new observed
failure mechanism, not to scalar corridor tuning.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish direction tracking
source_mechanism: release transient anterior C-start-like curvature after observed intercept acquisition while retaining posterior rhythmic propulsion
transferable_invariant: extra anterior turning authority can relax once target-relative velocity geometry indicates a viable intercept, while posterior wave support remains continuous
nontransferable_details: species kinematics, published gains, dimensional burst timing, exact capture radius, clock phase, vortex phase, and task-specific coordinates or route
policy_translation: blend bounded body-frame course error with normalized projected miss, gate only anterior redirect through a smooth intercept corridor, and preserve the posterior two-joint traveling-wave contribution
falsification: reject if replication loses capture or does not beat repeat variation, or if terminal topology, wake coherence, force and moment class, joint margin, command effort, or near-bound residence regress
