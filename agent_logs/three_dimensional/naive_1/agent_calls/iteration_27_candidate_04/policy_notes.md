# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected every combined sheet's top-down vorticity and oblique
  body/Lambda2 rows before editing, then cross-checked the images against
  scores, diagnostics, trajectories, executable policy diffs, assigned-parent
  guidance, and inherited optimizer notes. The current set has no semantic
  failure image, so the inherited broadside-to-left-exit result remains the
  informative negative boundary.
- Three sampled policies are executable-identical half-cycle envelope-
  redistribution carriers. They capture at `18.6505--18.8815T`, with mean
  distance `2.08855--2.09222L`. The fourth adds a dormant rearward multiplier
  and captures at `18.9640T`, mean distance `2.09072L`; inherited
  reconstruction shows that its target stays ahead, so it supplies no
  recovery evidence. All four sheets show genuine self-propulsion: coherent
  alternating top-down streets bend toward the target from quiescent water,
  while compact caudal Lambda2 structures persist through first crossing.
- Demand remains in one repeatable high-contact class: anterior/posterior
  acceleration contact is `60.85--61.17%`/`72.97--73.27%`, rate contact is
  `10.90--11.07%`/`14.73--15.07%`, and peak planar force/moment is
  `0.03066--0.03217`/`0.01603--0.01663`. The exact acceleration projection is
  therefore retained; prior pointwise rate barriers lost capture.
- The narrow actionable signal is route chatter near alignment. Reconstructing
  normalized body-frame target direction from every sampled trajectory gives
  `46--47` lateral-sign crossings per capture, while `9.3--9.6%` of rows lie
  inside `|lateral_fraction| < 0.05`. Yet the large-error topology is already
  capture-capable. Conversely, inherited full redistribution-plus-broadside
  reserve exited left after reaching `1.90495L`, and two geometry-authoritative
  handoffs restored capture but worsened mean distance to
  `2.09850--2.10301L`. Evidence therefore supports isolating the small-error
  route channel, not adding another broadside, terminal, velocity, posterior,
  or actuator modifier.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and CPG modulation
source_mechanism: separate slow persistent target steering from small fast direction reversals while preserving the propulsive rhythm
transferable_invariant: weak alternating direction error near alignment need not receive the same mean-curvature authority as persistent body-frame target error
nontransferable_details: published deadbands or gains, robot geometry, dimensional cadence, prescribed oscillator phase, exact vortex phase, species-specific motion, and task-specific routes
policy_translation: apply a smooth zero-to-one authority gate only over the sampled normalized body-lateral interval from zero to 0.05, then recover the existing route request exactly; preserve current target-owned sign, response release, displacement-phase redistribution, posterior lag, and acceleration projection
falsification: reject if capture or either coherent wake row is lost, arrival or mean distance leaves the sampled carrier band without a distinct benefit, large-error steering is weakened, or actuator contact and planar loads worsen rather than remaining in the established class
```

## Single-candidate policy hypothesis

Add exactly one small-error route-persistence mechanism to the prefilled
redistribution carrier. A cubic smoothstep of absolute normalized body-lateral
target direction gates the existing bounded route request from zero at exact
alignment to full authority at `0.05`; outside that narrow evidenced sector,
the executable route, correcting-yaw release, target-signed differential
curvature, half-cycle steering and envelope redistribution, traveling-wave
lag, damping, and hard acceleration projection are unchanged.

This is a normalized body-frame feedback architecture, not scalar-only carrier
tuning. It adds no time, step count, world coordinate, target identity, route
memory, velocity residual, flow term, broadside reserve, terminal compound,
posterior-only allocation, or rate barrier. Formal CFD occurs only after this
worker exits. Credit the mechanism only if another evaluation retains capture
and both wake views and shows a useful route, distance-integral, or demand
change beyond the present repeat spread.
