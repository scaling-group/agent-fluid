# Approach-scheduled phase-space reserve candidate

## Visual and metric diagnosis before editing

All four sampled solver rollouts and the completed inherited rollouts report
direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
cylinders or prewarm, finite dynamics, and capture termination. I inspected
the combined keyframe sheets from release through capture in both required
views. The top-down rows show genuine down-left self-propulsion behind coherent
alternating mid-plane wakes; the oblique body/Lambda2 rows show compact,
body-connected three-dimensional vortex trains. The score-leading tail-only
residual, sampled directional allocator, inherited phase-space projection, and
assigned parent's posterior wave target keep this same topology. There is no
visible advection, wake breakup, boundary interaction, or instability, so the
carrier and far-field route are not the mechanism to change.

The synchronized traces distinguish terminal steering quality from wake
quality:

- the sampled directional allocator captures at `15.3385T/-0.01502` with
  `0.461L` head-relative constant-course miss, `0/0.681%` anterior/posterior
  `>40 deg` dwell, and `0.03959/0.01889` peak normalized planar force/moment;
- a fixed one-radian oscillator-phase angle projection captures on the same
  compact-wake route with better `0.421L` miss, zero angle dwell, and lower
  `0.03628/0.01798` loads, but arrives at `15.5850T/-0.02349`;
- the assigned parent's envelope-preserving posterior wave target reduces
  loads to `0.03506/0.01724`, but widens miss to `0.725L`, retains `0.174%`
  posterior dwell, and slows arrival to `15.8431T/-0.02283`.

Thus fixed phase-space projection is the only newest mechanism that improves
margin, both-joint reserve, and loads together, but its early use gives up
translation. The wave-target result falsifies posterior offset plus amplitude
contraction as the next margin mechanism. Earlier receiver shedding,
`previous_action`/analytic carrier-phase gates, line-rate steering, and static
bend changes also failed their joint margin/load boundaries, so this candidate
does not add another allocator threshold, carrier proxy, or gain-only change.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and continuous terminal approach scheduling
source_mechanism: preserve an autonomous traveling carrier while changing a bounded steering safeguard from broad approach behavior to near-target state feedback
transferable_invariant: keep productive rhythmic propulsion intact; introduce anticipatory joint-state protection only where measured approach geometry makes terminal margin the active objective
nontransferable_details: published gains, dimensional frequencies, hardware duty ratios, robot linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: retain normalized body-frame predicted miss and tail-first directional allocation; multiply the oscillator-normalized joint-angle look-ahead by the existing smooth body-frame distance gate so early predictive steering matches the faster directional allocator and near-target steering acquires the evidenced phase-space reserve
falsification: reject if capture or compact-wake routing is lost, terminal miss exceeds `0.461L`, either joint regains material `>40 deg` dwell, loads exceed about `0.040/0.019`, or arrival remains outside the `15.14--15.34T` class without a compensating margin improvement

## Single candidate hypothesis

Start from the sampled directional allocator and change one feedback
mechanism. The existing smooth near-target distance gate schedules the
phase-space angle projection continuously from zero to one oscillator-normalized
look-ahead. The earlier predictor therefore keeps the directional allocator's
translation, while the final approach anticipates outward joint motion and
restores capacity for inward motion. All carrier, target-relative steering,
response-plus-miss release, posterior pulse, residual magnitude, rate guard,
and acceleration-envelope terms remain unchanged.

Support requires capture with the direct compact wake, miss at or below the
directional baseline's `0.461L`, zero anterior dwell, posterior dwell at or
below `0.681%`, peak normalized force/moment no worse than approximately
`0.040/0.019`, and arrival back within `15.14--15.34T`. A later arrival is
acceptable evidence only if it improves the fixed projection's `0.421L`
margin without losing its zero dwell and lower load class. Formal CFD remains
deferred to EvE and is not evidence available to this worker.

## Dry validation boundary

The prescribed guidance-materiality, lightweight Julia contract/schema, and
solver editable-boundary checks pass without running CFD. A deterministic
`34,992`-state grid over normalized body-frame target/course geometry,
distance, heading response, both joint angles, and both joint rates produced
finite commands inside the owned `30 rad/T^2` smooth envelope with exact
left/right reflection (maximum error `0.0`). On a separate `8,748`-state
comparison, the scheduled policy changed `3,768` states from the directional
prefill (maximum command difference `3.17224 rad/T^2`) and `3,834` from the
fixed projection (maximum `1.40412 rad/T^2`). At `0.8L` its maximum difference
from fixed projection was only `6.15e-8`, while at `5L` its maximum difference
from the directional allocator was `0.00379 rad/T^2`, confirming that the
intended approach handoff is active. These algebraic checks do not establish
capture, wake, load, joint-history, or arrival improvement.
