# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 flow contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. I inspected both rows of the combined keyframe sheets for the best
  finite capture and the lower-boundary failure, and checked the other two
  capture sheets for trajectory differences.
- The transferred seed is self-propelled, not advected. Its top-down row shows
  a strong alternating wake and initial progress, while the oblique Lambda2
  row retains organized three-dimensional caudal structures through failure.
  The fish nevertheless holds the wrong planar course: distance bottoms at
  `4.7800L`, then grows to `9.7089L` before lower-boundary exit. The inherited
  log identifies the causal sign mismatch: negative target requests produced
  positive posterior mean curvature.
- The bounded odd same-sign curvature map is the decisive sampled mechanism.
  It preserves the compact alternating wake and changes termination to capture
  at `23.353T` and `0.74968L`. Adding a policy-side copy of the evaluator's
  symmetric acceleration clamp produces exactly the same 4246-step trajectory
  and score, so redundant output bounding is not a semantic improvement.
- The prefilled course-aligned cadence candidate also preserves capture. Its
  trajectory is identical to the signed-curvature baseline until entry into
  the existing `2.10L` approach region. It then captures one integration step
  later at `23.3585T`, but crosses slightly deeper (`0.74697L`) and lowers mean
  distance from `2.41468L` to `2.41260L`, improving score from `-0.51791` to
  `-0.51528`. This is small positive terminal evidence, not evidence for
  changing the route controller or traveling-wave carrier.
- Inside `2.10L`, the prefilled rollout keeps mean target/velocity alignment
  at `0.960`, but beat-scale alignment falls as low as `0.858`; the signed
  target/velocity cross product spans `-0.514` to `+0.474` while recent yaw
  rate spans `-2.22` to `+2.43 rad/T`. Closing remains positive throughout
  (`0.569--0.754 L/T`). Thus the terminal defect is an oscillatory course/yaw
  excursion during otherwise reliable closing, not insufficient route-level
  steering or loss of thrust.
- Inherited optimizer logs rule out repeating large direct joint redirects.
  A closing-deficit velocity-course branch on the inverse-polarity seed
  improved closest approach from `4.780L` to `4.022L` but crossed to the upper
  boundary, while steering-reserve and geometry-burst variants also exited.
  The new residual is deliberately different: it is inactive before the
  already successful approach corridor, is speed-gated, has no direct joint
  equilibrium shift, and enters through the validated odd curvature map.

## One candidate hypothesis

Preserve the prefilled captured controller, including its state-feedback
traveling bend, posterior lag, signed mean-curvature steering, half-cycle
asymmetry, and course-aligned terminal cadence. Add one compact terminal course
damper: form the normalized signed cross product from the body-frame velocity
and target vectors, speed-gate it, ramp it continuously only inside `2.10L`,
and add the bounded residual to the final turn request before the existing
clamp. The signal is rotation invariant and changes sign under reflection.

On replayed prefill states, a gain `0.55` and cross scale `0.35` leave all
pre-corridor requests unchanged. Inside the corridor the residual has mean
`-0.014`, RMS `0.128`, and range `-0.316` to `+0.238`; at sampled distance
crossings it opposes the phase-contaminated baseline turn request. This replay
only bounds intervention size and is not new CFD evidence. The expected test
is preserved capture with smaller terminal course/yaw excursions, at least as
good an arrival and mean/final distance, and no material load or saturation
increase. Falsify the mechanism if capture is lost, progress slows, terminal
cross-track oscillation grows, or the coherent wake deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal target approach
source_mechanism: retain a propulsive oscillator while bounded observed course feedback damps near-target yaw and slip
transferable_invariant: once broad target-directed motion works, regulate signed target-course misalignment near capture without removing the traveling wave
nontransferable_details: published gains, dimensional beat settings, species kinematics, clock phase, exact vortex phases, and task-specific routes
policy_translation: use the normalized body-frame cross product of velocity and target, a bounded speed gate, and the existing distance gate to add a small reflection-equivariant residual through the two-joint odd curvature map
falsification: reject if capture, arrival, distance integral, load history, saturation, or wake coherence worsens relative to the sampled captured baseline
