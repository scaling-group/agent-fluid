# Smooth-envelope response-release candidate

## Visual and quantitative diagnosis

- All four sampled solver rollouts satisfy the evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their motion is therefore self-propelled rather
  than imposed-flow advection.
- The assigned solver prefill `solver_d594e3893325` and its byte-identical
  repeat `solver_6c6aaae744be` preserve a compact alternating top-down wake and
  an organized three-dimensional Lambda2 train while following a broad arc to
  capture at `25.388T`. They reach `0.74947L`, have mean distance `2.55720L`,
  and score `-0.65632`, but their recorded joint commands peak at about
  `79.999/108.510 rad/T^2`, far outside the `31.416 rad/T^2` envelope.
- `solver_953f16c610ad` differs from that prefill only by a component-wise
  fourth-order smooth command projection. Both visual rows retain the
  alternating propulsive wake through capture, while the commands remain at
  `31.251/31.374 rad/T^2`. It captures earlier at `23.997T`, lowers mean
  distance to `2.43835L`, and improves score to `-0.54034`. This completed CFD
  result supports keeping the projection; it is not merely an algebraic
  saturation argument. Joint-speed contact remains, so the evidence does not
  justify stronger cadence or scalar drive tuning.
- `solver_82fca3f02154` differs from the unprojected prefill only by releasing
  part of the same-polarity C-bend after requested and observed yaw agree. It
  also retains the coherent wake and capture, modestly improving arrival to
  `25.152T` and mean distance to `2.52183L`, while reducing peak positive yaw
  rate from `2.781` to `2.604 rad/T` and narrowing the heading excursion. Its
  commands remain unconditioned at about `79.437/108.656 rad/T^2`, so the
  response mechanism and envelope mechanism address distinct measured defects.
- The inherited `solver_f578f8771e8a` is the informative counterexample: its
  polarity-inverted, near-total response-gated redirect curls into a tight
  C-shape, loses the detached alternating train, improves closest distance by
  only `0.155L`, and exits upward at `7.99T`. Response gating is supported only
  as a bounded release of the already validated same-polarity topology.

## One candidate hypothesis

Retain `solver_953f16c610ad`'s complete normalized body-frame controller and
smooth output projection, and add only `solver_82fca3f02154`'s bounded,
sign-symmetric response-release gate. Large geometric error will still receive
the full validated C-bend until yaw follows the requested direction; agreement
between bounded target yaw and recent observed turn rate will then release at
most 28% of the redirect into the posteriorly lagged propulsive carrier. This
is one response-modulated redirect mechanism layered on an evidence-backed
actuator envelope, with no clock, route, mutable state, or gain-only tuning.

Falsification: reject the combination if it loses capture, is not materially
better than the `23.997T`/`2.43835L` smooth-envelope parent, recurs into an
upper-exit curl, weakens the alternating top-down or Lambda2 wake, violates the
acceleration envelope, or increases angle/rate-limit contact. A reduction in
yaw excursion without improved arrival or distance integral is not sufficient.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological C-start/burst redirects and sensor-modulated robotic-fish CPG control
source_mechanism: large directional error invokes bounded curvature, then observed heading response releases steering posture back into a posteriorly lagged propulsive beat
transferable_invariant: a strong target-referenced redirect should yield continuously to the traveling-wave carrier once measured yaw follows the requested body-frame turn
nontransferable_details: species-specific bend shape, published gains and frequencies, dimensional maneuver timing, full-body kinematics, exact vortex phase, and task-specific routes
policy_translation: retain the normalized bearing/vector-angle C-bend and component-wise physical command projection, and multiply redirect load by a bounded function of target turn-rate request times recent observed turn rate
falsification: loss of capture, wake coherence, envelope compliance, or improvement over the projected parent invalidates the transfer; the polarity-inverted upper-exit topology is an immediate rejection
```

## Verification boundary

- The required semantic-guidance check passes, confirming a material reusable
  update relative to the assigned parent, and the repository boundary check
  confirms that the candidate is the only solver edit.
- The deterministic schema audit finds 60 returned parameter fields and 58
  direct `params.FIELD` references, with no missing field. The candidate is a
  small textual composition of two already evaluated Julia policies: relative
  to the projected parent, only the two response parameters and bounded
  response-release calculation are new.
- The configured check-runner was invoked but its pinned model is unavailable
  for this account. Its Julia load test also cannot run directly because no
  `julia` executable is installed. No formal CFD was run, as required; syntax
  loading and the combined mechanism's fluid-dynamic effect remain downstream
  evaluation responsibilities.
