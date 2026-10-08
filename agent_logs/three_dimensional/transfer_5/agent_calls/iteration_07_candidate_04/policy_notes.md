# Direction-consensus terminal-brake candidate

## Visual and quantitative diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water runs:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture. The top-down rows show self-propelled motion along the same
  broad target-directed arc with a strong alternating wake; the oblique rows
  confirm coherent paired three-dimensional structures through capture. The
  current sample has no semantic failure or visible carrier breakup. The
  informative failure boundary is inherited instead: replacing the carrier
  with opposite-sign static posture produced weak-wake upper exits, whereas
  retaining it and adding the same-sign C-bend produced capture.
- The strongest scalar sample, `solver_8ce1bc88a53c` (v24), captures at
  `23.8315T` with scoring mean distance `2.434073L`. Its phase-demodulated
  course gate is a small improvement over the target-course sample
  `solver_e08e4373a646` (`23.8810T`, `2.434313L`), so the v24 carrier and its
  terminal progress are the behavior to preserve.
- The same comparison does not show cleaner terminal control. V24 raises peak
  yaw from `2.975` to `3.208 rad/T`, mean absolute yaw inside `3L` from `1.556`
  to `1.684 rad/T`, mean absolute target-transverse speed there from `0.225`
  to `0.239U`, and mean absolute lateral-force/yaw-moment coefficients there
  from `0.01106/0.00596` to `0.01179/0.00640`. Its joint-1 high-command
  exposure is also essentially unchanged (`55.1%` versus `55.2%`). Thus
  multiplying an excess-yaw magnitude by the course-residual sign improved
  distance progress but did not validate joint damping of yaw, course, loads,
  or saturation.
- Offline reconstruction of v24's normalized terminal cues shows why this
  remains ambiguous: the course-requested bend opposes the carrier-rejected
  yaw, and can therefore brake it, for `76.2%` of samples inside `3L`, but only
  `46.2%` inside `1L`. The existing gate uses yaw only as an unsigned magnitude,
  so the contradictory near-capture samples can command a bend that reinforces
  rather than damps yaw. These percentages diagnose cue compatibility on the
  recorded trajectory; they are not a closed-loop prediction.

## Policy hypothesis

Use v24 as the sole carrier and retain its traveling-wave oscillator,
same-sign redirect, response release, carrier-rejected course/yaw signals, and
smooth physical-command projection. Add one bounded arbitration mechanism:
form the yaw-braking direction from signed carrier-rejected yaw and permit the
existing course-signed terminal counter-bend only when the two requested bend
directions agree. The agreed branch keeps v24's exact magnitude; a conflict
sets only this small terminal residual to zero, leaving the target-aware carrier
and all far/middle guidance intact. This is normalized body-frame state
feedback with no clock, route memory, target identity, or global direction.

Expect the coherent captured topology to survive while peak/near-target yaw,
cross-track speed, and lateral load move toward or below the cleaner
`solver_e08e4373a646` values without materially losing v24's arrival or distance
integral. Falsify the mechanism if capture is lost, arrival exceeds `23.9T` or
scoring mean distance exceeds `2.435L` without a material yaw/load benefit, or
if wake coherence, joint-speed exposure, or command exposure regresses.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish capture control
source_mechanism: preserve the rhythmic carrier while a bounded near-field residual damps route-scale yaw and slip rather than beat motion
transferable_invariant: apply terminal correction only when independent target-course and signed yaw cues request the same corrective direction
nontransferable_details: published gains, dimensional cadence, robot linkage kinematics, species envelopes, exact vortex phase, and prescribed routes
policy_translation: use normalized body-frame target and velocity for carrier-rejected cross-track direction, joint-state-rejected heading rate for yaw-brake direction, and gate the existing two-joint terminal counter-bend on their sign agreement
falsification: reject if capture or alternating-wake coherence is lost, or if arrival, distance integral, terminal yaw/course, loads, or joint/command exposure do not jointly improve
```
