# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the staggered four-cylinder
  streets develop, merge, and pass through the target region. This is common
  initial-condition evidence and does not distinguish policies.
- All four sampled policies and released sheets are also byte-identical
  `oscillator_amplitude=28`-degree, `tail_lag_gain=0.75`,
  `tail_damping=0.65` replicas. The fish turns left and down under its own dense
  alternating trail, traverses the merged wake corridor, and crosses the target
  ring without collision, exit, or instability. Mean fish velocity
  `(-0.2853,-0.1198)` versus mean local flow `(-0.1687,-0.1692)` confirms
  active leftward propulsion rather than passive advection. Every repeat
  reaches at `38.049`, with score `0.073801`, mean distance `1.802L`, energy
  `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and joint peaks `0.496/0.521` rad. Both joints touch the
  `4.538`-rad/time rate and `31.416`-rad/time-squared acceleration caps.
- No sampled or available inherited sheet is a semantic failure. The assigned
  parent's higher-damping `0.675` rollout is the clearest navigation-hypothesis
  failure: it keeps the safe route but is visibly behind at matched middle and
  late frames, reaches at `41.591`, raises mean distance to `1.901L` and
  energy/power to `58328/4400`, and increases joint peaks to `0.508/0.551` rad
  despite lowering force/moment to `40.10/637.97`. The `0.70` damping sample
  extends that regression to `46.910/2.067L` while only reducing loads.
- The parent's opposite `0.625` damping probe reaches sooner at `37.339` and
  lowers energy/power to `52247/3947`, but its released sheet has a visibly
  stronger disturbed trail and its mean distance and score regress slightly to
  `1.803L/0.071866`. Crossflow and force/moment jump to
  `0.2461/47.26/710.38`, joint peaks rise to `0.516/0.565` rad, and cap contact
  remains. Together, the damping probes show that faster posterior response is
  coupled to excessive excursion and wake loading, while extra damping trades
  away useful traverse without removing saturation.
- Inherited lag (`0.70`, `0.7675`, `0.80`), allocation (`0.30`, `0.45`), and
  bearing-gain (`1.725`, `1.9`) tests already regress around their measured
  anchors. The older mixed-feedback instability supplies no safe scale for a
  new velocity, force, or moment term. Those axes and the observation set stay
  fixed here. No omitted shelf, neighboring configuration, external artifact,
  or repository history was consulted.

## Candidate hypothesis

Preserve the replicated `0.55`-period oscillator, `tail_lag_gain=0.75`,
`tail_damping=0.65`, gain-`1.7` bounded body-frame bearing law, 12-degree
steering bound, fraction-`0.35` allocation, and observation set. Change only
`oscillator_amplitude` from 28 to 27 degrees. This `3.57%` reduction is a new,
bounded propulsion-envelope test motivated by the inherited lower-damping
result: reducing the anterior oscillator's nonlinear amplitude scale may
suppress joint excursion and the dense lateral trail without the traversal
loss caused by directly increasing posterior damping. The nominal harmonic
rate and acceleration at 27 degrees remain above the configured actuator caps,
so the test asks whether less time near the envelope can straighten the route
while preserving decisive propulsion; it does not assume cap contact will
disappear.

The later CFD rollout supports the hypothesis only if it captures on the same
visible turn-then-diagonal route and improves score above `0.073801` or mean
distance below `1.802L`, while reducing joint excursion, crossflow, or loads
without a material regression in the other measures. Arrival at or beyond the
`0.80` lag comparator's `38.362`, mean distance above `1.812L`, loss of
capture, route change, or any collision, exit, or instability falsifies the
navigation mechanism. Force/moment above `42.01/653.13`, posterior excursion
above `0.521` rad, or unchanged cap contact with weaker traverse also rejects
the proposed envelope benefit. Any positive result remains limited to the
certified wake phase and start pose until held-out evidence tests it.
