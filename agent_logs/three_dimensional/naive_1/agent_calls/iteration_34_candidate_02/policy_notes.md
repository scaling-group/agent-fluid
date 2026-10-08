# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. Two semantic replicas of
  the assigned parent capture at exactly `22.187000T`, with `0.748118L`
  crossing, `2.106255L` scored mean distance, and score `-0.211504`; the
  fixed-lead comparison captures later at `22.307997T`, with `2.107401L` mean
  distance and score `-0.212396`.
- The current best sample adds proximity-conditioned target-line preview only
  to the slow anterior curvature request. It captures at `22.159500T`, lowers
  mean distance to `2.105808L`, and improves score to `-0.211168`. Relative to
  the unmodified assigned parent, it is already closer at `16T`
  (`3.979636L` versus `3.982730L`) and `22T` (`0.817512L` versus
  `0.829695L`). This is a small but semantic improvement from prediction on a
  distinct allocation path, not evidence for more steering or drive gain.
- Both rows of the best and fixed-lead comparison sheets were inspected from
  release through capture. Their top-down views show self-propelled S-shaped
  approaches: alternating red/blue mid-plane structures develop behind the
  caudal region by `4T`, remain attached to the rhythmic body wave, and persist
  through the target crossing. The best sample also has a complete oblique row
  with discrete three-dimensional Lambda2 structures from the moving tail at
  `4T` through capture. The fixed-lead row is black after its labels, so that
  render is an evidence failure rather than evidence of wake collapse.
- No non-capture policy is present in the current four-solver sample. The
  fixed-lead capture is therefore the informative weaker visual comparison;
  the inherited valid two-view self-motion-course failure remains the route
  counterexample, curling past a `0.813329L` near miss before exiting at
  `6.290125L`. The inherited response-qualified rudder release is an additional
  matched negative control: it reproduces the fixed-lead `22.307997T` result
  exactly, so proximity prediction's useful contribution cannot be reduced to
  only removing posterior load.

## One candidate hypothesis

Use the sampled best slow-course-preview policy as the base. Preserve its
through-water course observation, anterior speed recovery, full body-frame
target geometry, phase-selective traveling carrier, fixed-lead posterior
recovery allocation, proximity-led reactive rudder, and stroke-qualified
terminal relief. Extend the same already bounded half-cycle, proximity-grown,
de-yawed target-line preview from the anterior curvature center to the smooth
error gate of the existing anterior redirect. Keep instantaneous target
geometry for redirect sign and keep every oscillator, acceleration, angle,
rate, recovery, rudder, and distance ceiling unchanged.

The best trace has full target error in the redirect transition band during
the middle approach, while its measured target-line trend reinforces the
target-side slow turn after proximity opens. Advancing the gate should recruit
the bounded transient anterior redirect before current error alone reaches the
same value, while its unchanged joint-state carrier continues to propel the
fish. This is one observation-to-actuator timing mechanism rather than a
scalar-gain edit; it adds no clock, step count, coordinate, route memory,
target identity, external phase, mutable state, force residual, or moment
residual.

Falsify the mechanism if capture is lost or not earlier than `22.159500T`,
scored mean distance is not below `2.105808L`, score does not exceed
`-0.211168`, or the pre-proximity route changes. Also reject it if mean action
exceeds the inherited approximately `59.850` envelope, anterior/posterior
exact-rate-cap occupancy materially exceeds `11.53/6.40%`, peak normalized
force/moment exceed `0.030897/0.015839`, or a complete two-view sheet does not
retain the established alternating three-dimensional wake. Any improvement
would remain fixed-pose still-water evidence, not robustness to changed pose,
inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded biological burst redirect
source_mechanism: preserve a posterior-delayed propulsive rhythm while measured target-line evolution recruits a separate bounded anterior redirect before large current error accumulates
transferable_invariant: normalized body-frame route response can continuously advance a capped transient turn path without increasing authority or replacing the traveling carrier
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: apply the already sampled half-cycle proximity preview to the existing smooth anterior-redirect error gate while retaining instantaneous target-side sign, the 16 rad/T^2 redirect ceiling, and every carrier and posterior path
falsification: reject if capture is not earlier than 22.159500T, mean distance is not below 2.105808L, the pre-proximity route changes, or complete wake, action, saturation, force, or moment envelopes worsen
