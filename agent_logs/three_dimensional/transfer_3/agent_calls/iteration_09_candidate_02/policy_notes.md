# Direct route-curvature candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  (`U_infinity=(0,0,0)`), no cylinders, no prewarm, finite dynamics, and
  `left_domain` termination. Their motion and wakes are self-generated, not
  background or moving-window advection.
- The strongest-score finite sample, `solver_adc862529891`, visibly sustains a
  compact alternating top-down wake and discrete oblique Lambda2 structures,
  but its body/wake axis bends upward until the head exits at `y=15.343L`.
  The metrics agree with a route failure: minimum/final distance is
  `5.658/5.843L` at `16.77T`, not instability or collapsed propulsion.
- The inherited slip candidate `solver_b22e8cf1f277` also retains a coherent
  wake and improves the minimum to `4.158L`, but crosses the target's x station
  about `4.1L` high and continues to the left boundary. The inherited full-course
  and phase-separated-course experiments repeat that topology at `4.358L` and
  `4.128L`; the later half-cycle actuator instead weakens useful translation
  and regresses to `12.175L`. Thus neither another slip coefficient nor the
  tested half-cycle mapping is supported.
- `solver_3b6bd84298a5` is the most useful sampled route mechanism despite its
  lower scalar score. Both visual rows show a strong, coherent alternating wake;
  its center descends from about `13.98L` at `12T` to `12.89L` at closest
  approach, and the minimum improves to `3.369L`. It still crosses the target
  x station about `3.4L` high and exits left at `30.12T`, so the LOS-rate release
  improves the trajectory without completing the redirect.
- Replaying that policy algebra against its trace shows why useful route demand
  is diluted. From about `16T` onward, bounded bearing-plus-LOS-rate demand is
  essentially `+0.5 rad/T`, yet phase-conditioned instantaneous yaw makes the
  posterior mean-curvature command negative during roughly `9--20%` of each
  beat and leaves only about `5.7--7.9 deg` mean bias. Posterior angle already
  reaches about `0.58 rad` and acceleration commands about `119 rad/T^2`, so
  increasing the same feedback gain or limit would add saturation rather than
  fix the sub-beat sign reversals.

## Policy hypothesis recorded before editing

Preserve the evidenced `28 deg`, `0.55T` joint-state traveling-bend carrier and
the LOS-rate route response from `solver_3b6bd84298a5`. Remove the
joint-rate/instantaneous-yaw residual from the steering path and translate the
bounded route demand directly into posterior mean curvature. This tests a
sensor-modulated tail-beat offset rather than another scalar setting: persistent
route demand will retain one steering sign across the carrier cycle, while the
oscillator and posterior lag continue to create the propulsive wave. Expected
evidence is the same coherent wake with a lower target-station crossing and a
minimum below `3.369L` or a better termination class. Reject it if the posterior
joint spends more time at its limits, wake coherence or propulsion degrades, or
the same left exit remains without a meaningful closest/final-distance gain.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and tail-beat averaging
source_mechanism: sensory direction feedback modulates a bounded mean tail-beat offset while the rhythmic carrier remains autonomous
transferable_invariant: a persistent route request should set the slow curvature sign without treating carrier-scale rigid-yaw recoil as an equal and opposite route response
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, exact vortex phase, dimensional frequency, and task-specific routes
policy_translation: form bearing and LOS angular rate from normalized body-frame target and velocity observations, preserve the two-joint state-feedback carrier, and map their bounded combined demand directly to bounded posterior mean curvature
falsification: reject if coherent propulsion weakens, posterior saturation grows, or target-station height and the left-exit topology do not improve beyond the sampled `3.369L` minimum
