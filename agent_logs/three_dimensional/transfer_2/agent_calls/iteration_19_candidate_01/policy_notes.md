# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled evaluations are valid direct-uniform, quiescent-water runs
  (`U_infinity=0`) and terminate in capture. The strongest finite score is the
  response-gated posterior-curvature sample at `19.360T`, mean distance
  `2.08911L`, and score `-0.19989`; the prefilled posterior-authority stack
  captures at `19.431T`, `2.09458L`, and `-0.20560`.
- The top-down and oblique rows for those two samples show the same control
  class: self-propulsion from a coherent alternating 3D vortex street, a
  largely direct approach, and a late hook into the capture circle. There is
  no visible advection artifact, wake collapse, collision, or new terminal
  topology in the prefill.
- Trajectory cross-checks agree with the images. Relative to the clean
  posterior-lag sample, the prefill is slightly slower (`19.431T` versus
  `19.409T`) and uses more mean command (`19.18/17.83` versus
  `19.03/17.72 rad/T^2`) and posterior 90%-smooth-bound residence (`34.16%`
  versus `33.83%`). The direct-curvature sample's apparent lead is only
  `0.049T` over the fastest exact clean repeat and remains inside the inherited
  exact-policy timing spread, while its anterior command burden rises.
- The higher-Elo sampled guidance reports that a relative-crossflow tail
  residual regressed to `19.894T/2.11284L/-0.22287` and increased sub-`2L`
  yaw and path inefficiency; a projected-miss/intercept controller merely
  straddled its simpler LOS base on repeat. Those observations rule out using
  the repeated late hook as evidence for another slip or intercept scalar.
  No inherited optimizer note files are present in this workspace beyond the
  durable guidance examples.

## Candidate hypothesis

Materialize the clean posterior-lag controller represented by the strongest
exact clean repeat. Preserve the corrected body-frame target sign,
distance/closing drive relief, continuous velocity-course/LOS redirect, and
joint-state half-cycle steering, but remove the prefill's response-gated mean
tail curvature and drive-relief posterior carrier multiplier. This is a
controlled negative-result response: it should retain capture and the coherent
traveling wake while recovering posterior command headroom and avoiding the
small timing/integral regression caused by stacking two non-repeat-resolved
mechanisms. Falsify the choice if the next evaluation loses capture or falls
outside the clean repeat envelope without a compensating improvement in path,
loads, joint margin, command residence, or wake topology.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish turning
source_mechanism: posterior-lag traveling bend with bounded joint-state-derived half-cycle steering
transferable_invariant: preserve a directional anterior-to-posterior bend and use observed joint phase for bounded useful/return-stroke asymmetry
nontransferable_details: published gains, species kinematics, dimensional beat rates, exact vortex phase, and task-specific routes
policy_translation: retain the normalized body-frame LOS/course scaffold and clean posterior lag while removing unsupported stacked carrier and mean-curvature interventions
falsification: reject if capture, distance integral, actuator headroom, joint margin, load envelope, or two-view wake coherence leaves the established clean-repeat class
