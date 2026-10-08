# Closure-gated carrier with bidirectional rejected-steering allocation

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  The
  assigned parent is strongest, capturing at `18.754995 T` with score
  `-0.171145` and distance integral `2.058863 L`.  The v30 whole-wave base
  captures at `18.996988 T`, `-0.185969`, and `2.074552 L`; reverse rejected-
  steering allocation improves that same base to `18.870491 T`, `-0.181022`,
  and `2.068913 L`; centered half-cycle detection is the weakest current
  capture at `19.035492 T`, `-0.201845`, and `2.089927 L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the assigned parent and the weakest current capture from release through
  termination.  Both fish visibly self-propel along smooth target-signed arcs
  from quiescent water, leaving compact startup structures and then coherent
  alternating mid-plane wakes.  The oblique rows show organized paired
  posterior three-dimensional structures rather than passive advection, wake
  collapse, collision, domain exit, or instability.  The assigned parent is
  farther along the same useful arc at the late matched frame and reaches the
  capture circle about `0.2805 T` earlier.
- Trace diagnostics agree with the visual reading.  Relative to v30, the
  parent's positive-closing-response release reduces capture time by
  `0.24199 T` and integral by `0.01569 L`, while mean/max speed changes from
  `0.6764/0.9272` to `0.6862/0.9492 L/T`.  Any-joint acceleration-limit
  residence falls from `43.43%` to `41.96%`, peak normalized planar force is
  unchanged at `0.03068`, and peak yaw moment changes only from `0.01541` to
  `0.01564`.  Thus releasing pre-existing turn-induced cadence relief only
  after measured closure is a completed positive result, not a same-worker
  hypothesis.
- Reverse allocation is independently positive on v30: it advances capture by
  `0.12650 T`, lowers the integral by `0.00564 L`, leaves the peak normalized
  force/moment at `0.03068/0.01541`, and slightly lowers limit residence from
  `43.43%` to `43.17%`.  The parent's completed trace still places the tail at
  its acceleration bound for `6.42%` of states but never records both joints
  at the bound together.  This preserves a concrete complementary-headroom
  opportunity after cadence release; it does not justify raising a carrier or
  steering gain.
- The inherited negative boundaries remain active.  Centering the actuator
  half-cycle detector around commanded mean bend delayed capture and increased
  integral, while whole-wave derivative projection previously reversed the
  route and exited the upper boundary despite an organized wake.  This
  candidate retains the raw half-cycle detector and the head-only derivative
  correction.

## One-candidate policy hypothesis

Preserve the assigned parent's state-feedback traveling wave, posterior lag,
raw-geometry completion-gated redirect, whole-wave pose projection, raw
half-cycle steering, closure-gated cadence release, approach scheduling,
head-to-tail rejected-steering spillover, and componentwise physical bounds.
Add the sampled reverse allocation path: after composing the posterior carrier
with its target-derived residual, measure only the signed steering residual
rejected by the posterior bound and add one half of it to the anterior target
residual before final projection.  Do not transfer posterior carrier demand.

The two mechanisms act on different signals: measured body-frame target
closure controls withheld cadence, while actuator headroom controls only lost
target steering.  The expected result is to retain the parent's coherent wake
and target-signed arc while recovering useful steering on posterior-only
clipping states, improving middle/late closure and capture time.  Falsify the
combination if capture is lost or later than `18.754995 T`, distance integral
exceeds `2.058863 L`, the route or alternating wake changes qualitatively, or
maximum speed, limit residence, normalized force, or yaw moment materially
exceeds `0.9492/41.96%/0.03068/0.01564` without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish asymmetric turning
source_mechanism: renew posterior propulsion after observed useful redirection while layering target-derived turning asymmetry separately from the rhythmic carrier
transferable_invariant: use measured target response to schedule propulsion, and use complementary actuator authority only for rejected target steering; keep both feedback paths separate from the traveling-wave carrier
nontransferable_details: published gains, species burst timing, duty ratios, clocked CPG phase, linkage geometry, dimensional cadence, full-body kinematics, exact vortex phase, and prescribed routes
policy_translation: retain positive normalized closing-speed release of turn-induced cadence relief and add only the signed posterior target residual rejected after carrier-first composition to available anterior headroom within the existing two-joint bounds
falsification: reject if the composition loses or delays capture, worsens middle or late closure, reverses the target-signed arc, disrupts the coherent alternating wake, or materially raises speed, saturation, normalized force, or yaw moment without compensating progress
```

## Evidence boundary

All outcome claims above come from completed sampled CFD and inherited
optimizer logs.  This combined candidate is evaluated only after worker exit;
no same-worker CFD result is claimed.

## No-CFD implementation audit

A deterministic `24,300`-state grid compared the candidate with the assigned
parent across joint pose/rate, body-frame target side, bearing, closing
response, and yaw rate.  All outputs were finite and within the unchanged
`1800 deg/T^2` componentwise limit.  The new path changed only the anterior
command on `5,133` states, every change coincided with the parent's posterior
output being at its bound, and the posterior output was identical throughout;
the largest sampled anterior change was `3.634 rad/T^2`.  This establishes
mechanism targeting and envelope preservation, not closed-loop improvement.
