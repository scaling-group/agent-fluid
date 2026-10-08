# Evidence-constrained multi-wake candidate

## Visual and rollout diagnosis before candidate selection

- The assigned parent and all four sampled solvers use policy SHA-256
  `452903db...9781`. Their policy files, trajectories, combined sheets, and
  both view-specific sheets are byte-identical. Each direct-uniform rollout
  has `U_infinity=(0,0,0)`, no cylinders or prewarm, and captures after
  `16.604496T` and 237 moving-window shifts at `0.743958L`, with scored
  distance integral `1.998146L` and score `-0.113729`. These are deterministic
  replicas of one physical trajectory, not four independent control tests.
- I inspected the shared combined sheet from release through capture. The
  top-down row shows self-propelled left/down progress on a shallow target-
  crossing arc and an alternating red/blue wake connected to the posterior
  body. The oblique row shows compact three-dimensional Lambda2 structures
  connected to the tail and traveled path through capture. Neither view shows
  wake breakup, passive advection, collision, boundary exit, instability, or
  a discontinuity aligned with storage recentering.
- The trace supports the visual reading: distance falls from `12.327720L` to
  the first-crossing threshold, with final velocity
  `(-1.100098,-0.270060)U`. The active beat, `1.132762U` speed, and
  `2.238745 rad/T` recent yaw at the final sample are not a demonstrated hold
  error because this task terminates on first crossing without dwell.
- No distinct failed visual artifact is available; every supplied sheet is
  the same successful trace. The valid informative-failure comparison is
  therefore metric-level and inherited: a closure-qualified yaw-response
  release crossed one integration step earlier but made the crossing
  shallower and regressed distance integral and score to
  `0.744276L/1.998380L/-0.114037`. Carrier-synchronous local-flow subtraction
  likewise regressed to `0.745252L/1.999280L/-0.115121`, while completed
  target-rate, moment, posterior-relief, and projected-corridor variants
  supplied no positive control implication.
- More than three completed inherited iterations selected the same controller
  without a new mechanism or semantic improvement, so the structured
  bookshelf consultation is required. Its traveling-wave, bounded route
  asymmetry, response residual, phase modulation, and terminal-hold families
  are already represented by the incumbent or by completed negative controls.
  The duplicate nominal samples expose no new body-frame response deficit that
  identifies another channel.

## Sole candidate and falsifiable hypothesis

Retain `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-for-byte as the workspace's one candidate. It preserves the evidenced
full traveling-wave carrier, raw target geometry and anterior course center,
mean-preserving yaw and lateral-response demodulation, phase-compatible
posterior steering, smooth acceleration bound, and narrow one-sided joint-
speed guard. No sibling candidate, terminal intervention, storage-window cue,
or scalar-only gain retune is introduced.

This is an evidence-constrained null mechanism translation, not a same-worker
claim of CFD improvement. Formal evaluation should reproduce capture, arrival,
route cost, crossing depth, connected two-view wake, joint feasibility, effort,
force, and moment. Falsify preservation if that nominal envelope does not
reproduce. Reopen one compact bounded primitive only after a completed
nonduplicate or held-out pose, target, inflow, or imposed-wake rollout isolates
a repeatable body-frame propulsion, route, response, feasibility, or load
deficit.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish direction control
source_mechanism: preserve a posterior-lagged rhythmic carrier and recruit separate bounded steering or disturbance feedback only for an observed response deficit
transferable_invariant: productive carrier-correlated motion must be separated from persistent route or disturbance error before changing the carrier
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, fixed schedules, world-frame coordinates, and task-specific routes
policy_translation: null translation; retain the normalized two-joint response-demodulated carrier because every supplied physical payload is the same successful trace and completed terminal or residual additions regress target cost
falsification: test one bounded state-feedback primitive only after nonduplicate evidence isolates its error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All numerical and visual outcomes above belong to completed sampled or
inherited rollouts. The retained candidate receives formal CFD only after this
worker exits. Exact nominal reproduction establishes determinism, not
robustness to a changed pose, target, inflow, or imposed wake, and the absence
of a failed sheet is not treated as an image-level failure comparison.
