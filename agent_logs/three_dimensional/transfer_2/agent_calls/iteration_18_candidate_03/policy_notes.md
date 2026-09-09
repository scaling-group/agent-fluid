# Posterior rate-governed response-curvature candidate

## Visual and diagnostic evidence before the edit

- All four sampled rollouts are valid direct, uniform, quiescent releases:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics, and
  `capture` termination. They capture in `19.360--19.552T`, with distance
  integrals `2.08911--2.09458L` and scores `-0.19989-- -0.20560`. The task no
  longer lacks a successful targeting architecture; this candidate must retain
  the body-frame target, closing-aware drive relief, and course redirect.
- I inspected both rows of every combined keyframe sheet, using the strongest
  response-gated-curvature sample (`solver_1af6c62469a7`) and the assigned
  prefill/weakest scalar sample (`solver_cb03d3cda781`) as the main comparison.
  From release through capture, both top-down rows show the fish translating
  under its own undulation from still water, turning toward the target, and
  leaving an alternating posterior vortex street. The oblique rows show compact
  three-dimensional Lambda2 structures convecting behind the body. Neither
  sample shows passive advection, wake breakup, wasteful wandering, collision,
  domain exit, or numerical instability. Both finish with the same bounded
  hook and elongated paired shear layers as approach relief reduces the beat.
- The scalar and trace evidence agrees that this is a within-class control
  difference. The matched response-curvature scaffold captured at `19.360T`,
  distance integral `2.08911L`, score `-0.19989`, and sub-`2L` mean absolute
  yaw about `0.285 rad/T`. Adding only the prefill's `0.12` approach multiplier
  to retain posterior carrier/lag authority preserved the wake and capture but
  moved to `19.431T`, `2.09458L`, and `-0.20560`. That change does not clear the
  inherited exact-policy timing/integral variation in the favorable direction,
  so there is no support for retaining or tuning the multiplier.
- The actuator boundary is more consistent than the small score differences.
  Inherited diagnostics report that every sampled policy reaches the
  `260 deg/T` ceiling on both joints; posterior rate spends about `21.8--22.1%`
  of samples above 80% of that ceiling, while only about `9.7--10.3%` of
  posterior accelerations continue to push into that band. Peak planar force
  and yaw-moment coefficients remain near `0.023/0.0135`, and both keyframe
  views remain coherent. The actionable residual is localized same-direction
  effort at a rate-limited posterior joint, not missing tail authority.
- Assigned-parent guidance and inherited logs rule out more terminal-gate,
  slip-residual, projected-corridor, and previous-command feasibility tuning on
  this release. The inherited rate-governor proposal is compatible with the
  current evidence because it uses measured joint state and preserves braking;
  it has not yet been validated by a sampled CFD result.

## One-candidate policy hypothesis

Restore the strongest sampled response-gated posterior-curvature scaffold by
removing only the unsupported approach carrier multiplier. Add one actuator
mechanism: normalize measured posterior joint rate by the known rate envelope,
and, above the evidenced 80% band, smoothly attenuate only posterior
acceleration whose sign would push the joint farther toward saturation.
Opposite-sign braking, mean lag, propulsive carrier, anterior steering,
body-frame target geometry, closing relief, and the terminal redirect remain
unchanged. This is a bounded state-feedback rate governor, not a new steering
gain, clock, command-history loop, or memorized route.

The mechanism is supported only if formal evaluation preserves capture and the
coherent two-view wake while materially reducing posterior near-limit command
or rate residence at comparable or better timing and distance integral. Reject
it if the tail wave weakens, capture is lost, arrival/integral regresses beyond
repeat variation, braking is delayed, joint-angle margin or the late hook
worsens, or force/moment coefficients leave the sampled envelope.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish central-pattern-generator control
source_mechanism: sensor feedback modulates a low-dimensional rhythmic actuator command without replacing its traveling-wave scaffold
transferable_invariant: use normalized measured actuator state to remove locally infeasible same-direction effort while preserving the opposite-sign braking response and the target-directed rhythm
nontransferable_details: published gains, robot hardware limits, clock phases, species-specific kinematics, dimensional cadence, exact vortex phases, and task routes
policy_translation: gate only posterior acceleration that shares the sign of posterior joint rate once normalized rate enters the evidenced near-limit band; retain body-frame target feedback and the two-joint state-feedback contract
falsification: reject if posterior command or rate headroom is not materially better at preserved capture, timing, distance integral, joint margin, loads, braking, and wake coherence
