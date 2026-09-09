# Posterior damping-asymmetry candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
  The two byte-identical joint-phase posterior-lag samples capture at
  `19.409T/2.09210L/-0.20288` and `19.508T/2.09701L/-0.20789`; inherited logs
  extend the exact-policy spread to `19.635T/2.10246L/-0.21272`. Any new
  timing or scalar change inside that span is not repeat-resolved evidence.
- I inspected the complete top-down vorticity and oblique body/Lambda2 rows
  for all four samples, including the strongest finite direct-curvature sample
  (`solver_1af6c62469a7`) and the slowest current exact-lag repeat
  (`solver_1fb0a88ab950`). Each fish self-propels from quiescent water, forms a
  coherent alternating posterior wake with compact three-dimensional
  structures, approaches monotonically, and makes essentially the same late
  hook into capture. None is passively advected and none shows collision,
  wake collapse, domain exit, or numerical instability. The weaker repeat is
  therefore an informative within-class failure, not a semantic failure.
- The assigned parent's response-gated posterior curvature preserves that
  class at `19.360T`, mean distance `2.08911L`, and score `-0.19989`. Its
  apparent arrival lead over the fastest exact-lag sample is only `0.049T`,
  far below the `0.226T` exact-policy spread; it also raises anterior mean
  command and 90%-bound residence to `19.25 rad/T^2` and `37.07%`. The same
  terminal hook remains visible, so the direct gate is not a repeat-resolved
  new response mechanism.
- The prefilled phase-conditioned posterior-amplitude sample likewise retains
  capture at `19.552T`, mean distance `2.09001L`, and score `-0.20065`, but
  its top-down terminal hook is not shortened. Relative to the exact-lag
  samples, head path grows to `12.549L`, posterior excursion to `0.608 rad`,
  and peak planar force/yaw moment to `0.02535/0.01343`, despite lower anterior
  mean command. That mixed result does not support tuning the amplitude scalar.
- Across the current samples, joint angles remain below the `0.785 rad` hard
  limit, but both joint rates touch `4.538 rad/T` and smooth-command residence
  remains about `35.1--37.1%` anterior and `33.3--34.2%` posterior. The clean
  next test should preserve the established carrier and route scaffold while
  changing how posterior tracking effort is distributed across the two
  steering half-cycles, rather than requesting more displacement or curvature.

## One-candidate hypothesis

Restore constant posterior carrier amplitude and base phase lag while
preserving the captured oscillator, fore/aft-aware body-frame target vector,
distance/positive-closing drive relief, velocity-course redirect, LOS-rate
lead, anterior joint-phase steering, bounded mean curvature, and smooth action
limit. Add one actuator mechanism only: infer posterior stroke side from
normalized posterior-joint velocity, then reduce posterior tracking damping
slightly while that stroke aligns with the body-frame turn request and
increase it symmetrically on the return stroke. This is a bounded duty-ratio
translation; it changes neither the target bend nor its mean lag and uses no
clock, route memory, world coordinate, or vortex phase.

Expected signature: retain capture and both coherent wake views while reducing
posterior mean command or rate-limit residence, or improve arrival/distance
integral outside the exact-lag repeat envelope without increasing path length,
joint excursion, anterior effort, or the approximately `0.025/0.013`
force/moment class. Falsify if capture or wake coherence is lost; the same hook
persists without actuator benefit; timing/integral stays within repeat
variation; or command/rate residence, joint margin, path, force, or moment
regresses. The new CFD result is intentionally not claimed here; it becomes
evidence only after this worker exits.

bookshelf_consulted: true
source_domain: robotic-fish CPG duty-ratio turning and two-joint traveling-wave swimming
source_mechanism: asymmetric flapping redistributes actuation between useful and return strokes while retaining a rhythmic carrier
transferable_invariant: use observed joint phase and target-derived turn demand to allocate bounded posterior tracking dissipation asymmetrically without changing mean bend or base lag
nontransferable_details: published duty ratios and gains, dimensional cadence, species-specific envelopes, exact gait or vortex phase, full-body waveforms, and task-specific routes or coordinates
policy_translation: modulate the owned posterior damping symmetrically about its base value using the bounded product of normalized posterior-joint velocity and the equivariant body-frame turn request under the existing two-joint soft action bound
falsification: reject if capture timing or distance integral does not clear exact-policy variation without a posterior effort or rate-residence benefit, or if path topology, wake coherence, joint margin, anterior effort, force, or moment regresses
