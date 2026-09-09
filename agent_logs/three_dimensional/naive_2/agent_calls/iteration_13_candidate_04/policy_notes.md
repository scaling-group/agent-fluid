# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled evaluations report direct-uniform still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In both rows of the
  combined sheets, motion is self-propelled: the top-down mid-plane views show
  body-connected alternating vorticity and the oblique views show coherent
  three-dimensional Lambda2 structures behind the caudal region.
- The informative `2.595L` failure preserves that wake but visibly curls away
  after passing above the target, reaches both joint angle stops at closest
  approach, and exits the upper-left boundary. The assigned-parent guidance
  and inherited logs likewise show that bend releases, drive braking, and a
  fixed-horizon aim displacement did not capture; preserving actuator reserve
  without predictive target-relative geometry was not sufficient navigation.
- The prefilled predicted-miss parent changes the semantic class: it captures
  at `16.011T` and `0.748L`, with a compact alternating wake through the final
  approach, no joint angle above `37.5 deg`, and finite normalized peak planar
  force/moment of about `0.030/0.017`. This confirms the combination of a
  joint-state traveling carrier, course-residual steering, and early
  body-frame predicted-miss mean curvature.
- The capture still spends actuator reserve unnecessarily. Either joint is
  exactly at the `260 deg/T` rate limit in `21.9%` of trace samples and `29.9%`
  after `12T`; every one of those samples commands acceleration in the same
  direction as the saturated joint rate. At least one command exceeds
  `29 rad/T^2` in `62.5%` of samples. Because outward acceleration cannot alter
  a rate-clamped joint, this is evidenced windup-like command occupancy rather
  than useful additional kinematics.

## Single candidate hypothesis recorded before editing

Preserve the captured parent's target geometry, predictive-miss gate,
mean-curvature equilibrium, half-cycle steering, oscillator, and posterior
lag. Add one actuator-aware state-feedback barrier after those components are
combined: as a joint rate enters a narrow normalized reserve below its known
envelope, smoothly attenuate only the acceleration whose sign would drive the
rate farther outward. Leave inward/reversing acceleration unchanged so the
traveling bend can reverse on schedule. This changes the feedback structure,
not the carrier gains or task route, and acts from joint state alone.

The primary requirement is retaining capture and a coherent alternating wake.
Supporting evidence would be reduced exact rate-limit occupancy and fewer
outward commands at the rate stop without later arrival or load growth. The
mechanism is falsified if capture is lost, arrival is materially delayed,
rate-limit occupancy is not reduced, reversal is impeded, joint-angle dwell or
loads grow, or the wake loses its traveling structure.

bookshelf_consulted: true
source_domain: state-feedback robotic-fish CPG locomotion and bounded burst-turn release
source_mechanism: preserve the propulsive rhythm while observed actuator state releases outward drive near a physical envelope and keeps reversal authority
transferable_invariant: rhythmic propulsion and target-signed curvature should retain an inward recovery channel instead of commanding farther into an active joint constraint
nontransferable_details: published CPG gains, species-specific rate envelopes, dimensional frequencies, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalize each observed joint rate by controller-owned rate-envelope parameters and smoothly attenuate only same-sign outward total acceleration before the existing acceleration bound
falsification: lost or delayed capture, unchanged rate-stop occupancy, impaired carrier reversal, joint-angle dwell, load growth, or collapse of the coherent alternating wake

## Dry validation only

The parameter-schema check found every direct `params.FIELD` reference in the
returned parameter object. A deterministic `99,225`-state grid spanning
body-frame target geometry, velocity, both joint angles, and rates through and
beyond the configured envelope produced finite commands within
`30 rad/T^2` and exact left/right reflection (maximum error `0.0`). At ordinary
rates through `2 rad/T`, actions match the captured parent to floating-point
roundoff (`2.22e-16`). In constructed rate-limit states, outward joint-1 drive
changes from `29.57` to `0.0 rad/T^2`, while the opposing reversal remains
unchanged at `-24.10 rad/T^2`. These are contract and mechanism checks, not CFD
evidence; only the later formal evaluation can establish retained capture,
reduced saturation, wake quality, loads, and arrival time.
