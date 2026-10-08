# Wake-policy optimization notes

## Evidence diagnosis

All four sampled evaluations used direct uniform quiescent initialization and
captured with a coherent, self-propelled alternating wake in both the top-down
vorticity and oblique Lambda2 views. The sheets show sustained posterior vortex
formation rather than passive advection, a broad target-directed turn, and a
late curved approach. The key visual difference is subtle because all four
retain the same carrier topology, so the histories decide the intervention.

The prefilled posterior half-cycle counter-tangent is the fastest sampled
capture at `23.793T` and preserves the wake, but it also has the largest peak
yaw (`3.289 rad/T`), inside-`3L` mean absolute yaw (`1.706 rad/T`), target-
transverse speed (`0.249U`), lateral force (`0.01186`), and yaw moment
(`0.00646`) of the four. The half-cycle-only whole-bend variant is the
informative mechanism failure: it cleans those measures to `2.991 rad/T`,
`1.616 rad/T`, `0.220U`, `0.01133`, and `0.00610`, but removes too much
continuous course authority and arrives last at `23.909T`. Hard course/yaw
consensus likewise arrives later (`23.859T`) without material cleanup. All
traces have zero joint-angle-limit exposure, about `8.2%` combined joint-speed-
cap exposure, and projected commands below `31.40 rad/T^2`; the remaining
deficit is therefore terminal coupling, not missing feasibility projection.

Across the four sampled traces inside `3L`, normalized yaw moment correlates
`0.964-0.966` with next-step yaw acceleration and has the same sign for
`98.7-99.2%` of samples. Moment reinforces the present yaw for only
`53.1-57.0%` of that regime, so it can distinguish a load-driven growth
half-cycle from one in which the hydrodynamics already brake the turn. The
policy hypothesis is to preserve v29's continuous target-course curvature and
carrier, but multiply its yaw-directed posterior counter-tangent by a smooth
moment/yaw reinforcement gate. Course still owns route direction; carrier-
rejected yaw owns counter direction; moment supplies only fast correction
urgency. This is a new load-selective residual, not scalar gain tuning.

bookshelf_consulted: true
source_domain: wake interaction and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow route feedback from a small bounded fast disturbance residual, and modulate rhythmic actuation from observed state rather than a clock
transferable_invariant: preserve the propulsive carrier and target-derived mean turn while applying disturbance rejection only when a normalized measured load indicates that excess motion is being reinforced
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: keep the body-frame course bend; use carrier-rejected yaw for counter direction and normalized yaw moment for a smooth urgency gate on the posterior tail-side half-cycle
falsification: reject if capture or arrival regresses, the alternating wake weakens, or terminal yaw, cross-track speed, force/moment, joint-speed exposure, and projected command exposure fail to improve jointly relative to v29 and v24

