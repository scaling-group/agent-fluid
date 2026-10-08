# Evidence-constrained multi-wake carrier selection

## Pre-edit visual and metric diagnosis

- The four sampled solver examples are one behavioral result, not four policy
  alternatives: their policy, trajectory, and combined-keyframe hashes are
  identical. Each starts from direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, then captures at
  `16.604496T` after 237 moving-window shifts. Each has score `-0.113729`,
  `1.998146L` scored distance integral, and `0.743958L` final/minimum distance.
- I inspected the top-down and oblique rows of the shared combined sheet from
  release through capture. The fish accelerates from rest and travels left and
  down toward the target on a shallow curved route, so the motion is
  self-propelled rather than advection. The top-down vorticity street remains
  alternating and coherent; the oblique Lambda2 structures remain compact,
  three-dimensional, and connected to the posterior body and traveled path.
  Nothing visible or diagnostic indicates collision, domain exit, wake
  breakup, inherited flow, or numerical instability before capture.
- The trace supports the visual interpretation: distance falls from
  `12.327720L` to `0.743958L` in 3019 steps, the final inertial velocity is
  `(-1.10010,-0.27006)U`, the peak joint speed reaches the released
  `4.537856 rad/T` limit, peak requested acceleration is `31.4091 rad/T^2`,
  and peak yaw moment is `0.018356`. Thus the connected wake accompanies
  productive closure, but capture is not an effort or held-out robustness
  result.
- No informative failure sheet is available in this workspace: all sampled
  and inherited combined sheets have the same hash. I therefore do not invent
  a visual failure comparison. The assigned-parent guidance and inherited
  optimizer notes supply completed negative controls. Closure-qualified yaw
  release kept the wake class and arrived one `0.0055T` step earlier but
  regressed crossing/integral/score to
  `0.744276L/1.998380L/-0.114037`; carrier-synchronous local-flow subtraction
  kept arrival and wake class but regressed them to
  `0.745252L/1.999280L/-0.115121` without a feasibility or load benefit.
  Line-of-sight-rate, bearing, moment, half-cycle, and projected-corridor
  descendants also failed to improve the demonstrated capture.
- The inherited sequence contains at least four consecutive completed
  selections with no new mechanism, semantic improvement, or useful
  trajectory class. This activates the structured bookshelf review. Its
  traveling-wave, route/asymmetry, disturbance-residual, and approach-hold
  primitives either describe mechanisms already in the incumbent, mechanisms
  already falsified by completed descendants, or mechanisms for a disturbance
  absent from the supplied nominal evidence.

## Policy hypothesis and sole candidate

Keep `solver/cases/dogfish_3d_shape_policy/candidate_target_policy.jl`
byte-identical to the sampled response-demodulated carrier as this workspace's
one candidate. It retains the evidenced full traveling wave, raw body-frame
target geometry, mean-preserving yaw and lateral-response demodulation,
posterior route/crossflow feedback, phase-compatible half-cycle steering,
smooth acceleration bound, and one-sided final-one-percent speed guard.

This is a null mechanism translation, not a same-worker claim of improvement.
The next nominal evaluation should reproduce capture, the connected wake in
both views, `16.604496T` arrival, `1.998146L` scored distance integral,
`0.743958L` crossing, and the sampled joint/action/load envelope. Falsify this
selection if replication loses capture or materially changes any of those
quantities. Reopen architecture work only when a completed held-out pose,
target, or flow, or a meaningfully different failed trajectory, isolates a
specific response deficit for one bounded primitive.

bookshelf_consulted: true
source_domain: traveling-wave fish propulsion, closed-loop robotic-fish CPG direction tracking, wake-interaction control, and terminal capture control
source_mechanism: preserve a productive rhythmic carrier and recruit a separate bounded route, disturbance, or terminal channel only for an observed response deficit
transferable_invariant: an architecture review may reject all new primitives when the evidenced carrier captures and completed perturbations preserve wake class but worsen route cost without improving feasibility or loads
nontransferable_details: published gains, dimensional beat frequencies and speeds, species or robot kinematics, exact vortex phase, capture thresholds, and task-specific routes
policy_translation: retain the normalized body-frame two-joint carrier exactly; do not force another terminal, target-rate, moment, local-flow, or scalar channel into the nominal capture
falsification: reject preservation if nominal capture or connected-wake replication fails, or if held-out evidence isolates a repeatable deficit that one compact state-feedback primitive corrects without degrading approach, feasibility, loads, or score

## Evidence boundary

Favorable values above belong to completed sampled rollouts, and negative
controls belong to completed inherited logs. The current candidate will be
evaluated only after this worker exits. Exact nominal replication can establish
determinism, but not robustness to another pose, target, or imposed flow.
