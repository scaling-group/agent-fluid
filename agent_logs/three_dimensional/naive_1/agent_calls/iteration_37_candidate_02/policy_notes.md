# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract and terminate in capture. Three execute the prefilled half-cycle
  envelope-redistribution policy (one differs only in comments); they capture
  at `18.7165--18.8815T`, have score-defined mean distances
  `2.08855--2.09266L`, and finish at `0.74722--0.74928L`. The fourth removes
  half-cycle relief redistribution while retaining displacement-phase
  steering; it captures slightly earlier at `18.6010T`, but its `2.09042L`
  mean distance and load/contact statistics overlap the clean carrier's repeat
  band. That isolated arrival difference is not evidence for a gain or gait
  replacement.
- I inspected every sampled combined sheet and the inherited parent failure
  sheet from release through termination. The sampled top-down rows show
  genuine self-propulsion along a smooth target-bending route with detached
  alternating vortices; their oblique rows show compact, finite caudal
  Lambda2 structures through first crossing. The views agree with monotone
  eventual target approach, bounded loads, and capture rather than advection,
  wake collapse, collision, or instability.
- The assigned parent's common two-command projection is the informative
  failure. Its top-down row never develops the sampled captures' detached
  street and instead shows mostly attached vorticity while the fish curls
  upward; the oblique row shows weak, body-attached structures rather than a
  sustained compact caudal wake. It reaches only `11.54354L`, turns from a
  maximum heading of `0.6450 rad` to `-1.1203 rad`, and exits left at
  `9.7075T` and `11.83495L`. This is a semantic regression from capture, not
  actuator relief: joint displacement falls to `0.3425/0.4635 rad` from the
  captures' roughly `0.52--0.58 rad`, joint rates fall to `3.00/3.85 rad/T`
  from the `4.5379 rad/T` envelope, and acceleration contact falls to
  `19.60%/42.78%` only because propulsion and steering authority collapse.
- In the clean captures, independent acceleration projection contacts the
  anterior/posterior envelopes on about `60.85--61.00%`/`72.97--73.27%` of
  rows, but both joints contact simultaneously on only `39.73--39.94%`.
  The failed parent scaled both raw commands whenever either one exceeded the
  envelope, so tail-only excess also attenuated an in-envelope anterior
  command. This confounds true two-joint corner allocation with widespread
  carrier throttling and identifies activation scope, not a scalar gain, as
  the next falsifiable distinction.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and robotic-fish coupled-oscillator control
source_mechanism: anterior state feedback sustains and steers a traveling bend while posterior lag carries the wave and emphasizes thrust
transferable_invariant: preserve the anterior carrier and posterior lag during ordinary single-joint saturation; coordinate commands only where independent projection would actually collapse two out-of-envelope demands onto one corner
nontransferable_details: published gains, dimensional cadence, full-body amplitude envelopes, species or robot kinematics, exact vortex phase, world coordinates, and task-specific routes
policy_translation: retain the normalized body-lateral route request, correcting-yaw release, differential curvature, displacement-only half-cycle steering, common relief redistribution, and posterior lag; use the existing independent exact projection for all interior and single-joint-overdrive states, and apply one positive ratio-preserving scale only when both raw accelerations exceed the public envelope
falsification: reject if capture or either coherent wake row is lost, joint amplitude/rate collapses toward the inherited allocator failure, the route leaves the 2.08855--2.09266L mean-distance band without a distinct coordination or load benefit, or simultaneous-corner relief merely shifts contact without improving route or loads
```

## Single-candidate policy hypothesis

Materialize exactly one selective-corner acceleration allocator. It leaves the
proven clean carrier bit-for-bit unchanged when neither or only one raw joint
command is outside the envelope. Only when both raw magnitudes exceed the
limit does it multiply the pair by their common maximum-demand scale before
the exact final guard. The conditional distinguishes true corner distortion
from the parent's broad scaling failure while preserving sign, ratio,
target-owned curvature, and posterior-lag coordination at the selected corner.

This is one bounded actuator-allocation mechanism, not scalar-only tuning. It
adds no clock, step count, coordinates, route memory, terminal channel,
flow/load residual, rate barrier, or new recovery branch. Formal CFD runs only
after handoff, so no outcome is claimed here.
