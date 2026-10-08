# Evaluated lateral-response residual candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  an active moving window, and capture. Three sampled IDs are byte-identical
  evaluations of the lateral-residual policy and capture at `16.604496T`,
  `0.743958L`, and score `-0.113729`. The prefilled one-sided speed-guard
  carrier captures at `16.609995T`, `0.745621L`, and score `-0.115560`.
  Repeated IDs establish fixed-case reproducibility, not robustness.
- I inspected the combined sheet and both view-specific sheets for a strongest
  lateral-residual capture and the weaker prefilled capture. In both top-down
  rows, the fish moves under its own alternating vorticity street from release
  through a shallow target-crossing arc; it is not passively advected. Both
  oblique rows show finite, compact, tail-connected three-dimensional
  Lambda2 structures. There is no collision, wake breakup, domain exit, or
  numerical instability, and no semantic failure sheet exists in the sampled
  set, so the weaker captured prefill is the informative visual comparator.
- The metrics support a narrow response-observer benefit rather than a gait or
  effort change. Removing fitted anterior-phase sway only from posterior
  course and relative-crossflow feedback improves arrival by one `0.0055T`
  step and reduces scored distance integral from `1.999656L` to `1.998146L`.
  Mean absolute action is essentially unchanged, while peak planar
  force/moment increase from `0.035828/0.017759` to
  `0.037165/0.018356` and near-limit residence rises slightly. The full
  traveling-wave carrier and final-one-percent speed guard therefore remain
  the supported scaffold; stronger actuation is not supported.
- Inherited optimizer logs provide two important negative controls on the same
  successful scaffold. Adding phase-demodulated line-of-sight-rate
  feedforward retained capture but worsened score and distance integral to
  `-0.118996` and `2.002387L`. Removing fitted carrier phase from the target
  bearing also retained the visible wake and capture, but delayed arrival to
  `17.094002T` and worsened score and distance integral to `-0.121357` and
  `2.006259L`. High phase correlation alone does not make target geometry a
  nuisance signal: response variables such as sway and yaw may be
  residualized, while the geometric route request should remain raw.

## Sole policy hypothesis

Promote the evaluated lateral-residual policy as this workspace's one
candidate. Preserve the anterior traveling-wave oscillator, raw target bearing
and raw-course anterior center, mean-preserving yaw observer, posterior
half-cycle steering, smooth acceleration bound, and one-sided speed guard.
On approach only, reconstruct the carrier's body-lateral sway from the
mean-removed anterior joint angle and velocity, subtract it from body-lateral
velocity, and add it consistently to relative crossflow before those response
cues enter posterior steering.

This is normalized, body-frame, reflection-equivariant, clock-free feedback
under the existing two-joint contract. The completed samples support repeated
nominal capture with the same connected wake and a small distance/arrival
improvement over the assigned prefill. They do not support an efficiency or
held-out robustness claim. Falsify reuse if capture or wake connectivity is
lost, the target-crossing arc changes materially, the residual remains
carrier-correlated, or the sampled load and saturation tradeoff grows.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-disturbance residual control
source_mechanism: preserve rhythmic propulsion while feedback acts on directional response after internally generated carrier motion is separated
transferable_invariant: remove beat-synchronous body-frame self-motion from a measured response before that residual drives bounded steering, while retaining raw body-frame target geometry as the route request
nontransferable_details: published gains, species or robot kinematics, dimensional beat frequency, exact vortex phase, prescribed routes, maneuver timing, and fitted coefficients outside this carrier and observation scale
policy_translation: on approach reconstruct carrier sway from centered anterior joint angle and joint velocity, then use residual lateral velocity and consistent relative crossflow only in posterior feedback while leaving the two-joint carrier and raw target bearing unchanged
falsification: reject if capture, distance integral, target arc, connected wake, residual phase separation, joint envelope, effort, force, or moment worsens beyond the sampled narrow tradeoff

## Evaluation boundary

No CFD result is claimed for this unevaluated workspace. Later evaluation
should require capture and the same top-down/oblique wake class first, then
compare arrival, scored and observed distance integrals, residual phase
correlation, joint contact, speed and acceleration residence, mean action, and
peak force/moment against the prefilled speed-guard carrier. A changed pose,
flow, carrier family, approach schedule, or observation filter remains a
held-out test that may invalidate the fitted observer.
