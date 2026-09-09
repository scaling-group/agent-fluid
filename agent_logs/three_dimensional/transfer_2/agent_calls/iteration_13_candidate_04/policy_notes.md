# Posterior phase-lag allocation for terminal redirect

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and `capture` termination. They capture in `19.701--19.850T` with
  scores `-0.21598` to `-0.22093`; this batch therefore has no semantic
  failure, and the weakest capture is only a failure-side control comparator.
- Both rows of the combined sheets for the strongest sample
  (`solver_1b6df3d71b19`) and weakest sample (`solver_788c33d018cf`) were read
  from release through termination. The top-down vorticity views show
  self-propelled, alternating wakes and similar bounded terminal hooks; the
  oblique Lambda2 views show compact three-dimensional structures following
  both routes. Neither sheet shows passive advection, collision, domain exit,
  wake collapse, disordered lateral motion, or numerical instability.
  Trajectory metrics agree: peak planar force/yaw-moment coefficients are
  `0.02458/0.01314` and `0.02443/0.01298`, maximum joint angles remain below
  `0.60 rad`, and both joints reach the `4.538 rad/T` rate limit.
- The strongest plain LOS-led half-cycle policy captures at `19.706T`, has
  distance integral `2.10594L`, and scores `-0.21598`. Its anterior-response
  release prefill captures at `19.701T/-0.21675`, while full response release
  gives `19.850T/-0.22093` and a range-aware projected-miss redirect gives
  `19.723T/-0.21601`. These are semantic repeats rather than supported
  improvements. The assigned parent's independent middle-field course
  schedule also captures but regresses to `19.872T/-0.22294`.
- The plain policy's trajectory has large beat-scale course/yaw variation: at
  about `8L`, course error is `-0.659 rad`, recent yaw rate is `2.56 rad/T`,
  and commands are already about `-26.7/29.8 rad/T^2`; starting course
  correction there did not help the assigned parent. Across the full rollout,
  both joints spend roughly `35.3%/32.7%` of samples above 90% of the smooth
  command bound. Another geometric gate or stronger static redirect is thus
  unsupported.

## One-candidate hypothesis

Restore the evaluated plain LOS-led half-cycle scaffold and add one new
two-joint actuator primitive: modulate posterior phase lag only when the
terminal redirect is active. Joint velocity supplies observable beat phase;
the product of signed redirect request and normalized phase is reflection
invariant. On the redirect-aligned half-cycle, a small bounded increase in lag
emphasizes the posterior traveling bend; on the return half-cycle it relaxes
lag by the same bounded rule. Far-field propulsion, target/turn feedback,
distance-and-closing drive relief, mean curvature, LOS lead, and soft command
bounds remain unchanged.

Expected signature: retain capture and both coherent wake views while moving
some terminal correction into posterior wave timing, improving arrival or
distance integral beyond the observed repeat band without increasing joint
rate/command-bound residence or the approximately `0.025/0.013` load class.
Falsify this mechanism if it loses capture, produces a larger terminal hook,
does not beat repeat variation, weakens the traveling wake, or worsens joint,
command, force, or moment margins. If falsified, later workers should not tune
the lag modulation scalar; they should revert to the plain LOS-led scaffold
and test a different observation/actuator primitive only when a specific
trajectory failure supports it.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG turning
source_mechanism: bounded phase-lag or wave-shape modulation that steers through posterior timing without replacing the propulsive rhythm
transferable_invariant: allocate a turn request through observed joint-state phase and posterior wave lag while preserving a lagged traveling bend
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, clock-driven CPG phase, and task-specific routes
policy_translation: multiply the existing posterior lag by a small bounded function of terminal redirect weight times signed redirect-phase alignment, within the normalized body-frame two-joint feedback contract
falsification: reject if capture timing or distance integral does not improve beyond repeat variation, terminal curvature grows, or command, joint-rate, load, and either wake-coherence view regress
