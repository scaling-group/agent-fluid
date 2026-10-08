# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled evaluations satisfy the experiment contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Their motion and wakes are therefore policy-generated rather than
  ambient advection.
- The top-down vorticity and oblique Lambda2 rows of the strongest sampled
  controller agree that the zero-centered anterior oscillator with posterior
  bearing/trend mean curvature is a useful self-propelled carrier. It leaves a
  coherent alternating three-dimensional wake, travels from `x=21.00L` to
  `16.40L`, and reduces distance from `12.328L` to `9.141L` before the upper
  `left_domain` exit at `13.129T`.
- The inherited posterior half-cycle attenuation was meant to improve that
  carrier's recovery without increasing its peak tail target. Its combined
  sheet still shows a coherent wake, but the trajectory repeats the same
  upper-exit topology at `y=15.201L`. It ends sooner at `12.551T`, reaches only
  `x=17.270L`, and finishes at `9.855L`. Thus it gives up about `0.87L` of
  leftward travel and `0.71L` of closest approach relative to the unattenuated
  carrier without improving termination class.
- The half-cycle edit did reduce posterior raw-acceleration requests beyond
  `1800 deg/T^2` from about `61.9%` to `50.1%` of samples and posterior
  rate-limit contact from about `5.8%` to `2.6%`. Those load improvements did
  not produce course recovery: body-frame bearing still reaches about
  `-1.28 rad` at exit, and the measured lateral velocity remains away from the
  negative-bearing target side at `7T` (`+0.355U`), `10T` (`+0.253U`), and
  `12T` (`+0.367U`). The edit reduced propulsive translation more than it
  reduced the late lateral escape.
- The two wider-scale posterior mean-curvature variants likewise exit near
  `9.2T` with only `0.50-0.69L` best progress, while inherited notes show that
  moving the anterior oscillator center collapses its carrier-scale excursion
  and useful travel. The evidence therefore supports preserving the anterior
  oscillator, rejecting another persistent half-cycle multiplier, and testing
  a transient actuator-priority change only after target error becomes large.

## Policy hypothesis

Restore the strongest sampled bearing/trend mean-curvature carrier and replace
the persistent half-cycle attenuation with one response-gated posterior burst
redirect. For small body-frame bearing the policy is exactly the demonstrated
carrier. As absolute bearing crosses a bounded onset, a smooth gate blends the
posterior target away from its oscillatory cruise target and toward a bounded
turn-side curvature. The gate grows when normalized body-frame lateral motion
is absent or directed away from the requested target side, and releases when
that motion has the requested sign; shrinking bearing also releases it. The
zero-centered anterior oscillator continues throughout, so there is no clock,
hidden stage, shifted head center, or memorized route.

An offline signal replay over the two sampled trajectories (not a CFD outcome)
keeps mean redirect blend at `0.002` before `7T`, first exceeds `0.05` near
`6.85T`, and raises mean late blend to `0.277` on the strongest carrier and
`0.342` on the inherited half-cycle path. This checks that the new mechanism is
isolated to the diagnosed late failure; only the next formal rollout can test
whether the hydrodynamic response improves.

This gives corrective curvature priority during the late divergent hook without
adding a larger static offset to an already clipped posterior request. It should
retain the early coherent wake and leftward progress, then reduce or reverse the
large negative-bearing/upward excursion after roughly `7T`. Falsify the
translation if it suppresses the wake or surge before the large-error gate is
active, produces persistent bang-bang tail motion, increases joint-limit
occupancy materially, or repeats the upper exit without beating the inherited
`9.855L` result; stronger evidence would be bearing recovery, a later or better
termination class, or progress past `9.141L`.

bookshelf_consulted: true
source_domain: biological C-start or burst redirection and sensor-modulated robotic-fish direction tracking, paired with classical posterior traveling-wave propulsion
source_mechanism: large direction error temporarily prioritizes bounded body curvature, then observed turning response releases the swimmer back into its propulsive rhythm
transferable_invariant: preserve the proven rhythm at small error; when body-frame direction error is large and lateral motion is not responding toward the target side, smoothly trade part of the posterior oscillation for bounded turn-side curvature and release that trade as response or alignment improves
nontransferable_details: species-specific C-start shapes, published gains and thresholds, clocked phases, dimensional cadence, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: use bounded body-frame bearing for the redirect magnitude and bounded target-side body-frame lateral velocity for response release; blend only the posterior joint target while leaving the zero-centered joint-state oscillator active
falsification: reject if the early alternating wake or surge degrades, large-error bearing does not recover, actuator-limit occupancy worsens materially, or the same upper-boundary exit persists without a longer or closer useful trajectory
