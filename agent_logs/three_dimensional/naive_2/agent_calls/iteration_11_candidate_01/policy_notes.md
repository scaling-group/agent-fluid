# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled solver examples and both inherited assigned-parent
  evaluations are valid direct-uniform still-water rollouts with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. In every combined sheet,
  the top-down row develops body-connected alternating vorticity and the
  oblique row develops three-dimensional Lambda2 structures. The fish are
  self-propelled; the repeated `left_domain` terminations are navigation and
  terminal-allocation failures rather than passive advection.
- The sampled prefill, closest sample, mean-bend release, and best-score sample
  reach only `2.703L`, `2.595L`, `2.664L`, and `4.650L`, respectively. The
  closest sampled controller reaches `(8.861,12.092)L` at `17.462T` with both
  joints fixed at `-45 deg`; its visually strong upward curl is joint-limit
  dwell, not a usable final turn. The best scalar sample preserves a clean
  alternating wake but never comes inside `4.650L`, so score alone does not
  select a capture mechanism.
- The assigned-parent course-residual evidence is the useful far/middle
  control result: it reached `1.173L` with no `>40 deg` dwell and low normalized
  force/moment peaks, but crossed below the target at about `1.05L/T` and then
  escaped lower-left. Its inherited terminal mean-curvature handoff improved
  the minimum to `1.033L`; at closest approach the head is
  `(9.481,8.586)L`, velocity is `(-0.732,-0.777)L/T`, and distance is already
  reversing while both commands are about `-27.5 rad/T^2`. Instantaneous target
  bearing therefore turns too late to cancel the measured cross-target
  momentum.
- The next inherited common-mode-PD plus closing-speed carrier brake regresses
  to `2.167L` and visibly forms a hard terminal curl before a left exit. A
  separately sampled damped interception hold reaches `1.008L`, but at closest
  approach it is still moving down-left at `(-0.737,-0.692)L/T` with both joint
  accelerations near zero and then exits left. Across these results, further
  static-posture or drive-relief stacking is not supported: it changes effort
  and the exact miss but has not crossed the `0.75L` capture radius.

## Single candidate hypothesis

Preserve the inherited traveling-bend carrier, course-residual half-cycle
steering, and `3L` mean-curvature handoff. Change only the terminal geometric
request: subtract a bounded, observed body-velocity displacement from the
body-frame target vector before mapping it to mean bend. This one-response-
horizon intercept vector points against the impending lateral miss while the
ordinary target vector remains authoritative when speed is low or the gate is
inactive. The carrier is neither braked nor replaced by a posture, so the
alternating wake and recovery propulsion remain available.

Capture is the semantic success criterion. Weaker support is a minimum below
the inherited `1.033L` with a target-side return arc or a non-left termination.
Falsification is a minimum above `1.033L`, the same lower-left escape, a hard
terminal curl or persistent `40 deg` joint dwell, loss of the coherent wake,
or force/moment growth without capture.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and fish terminal prey capture
source_mechanism: preserve the propulsive rhythm while near-target geometry anticipates measured slip over a bounded response horizon
transferable_invariant: terminal steering should oppose the observed cross-target velocity early enough for body curvature to act, while continuing the traveling wave needed for control authority
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional response times, exact vortex phases, and prescribed capture routes
policy_translation: inside a smooth normalized-distance gate, form a body-frame intercept vector from target displacement minus bounded body velocity times a controller-owned horizon, then map its signed angle to the two-joint mean-curvature equilibrium while retaining course-residual carrier steering
falsification: no capture or closer pass, repeated lower-left exit, joint-limit dwell, load growth, or collapse of the alternating wake
