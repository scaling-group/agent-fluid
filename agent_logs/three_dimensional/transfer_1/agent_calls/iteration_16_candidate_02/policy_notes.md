# Closing-response and complementary-steering candidate

## Evidence and visual diagnosis before editing

- All four sampled solver results satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and `capture` termination.  The assigned v31
  half-cycle-centered prefill captures at `19.03549 T`, score `-0.20185`, and
  distance integral `2.08993 L`.  The v30 whole-wave projection improves those
  values to `18.99699 T`, `-0.18597`, and `2.07455 L`.
- I inspected both top-down vorticity and oblique body/Lambda2 rows of the
  combined sheets for the strongest sampled result and the assigned prefill
  from release through capture.  Both are visibly self-propelled along smooth
  target-directed arcs and retain compact, alternating posterior wake
  structures; neither shows background advection, a moving-window artifact,
  wake collapse, collision, or instability.  The strongest run is farther
  along the same route at matched frames, so the remaining opportunity is
  closure efficiency rather than a new carrier or route topology.
- The strongest completed child adds positive-closing response to v30's
  existing turn-relief schedule.  It captures at `18.754995 T`, score
  `-0.171145`, and distance integral `2.058863 L`, with mean/max speed
  `0.6862/0.9492 L/T`, any-joint acceleration-limit residence `41.96%`, and
  peak normalized force/moment `0.03068/0.01564`.  Relative to v30 it is
  `0.2420 T` earlier, improves the integral by `0.01569 L`, and reduces
  limit residence from `43.43%`, while preserving the visible wake and route.
- A distinct completed child adds only reverse recovery of posterior-rejected
  steering into anterior headroom.  It also improves v30, capturing at
  `18.87049 T`, score `-0.18102`, and integral `2.06891 L`, with
  `43.17%` any-joint limit residence and the same `0.03068/0.01541` peak
  force/moment scale.  Thus outcome-gated carrier scheduling and
  complementary target-residual allocation are separately positive against
  the same base and act at different points in the controller.
- The assigned v31 centering change is a concrete negative boundary: removing
  commanded mean curvature from the raw half-cycle detector delays capture,
  worsens the integral by `0.01538 L` versus v30, increases maximum speed from
  `0.9272` to `0.9480 L/T`, and raises limit residence from `43.43%` to
  `44.21%`.  The raw two-joint tangent is therefore restored for actuator
  phase classification even though mean-preserving projection remains useful
  for route geometry.
- The inherited whole-wave derivative projection is the informative semantic
  failure.  Its top-down sheet turns upward and away while the oblique sheet
  still shows an organized self-propelled wake; it exits the upper boundary at
  `8.4755 T`, with minimum/final distance `12.2107/12.7296 L` and score
  `-15.22484`.  A fitted joint-rate correlation was not a causal disturbance
  estimate, so this candidate retains the validated head-only rate correction.

## One-candidate policy hypothesis

Use the strongest completed closing-response release policy as the base and
add the independently positive bidirectional target-residual allocation.
Preserve its state-feedback traveling wave, posterior lag, raw-geometry
completion-gated redirect, whole-wave pose projection, head-only derivative
correction, raw half-cycle steering, approach scheduling, head-to-tail
spillover, componentwise physical limits, and positive-closing cadence gate.
After composing the posterior carrier first, measure only signed target
steering rejected by its physical projection and return a bounded fraction to
the anterior target residual.  Never transfer carrier demand between joints.

The expected result is the same coherent target-directed wake and capture,
with response-gated cadence preserving productive translation while
complementary headroom recovers steering otherwise discarded during posterior
clipping.  Falsify the combination if capture is lost or later than
`18.754995 T`, distance integral exceeds `2.058863 L`, the arc changes sign,
the alternating wake decoheres, or maximum speed, any-joint limit residence,
normalized force, or moment materially exceeds
`0.9492/41.96%/0.03068/0.01564` without compensating progress.  If it merely
reproduces or regresses the winner, treat interaction between cadence release
and reverse allocation as non-additive and do not stack further positive
single-change results without a closed-loop combination test.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric turning layered on a posterior traveling bend
source_mechanism: keep rhythmic propulsion distinct from slower target steering, restore withheld propulsion after observed useful response, and place rejected steering in complementary actuator authority
transferable_invariant: body-frame target closure may gate carrier relief while only target-derived residual rejected at one physical bound may use headroom at the other joint
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phases, duty ratios, and prescribed routes
policy_translation: retain the completed positive-closing cadence gate and recover only posterior-rejected target steering into bounded anterior headroom under the existing normalized body-frame two-joint controller
falsification: reject if the combination loses or delays capture, worsens the distance integral, reverses the target-signed arc, disrupts the coherent wake, or materially raises saturation, speed, normalized force, or moment without compensating progress
```

## Evidence boundary

All numerical and visual outcome claims above come from completed sampled CFD
and inherited optimizer logs.  This combined candidate receives formal CFD
only after worker exit; no same-worker improvement is claimed.
