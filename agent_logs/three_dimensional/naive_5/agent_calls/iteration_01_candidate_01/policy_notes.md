# Wake-policy candidate notes

## Evidence diagnosis

- The only sampled solver is the common naive state-feedback seed. Its evaluation is contract-valid direct uniform still water (`U_infinity=[0,0,0]`) with no cylinders or prewarm.
- It is self-propelled rather than advected: the center travels `1.959L` while the still-water local flow remains small (maximum observed magnitude by component about `0.026U`). The top-down row shows a growing alternating vorticity trail, and the oblique row confirms coherent three-dimensional Lambda2 structures behind the caudal region.
- Propulsion is not target-controlled. Distance improves only from `12.328L` to `12.078L` at `6.358T`, then worsens to `12.380L`. The heading ranges from `0.602` to `-1.201 rad`; the fish develops a large clockwise/upward arc and terminates `left_domain` at `8.547T` with center `(20.075,15.200)L`.
- The target-bearing sign crosses from `+0.155 rad` initially to `-0.780 rad` at closest approach and `-1.296 rad` at exit, so the missing capability is closed-loop turn reversal after overshoot, not more route-independent thrust.
- The seed carrier is also actuator-distorted: at least one raw acceleration command exceeds the `1800 deg/T^2` envelope on `811/1554` samples (`52.2%`), and a joint is at the `260 deg/T` speed limit on `56/1554` samples (`3.6%`). Visible wake strength therefore does not justify retaining the seed cadence unchanged.

## Policy hypothesis

Test one compact mechanism: keep a joint-state oscillator, but make its nominal traveling bend feasible inside the measured actuator envelope and center that bend on a bounded mean-curvature request from body-frame target bearing. Dampen the request with observed body yaw rate so a correct-sign turn is released as the fish rotates, allowing the bias to reverse when bearing changes sign. Use posterior amplitude emphasis and lag only as the propulsive scaffold; do not add clock phase, target coordinates, wake phase, or a staged route.

Falsification: reject this translation if the rollout retains the same upper-boundary exit topology, cannot reverse curvature after bearing crosses zero, loses the seed's early distance improvement, lacks a coherent posterior wake, or spends substantial time at the command/joint limits. A longer finite trajectory without meaningful target progress would disprove steering authority even if survival alone raises the scalar score.

bookshelf_consulted: true
source_domain: classical reactive/undulatory swimming and robotic-fish turning control
source_mechanism: posterior-emphasized traveling bend combined with target-driven mean-curvature bias
transferable_invariant: preserve a directional posterior-lagged bend for thrust and superimpose bounded curvature from observed target error, releasing it with measured turn response
nontransferable_details: published gains, dimensional cadence, species envelopes, exact vortex or tail phase, full-body splines, and task-specific routes
policy_translation: state-feedback joint oscillator around a bounded function of normalized body-frame bearing and yaw rate, with a lagged stronger posterior joint and explicit acceleration bounds
falsification: same upper-domain exit or unreversed target overshoot, degraded early progress or coherent wake, or recurrent saturation despite the feasible carrier
