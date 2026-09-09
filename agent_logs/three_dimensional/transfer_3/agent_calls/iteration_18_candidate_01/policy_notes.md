# Replication candidate for response-reversing posterior half-cycle steering

## Evidence diagnosis recorded before the policy edit

- All four sampled solver examples satisfy the frozen experiment contract:
  direct uniform initialization in `[0,0,0]` still water, no cylinders or
  prewarm, and finite `capture` termination. They start at `12.3277L` and
  capture at `18.9310--19.8880T`. Their combined sheets show body-led motion,
  a coherent alternating mid-plane vorticity street, and compact tail-linked
  three-dimensional Lambda2 structures through capture; local-flow RMS is
  only about `0.018U`, so neither imposed advection nor moving-window
  transport explains the progress.
- The fastest and best-scoring sample is the response-reversing posterior
  half-cycle policy (`solver_85695f4d40af`): capture at `18.9310T`, mean
  distance `2.04175L`, score `-0.15357`. Its top-down row remains smoothly
  target-directed and its oblique row retains the traveling wake through the
  final crossing. The other three samples use the unmodulated distributed
  C-bend architecture and capture at `19.2335--19.8880T`, with mean distance
  `2.06505--2.09373L` and scores `-0.17657-- -0.20397`.
- The assigned parent's inherited `step_15` rollout is the informative
  failure and prevents treating the unmodulated architecture as robust. The
  acceleration-feasible policy hash that captured at `19.2335T` in the
  sampled set instead passes high at `1.845L`, retains a coherent propulsive
  wake, and exits left at `28.875T` with score `-9.77873`. The failure sheet
  shows no wake collapse or numerical instability; its late trajectory is a
  nearly straight high pass while both joint commands spend more time at the
  acceleration bound. More clipped mean-bend authority is therefore not the
  supported remedy.
- The inherited `step_17` notes introduced one mechanism rather than more
  mean curvature: use phase-conditioned yaw error to strengthen the helpful
  half of the posterior traveling wave and weaken the opposing half, reversing
  the preference whenever observed response outruns route demand. Its sampled
  outcome restores capture and improves both arrival and distance integral,
  but it has only one completed evaluation. Replication is more informative
  than adding another range gate, allocation switch, or untested gain change.

## Policy hypothesis recorded before editing

Materialize the sampled response-reversing half-cycle policy exactly. Preserve
the normalized body-frame bearing and rotation-invariant LOS-rate route law,
joint-recoil-conditioned yaw response, continuous anterior and posterior
mean-curvature work, `28 degree`/`0.55T` traveling carrier, and explicit
componentwise physical acceleration projection. Retain only the sampled
bounded posterior half-cycle scale as the mechanism under replication.

The candidate should repeat capture without the inherited coherent-wake high
pass and remain near or better than the conservative `20.020T` distributed-
bend reference. Falsify the mechanism if it loses capture, repeats a
greater-than-`1.845L` high pass, arrives after `20.020T`, breaks the alternating
wake, materially worsens posterior limit occupancy or hydrodynamic loads, or
violates reflection equivariance. A single further capture would support the
mechanism but would still not prove robustness across held-out geometry or
inflow.

bookshelf_consulted: true
source_domain: asymmetric robotic-fish CPG turning combined with Lighthill-style posterior traveling-wave propulsion
source_mechanism: modulate helpful and opposing tail-beat halves from observed directional response while retaining the propulsive wave lag
transferable_invariant: preserve the traveling wave and reverse a bounded phase-selective imbalance when observed yaw response crosses route demand
nontransferable_details: published gains, robot linkage geometry, species envelopes, dimensional beat frequencies, exact vortex phases, analytical force coefficients, and task-specific routes
policy_translation: retain normalized body-frame LOS route feedback and distributed slow curvature, and scale the posterior wave by the bounded product of normalized recoil-conditioned yaw error and instantaneous posterior-wave sign
falsification: reject if capture is lost or later than `20.020T`, the inherited greater-than-`1.845L` high pass recurs, wake coherence or loads worsen, posterior saturation increases materially, or reflection checks fail
