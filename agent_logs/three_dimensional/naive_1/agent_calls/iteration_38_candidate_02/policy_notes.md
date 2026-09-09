# Step 38 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver episodes satisfy the frozen contract: direct-uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Two
  execute the prefilled common-envelope redistribution policy exactly and
  capture at `18.8265--18.8815T` with score-defined mean distance
  `2.08855--2.08896L`. The distinct clean-envelope policy captures at
  `18.6010T` and `2.09042L`; the rearward-route composition captures at
  `18.9640T` and `2.09072L`, but inherited reconstruction establishes that its
  recovery branch is not exercised.
- I inspected both rows of the combined keyframe sheets for the best-score
  redistribution capture and fastest clean capture, and compared them with the
  assigned parent's newly evaluated coupled-allocation failure. Both captures
  begin in quiescent fluid, build energetic alternating target-bending
  top-down streets, and retain compact bilateral and caudal Lambda2 structures
  through first crossing. With zero background velocity, their translation is
  self-propelled; neither shows collision, wake collapse, domain exit, or
  instability.
- The coupled allocator applies one positive scale to both raw accelerations
  whenever either exceeds the independent actuator limit. Its sheet instead
  shows a weak, smeared early wake, little translation, and a sharp off-route
  turn immediately before the `9.713T` left-domain exit. Metrics agree: it
  improves only from `12.3277L` to `11.5298L` before finishing at `11.7998L`,
  mean speed falls to `0.2721U` versus `0.6874U` for the best sampled capture,
  and anterior amplitude falls to `0.342 rad` versus `0.527 rad`. Acceleration
  contact falls to `19.54%/42.87%` and rate contact to zero, but peak planar
  force/moment also fall to `0.01905/0.00950` versus sampled capture bands of
  `0.03066--0.03259`/`0.01603--0.01656`. Thus the lower contact is propulsion
  and steering loss, not useful demand relief: an instantaneous acceleration
  ratio is not the traveling-bend state when independent joint dynamics and
  limits intervene.
- The sampled captures remain actuator-heavy at about
  `60.85--61.17%`/`72.95--73.27%` acceleration contact and
  `10.93--11.07%`/`14.73--14.96%` rate contact, but both redistributed and
  clean envelopes preserve coherent two-view wakes and the capture topology.
  The new candidate therefore restores the independent final projection and
  does not reopen scalar gain tuning, shared allocation, rate barriers,
  posterior-state phase voting, posterior-only allocation, terminal
  compounds, or stacked route recovery.
- Inherited route evidence supplies one remaining discriminating observation.
  Yaw response and body-frame bearing progress disagree on only `6/1624`
  yaw-correcting rows in a projected capture but on `1092/2826` rows in the
  target-relative course-residual left-exit failure. A previous extra
  qualification gate merely retained capture and did not establish a benefit;
  this candidate instead replaces the yaw-only release variable so it tests
  task-relative response without stacking another steering channel.

## Structured bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst-redirect response release and closed-loop robotic-fish direction tracking
source_mechanism: retain a directed posterior-lagged traveling bend while releasing bounded target-signed curvature only after sensed route error responds
transferable_invariant: use normalized body-frame target-error progress, rather than body rotation alone, to decide when corrective mean curvature can be released without changing turn sign
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, robot duty ratios, exact vortex phases, world coordinates, and task-specific routes
policy_translation: preserve body-lateral route sign, displacement-only half-cycle steering, common envelope redistribution, differential curvature shares, posterior lag, and independent final acceleration projection; replace yaw-rate response release with a bounded body-frame bearing-window-progress release
falsification: reject if capture or either coherent wake row is lost, the inherited downward or early left-exit topology recurs, arrival or mean distance leaves the current redistribution repeat band without a semantic benefit, or actuator contact and planar loads worsen; one ordinary capture inside repeat spread is non-interference, not improvement
```

## Exactly one candidate hypothesis

Materialize one target-progress response-release controller on the established
redistribution carrier. The target's bounded lateral direction cosine still
owns route sign, and observed anterior displacement still allocates both
steering and common relief by half-cycle. The only architecture change is that
the one-sided release fraction is driven by decreasing body-frame target
bearing over the existing observation window rather than by recent body yaw.
Release can reduce but never invert target-signed curvature.

Expected result: retain the sampled self-propelled capture route and two-view
wake while avoiding premature steering release when body yaw looks corrective
but lateral translation makes target bearing worse. This is a body-frame
state-feedback mechanism, not scalar-only gain tuning. It adds no explicit
time, step, world coordinate, route, recovery branch, terminal schedule,
flow/force residual, mutable state, or shared actuator budget. Formal CFD runs
only after handoff, so no outcome is claimed for this unevaluated candidate.
