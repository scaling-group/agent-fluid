# Projected-miss anterior-release candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable finite
  moving-window transport, and `capture` termination. They capture in
  `19.360--19.552T`, with mean distance `2.08911--2.09458L` and scores
  `-0.19989-- -0.20560`. The useful capture scaffold must therefore be
  preserved; this iteration is testing terminal allocation rather than a
  missing-success capability.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows for the
  strongest scalar sample (`solver_1af6c62469a7`) and the weaker current sample
  (`solver_cb03d3cda781`) from release through capture. Both fish visibly
  self-propel from quiescent water, shed coherent alternating compact
  three-dimensional wake structures, follow a direct approach, and finish
  with the same late hook into the target. Neither is passively advected and
  neither shows collision, wake collapse, domain exit, or instability. The
  weaker rollout is therefore an informative within-class comparator, not a
  semantic failure.
- Trace diagnostics agree with the visual class. The best response-gated
  posterior-curvature sample captures at `19.360T`, mean distance `2.08911L`,
  and head path `12.052L`; the clean posterior-lag sample reaches
  `19.409T/2.09210L/12.095L`. Both joints touch the `4.538 rad/T` rate limit,
  while their peak planar force/yaw-moment coefficients remain about
  `0.023/0.013`. The apparent `0.049T` lead is below the inherited exact-policy
  spread, and the direct posterior bend raises anterior mean command from
  `19.03` to `19.25 rad/T^2`, so it does not justify retaining or tuning that
  posterior gate.
- The sampled posterior-amplitude variant stays in the same two-view class but
  lengthens head path to `12.549L`, increases posterior excursion to
  `0.608 rad`, and raises peak yaw moment to `0.01343`, without a
  repeat-resolved arrival benefit. The assigned parent's posterior
  damping-asymmetry rollout is a stronger negative: despite retaining capture,
  it slows to `20.647T`, raises mean distance to `2.16229L`, and drops score to
  `-0.27030`. These completed results argue against another posterior
  amplitude, lag, damping, or curvature allocation on this release.
- In the clean posterior-lag trace, instantaneous projected closest-approach
  miss falls from a mean `0.986L` at `2--6L` range to `0.117L` at `1--2L`.
  The owned `0.50L` transition lies between those observed regimes while the
  current head command is already entering terminal relief. The
  inherited guidance separately reports that full response release and
  anterior-only response release did not improve beyond variation, whereas a
  bounded projected-miss observation retained the strongest trajectory/load
  class. This supports changing the release observation, not increasing a
  steering scalar or interrupting posterior LOS-led curvature.

## One-candidate hypothesis

Restore the clean joint-phase posterior-lag scaffold: retain its state-feedback
carrier, fore/aft-aware body-frame target vector, distance/positive-closing
drive relief, velocity-course redirect, LOS-rate lead, bounded mean curvature,
anterior half-cycle steering, posterior lag allocation, and smooth action
limit. Add exactly one mechanism: compute instantaneous future-course
closest-approach miss from the body-frame target vector and measured body-frame
velocity, normalize it by an owned body-length scale, and use that
bounded geometry only to release the extra anterior redirect bias as the
predicted miss becomes small. Keep the base approach bias and posterior
LOS-led redirect continuous.

This is a transient redirect/release architecture rather than scalar-only gain
tuning. It uses no time, route memory, world coordinate, target identity, or
vortex phase. Expected signature: preserve capture and the coherent two-view
wake while shortening or softening the late hook, or improve arrival/distance
integral beyond repeat variation without worse command residence, joint
margin, head path, or the approximately `0.023/0.013` load class. Falsify if
capture is lost; the predicted-miss gate releases steering too early; the
terminal hook, integral, or path grows; posterior coherence or propulsion
weakens; or effort, rate residence, joint margin, force, or moment regresses.
The new CFD outcome is not claimed here; it becomes evidence only after this
worker exits.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish direction tracking
source_mechanism: apply strong bounded curvature for a redirect, then release transient anterior authority continuously when observed geometry indicates that the new course is sufficient
transferable_invariant: preserve the propulsive traveling wave while an observed body-frame interception residual, rather than elapsed time, releases only transient steering authority
nontransferable_details: species-specific C-start kinematics, published gains and timing, dimensional cadence, full-body waveforms, exact vortex phase, and task-specific routes or coordinates
policy_translation: derive normalized future-ray closest-approach miss from `target_body_L` and `velocity_body_U`, falling back to current range when the target projects behind; gate only the extra anterior LOS redirect bias while leaving base target steering and posterior LOS curvature continuous under the two-joint soft action bound
falsification: reject if capture, timing, distance integral, terminal topology, path, wake coherence, command or rate headroom, joint margin, force, or moment regresses beyond completed-rollout variation
