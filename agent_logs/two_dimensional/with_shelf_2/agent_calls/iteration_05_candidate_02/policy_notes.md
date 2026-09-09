# Multi-wake candidate diagnosis

## Evidence read before editing

- The common prewarm sheet shows four fully developed, interacting vortex
  streets between the release pose and the target. The released sheets show
  that propulsion is necessary: useful policies generate a posteriorly
  traveling body wake and move upstream rather than drifting with the inflow.
- The assigned prefill (`solver_b2565fd6bd70`) retains upstream motion
  (`-10.51L`) but its posterior mean-curvature steering forms a broad arc,
  reaches only `2.43L`, and exits the lateral boundary at `84.22`; its visual
  trajectory does not settle onto the target line after entering the wake.
- The distributed, response-damped half-cycle sibling
  (`solver_a84fba8bf04f`) gets much closer (`1.65L`) and travels `-8.32L`
  upstream, but visibly crosses below the target and continues to the lower
  boundary. It has `487.10/4680.10` force-y/moment-z RMS and saturates both
  joint rates.
- The controlled load-gated sibling (`solver_e6805fe0c5bc`) preserves that
  traveling-bend scaffold but attenuates steering as normalized yaw-moment
  magnitude grows. It follows a monotone diagonal through the developed wake
  and reaches the `0.75L` target at `51.47`, with `-11.28L/-4.94L` displacement,
  `1.82L` mean distance, and lower `426.26/4084.50` force-y/moment-z RMS.
  Its remaining risk is substantial load and near-envelope joint motion, so
  the gate must not be interpreted as general load suppression.
- Inherited guidance and optimizer scores agree that scalar tuning around
  anterior/two-joint mean-curvature equilibria destroyed initial propulsion,
  while distributed acceleration asymmetry recovered upstream travel but
  needed observed response/load feedback to stop the lateral escape.

## Candidate hypothesis

Replace posterior mean-curvature steering with the single successful
response-damped, yaw-load-gated half-cycle mechanism. Keep the zero-centered
anterior oscillator and posterior velocity lag as the propulsive scaffold.
Compute the slow route request from normalized body-frame bearing minus a
bounded observed heading response, then smoothly reduce only that steering
residual when absolute normalized yaw moment indicates that the wake/body
system is already turning. Apply the residual as compatible half-cycle
acceleration asymmetry at both joints and retain candidate-owned soft limiting.

Expected result: preserve the sampled successful diagonal topology and target
capture rather than the prefill's wide lateral arc. Falsify the mechanism if
the rollout loses upstream displacement, returns to a lateral exit or misses
the capture radius, or raises force/moment RMS above the ungated sibling; also
do not claim load relief merely from success unless later evidence shows lower
peak and saturation histories.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive swimming in organized wakes
source_mechanism: preserve a propulsive rhythm while using observed response to modulate a bounded steering residual instead of prescribing a route or vortex phase
transferable_invariant: separate slow target-directed turning from fast wake/body yaw response, and reduce added steering when observed yaw load indicates that turning is already being supplied
nontransferable_details: published CPG gains, species-specific kinematics, dimensional beat frequencies, single-cylinder vortex phase, and task-specific trajectories
policy_translation: body-frame bearing minus bounded heading response forms the route request; absolute normalized moment_z_L2 smoothly gates distributed two-joint half-cycle acceleration asymmetry without shifting the propulsive equilibrium
falsification: reject if upstream propulsion degrades, target capture is lost, the same lateral-exit topology returns, or normalized load and saturation evidence is worse than the ungated distributed sibling
