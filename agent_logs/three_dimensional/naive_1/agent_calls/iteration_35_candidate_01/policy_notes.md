# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned prefill and
  two executable-equivalent samples reproduce the exact `22.187000T` capture,
  `2.106255L` scored mean distance, and `-0.211504` score. The strongest sample
  captures at `22.159500T`, lowers mean distance to `2.105808L`, and improves
  score to `-0.211168`.
- Both rows of the strongest and assigned-prefill combined sheets were
  inspected from release through capture. Their top-down rows show
  self-propulsion rather than advection: an alternating red/blue caudal street
  grows by `4T`, remains attached along the smooth S-route, and persists into
  the target. The strongest sample's oblique row shows discrete three-
  dimensional Lambda2 packets through capture. The assigned prefill's oblique
  row is blank after its frame labels; its matching top-down trajectory and
  finite diagnostics make that a render failure, not evidence of wake collapse.
- The isolated positive change previews only the bounded slow anterior
  curvature request with a half-cycle, proximity-grown, clamped de-yawed
  target-line rate. It preserves the route at `4/8T` and improves distance at
  `16/20/22T` from `3.983/1.872/0.830L` to
  `3.980/1.861/0.818L`. Mean action falls slightly from `59.850` to `59.830`,
  peak normalized force/moment remain `0.030897/0.015839`, and anterior/tail
  rate-cap occupancy remains about `11.47/6.40%`. At capture, the sampled
  recent heading-rate magnitude also falls from about `0.472` to `0.121 rad/T`
  while full-error magnitude remains comparable; this supports response
  shaping rather than added thrust or authority.
- The assigned-parent log supplies a matched negative boundary: clipping the
  proximity-led posterior rudder prediction to release-only restores the
  slower `22.307997T/2.107401L/-0.212396` fixed-lead trajectory. Prediction is
  therefore not a generic low-effort release mechanism, and its established
  bidirectional rudder path must remain intact.

## One candidate hypothesis

Use the strongest sampled controller as the base. Preserve its through-water
course observation, proximity-previewed anterior curvature, low-speed carrier
recruitment, full body-frame target geometry, fixed-lead posterior recovery
allocation, independently proximity-led rudder, rudder sign and ceiling,
phase-selective carrier, terminal relief, and every actuator bound. Make one
feedback-path change from the assigned-parent hypothesis: use the same bounded
proximity-previewed full target-error magnitude to recruit or release the
existing phase-speed-qualified anterior redirect. Keep instantaneous normalized
target lateral displacement for redirect sign and retain the existing
`16 rad/T^2` ceiling.

This is coordinated predictive anterior steering, not scalar gain tuning. The
sampled controller moves its slow curvature center predictively while the
compatible anterior half-cycle redirect still waits for current full error.
Scheduling that residual from the same measured target-line evolution should
improve the `12--22T` route and terminal body response without altering launch,
the traveling carrier, posterior allocation, or authority. It uses only
normalized body-frame observations and joint-state phase; it adds no clock,
coordinate, route memory, target identity, modeled vortex phase, mutable state,
or force/moment residual.

Falsify the mechanism if capture is lost or not earlier than `22.159500T`,
scored mean distance is not below `2.105808L`, or score does not exceed
`-0.211168`. Also reject it if the unchanged pre-proximity route no longer
reaches about `11.300/8.629L` at `4/8T`, the `16/20/22T` sequence does not beat
`3.980/1.861/0.818L`, mean action materially exceeds `59.830`, rate-cap
occupancy exceeds about `11.47/6.40%`, peak normalized force/moment exceed
`0.030897/0.015839`, or a valid two-view sheet does not retain the alternating
three-dimensional wake. Any gain remains fixed-pose still-water evidence, not
robustness to changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and bounded asymmetric fish turning
source_mechanism: preserve a posterior-delayed traveling carrier while measured route evolution schedules a phase-qualified anterior steering residual
transferable_invariant: a slow body-frame target-line response can recruit or release a bounded phase-qualified steering path without increasing its authority or replacing the propulsive rhythm
nontransferable_details: published gains, dimensional frequencies and speeds, species-specific envelopes, distributed-body kinematics, robot calibration, source prediction horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use the sampled proximity-previewed full target-error magnitude only on the existing anterior redirect gate while retaining instantaneous body-frame target side for sign and all completed carrier, recovery, rudder, relief, and authority limits
falsification: reject if capture is not earlier than 22.159500T, mean distance is not below 2.105808L, or route, valid two-view wake, effort, saturation, force, or moment envelopes worsen
