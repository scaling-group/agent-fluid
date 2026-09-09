# Response-gated terminal-curvature release

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm). Their combined sheets show
  self-propulsion: alternating body-connected mid-plane vorticity is paired
  with compact three-dimensional Lambda2 structures. The three failures keep
  producing a wake but curl into upper/left boundary exits after minima of
  `2.595L`, `2.664L`, and `4.650L`; missing thrust or passive advection is not
  the common failure.
- The assigned parent changes the semantic class to capture at `16.011T` and
  `0.748L`. Its top-down row follows a shallow target-directed path rather than
  the large post-miss arcs, while the oblique row retains the posterior wake
  through capture. Numerically it also retains reserve: maximum joint angles
  are `37.4/36.6 deg`, and peak normalized planar force/moment magnitudes are
  only `0.030/0.017`. This is positive evidence for preserving the traveling
  carrier, course-residual steering, and predicted-miss mean curvature.
- The useful remaining weakness is confined to the final response. At
  `1.174L` the target/course prediction is already within about `0.53L`, while
  same-sign yaw response is about `2.30 rad/T`; at capture the predicted miss
  remains about `0.57L` and yaw response is about `1.39 rad/T`. Yet the parent
  keeps the full persistent mean-curvature request, with final commands about
  `-28.8/+23.5 rad/T^2`. The fish captures, but curvature is not released when
  the observed turn has already put the course inside the terminal corridor.
- Inherited logs make the boundary important. Static posture, closing-speed
  braking, fixed-horizon aim displacement, and wrong-sign terminal bend all
  failed before the predicted-miss parent. This candidate therefore does not
  add braking, replace the carrier, or change the established prediction.

## Single candidate hypothesis recorded before editing

Preserve the captured parent exactly outside the terminal response. When the
ordinary terminal gate is active, the predicted course lies inside a smooth
controller-owned miss corridor, and measured yaw rate has the same sign as the
requested turn, release only a bounded fraction of the persistent mean bend.
Never reverse it and never attenuate the traveling carrier or half-cycle course
steering. The expected effect is a less over-driven final crossing without
changing the parent route or wake.

Primary support remains capture, preferably earlier than `16.011T` or with a
higher score. Secondary support is capture with lower final command/yaw
occupancy and the same low loads. Falsification is any loss of capture, later
arrival without a physical-quality gain, early release while predicted miss
is outside the corridor, loss of the coherent alternating wake, joint-limit
dwell, or materially higher force/moment.

bookshelf_consulted: true
source_domain: biological C-start response-gated redirect and sensor-modulated robotic-fish CPG turning
source_mechanism: recruit bounded curvature for a measured directional error, then release toward the propulsive rhythm once useful heading response appears
transferable_invariant: persistent target-relative curvature should diminish continuously when observed same-sign yaw has put the predicted course inside the terminal corridor, without suppressing the traveling wave
nontransferable_details: species-specific C-start shape, published gains, clock phase, dimensional response rates, exact vortex phase, robot linkage geometry, and task-specific routes
policy_translation: use normalized body-frame predicted miss, normalized distance gating, and observed heading rate to attenuate only a bounded share of two-joint mean curvature; retain the joint-state carrier and half-cycle course steering
falsification: capture loss, later arrival without lower terminal occupancy, off-corridor release, route change before the terminal response, joint/load growth, or wake collapse

## Dry validation only

The required guidance-materiality, Julia contract, declared-parameter, and
editable-boundary checks pass. A deterministic `102,060`-state grid spanning
target side and distance, body velocity, both joint states, and yaw response
produced finite commands within the smooth `30 rad/T^2` envelope with exact
left/right reflection (maximum error `0.0`). Replaying the captured parent
trajectory through both policies, without changing its CFD state, makes the
new action differ by more than `0.01 rad/T^2` only from `14.636T` onward; its
maximum difference is `2.797 rad/T^2`, while the maximum difference at
distance at least `2L` is only `0.0011 rad/T^2`. A same-sign terminal probe
activates the release, while reversing yaw direction leaves the parent action
unchanged. These are semantic and scope checks, not evidence of physical
improvement; post-worker CFD must decide capture, arrival, wake, joint, and
load falsifiers.
