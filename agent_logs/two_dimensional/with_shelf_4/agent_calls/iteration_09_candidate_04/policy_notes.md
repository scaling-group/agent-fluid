# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above/right of the target while
  four developed cylinder streets merge around the second-row corridor. This
  is a common initial condition, not a reusable vortex phase or fixed route.
- Three sampled copies of the progress-qualified policy reproduce the strongest
  finite result: target capture after `137.357` released units, `4.184L` mean
  distance, `-10.914L` upstream head displacement, `90228` total command
  energy, and `14.75/303.02` RMS lateral force/yaw moment. The released sheet
  shows self-propelled upstream motion and a persistent posterior-lagged bend,
  but its path still has sharp beat-to-beat direction changes during the
  initial redirect and wake-corridor entry.
- The unqualified bearing-rate policy also captures, but later (`149.605`) and
  with worse mean distance (`4.358L`), relative crossflow (`0.13206`), and
  force/moment (`15.49/308.48`) than the progress-qualified result. Preserve
  positive-closing-speed qualification as an evidenced route mechanism.
- The inherited headroom-gated/slower-gait failure visibly closes into an
  upper-right loop and exits the top boundary after `126.428` units. It moves
  only `-1.116L` upstream and regresses from `8.610L` closest distance to
  `12.046L` final distance; feasible joint extrema and `317.27` RMS moment do
  not rescue lost route topology.
- Two newer sampled additive-residual tests preserve capture but regress the
  best route. Adding body-frame lateral target displacement delays capture to
  `159.302`, raises mean distance to `4.722L`, and raises force/moment to
  `15.35/308.25`. Adding an oppositely signed relative-crossflow residual takes
  `154.110`, raises mean distance to `4.687L` and force/moment to
  `15.85/310.83`, and does not reduce RMS relative crossflow (`0.13005` versus
  `0.12955`). These results argue against another parallel term in the shared
  turn sum.
- The best rollout already reaches `30.846 rad/time^2` anterior acceleration
  against the `31.416` cap, while the posterior maximum is `25.552`. More
  anterior amplitude, frequency, or additive steering authority is therefore
  not the supported next move; the posterior wave has the clearer measured
  allocation margin.

## Candidate hypothesis

Make one controller-mechanism change: distribute a small share of the existing
bounded `turn_request` into the posterior traveling-bend target on the requested
half-cycle. The anterior oscillator remains the route owner and retains its
evidenced half-cycle amplitude asymmetry. The posterior target keeps the same
base lag, but a state-inferred beat-side envelope gives the useful half-cycle
slightly more posterior emphasis. This is actuator allocation of an existing
body-frame route request, not another route, flow, or load residual and not an
external phase signal.

The expected formal test is retained capture and upstream propulsion with a
tighter initial redirect, lower mean distance, and no new anterior cap contact.
Falsify posterior sharing if capture is lost or delayed, mean distance or loads
rise, posterior acceleration reaches the hard cap, the alternating zero-mean
wave becomes a static bend, or a loop/boundary exit returns. CFD evaluation
occurs only after this worker exits, so these are tests rather than claims.

## Pre-evaluation actuator audit

A joint-only semi-implicit sweep (not CFD or rollout evidence) covered fixed
body-frame bearings from `-pi` to `pi`, signed bearing rates, zero/positive
closing speed, and normalized yaw moments through `+/-0.16`. The worst
anterior/posterior demands were about `23.1/21.3 deg`, `192/165 deg/time`, and
`1768/1550 deg/time^2`, within the `45/260/1800` envelope. This checks bounded
realization only; route shape, wake response, target capture, and loads remain
tests for the later formal rollout.

bookshelf_consulted: true
source_domain: elongated-body swimming and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve a traveling wave while placing a bounded share of turn asymmetry in posterior kinematics instead of concentrating steering in the anterior oscillator
transferable_invariant: target-directed half-cycle asymmetry can be distributed along a state-feedback traveling bend so posterior motion contributes to turning without replacing the zero-mean propulsive rhythm
nontransferable_details: published gains, dimensional beat settings, species amplitude envelopes, robot linkage geometry, clock phase, exact vortex phases, cylinder layout, and source-task routes
policy_translation: keep normalized body-frame bearing, progress-qualified bearing-rate damping, and direct normalized yaw-moment rejection unchanged; use joint-state beat side to apply a small bounded envelope to the existing posterior lagged target
falsification: reject if posterior sharing loses or slows capture, weakens upstream translation, raises distance integral, load, effort, or actuator-cap contact, destroys posterior lag, creates mean curvature, or recreates a sampled loop or domain exit
