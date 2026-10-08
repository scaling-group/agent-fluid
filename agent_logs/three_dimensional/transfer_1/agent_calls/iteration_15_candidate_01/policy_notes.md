# Whole-wave rate projection candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the Phase-2 evidence contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and semantic `capture`.  The assigned-parent
  v31 centered-half-cycle policy captures at `19.03549 T`, score `-0.20185`,
  and distance integral `2.08993 L`.  The strongest v30 whole-wave pose
  projection captures earlier at `18.99699 T`, score `-0.18597`, and integral
  `2.07455 L`; the reproduced v29 controls are slower at `19.31050 T`,
  `-0.21058`, and `2.09959 L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows in the
  combined keyframe sheets for v30, v31, and a reproduced v29 comparator from
  release through capture.  Every fish is visibly self-propelled from
  quiescent water along the same continuous target-signed arc.  A compact
  startup disturbance becomes an orderly alternating mid-plane vortex street,
  while the oblique view shows compact alternating posterior structures with
  no collision, domain-exit, passive-advection, or instability precursor.
  V31 does not show a compensating qualitative wake improvement over v30.
- The completed trajectories confirm that mean-centering the half-cycle
  classifier failed its proposed performance and saturation tests.  Relative
  to v30, v31 trails by `0.0180/0.1184/0.1241/0.0516 L` at `4/8/12/16 T`,
  increases any-joint acceleration-limit residence from `43.43%` to `44.21%`,
  and slightly lowers mean center speed from `0.6764` to `0.6748 L/T` while
  preserving essentially the same peak normalized planar force/yaw moment
  (`0.03058/0.01538` versus `0.03068/0.01541`).  The coherent capture survives,
  but deliberately centering `phi1+phi2` for beat-side selection should not be
  retained as an improvement.
- A different inconsistency repeats in both the stronger v30 and assigned v31
  traces.  Over `2 T` through capture, `yaw_rate + 0.4*qdot1` remains correlated
  `-0.9255` (v30) and `-0.9243` (v31) with the observed whole-wave tangent rate
  `qdot1+qdot2`.  Independent two-joint fits give posterior yaw-rate
  coefficients `-0.1620` and `-0.1643`, while the policy currently rejects
  only a head-joint rate component.  This repeated signal supports testing a
  posterior derivative common-mode, not changing carrier cadence or amplitude.

## One-candidate policy hypothesis

Restore the evaluated v30 raw observed tail tangent for half-cycle steering,
preserving the stronger sampled actuator-phase behavior.  Add one conservative
whole-wave rate projection to ordinary route feedback: augment the existing
head rate correction with `0.16*(qdot1+qdot2)` before bearing-trend and yaw-rate
feedback.  Keep completion-gated redirect response on the evaluated head-only
rate correction, so the new posterior term cannot reinterpret or prematurely
release the large-error burst.  Preserve the oscillator, posterior lag,
whole-wave pose projection, raw redirect geometry, approach scheduling,
carrier-first allocation, rejected-steering spillover, and physical bounds.

The expected result is to preserve capture and the coherent alternating wake
while reducing beat-frequency countersteering and recovering or improving the
v30 middle/late route.  Falsify the mechanism if capture is lost or later than
`18.99699 T`, the distance integral exceeds `2.07455 L`, the lead at `8/12 T`
does not recover, the route changes sign, wake coherence degrades, or
acceleration-limit residence, center speed, normalized force, or yaw moment
materially exceed the v30 envelope.

bookshelf_consulted: true
source_domain: classical posterior traveling-wave swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate the observed derivative of the posterior propulsive wave from slower target-direction and body-yaw feedback
transferable_invariant: a coherent two-joint traveling-wave rate is a rhythmic common mode and should not be fed back as persistent route yaw or bearing motion
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional cadence, full-body waveforms, exact vortex phases, and prescribed task routes
policy_translation: use normalized body-frame route observations and observed qdot1+qdot2 to reject a bounded posterior rate common mode while retaining raw target geometry and the evaluated head-only redirect-release signal
falsification: reject if capture is lost or delayed, middle or late closure fails to improve, the target-signed arc reverses, the alternating wake loses coherence, or saturation, speed, normalized force, or yaw moment rises without compensating progress

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  This candidate receives formal
CFD evaluation only after worker exit; no same-worker performance is claimed.
