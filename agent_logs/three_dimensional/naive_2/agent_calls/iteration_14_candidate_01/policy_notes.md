# Rate-reserve predicted-miss candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected the top-down mid-plane vorticity and
  oblique body/Lambda2 rows of the combined sheets for the captured rollout
  and the prefilled upper-exit failure. Both fish translate behind
  body-connected alternating wakes with coherent three-dimensional caudal
  structures, so their difference is closed-loop navigation and actuator
  allocation rather than passive advection, absent thrust, or instability.
- The prefilled phase-separated full-circle controller never comes closer than
  `4.650L`, pins both joints at `45 deg`, reaches normalized planar
  force/moment peaks of `0.620/0.261`, and bends upward before exiting at
  `y=15.202L` after `20.034T`. The other sampled full-circle variants also
  leave the domain after minima of `2.703L` and `3.312L`. Their coherent late
  wakes show that preserving propulsion while changing scalar relief or bend
  release is not the missing capture mechanism.
- The sampled predicted-miss controller changes the semantic class: it reaches
  the `0.75L` sphere at `16.011T` with a final distance of `0.748L`. Its
  top-down row carries a regular alternating wake into the capture sphere, and
  its oblique row retains compact Lambda2 structures through arrival. The
  trace has no joint-angle dwell above `40 deg`, maxima of only
  `37.42/36.57 deg`, and low normalized planar force/moment peaks of
  `0.0347/0.0172`. This supports preserving its joint-state traveling carrier,
  body-frame course residual, and early predicted-miss mean curvature.
- The capture nevertheless spends rate authority inefficiently. At least one
  joint is exactly at the `260 deg/T` rate limit in `21.85%` of all trace
  samples; every such sample commands acceleration with the same sign as the
  saturated rate. At least one command exceeds `29 rad/T^2` in `62.45%` of
  samples. The inherited log independently identifies the same windup-like
  occupancy and recommends preserving an inward recovery channel rather than
  changing the successful target geometry.

## Single candidate hypothesis

Promote the captured predicted-miss policy and add one actuator-state
mechanism after its carrier, mean curvature, and half-cycle terms are combined.
Normalize each observed joint rate by the controller-owned `260 deg/T`
envelope. Across a narrow reserve below the limit, apply a continuous
smoothstep barrier only when total requested acceleration would drive the rate
farther outward. Leave inward or reversing acceleration exactly unchanged,
and retain the existing smooth acceleration envelope. This is state feedback,
not scalar-only tuning, and it does not alter the evidenced navigation path at
ordinary joint rates.

Primary support requires retaining capture and the coherent alternating wake.
Secondary support is reduced exact rate-limit occupancy and fewer outward
commands at the rate stop without later arrival, angle dwell, or load growth.
Falsify the mechanism if capture is lost or materially delayed, if rate-stop
occupancy is unchanged, if reversal is impeded, if either joint develops
`>40 deg` dwell, or if force/moment peaks or wake quality regress.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG locomotion and bounded biological burst-turn release
source_mechanism: preserve the rhythmic propulsive scaffold while measured actuator state continuously releases outward drive and retains the recovery half-cycle
transferable_invariant: target-signed curvature and rhythmic propulsion need an inward recovery channel instead of continuing to command into an observed actuator constraint
nontransferable_details: published gains, species-specific joint envelopes, dimensional frequencies, full-body kinematics, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: use normalized observed two-joint rates to smoothstep-attenuate only same-sign outward total acceleration near a controller-owned rate envelope, while preserving body-frame predicted-miss steering and all inward acceleration
falsification: lost or delayed capture, unchanged rate-stop occupancy, impaired reversal, joint-angle dwell, load growth, or collapse of the coherent alternating wake

## Dry validation only

The mandated guidance materiality, parameter-schema/policy contract, and
editable-boundary checks pass. A deterministic `35,721`-state grid spanning
joint angles and rates through the configured envelope, fore/aft and lateral
target geometry, body velocity, and distance produced finite commands within
the smooth `30 rad/T^2` acceleration bound with exact left/right reflection
(maximum error `0.0`). Below the rate reserve, every action is exactly equal to
the sampled captured parent. At a constructed positive rate-stop state, an
outward parent command of `29.515 rad/T^2` becomes `0.0`, while an inward
command of `-3.224 rad/T^2` is unchanged. These are algebraic mechanism checks,
not CFD evidence; EvE must establish capture retention, wake quality, arrival,
rate occupancy, joint angles, and loads.
