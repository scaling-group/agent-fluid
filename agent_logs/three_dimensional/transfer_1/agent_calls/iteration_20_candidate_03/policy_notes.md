# Terminal carrier-crossflow pose candidate

## Rollout evidence and visual diagnosis before editing

- All four current solver examples satisfy the Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  Their
  three source variants are policy-equivalent and reproduce capture at
  `18.403006 T`, score `-0.140449`, total distance integral `2.027810 L`, and
  observed distance integral `1.418099 L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets from release through capture.  The repeated parent is
  visibly self-propelled from quiescent water along a smooth target-directed
  arc.  Compact startup structures develop into a coherent alternating
  posterior wake in both views; there is no passive advection, wake collapse,
  collision, domain exit, or numerical instability.  The current sample has
  no failed termination.  The inherited whole-wave route-rate projection
  remains the informative failure boundary: it retained an organized wake but
  turned upward, exited at `8.4755 T`, approached no closer than `12.2107 L`,
  and produced roughly tenfold force and moment peaks.
- I also inspected both visual rows for the completed inherited
  carrier-crossflow pose variant.  It preserves the same coherent wake and
  target-signed arc and captures at `18.325987 T`, `0.077019 T` earlier than
  the repeated parent.  Its observed approach integral is slightly better
  (`1.417990` versus `1.418099 L`), but its scalar score is worse
  (`-0.141865`) because the earlier, shallower discrete crossing increases
  the terminal-hold contribution (`0.610926` versus `0.609712 L`).
- The trajectory localizes the tradeoff.  The full-route crossflow variant is
  ahead by `0.003/0.004 L` at `2/4 T`, behind by `0.015/0.019/0.004 L` at
  `8/12/14 T`, then ahead by `0.010/0.042/0.065 L` at `16/17/18 T`.  Peak
  normalized force is unchanged at `0.03068` and peak moment falls slightly
  from `0.01587` to `0.01580`, while maximum speed rises from `0.9476` to
  `0.9631 L/T` and any-joint acceleration-limit residence rises from `42.14%`
  to `43.55%`.  This supports retaining the fluid-side pose signal only where
  it showed semantic benefit, not promoting its full-route action or tuning
  the carrier.
- The assigned-parent result supplies a compatible control boundary.  A
  yaw-and-positive-closure release stacked onto geometry-released
  bearing-divergence recovery delayed capture to `18.4140 T` without improving
  the wake or load envelope.  The candidate therefore leaves the validated
  geometry-only recovery and its contraction release untouched.

## One-candidate policy hypothesis

Preserve the repeated geometry-released controller through the far and middle
route: its state-feedback traveling wave, posterior lag, raw large-error
redirect, mean-preserving whole-wave joint-pose projection, head-only
route-rate correction, raw half-cycle steering, closing-response cadence
release, bearing-divergence recovery, approach schedule, carrier-first
head-to-tail rejected-steering allocation, and componentwise bounds.

Add one terminal sensing mechanism.  During a smooth body-frame distance
window from `4.25 L` to full authority at `2.25 L`, use the magnitude of
filtered local crossflow to weight the sign of the observed, de-meaned
anterior carrier phase.  Add the resulting bounded, odd correction only to
the proportional whole-wave pose projection.  Persistent crossflow cannot
become a one-sided route command; raw redirect selection, bearing trend, turn
rate, carrier dynamics, and direct actuator residuals remain unchanged.  The
gate is dimensionless in body lengths and has zero authority over the middle
interval where the completed full-route variant trailed.

The candidate should retain the parent's middle-route closure, coherent wake,
and force/moment envelope while recovering the inherited variant's late lead
and earlier arrival without its full-route saturation and speed cost.  Falsify
the mechanism if capture is lost or not earlier than `18.403 T`, observed
distance integral exceeds `1.41810 L`, the `16-18 T` lead fails to appear, the
alternating wake changes qualitatively, or maximum speed, acceleration-limit
residence, normalized force, or moment materially exceeds the completed
crossflow envelope `0.9631/43.55%/0.03068/0.01580`.  Formal CFD occurs only
after this worker exits, so no same-worker outcome is claimed.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish control
source_mechanism: separate slow target geometry from fast carrier-coherent crossflow and apply only bounded feedback to the latter
transferable_invariant: a fast body-frame flow signature may correct locomotor pose sensing without becoming a persistent route command, and should yield outside the regime where measured progress improves
nontransferable_details: published gains, species kinematics, exact vortex phase, cylinder-wake synchronization, clocked CPG timing, full-body envelopes, and prescribed routes
policy_translation: over a normalized late-approach distance window, use filtered local body-frame crossflow magnitude to weight an odd de-meaned anterior-joint-phase correction only in proportional whole-wave pose rejection
falsification: reject if terminal capture or observed closure does not improve, the coherent alternating wake weakens, or speed, saturation, normalized force, or yaw moment exceeds the completed crossflow envelope without compensating progress
```

## Evidence boundary

Numerical and visual outcome claims above come from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  The terminally gated candidate
receives formal CFD only after worker exit.

## No-CFD implementation audit

- Frozen-state reconstruction on the repeated parent trace keeps the new gate
  exactly zero until distance falls below `4.25 L` at about `13.987 T`, reaches
  full authority below `2.25 L` at about `16.385 T`, and bounds the realized
  pose correction to `1.20 deg` on that trace despite its `2 deg` parameter
  bound.  This confirms targeting of the diagnosed interval only; it is not a
  closed-loop outcome.
- A Julia comparison makes the candidate and repeated-parent actions
  bit-identical above the activation distance, distinct on a representative
  near-target state, and finite within the unchanged componentwise limit on a
  `200`-state distance sweep.  The public contract returns two finite
  accelerations, and all `63` direct parameter references are present among
  the `65` fields returned by `target_policy_params()`.
- The guidance and solver-boundary checks pass.  No CFD was run.
