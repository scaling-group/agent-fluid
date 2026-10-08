# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures under the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three independently rendered
  copies of the prefilled composition reproduce exactly the same
  `23.864521T`, 4,339-step capture, `0.749310L` crossing, `2.192138L`
  score-metric mean distance, and `-0.294271` score despite comment-only policy
  differences. This verifies deterministic compatibility of water-relative
  lateral route sensing with forward-speed-deficit carrier recruitment. It
  improves both independently positive components: the complete two-view
  speed-recruiting sample captures at `23.985519T` with `2.202000L` mean
  distance, while the assigned-parent log records `24.018509T` and
  `2.206025L` for water-relative sideslip alone.
- The prefilled composition's top-down sheets show continuous self-propelled
  translation along the established S-shaped approach and an alternating
  red/blue caudal street through capture. All three of its oblique rows are
  black render artifacts, so they do not independently establish preservation
  of the three-dimensional wake. The slower speed-recruiting comparison is the
  strongest complete visual control: its oblique row shows discrete alternating
  Lambda2 structures from wake formation through capture. Thus the current
  improvement is supported by route and numerical evidence, not by claiming
  stronger vortices from missing imagery.
- The composition preserves a finite physical envelope: mean action is about
  `57.57`, mean action inside `1.5L` is `41.56`, anterior/posterior rate-cap
  occupancy is about `11.75/6.41%`, and peak normalized force/moment are about
  `0.02948/0.01534`. Its `2T` distance is `12.222539L`. The trace exposes one
  remaining observation inconsistency rather than a gain deficiency. The
  recovery gate reads inertial body-forward speed even though the route loop
  now reads body motion relative to local water. Filtered local axial flow has
  mean/RMS about `-0.01697/0.01766 U`; translating the recorded signal to
  forward body-minus-water speed changes mean/RMS from about
  `0.55529/0.58427 U` to `0.53832/0.56672 U`, raises below-`0.45 U` occupancy
  only from `15.28%` to `15.97%`, and raises the offline mean smooth recovery
  gate from `0.11570` to `0.11950`. This is a modest, normalized semantic
  change, not evidence for increasing the recovery gain.

## One candidate hypothesis

Preserve the prefilled composition's joint-state traveling carrier,
water-relative lateral route feedback, full target geometry, reactive-rudder
sign, closing-deficit relief, and target-side anterior-stroke qualification.
Change only the speed observed by the bounded anterior locomotor-recovery gate:
replace inertial `-state.velocity_body_U[1]` with
`state.relative_flow_velocity_body_U[1]`, which is forward body speed relative
to the locally sampled water because the observation adapter defines relative
flow as local water minus body velocity and the fish points along negative body
x. A headwind or adverse wake can then recruit oscillator energy according to
actual body-water advance, while helpful coflow avoids unnecessary recruitment.
The threshold, gain, and smooth gate remain unchanged, so this tests a physical
observation pathway rather than scalar-only drive tuning.

Falsify the translation if it loses capture, arrives later than the reproduced
`23.864521T`, raises score-metric mean distance above `2.192138L`, worsens
`2T` distance beyond `12.222539L`, or materially exceeds the sampled action,
rate-cap, peak-force, peak-moment, top-down route, or complete-control wake
envelopes. Even a better direct-still-water result would establish only
fixed-pose compatibility; an evaluation with complete oblique rendering and a
changed flow or pose is required before claiming multi-wake robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction locomotion
source_mechanism: modulate a rhythmic traveling carrier from measured locomotor deficit while distinguishing body-water motion from inertial transport
transferable_invariant: preserve the joint-state carrier and use normalized local-water-relative forward speed only to recruit bounded oscillator energy when actual locomotor advance falls below its useful envelope
nontransferable_details: published gains, dimensional speed thresholds, robot sensors, species-specific kinematics, prescribed timing, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: retain every sampled gain and actuator allocation but replace inertial forward speed in the existing smooth recovery gate with the sign-correct forward component of `relative_flow_velocity_body_U`
falsification: reject if capture is lost or later than 23.864521T, mean distance exceeds 2.192138L, startup progress regresses, or action, saturation, force, moment, route, or coherent wake envelopes worsen
