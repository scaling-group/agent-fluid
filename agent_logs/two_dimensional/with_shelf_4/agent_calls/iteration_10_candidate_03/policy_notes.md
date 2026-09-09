# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and far to the right of
  the target while the four developed cylinder streets merge around the
  second-row capture region. This is the common release flow, not a reusable
  vortex phase, cylinder-dependent route, or candidate-specific advantage.
- Three sampled copies of the current progress-qualified policy reproduce the
  strongest finite result exactly. Their released sheets show a firm initial
  redirect, persistent alternating posterior-lagged propulsion, upstream wake
  entry, and capture after `137.357` released units. The matching metrics are
  `4.18356L` mean distance, `-10.9139L` upstream displacement, `90228.38`
  total command energy, `0.12955` RMS relative crossflow, and `14.75/303.02`
  RMS lateral force/yaw moment. This is self-propelled targetward motion, not
  passive downstream advection.
- The otherwise identical rate-only sampled predecessor also captures, but
  takes `149.605` units with `4.35835L` mean distance, `96932.99` energy, and
  higher crossflow/force/moment (`0.13206/15.49/308.48`). Preserve positive
  closing-speed qualification of bearing-rate damping, instantaneous bearing
  as route owner, and the established zero-mean half-cycle gait.
- The assigned parent's inherited posterior-sharing test is the most
  informative mechanism failure available in the current keyframes. Its sheet
  shows a much wider initial loop and longer lateral reversals before it enters
  the same wake corridor. Although it eventually captures, arrival regresses
  to `172.095`, mean distance to `5.81638L`, effort to `111777.57`, and
  force/moment to `16.39/322.27`; posterior acceleration also rises from
  `25.552` to `27.791 rad/time^2`. A separate inherited large-bearing relief
  of posterior phase lag likewise delays capture to `158.147`, raises mean
  distance to `4.69192L`, and raises effort/load. Both directions of direct
  posterior reallocation therefore damage the evidenced route.
- A direct opposing relative-crossflow residual is also a negative control:
  it delays capture to `154.110`, raises mean distance/energy to
  `4.68696L/99456.88`, and raises force/moment to `15.85/310.83` without
  reducing RMS crossflow. The best sheet still contains beat-scale kinks and
  material yaw load, but this result says not to append another unconditioned
  flow term. The anterior demand is already `30.846 rad/time^2` against the
  `31.416` cap, so more drive or additive steering authority is also
  unsupported.

## Policy hypothesis

Make exactly one mechanism change from the prefill: retain the existing direct
normalized yaw-moment residual, but smoothly relieve half of that residual
only when positive normalized windowed closing speed confirms useful
targetward translation. At zero or negative progress, the full evidenced
moment response remains available; under strong positive progress it retains
half authority instead of cancelling every wake-induced yaw. Instantaneous
body-frame bearing continues to own the route, and the sampled
progress-qualified bearing-rate damping, anterior half-cycle asymmetry,
oscillator, posterior lag, and tail tracking remain unchanged.

This is task-response conditioning of an existing disturbance loop, not a new
parallel route signal, a scalar-only gait change, or an assumed wake phase.
The expected formal test is retained capture and upstream translation with
fewer visible corridor kinks and lower distance integral, effort, or yaw load.
Falsify it if capture is lost or delayed beyond the `137.357` baseline, mean
distance or loads regress, the alternating traveling bend weakens, the moment
residual is needed during positive progress to hold the route, actuator-cap
contact increases, or a loop or boundary exit returns. CFD evaluation occurs
only after this worker exits, so these are expectations rather than results.

bookshelf_consulted: true
source_domain: wake-interacting biological swimming and sensor-modulated robotic-fish direction control
source_mechanism: preserve useful wake-induced motion by conditioning disturbance rejection on measured task response instead of cancelling all lateral load
transferable_invariant: persistent normalized body-frame target geometry should own the route, while a bounded fast-load residual may be reduced when normalized targetward translation verifies that the current response is useful
nontransferable_details: published gains, dimensional beat settings, species-specific kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend and progress-qualified bearing loop, then multiply only the existing normalized `moment_z_L2` residual by a smooth gate from positive normalized `window_closing_speed_L` with a nonzero lower bound
falsification: reject if moment-progress conditioning loses or slows capture, weakens upstream translation, raises distance integral, effort, load, or cap contact, destroys posterior lag, preserves the visible kinks, or recreates a loop or domain exit
