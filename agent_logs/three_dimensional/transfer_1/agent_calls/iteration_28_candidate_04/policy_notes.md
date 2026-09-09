# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics,
  and active moving-window shifts. Their motion is released self-propulsion,
  not ambient advection or a stored-flow artifact.
- I inspected both rows of all four combined wake sheets, including the
  best-scoring speed-reserve capture (`solver_6b0e320e2f55`) and the assigned
  parent's anterior-transfer capture (`solver_55f3a103ab95`). From release to
  capture each top-down row develops a persistent alternating red/blue street,
  while each oblique row retains compact bilateral Lambda2 structures and an
  active traveling bend. The parent therefore preserved useful propulsion;
  there is no visible wake collapse, passive transport, or instability to fix.
- The exact speed-reserve baseline captures in both current samples at
  `18.2050T` and `18.6010T`, with terminal speeds `0.9083` and `0.8268L/T`.
  The parent's unconditional unsafe-terminal anterior transfer also captures,
  but later at `18.7495T` and `0.8328L/T`. Its score (`-0.15335`) is below the
  best sampled baseline (`-0.15140`), and its distance integral, force, and
  moment remain inside rather than improve the baseline envelope.
- The transfer also fails its actuator-allocation motivation: anterior action
  clipping is `68.82%` versus `68.51--68.67%` in the two baseline samples,
  posterior clipping is `70.81%` versus `70.67--70.97%`, and speed-limit
  residence is `11.12%/11.85%` versus `10.79--10.82%/11.62--11.69%`.
  Moving a fixed share whenever terminal projection is unsafe therefore does
  not establish available anterior authority or recover tail steering that
  would otherwise be lost.
- Inherited logs supply the failures absent from the four current capture
  sheets. Exact baseline replays missed below at `1.4642--1.6463L`, the
  posterior pulse was only `2/3` after a `1.2589L` miss, and phase-course
  compensation, bearing recovery, a wider release veto, mean curvature, yaw
  damping, and half-cycle reallocation all retained active wakes but missed.
  The evidence rejects another route-observer, cadence, carrier-suppression,
  or fixed spatial-share edit; the remaining testable distinction is whether
  the parent's demonstrated-safe spatial transfer can respond to observed
  asymmetric actuator burden rather than projection geometry alone.

- A non-CFD replay of the initial clipping-recovery proposal over all four
  recorded traces found zero rows where tail saturation discarded additive
  steering in the steering direction. That proposed allocator would therefore
  be behaviorally inert on every sampled path and is rejected before formal
  evaluation. This negative check sharpens the evidence: total clipping is not
  proof that the steering component itself was clipped.

## One candidate hypothesis

Restore the exact intercept-guarded speed-reserve scaffold and replace the
parent's unconditional anterior transfer with one bounded actuator-burden
allocator. Inside the same unsafe terminal gate, normalize each joint's
previous returned action and current speed by their existing hard limits, and
define burden as the larger of those two ratios. Transfer steering from tail
to head only while tail burden exceeds head burden, in proportion to that
excess relative to unused head envelope, and cap the transfer by the head's
remaining normalized acceleration margin. Preserve the sum of steering
shares, carrier equations, posterior lag, cadence, route observation, response
release, sparse speed reserve, and final actuator clamp.

Expected test: match the established far-field trajectory exactly outside the
`4L` terminal band and retain both coherent wake views, while relocating the
parent's already-tested steering share only during measured asymmetric
head/tail burden. This is feedback control allocation from normalized
actuator-envelope state, not scalar gain tuning or an attempt to minimize clamp
fraction by suppressing the carrier.

Falsification: reject burden-responsive allocation if capture is lost, the lower-miss
topology persists on repeats, either wake row weakens, terminal speed leaves
the sampled `0.83--0.91L/T` envelope, or clipping, force, or yaw moment exceeds
the speed-reserve family without a repeatable arrival benefit. Do not answer
failure by increasing the transfer cap or stacking the rejected observer,
phase, pulse, governor, bearing, yaw-brake, or carrier-suppression mechanisms.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve a posteriorly lagged propulsive wave while bounded target steering is realized through actuator-aware closed-loop modulation
transferable_invariant: steering allocation should preserve the directed traveling bend and move control effort anteriorly only while observed actuator state shows the posterior channel is more burdened
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, task coordinates, and memorized routes
policy_translation: use normalized previous action and current joint speed inside the body-frame unsafe-intercept gate to modulate a bounded tail-to-head steering transfer with constant total steering share
falsification: reject if far-field closure changes, either wake view weakens, capture reliability or arrival worsens, or actuator and load metrics leave the evaluated speed-reserve envelope

## Non-CFD selectivity check

Replaying only the new burden and geometry gates over the four recorded traces
makes transfer identically zero outside `4L`. It is active on `10.3--13.0%` of
recorded terminal rows, with mean active steering-share transfer
`0.078--0.108` and maximum `0.294--0.401`; both-action-clamped rows and rows
where the head is at its speed envelope receive no transfer. This establishes
bounded selectivity, not a claim about the unevaluated closed-loop CFD result.
