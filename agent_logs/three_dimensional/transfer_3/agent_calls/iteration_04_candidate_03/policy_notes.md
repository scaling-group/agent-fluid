# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All sampled evaluations use direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The translations and the
  top-down/oblique wake structures are therefore self-generated, not imposed
  advection.
- `solver_19f251537923` remains the useful propulsion reference. Both visual
  rows show a long coherent alternating wake, and range falls from `12.328L`
  to `6.138L` at `16.505T`. It then follows a wrong-side arc to the lower
  boundary at `26.147T`. Its raw anterior/posterior commands exceed
  `1800 deg/T^2` in `3346/4754` and `3655/4754` samples, so its strong wake
  does not validate its complex steering or routine clipping.
- The assigned-parent lineage has now completed three target-aware steering
  iterations without a semantic improvement. The raw yaw-rate mean-bend
  policy `solver_97bc3c03d55b` reaches `9.175L` but exits the upper boundary;
  the correct-sign static `4 deg` mean bend `solver_a8731015fd6e` reaches only
  `11.878L` and exits the same boundary; and its bounded bearing-response-lead
  child `solver_d94c4664e94e` regresses to `12.030L`, again exiting upward.
  The latter two sheets show a short curved wake and increasing opposite-side
  route error rather than evidence that response lead arrests yaw momentum.
- The inherited half-cycle experiment `solver_3449e72838d2` is also a concrete
  negative result. Its `18 deg`, `0.68T` envelope-aware carrier remains below
  the raw acceleration limit and sheds a visibly weaker wake, but trend-led
  asymmetry reaches only `12.191L`, finishes at `12.929L`, and exits upward at
  `8.624T`. Repeating response lead through a different steering actuator, or
  weakening the carrier at the same time, is not supported.
- The failed yaw-rate loop used a rate dominated by locomotor recoil rather
  than slow rigid turning. A retrospective least-squares phase diagnostic on
  the three compact policies gives
  `yaw_slow = heading_rate + 0.64*phi_dot1 + 0.21*phi_dot2`. This reduces
  beat-scale rate standard deviation from `1.91` to `0.38 rad/T` for
  `solver_97bc3c03d55b`, from `1.27` to `0.20` for
  `solver_a8731015fd6e`, and from `1.22` to `0.22` for
  `solver_d94c4664e94e`. Applied without refitting to the different clean-B
  policy, it reduces `1.85` to `0.19 rad/T`. The residual retains the slow
  turn polarity (about `-0.17` to `-0.19 rad/T` for the upper-exit compact
  policies), unlike raw samples oscillating near `+/-2 rad/T`.
- Local head flow remains only about `0.02--0.04U` in the informative late
  segments, no rollout approaches the `0.75L` capture regime, and no sampled
  termination is unstable. Wake rejection and terminal scheduling remain
  unsupported; the missing capability is beat-separated yaw braking.

## Policy hypothesis

Test one new feedback mechanism: gait-phase-compensated yaw-rate pursuit. Keep
the evidenced `28 deg`, `0.55T` joint-state traveling-bend carrier unchanged
so the experiment does not confound yaw estimation with another weak carrier.
Estimate slow rigid yaw by removing from `heading_rate` the joint-velocity
recoil identified consistently across completed rollouts. A normalized
body-frame line-of-sight angle requests a small signed yaw rate; the difference
between compensated and requested yaw sets a bounded posterior mean curvature.
The calibrated sign is explicit: a positive body-y target requests negative
yaw, while a positive posterior curvature supplies that negative yaw. Once
the compensated yaw becomes more negative than requested, curvature reverses
before line-of-sight crossing and actively brakes rather than merely releasing.

Expected result: preserve the strong alternating wake and initial target-side
turn, but replace the `+/-2 rad/T` command chatter with a slow negative-yaw
response followed by counter-curvature, avoiding the repeated upper exit and
beating the parent's `9.175L` minimum. Falsify the mechanism if the compensated
rate remains beat-dominated, positive initial line of sight does not create
positive posterior curvature, curvature stays near a limit for whole beats,
the wake collapses, or another upper exit occurs without a better closest
approach. The new CFD outcome is not available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and tail-beat averaging models
source_mechanism: close the direction loop around the slow rigid response of a rhythmic gait instead of treating locomotor recoil as route yaw
transferable_invariant: preserve the propulsive rhythm, remove its joint-state-correlated fast yaw component, and let only the remaining signed response brake a bounded body-frame turn request
nontransferable_details: published CPG gains, dimensional beat rates, linkage geometry, fitted coefficients from other species, exact vortex phase, and task-specific routes
policy_translation: use normalized `target_body_L` for desired yaw and current `phi_dot` to compensate `heading_rate`; map the bounded compensated rate error only to the posterior equilibrium of the two-joint state-feedback carrier
falsification: reject if compensation does not materially suppress within-beat yaw variation, slow turn polarity is lost, braking fails before line-of-sight overshoot, propulsion collapses, or the upper-boundary topology repeats
