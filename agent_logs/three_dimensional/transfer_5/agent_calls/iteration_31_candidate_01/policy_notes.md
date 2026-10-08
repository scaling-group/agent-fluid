# Candidate diagnosis and hypothesis

## Evidence read before editing

- The four sampled solver examples all report direct uniform still water,
  `capture`, score `-0.5350132766550009`, final/minimum distance
  `0.7460955381393433L`, and `23.837020874023438T` arrival. Their combined
  keyframe sheets are byte-identical. Three policy files are also
  byte-identical to the prefill; the fourth differs in names and comments but
  implements the same role-separated observer algebra and produces the same
  trajectory. There is therefore no sampled visual failure to contrast with
  the successful rollout and no evidence for another algebraic observer
  rewrite.
- In the top-down row, the fish moves under its own actuation from release,
  sheds a coherent alternating red/blue wake, preserves that street through
  the long approach, and makes the late upward turn into the target rather
  than being passively advected. The oblique row confirms compact alternating
  three-dimensional Lambda2 structures behind the physical tail and no
  prewarm structure at release. The wake remains organized through capture;
  this argues against changing the carrier, posterior lag, or propulsion
  amplitude.
- The trajectory is still dynamically turning at capture: final heading error
  is `-0.06501 rad`, heading rate is `1.33272 rad/T`, velocity is
  `(-0.66247,-0.34386)U`, and projected commands are
  `(-30.4292,30.2150) rad/T^2`. Inherited aggregate diagnostics report
  `1.67938 rad/T` mean absolute yaw and `0.23868U` target-cross-track speed
  inside `3L`, with `3.19386 rad/T` peak yaw and `0.013581` peak absolute
  moment. This supports a terminal correction-timing test, not additional
  steering authority.
- The assigned-parent logs add captures at `-0.5353627`/`0.7464477L` and
  `-0.5363256`/`0.7482820L`, while other inherited sampled logs include
  `-0.5351083`/`0.7461746L`. Those records lack policies, trajectories, and
  wake/load evidence, so their regressions cannot be attributed to a
  primitive and they are not promoted.

## Policy hypothesis

The current anterior terminal residual is selected by the sign of posterior
tail-tangent displacement alone. Near a zero crossing, that sign recognizes a
new beat side only after it has begun. Replace only this selector with a small,
bounded displacement-rate phase coordinate,
`tail_tangent + lead * tail_tangent_rate / omega`. It advances both zero
crossings without a clock, changes timing rather than authority, and leaves
the evaluated continuous course observer plus posterior traveling-wave target
unchanged. Reject the candidate if CFD delays capture, worsens mean/final
distance, disrupts the alternating wake, raises terminal yaw/moment, or
increases joint/command limit exposure relative to the repeated split
baseline.

bookshelf_consulted: true
source_domain: robotic-fish CPG and asymmetric-flapping control
source_mechanism: infer beat phase from observed joint angle and velocity, then apply bounded steering on the useful half-cycle
transferable_invariant: phase-dependent steering can be timed from oscillator state while preserving the propulsive carrier
nontransferable_details: published gains, clock phase, duty ratios, species-specific envelopes, exact vortex phase, and prescribed routes
policy_translation: phase-advance only the existing anterior terminal half-cycle selector with normalized full-tail displacement plus rate over observed drive frequency
falsification: reject if capture/progress, coherent wake, terminal yaw or moment, or actuator feasibility regresses from the repeated split-observer baseline
