# Gait-frame target-projection candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and semantic `capture`.  Three are the reproduced
  v26 phase-neutral/allocation controller at `23.9305 T`, score `-0.55178099`,
  and distance integral `2.45000 L`.  The strongest finite rollout is the
  assigned parent's v27 common-mode derivative rejection at `23.6390 T`,
  score `-0.54450554`, and integral `2.44217 L`.
- I inspected both the top-down vorticity and oblique Lambda2 rows of the
  combined sheets for v26 and v27 from release through capture.  Both fish are
  visibly self-propelled from quiescent water: compact startup structures grow
  into coherent alternating posterior packets while the body follows one
  continuous target-signed arc.  V27 retains the wake topology and is only
  `0.006 L` farther away at `8 T` and `0.020 L` farther at `12 T`, then leads
  by `0.030 L` at `16 T` and `0.129 L` at `20 T` before capturing `0.292 T`
  sooner.  No sampled rollout has a failure termination; the inherited
  response-only redirect that approached to `2.4625 L` and exited left remains
  the semantic failure boundary, so completion-gated redirect release stays
  protected.
- Metrics show that v27's positive route result did not deliver its predicted
  actuator relief.  Relative to v26, mean/max speed increases from
  `0.546/0.784` to `0.553/0.810 L/T`, head/tail acceleration-limit residence
  increases from `31.60/14.02%` to `32.50/15.70%`, and any-joint residence
  increases from `45.62%` to `48.21%`; peak normalized planar force and yaw
  moment remain at the same startup-dominated `0.02974/0.01484` scale.  Thus
  the common-mode derivative correction improves late closure but still lets
  beat-scale pose enter proportional target steering.
- Reconstructing `bearing` and `vector_angle` from the v27 trajectory gives
  the missing observation boundary.  Within `0.55 T` carrier bins, either raw
  target angle has aggregate deviation `0.167 rad` and correlation `-0.927`
  with head-joint angle.  Applying the existing `0.40` carrier-yaw coefficient
  to head angle reduces that deviation to `0.068 rad`.  After subtracting the
  head-joint mean commanded by the inherited redirect, the same reconstruction
  still reduces it to `0.072 rad`, keeps the full-route mean within `0.012 rad`,
  and avoids misclassifying deliberate mean curvature as gait recoil.  The
  v26 control shows the same relationship (`0.163` to `0.070 rad`), so this is
  not a one-trajectory scalar fit.

## One-candidate policy hypothesis

Promote the evaluated v27 controller and add one consistent observation
mechanism.  Preserve raw body-frame geometry for the proven large-error
completion-gated redirect.  Use that redirect to estimate its commanded
head-joint mean, subtract the mean from observed `phi[1]`, and add the existing
bounded carrier-yaw estimate to proportional `bearing` and `vector_angle` as
well as their already corrected derivative.  Route feedback then sees a
gait-frame target direction while the state-feedback traveling wave, posterior
lag, redirect, half-cycle steering, and carrier-first projection are unchanged.

The expected outcome is to retain v27's late-route lead and capture while
reducing beat-frequency countersteering, peak speed, and acceleration-limit
residence toward the v26 envelope.  Falsify the mechanism if capture is lost
or later than `23.6390 T`, distance integral exceeds `2.44217 L`, the lead
after `16 T` disappears, the target-signed arc or alternating 3D wake loses
coherence, or speed, limit residence, normalized force, or yaw moment grows.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: separate observed carrier-scale body motion from persistent target-direction feedback while retaining the propulsive oscillator
transferable_invariant: target feedback should reject an observed gait-synchronous common mode without cancelling the deliberate mean curvature that produces route change
nontransferable_details: published oscillator gains, clocked CPG phase, robot geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed task routes
policy_translation: preserve normalized raw target geometry for redirect selection, subtract its expected bounded head-joint mean from observed joint angle, and use the existing joint-state carrier coefficient to project proportional bearing and vector-angle feedback into a gait frame under the two-joint state-feedback contract
falsification: reject if the projection does not preserve or improve capture and distance integral, fails to reduce oscillatory action or limit residence, or worsens route direction, wake coherence, speed, normalized force, yaw moment, or the inherited left-exit boundary

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer logs.  This candidate receives formal CFD evaluation only
after worker exit; no same-worker performance is claimed.
