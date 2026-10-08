# Carrier-rejected terminal-course candidate

## Visual and quantitative diagnosis before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, and capture. In every
  combined sheet, the top-down row shows self-propelled motion along the same
  broad target-directed arc with a strong alternating wake; the oblique row
  confirms coherent paired three-dimensional structures from release through
  capture. The sheets contain no current failure and no visible carrier
  breakup. The informative failure boundary is therefore inherited: replacing
  the carrier with opposite-sign static postures caused weak-wake upper exits,
  while the transferred carrier without enough redirect missed below.
- The target-relative course residual is the strongest joint outcome in the
  current sample. It captures at `23.881T`, improves score from the v22
  amplitude-relief parent's `-0.537462` to `-0.535986`, reduces mean scoring
  distance from `2.435490L` to `2.434313L`, and lowers near-target mean absolute
  yaw modestly while leaving the coherent wake intact. Its visual change is
  below keyframe resolution, so the numeric histories, not vortex appearance,
  are the supporting evidence.
- The alternatives do not justify replacing that path. The approach allocator
  is later (`23.925T`) and has worse mean distance (`2.435081L`) despite a small
  reduction in high-command exposure. The phase-compensated yaw brake arrives
  earlier (`23.760T`) but raises peak yaw to `3.472 rad/T`, mean absolute yaw
  inside `3L` to `1.865 rad/T`, and mean absolute cross-track speed inside `1L`
  to `0.539U`, versus `2.975`, `1.556`, and `0.360` for the course-residual
  policy. This is a speed-versus-control trade, not a clean improvement.
- The remaining course observation is strongly contaminated by the traveling
  beat. Inside `3L` on the course-residual rollout, target-relative cross-track
  speed has correlation `0.841` with anterior joint velocity; body-frame
  lateral velocity has correlation `-0.961` and fitted slope `-0.0826` with
  that same joint velocity. The corresponding lateral-velocity slope remains
  between `-0.0831` and `-0.0942` across the other three samples. As an offline
  signal diagnostic only, adding `0.083 * phi_dot1` to body-frame lateral
  velocity reduces near-target cross-track RMS from `0.261U` to `0.155U` and
  mean absolute value from `0.225U` to `0.129U`; it does not predict the new
  closed-loop trajectory.

## Policy hypothesis

Use the evaluated terminal-course policy as the sole carrier and preserve its
traveling-wave oscillator, same-sign C-bend, response release, amplitude
relief, and smooth physical-command projection. Change only the terminal-course
observation: subtract the sampled beat-synchronous component from body-frame
lateral velocity using anterior joint velocity, then form the line-of-sight
cross-track residual and translation-speed gate from that carrier-rejected
velocity. This retains target-relative course feedback but prevents the
residual from treating normal propulsive sway as route error; it adds no clock,
world route, mutable phase, or scalar-only gain probe.

Expect capture and both coherent wake views to survive, with lower terminal
cross-track/yaw motion or a lower distance integral than the uncorrected course
residual. Falsify the mechanism if capture is lost, arrival/mean distance
materially regresses, cross-track directness does not improve, or velocity-cap,
command, force, moment, or yaw histories worsen enough to offset any score gain.
The new CFD result is not available to this worker and is not claimed here.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish capture control
source_mechanism: preserve a stable propulsive rhythm while slow target-referenced direction feedback corrects route error rather than beat-synchronous sway
transferable_invariant: separate carrier-correlated lateral motion from persistent target-relative course error before applying a bounded terminal steering residual
nontransferable_details: published CPG gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phase, and prescribed source-task routes
policy_translation: use normalized body-frame velocity and anterior joint velocity to reject the sampled carrier component, then compute the existing proximity- and speed-gated line-of-sight cross-track residual for the two-joint state-feedback controller
falsification: reject if capture or coherent wake topology is lost, if terminal course/yaw does not improve, or if joint-limit, command, load, arrival, or mean-distance histories regress
```
