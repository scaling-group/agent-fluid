# Candidate hypothesis: carrier-dephased yaw feedback

## Evidence read before editing

- All four sampled solver examples use the same policy bytes and the same
  combined keyframe sheet.  Each is a direct `uniform_direct` still-water run
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, and each captures at
  `26.4110T` and `0.7496068L` with score `-0.7105018`.  The duplicated samples
  therefore establish deterministic replay, not four independent mechanisms;
  there is no sampled failure image to compare in this generation.
- In the top-down row the fish is self-propelled, not advected: it lays down a
  coherent alternating red/blue wake from release through a broad S-shaped
  turn and capture.  The oblique Lambda2 row confirms compact alternating
  three-dimensional vortices remain attached to the traveling body/caudal
  wave while the moving window follows the fish.  Local flow magnitude stays
  near `0.017--0.019U` late in the run while body speed is about `0.64U`, which
  agrees that the motion is carrier-driven rather than background advection.
- The useful early/middle behavior is strong closing with an intact wake; the
  informative weakness is the beat-scale yaw and action clipping during the
  late approach.  Inside `2.1L`, mean speed remains `0.642U`, but mean absolute
  target bearing is `0.222rad`, mean absolute yaw rate is `1.242rad/T`, and at
  least one raw acceleration exceeds `1800deg/T^2` on `93.7%` of samples
  (`82.5%` over the whole episode).  At sampled distances `1.5L`, `1.0L`, and
  `0.75L`, yaw rate alternates `-1.23`, `-2.05`, and `+1.76rad/T`; capture is
  achieved without a quiet terminal alignment.
- A centered least-squares diagnostic on the full sampled trajectory gives
  `yaw_rate = 0.009 - 0.545*phi_dot1 - 0.220*phi_dot2`; the independently
  restricted `distance<2.1L` fit is `0.064 - 0.559*phi_dot1 - 0.214*phi_dot2`.
  The stable coefficients across regimes support treating most instantaneous
  yaw as a carrier-synchronous component.  This also sharpens the inherited
  lesson that beat yaw must not be mistaken for redirect completion.
- The inherited negative evidence says terminal amplitude/cadence relief lost
  capture at `1.2329L` and `1.3896L`.  This candidate therefore leaves carrier
  amplitude, cadence, posterior lag, and geometric completion gating intact.

## Policy hypothesis

Estimate carrier-induced yaw from the two observed joint velocities and
subtract it from measured yaw before the rate-feedback, redirect-response,
recovery, and centerline-braking paths.  Target geometry continues to set the
route turn, while the rate loop reacts to the residual macroscopic yaw rather
than fighting each propulsive half-cycle.  The edit should preserve the
coherent wake and capture topology while reducing alternating steering load
and the early S-turn.  Reject it if capture is lost, arrival is later, the
distance topology is unchanged with comparable clipping, or the carrier wake
loses its posterior traveling structure.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction control
source_mechanism: separate the slow direction-tracking request from fast rhythmic yaw before applying feedback
transferable_invariant: feedback should act on route-scale yaw residual after accounting for observable carrier phase, rather than canceling every lateral oscillation
nontransferable_details: published CPG gains, oscillator phases, species kinematics, exact vortex timing, and task-specific routes
policy_translation: estimate beat yaw from normalized two-joint velocity state and use the residual with body-frame target geometry in the existing bounded two-joint feedback paths
falsification: reject if fixed-evaluator capture is lost, arrival or distance integral worsens, clipping remains comparable, or wake coherence and posterior lag collapse
