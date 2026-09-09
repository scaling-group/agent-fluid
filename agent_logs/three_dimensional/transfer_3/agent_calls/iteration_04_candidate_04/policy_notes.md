# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All sampled and inherited rollouts report direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  translations and wakes are self-generated rather than imposed advection.
- The assigned parent `solver_a8731015fd6e` retains a posterior-lagged
  traveling bend, but both visual rows show it curling upward rather than
  establishing a target route. Its body-frame LOS error falls from about
  `+0.155 rad` to zero near `3T`, yet heading continues from `0.506 rad` to
  `-0.412 rad` by `8T`; it exits the upper boundary at `9.11T`, after improving
  only to `11.878L`. The compact alternating top-down street and oblique
  Lambda2 structures establish self-propulsion, but the steering response is
  not released soon enough.
- The sampled response-lead edit `solver_d94c4664e94e` adds a bounded
  `bearing_window_rate` term directly to LOS error. It preserves nearly the
  same wake and failure topology, but crosses through alignment sooner, reaches
  only `12.030L`, and exits upward at `8.72T`. Thus the short-window trend is
  not supported as an additive predicted angle: it can reverse the requested
  steering before the geometric LOS actually changes side without arresting
  the hydrodynamic turn.
- The stronger mean-curvature sample `solver_97bc3c03d55b` sheds a sustained,
  coherent street and translates faster, but the yaw-rate loop saturates its
  bend request over beat-scale yaw oscillations. It follows the same upper-exit
  topology at `11.13T` with a `9.175L` closest approach. The inherited
  response-led half-cycle candidate `solver_3449e72838d2` also exits upward at
  `8.62T` with a weak wake and only `12.191L` closest approach, so neither an
  additive trend lead nor a weaker asymmetric carrier has produced semantic
  improvement.
- The best useful trajectory remains `solver_19f251537923`. Its dense
  top-down vortex street and compact alternating oblique tubes accompany
  sustained translation to `6.138L` at `16.51T`, after which growing bearing
  carries it below the target and out the lower boundary at `26.15T`. That
  progress is not a clean carrier template: raw anterior/posterior actions
  exceed `1800 deg/T^2` in `3346/4754` and `3655/4754` samples. Copying its
  dense rate/recovery stack or increasing scalar authority would confound
  route control with routine evaluator clipping.
- Local flow magnitudes remain small (trajectory means about `0.013--0.018`
  in the sampled rollouts), so a wake-rejection residual is not evidenced in
  this still-water task. The missing capability is a steering-release rule,
  not crossflow cancellation.

## Policy hypothesis

Preserve the assigned parent's evidenced `0.55T`, `28 deg` joint-state
traveling-bend carrier, posterior lag, calibrated curvature polarity, and
`4 deg` authority. Change only how observed response affects that curvature:
the geometric LOS error always owns steering sign, while bounded
`bearing_window_rate` may only attenuate its magnitude when the LOS magnitude
is already decreasing. A smooth sign-preserving release gate returns the fish
toward the symmetric traveling wave as alignment develops; after an actual
LOS crossing, a trend continuing away from zero cannot suppress the opposite
geometric correction. This differs from treating the short trend window as a
future bearing and prevents it from commanding premature countersteer.

Expected result: retain the parent's visible wake, reduce heading toward the
initial LOS without passing deeply below zero, survive beyond the repeated
`8.7--9.1T` upper exit, and improve on the parent's `11.878L` closest approach.
Falsify the mechanism if initial yaw polarity changes, the top-down/oblique
wake weakens materially, heading still crosses below zero before useful range
reduction, the upper exit repeats without beating `9.175L`, or steering chatters
with the short-window trend.

bookshelf_consulted: true
source_domain: biological burst redirect and robotic-fish closed-loop CPG direction tracking
source_mechanism: observed alignment response releases a bounded mean bend back into the propulsive rhythm instead of continuing or prematurely reversing the turn
transferable_invariant: a target-side curvature request should retain geometric sign while measured closing response can smoothly reduce its authority
nontransferable_details: published gains, dimensional beat rates, linkage and species kinematics, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: normalize target_body_L by distance_L for body-frame LOS, normalize the bounded LOS-closing rate by a policy-owned scale, and use it only as a multiplicative release gate on posterior mean curvature in the two-joint state-feedback carrier
falsification: reject if wake strength or initial polarity changes, heading overshoot and the upper-boundary exit persist, closest approach does not beat 11.878L, or the trend gate produces beat-scale steering chatter
