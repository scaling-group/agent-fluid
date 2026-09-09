# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled solver examples and the three inherited assigned-parent
  evaluations are valid direct-uniform still-water rollouts with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their combined sheets
  show body-connected alternating mid-plane vorticity above and coherent
  three-dimensional Lambda2 structures below. Translation is self-propelled;
  the repeated boundary exits are controller failures rather than advection.
- The sampled `2.664L` and `2.703L` approaches retain productive alternating
  wakes but curl upward after the target-side approach and exit the upper
  virtual boundary. The higher scalar-score sample never comes inside
  `4.650L` and follows the same eventual upper-exit class. Scalar ranking,
  bend releases, and phase compensation therefore do not identify a terminal
  capture mechanism.
- The assigned-parent course-residual lineage is more informative. Its
  distance-only target-bearing mean-curvature handoff improved the evidenced
  `1.173L` near miss to `1.033L`, but the keyframes still show the fish crossing
  below the target and escaping left. Adding a positive-closing-speed carrier
  brake regressed to `2.167L` and produced a hard terminal curl. Replacing the
  terminal bearing with a fixed-horizon velocity-displaced aim reached only
  `1.158L`; its late top-down and oblique trajectory is nearly the same as the
  `1.033L` left escape. The latter two completed evaluations reject further
  stacking of static drive relief or fixed-horizon aim displacement.
- At the inherited near miss, speed remains about `1L/T`, the course error
  grows rapidly inside the last few lengths, and distance reverses before
  curvature can cancel cross-target momentum. The useful signal is not merely
  current proximity: body-frame target and velocity already define the signed
  constant-course miss and time to closest approach before the closest pass.

## Single candidate hypothesis recorded before editing

Preserve the evidenced state-feedback oscillator, posterior lag, and
course-residual half-cycle steering. Preserve the small mean-curvature carrier
centering that produced the `1.033L` approach, but recruit it with a smooth
collision-course gate: when positive body-frame target/velocity projection
predicts a closest approach within a bounded response horizon, the predicted
signed miss adds persistent mean-bend authority in proportion to its normalized
magnitude. The ordinary `3L` proximity gate remains a fallback, while a nearly
aligned approach receives no predictive intervention. This is one new
feedback mechanism, not scalar-only tuning or a route.

Capture is the semantic success criterion. Weaker supporting evidence is a
minimum below `1.033L`, a target-side return arc, or a better termination class
while retaining the alternating wake and low joint/load occupancy.
Falsification is loss of the inherited approach, the same lower-left escape,
an early false redirect on an aligned course, persistent `40 deg` joint dwell,
or force/moment growth without capture.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and fish terminal prey capture
source_mechanism: preserve a propulsive rhythm while terminal feedback acts early on observed cross-track motion rather than waiting for position error alone
transferable_invariant: target-relative course predicts signed miss and response time, so bounded persistent curvature should enter before closest approach without suppressing the traveling wave
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional response horizons, exact vortex phases, capture routes, and prey behavior
policy_translation: use normalized body-frame target and velocity to compute bounded time-to-closest and signed miss gates for the two-joint carrier mean, while preserving joint-state propulsion and course-residual half-cycle steering
falsification: no capture or closer pass, repeated left escape, false redirect on an aligned course, joint-limit dwell, load growth, or loss of the coherent alternating wake

## Dry validation only

A deterministic `24,300`-state grid spanning target side/fore-aft geometry,
body velocity, and both joint angles/rates produced finite commands inside the
smooth `30 rad/T^2` envelope with exact left/right reflection (maximum error
`0.0`). An aligned `8L` far approach is action-identical to the inherited
`1.033L` mean-curvature parent, while a closing `4.1L` cross-track-miss state
changes the action materially. Replaying the inherited trajectory through the
gate (without changing its CFD state) gives predictive authority about `0.53`
near `5L`, versus a negligible distance gate, and a smooth union with the old
handoff by `3L`. No CFD was run; the next formal evaluation must decide all
physical falsifiers.
