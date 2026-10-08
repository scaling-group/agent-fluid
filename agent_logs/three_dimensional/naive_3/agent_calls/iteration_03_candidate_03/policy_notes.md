# Wake-policy candidate notes

## Inherited and sampled evidence

- All sampled evaluations satisfy the frozen experiment: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders, and no prewarm. Their
  motion is self-propulsion, not ambient advection.
- The strongest finite sample is the sharp bearing/trend posterior-curvature
  controller. Its combined sheet shows a coherent alternating mid-plane wake
  and a persistent three-dimensional Lambda2 trail while it moves left from
  `x=21.000L` to `16.396L`. Distance falls from `12.328L` to `9.141L`, so the
  unchanged anterior oscillator and posterior traveling bend are useful.
- Both visual rows also show the failure topology. The fish is nearly level
  through about `8T`, then its path and wake hook upward while the target is
  below-left. The metric reconstruction agrees: body-frame bearing reaches
  `-1.330 rad`, center y reaches `15.201L`, and the run terminates
  `left_domain` at `13.129T`. During the late recovery, away-side body lateral
  velocity is `+0.289U` near `10T` and `+0.496U` near `12T`. Thus the useful
  surge coexists with accumulated lateral slip that bearing-only curvature
  reacts to too late.
- The prefilled bearing-plus-instantaneous-yaw-rate variant is an informative
  failure. Its top-down row retains an alternating wake and its oblique row
  confirms three-dimensional shedding, but the body turns sharply upward,
  reaches only `11.824L`, then recedes and exits at `9.191T`. Instantaneous yaw
  damping in the static offset is therefore not evidence of course recovery.
- Two completed tail half-cycle variants falsify the inherited phase-asymmetry
  hypothesis. The opposition-relief form retains a long coherent wake and
  reduces mean absolute yaw rate from about `1.31` to `1.13 rad/T` and
  posterior speed-limit contact from `5.8%` to `2.6%`, but it still reaches
  about `-1.28 rad` bearing at the same upper exit and worsens closest approach
  from `9.141L` to `9.855L`. The stronger two-sided tail scaling inherited from
  the assigned parent exits at `9.09T`, reaches only `11.655L`, and ends at
  `11.713L`. Tail-only half-cycle retuning changes effort, not termination
  class or target containment.
- Raw acceleration demand in the strongest sample already exceeds the
  `1800 deg/T^2` envelope in about `45%` of anterior and `62%` of posterior
  samples. The evidence does not support more carrier or curvature amplitude.

## Policy hypothesis

Retain the strongest sample's zero-centered anterior oscillator, posterior
lag, and `12 deg` bounded posterior mean curvature, but replace its noisy
short-window bearing lead with a body-frame lateral-slip residual. The turn
signal is target bearing minus bounded lateral body velocity: motion toward
the requested side releases curvature, while motion across or away from the
target strengthens the opposite correction before position error and yaw
build into the observed upper hook. This is a state-feedback direction
tracking mechanism, not a larger steering gain or a world-frame route.

The next rollout should preserve the coherent traveling wake and useful
leftward surge while reducing positive-y drift after the first bearing
crossing. Evidence should show tighter bearing containment, a later or better
termination class, and preferably a closest approach below `9.141L` without
greater actuator-limit occupancy. Falsify the mechanism if it damps productive
lateral motion enough to destroy surge or wake coherence, if bearing still
diverges below `-1 rad` into the same upper exit, or if effort rises without a
semantic trajectory improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and bounded slip damping in fish target control
source_mechanism: sensor feedback superposed on an unchanged propulsive oscillator so target error sets mean bend and lateral motion releases or strengthens it
transferable_invariant: preserve the traveling carrier while using normalized body-frame target error and lateral motion together, so steering responds to cross-target drift before accumulated position error becomes a large turn
nontransferable_details: published gains, clock phase, species-specific kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: map bounded body-frame bearing minus bounded lateral body velocity to posterior mean curvature while leaving the joint-state oscillator and lagged carrier unchanged
falsification: reject if the alternating wake or leftward progress collapses, actuator-limit occupancy rises materially, or negative bearing and positive-y drift still produce the same upper-boundary exit without a closer approach
