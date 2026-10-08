# Geometric-contraction response-brake candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 contract: direct uniform
  quiescent-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, finite dynamics, and `capture`.  Three independently
  materialized v34 policies reproduce the same `18.403006 T` capture, score
  `-0.140449`, total distance integral `2.027810 L`, observed integral
  `1.418099 L`, and `239` moving-window shifts.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  release through capture for the reproduced v34 parent and the distinct v35
  response-release comparator.  Both fish visibly self-propel along the same
  smooth target-directed arc from still water.  A compact startup structure
  develops into coherent, alternating posterior sheets in both views; neither
  rollout shows passive advection, wake collapse, collision, domain exit,
  numerical instability, or a prewarm artifact.  The edit should therefore
  preserve the carrier and alter only route-response timing.
- V35 is a controlled negative result.  It multiplies v34's divergence
  recovery by a release triggered by productive closing and target-signed yaw.
  It still captures, but later at `18.414005 T`, with worse score
  `-0.141536`, total integral `2.028719 L`, and observed integral `1.418269 L`.
  Because the wake topology and moving-window count are unchanged, yaw plus
  closing is not sufficient evidence to release corrective curvature while
  the de-gaited bearing is still diverging.
- Inherited guidance and optimizer logs give the wider boundary.  V34's
  divergence recovery improves the prior closing-response carrier from about
  `18.755 T` and `2.05886 L` total integral while retaining its coherent wake.
  Conversely, whole-wave rate projection produced a wrong-sign upward route,
  `left_domain` at `8.4755 T`, and peak normalized force/moment about
  `0.3025/0.1347`; frozen-trajectory rate correlation is therefore not a safe
  reason to change the validated head-only derivative rejection.  The
  candidate preserves that rate path, carrier-first allocation, posterior
  lag, and acceleration envelope.

## One-candidate policy hypothesis

Preserve the evaluated v34 controller, including its full divergence recovery
until geometric contraction begins.  Add one bounded response-brake term only
when three body-frame conditions agree: the carrier-rejected bearing remains
outside its centerline band, its windowed trend is contracting toward zero,
and the de-gaited yaw rate is still turning toward the target.  The term
opposes that residual yaw and fades with bearing excess, contraction rate, and
normalized approach distance.  It does not alter the traveling carrier,
redirect, cadence, posterior lag, phase detector, or cross-joint allocation.

This tests a redirect-to-cruise handoff rather than another release during
unresolved divergence.  Expect v34 capture and wake coherence to survive, with
less broad route-scale sweep and equal or better middle/late closure.  Falsify
the mechanism if capture is lost or later than `18.403 T`, observed distance
integral exceeds `1.41810 L`, the target-signed arc or alternating wake
regresses, or maximum speed, acceleration-limit residence, peak normalized
force, or yaw moment materially exceed the established
`0.948 L/T`, `42.14%`, `0.03068`, and `0.01587` envelope.  The candidate's CFD
evaluation occurs only after this worker exits; no same-worker outcome is
claimed.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control
source_mechanism: hand a bounded corrective bend back to rhythmic cruise only after observed geometry confirms error contraction
transferable_invariant: separate route curvature from the traveling carrier and use normalized geometric response, not elapsed time or exact beat phase, to switch from turning authority to bounded yaw braking
nontransferable_details: published gains, species-specific C-start stages, full-body kinematics, clocked CPG phase, linkage geometry, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: retain v34 curvature throughout de-gaited bearing divergence, then add a small opposite-signed two-joint steering residual only while out-of-band bearing contracts and target-signed yaw persists, fading it on approach
falsification: reject if capture or middle/late closure regresses, the target-directed alternating wake changes, or speed, saturation, normalized force, or yaw moment rises without compensating progress
```

## Evidence boundary

All numerical and visual results above are completed sampled CFD from the
assigned parent, sampled solver results, and inherited logs.  Static replay of
the new algebra may verify targeting and bounds, but cannot establish a
closed-loop improvement.

## No-CFD implementation audit

- Reconstructing the candidate observation over all `3346` recorded v34
  states activates the contraction-response brake on `1307` states (`39.1%`)
  from startup through the late route.  Its mean/max active magnitude is
  `0.181/0.298` turn-request units, and it changes `1373` final command pairs
  with maximum component difference `2.050 rad/T^2`.  This confirms a
  material but bounded handoff path; it is frozen-state algebra, not CFD.
- The same replay produces finite commands throughout and never exceeds the
  unchanged `1800 deg/T^2` componentwise limit.  The deterministic schema
  audit resolves all `60` direct parameter references among the `62` fields
  returned by `target_policy_params()`, including the new active brake gain.
