# Wake-policy candidate notes

## Evidence and visual diagnosis before editing

- The assigned parent guidance and inherited optimizer logs identify the
  common `0.55T` joint-state carrier plus shared half-cycle asymmetry as the
  useful propulsive/steering scaffold. They also supply two concrete negative
  boundaries: persistent posterior or equal-joint mean curvature preserved the
  upper exit while weakening translation, and a course-divergence gate without
  phase-compensated response regressed to `12.071L` minimum, `12.419L` final,
  and an upper-boundary exit at `8.69T`. Neither mechanism should be restored
  as an always-on bias or substituted for the evidenced carrier.
- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm, no cylinders). Their top-down sheets show
  self-generated alternating vorticity, and their oblique sheets show
  body-connected three-dimensional Lambda2 structures. Translation is
  self-propulsion rather than advection, and no sample is numerically unstable.
- The phase-compensated response controller is a semantic improvement over the
  other three samples even though the coarse termination label remains
  `left_domain`. It keeps center y within `12.709--14.019L`, travels until
  `27.43T`, exits through the left boundary at center `x=0.800L`, and reaches
  `3.174L`; the other samples rise to center `y=15.20L`, leave through the
  upper boundary by `9.25--10.41T`, and get no closer than `9.527L`. Its
  top-down wake remains coherent through the long targetward passage and the
  oblique row retains staggered tail-connected structures, so the gain is not
  bought by wake collapse or passive drift.
- The remaining miss is visible and geometric. At closest approach the best
  fish has already passed the target in x while its head remains near
  `y=12.66L`; the target is approximately `(-1.62,-2.73)L` in body coordinates,
  bearing is about `-1.03 rad`, body velocity is about `(-0.83,+0.53)U`, and
  world speed remains about `0.98L/T`. Its wrong-side-slip gate therefore puts
  half-cycle steering near full authority, yet the fish continues past the
  target and later exits left. More half-cycle gain is not a new mechanism;
  the evidenced need is a stronger course-changing actuator that releases on
  measured body response.

## Single candidate hypothesis

Restore the sampled phase-compensated response controller exactly as the
carrier and cruise/redirect scaffold. Add one C-start-like, response-gated
posterior-curvature mechanism: large normalized body-frame bearing opens a
bounded mean-curvature contribution to the lagged posterior target, while the
product of bearing and phase-compensated yaw residual releases that curvature
as soon as yaw develops toward the requested side. Small error, correct yaw
response, or zero target request therefore returns continuously to the
evidenced traveling bend; no clock, route, fixed direction, or raw-yaw brake is
introduced. This tests a distinct actuator channel only where the sampled
half-cycle channel was already saturated.

Falsify the candidate if it fails to beat the `3.174L` closest approach or
produce capture/a more useful terminal topology, if it reinstates the early
upper-boundary exit, if posterior bias suppresses the alternating traveling
wake or leftward propulsion, or if joint-limit occupancy and force/moment
loads worsen enough that any geometric gain depends on persistent clipping.

```text
bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a large observed direction error recruits a bounded curvature redirect, then measured turn response releases it back into the propulsive rhythm
transferable_invariant: normalized body-frame error may gate a stronger actuator channel only while phase-separated body response has not aligned with the requested turn
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific C-start shapes, maneuver timing, duty ratios, exact vortex phases, and task-specific routes
policy_translation: preserve joint-state traveling-bend and shared half-cycle steering, add bounded posterior mean curvature gated by absolute bearing, and release it with the reflection-invariant product of bearing and carrier-phase-compensated yaw residual
falsification: reject if closest approach does not beat 3.174L, terminal topology is not more useful, or propulsion, wake coherence, actuator occupancy, or loads deteriorate
```

## Dry validation only

The mandated guidance-semantic, policy-contract, and editable-boundary checks
pass. A `6,075`-case joint/target/response grid produced finite actions below
the configured `30 rad/T^2` smooth envelope and exact left/right reflection
(`max_error=0.0`). At bearing `+1.0 rad`, the new curvature gate is `0.977`
with zero or wrong-way residual yaw and releases to less than `0.0001` for a
strong correct-way residual. These checks establish schema, boundedness,
symmetry, and gate semantics only; post-worker CFD must decide the trajectory,
wake, load, and capture falsifiers above.
