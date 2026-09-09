# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- The assigned parent and inherited logs identify the common `0.55T`
  joint-state oscillator and posterior lag as an evidenced propulsion carrier.
  They reject equal static curvature and slower centered carriers, and show
  that bounded two-joint half-cycle asymmetry is the first steering structure
  to improve target progress while retaining a traveling bend.
- All four sampled rollouts satisfy the direct-uniform still-water contract:
  diagnostics report `uniform_direct`, `U_infinity=(0,0,0)`, no prewarm, and
  zero cylinders. In both combined views the fish creates its own alternating
  wake. The top-down vorticity sheets show a curved, widening reverse street;
  the oblique sheets show body-connected three-dimensional Lambda2 structures
  behind the posterior body and tail. The translation is self-propulsion, not
  advection, and no sample ends in numerical instability.
- `solver_a4eae6d626b3` is the strongest finite sample. Its response-gated
  two-joint half-cycle redirect moves the center from `x=21.000L` to
  `17.199L` and reduces distance from `12.328L` to `9.759L`, while preserving
  a coherent wake through `10.32T`. It nevertheless moves upward to
  `y=15.202L` and exits the upper boundary; both joint rates still reach
  `260 deg/T` (118 and 120 near-limit samples).
- The prefilled course-residual/rate-barrier sample
  `solver_ea2c58da5110` eliminates near-limit joint-rate samples, but reaches
  only `11.643L`, moves left by just `1.647L`, and exits the same upper
  boundary at `9.14T`. Reducing rate occupancy by attenuating the carrier is
  therefore not evidence of useful navigation in this comparison.
- The paired `solver_77089a0404da` and `solver_a4eae6d626b3` traces expose a
  more specific steering defect. Near `8T`, both have negative body-frame
  target bearing and positive body-frame lateral velocity, so the fish is
  moving away from the requested side. The gated candidate applies the
  stronger negative half-cycle redirect and has heading `-0.239 rad`, versus
  `-0.095 rad` for the fixed-authority policy, while its world y motion remains
  upward. The observation adapter defines bearing from body y while this fish
  swims toward body `-x`; the inherited assumption that bearing and yaw-producing
  half-cycle polarity have the same sign is contradicted by this response.

## Single candidate hypothesis

Start from the strongest sampled response-gated redirect, preserving its
carrier, posterior emphasis, lateral-response release, sub-unity redirect
authority, and smooth acceleration envelope. Change exactly the directional
mapping: target bearing and slip retain the same magnitude and gate, but select
the opposite acceleration half-cycle. This is a coordinate-aware actuator
polarity correction, not a propulsion gain edit. It should first turn the
head/world trajectory downward toward the target instead of amplifying the
upper-boundary route, while retaining the sampled leftward propulsion.

Falsify the hypothesis if initial and post-crossing target errors do not evoke
the opposite heading response, if the fish still exits the upper boundary
without a meaningful closest-approach improvement over `9.759L`, or if it
merely trades that exit for wake collapse, a lower/right-domain exit, worse
joint-limit occupancy, or materially larger force/moment loads.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning by sensor-selected asymmetric flapping
source_mechanism: preserve a propulsive rhythm while body-frame direction error selects which beat half-cycle receives bounded extra authority
transferable_invariant: target-side error may choose a bounded asymmetric half-cycle while joint-state phase and posterior lag preserve the traveling bend
nontransferable_details: published gains, linkage geometry, duty ratios, dimensional frequencies, species kinematics, exact vortex phases, world-frame paths, and the sign convention between a particular robot actuator and yaw
policy_translation: retain the sampled wrong-side-slip-gated half-cycle controller, but reverse its error-to-half-cycle polarity because the L64 paired response shows the inherited polarity turns world motion away from the target side
falsification: reject if heading response does not reverse and target progress plus termination topology do not improve without loss of propulsion, wake coherence, or actuator/load quality
```

The shelf supplies only the asymmetric-flapping invariant. The polarity is
calibrated from the current L64 body-frame convention and paired rollouts; it
is not copied from a source or justified as scalar gain tuning.

## Dry validation (not rollout evidence)

The mandated semantic-guidance, lightweight policy-contract, parameter-schema,
and editable-boundary checks pass. Across 2,880 sampled combinations of joint
state, bearing, and lateral velocity, every output is finite, the largest
returned acceleration is below the smooth `30 rad/T^2` envelope, and exact
left/right reflection error is zero. The candidate also matches the strongest
sampled controller exactly when only that controller's bearing and lateral
velocity inputs are reflected (`max_error=0.0`), confirming that the carrier,
redirect gate, and parameters are unchanged and only steering polarity differs.
These dry checks contain no free-body hydrodynamics; the next CFD evaluation
must decide every trajectory, wake, actuator, and load falsifier above.
