# Phase-horizon joint-speed viability candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In the strongest
  finite soft-envelope capture (`solver_ba8bbe9216df`) and the informative
  phase-reallocation contrast (`solver_94d1c68ad200`), the top-down sheets show
  a coherent alternating vorticity street growing behind the caudal region
  through approach and capture. The oblique sheets show compact alternating
  three-dimensional Lambda2 structures rather than a diffuse or collapsed
  wake. Peak fish speeds are `1.393U` and `1.373U`, while peak local-flow speeds
  are only `0.0325U` and `0.0297U`; the visible approach is self-propelled, not
  ambient advection.
- The unguarded high-knee soft envelope is the strongest sampled route: it
  captures at `16.943T`, scores `-0.205386`, and has distance integral
  `2.08985L`, but both joints sit at exactly `260 deg/T` for about
  `3.73/3.54%` of the trace. The inherited narrow positive-power guard removes
  exact contact and the sampled `0.94`-onset version preserves capture at
  `17.115T`, but score regresses to `-0.213215` and distance integral to
  `2.097996L`. Its `258.92/259.19 deg/T` peaks show that a fixed onset still
  suppresses several percent of near-limit carrier work rather than acting
  only on imminent crossings.
- The prefilled `0.90` guard plus anterior-to-posterior recycling also captures
  with an alternating 3D wake and keeps peaks at `257.11/257.75 deg/T`, but it
  arrives at `17.275T` and scores `-0.212754`. This is only `0.055T` faster than
  the inherited unrecycled `0.90` guard (`17.330T`) and remains `0.160T` slower
  than the sampled `0.94` guard. Cross-joint recycling therefore has weak
  recovery evidence, while the broader fixed speed gate remains the dominant
  route cost. Force and yaw-moment peaks remain tightly grouped across the
  sampled family (`0.0356--0.0361` and `0.01758--0.01782`), so the evidence
  does not motivate added steering, load rejection, or a stronger carrier.

## Policy hypothesis

Preserve the captured full-quadrant body-frame target/course feedback,
zero-centered anterior oscillator, lagged posterior carrier, terminal steering
reserve, high-knee acceleration shoulder, and posterior kinetic angle-margin
projection. Replace the fixed speed-onset gate and cross-joint recycling with
one state-dependent speed-viability mechanism. For each joint, normalize the
assembled outward acceleration by the oscillator rate and project joint speed
over a short owned phase horizon. Limit only positive joint power whose
projection exceeds a buffered normalized speed envelope; pass all braking and
all lower-risk carrier work unchanged.

The threat-conditioned projection should remove exact speed contact with less
route distortion than the sampled `0.94` fixed threshold. Falsify the candidate
if it loses capture or alternating three-dimensional shedding, either joint
touches `260 deg/T`, arrival reaches or exceeds `17.115T`, score fails to beat
`-0.213215`, posterior angle clearance worsens beyond the sampled family, or
force/yaw-moment peaks exceed `0.0361/0.0179`.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and classical reactive swimming
source_mechanism: sensor feedback modulates the active rhythmic envelope while preserving the phase-coherent traveling bend and its natural reversal
transferable_invariant: intervene only when observed joint state and outward work predict an actuator-envelope violation; retain lower-risk propulsion and opposing acceleration so the rhythm can brake and reverse
nontransferable_details: published CPG gains, dimensional cadence and amplitude, species-specific kinematics, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: use phi_dot divided by the owned speed limit and assembled outward phi_ddot divided by omega times that limit; project each speed over a short owned oscillator-phase horizon and cap only positive-power acceleration that would exceed a buffered normalized speed envelope
falsification: reject if exact speed contact remains, capture or alternating three-dimensional shedding is lost, arrival is not earlier than 17.115T, score does not beat -0.213215, angle clearance worsens, or load peaks exceed the sampled family
```
