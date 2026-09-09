# Multi-wake candidate diagnosis

## Evidence read before the edit

- The assigned parent and current candidate are the common target-blind seed;
  no inherited optimizer log exists in this workspace, and the only sampled
  solver is the finite `left_domain` failure `solver_4b03cd285d3a`. There is
  therefore no successful sampled comparator.
- The shared prewarm sheet shows the held fish above and to the right of the
  target after the four asymmetric vortex streets have developed. In the
  released sheet, the fish initially travels toward the target from the upper
  right, then rotates to an almost vertical downward attitude, never enters the
  target/wake corridor, and exits through the lower boundary.
- The trajectory briefly reduces distance to `8.615L`, but ends at `12.123L`
  after only `50.127` release-time units with just `0.0243` progress. The mean
  vertical fish velocity (`-0.263U`) nearly equals mean local vertical flow
  (`-0.241U`), so most of the terminal descent is passive advection rather than
  target-directed swimming. RMS relative crossflow is `0.175U`, and RMS lateral
  force/moment are `21.94` and `541.70` in the recorded diagnostic units.
- Both joints reach the `260 deg/time` velocity limit and `1800 deg/time^2`
  acceleration limit. The seed's `28 deg`, `0.55`-period oscillator itself asks
  for roughly `319 deg/time` peak velocity and `3664 deg/time^2` harmonic
  acceleration before posterior tracking, leaving no authority for steering.

## Policy hypothesis

Keep the seed's clock-free traveling-bend structure, but center both joint
motions on a bounded mean-curvature bias derived only from body-frame target
bearing. Increase the period and reduce amplitude enough that the nominal
anterior gait stays inside the measured actuator envelope. This is one
target-vector-to-curvature mechanism, with actuator headroom as a prerequisite,
not a wake-phase command or scalar-only gain sweep.

Expected result: the fish should retain the initial useful diagonal approach,
prevent persistent crossflow-induced bearing error from turning into a vertical
domain-exit trajectory, and keep joint velocity/acceleration below their hard
limits. The post-worker evaluation should falsify the proposal if it preserves
the same lower exit, loses the initial distance reduction through inadequate
propulsion, turns with the wrong sign, or still saturates either joint.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and fish turning by biased undulatory curvature
source_mechanism: sensor-driven mean-curvature bias superposed on a traveling bend
transferable_invariant: persistent body-frame target error should create a bounded average bend while posterior lag preserves directional propulsion
nontransferable_details: published controller gains, species-specific amplitudes, exact gait frequencies, vortex phases, and task routes
policy_translation: map normalized body-frame bearing through a smooth bounded bias; center both two-joint state-feedback motions on that bias while retaining posterior lag
falsification: reject if the turn sign is wrong, closest approach worsens, the same lower-boundary exit remains, propulsion collapses, or joint saturation persists
