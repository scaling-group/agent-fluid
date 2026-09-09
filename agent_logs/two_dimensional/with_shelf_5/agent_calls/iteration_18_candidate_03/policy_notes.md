# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish in the upper-right and
  four mature, interacting vortex streets around the second-row target. It is
  common initial-condition evidence, not support for a candidate-specific
  route or vortex phase.
- Every sampled released sheet terminates in target capture, so no sampled
  failure keyframe exists. The inherited naive-seed lower-boundary exit is
  retained only as metric-backed historical context. The useful visual
  contrast is the assigned solver prefill (`solver_db159861677d`) against the
  inherited optimizer's completed response-gated candidate
  (`solver_f878079fe7ba`).
- Both contrast sheets visibly make the decisive downward-left redirect, then
  sustain a compact upstream-left trajectory into the interacting wake region
  without collision, domain exit, or a route-scale reversal. The fish is
  self-propelled rather than merely advected: in `f878`, mean streamwise body
  velocity is `-0.27764` versus mean local flow `-0.15323`, a roughly
  `0.12441` relative upstream component consistent with the recorded wake
  diagnostics.
- The current prefill is byte-identical to `db159`. Its outward joint-rate
  guard reaches in `40.6450`, with mean distance `1.97860L`, command energy
  `52092.6`, and RMS crossflow/force/moment
  `0.22477/64.70/875.97`. Both joints still touch the configured rate and
  acceleration caps. This supports the inherited warning against another
  cap-threshold or scalar guard edit.
- The inherited step-17 notes identify `solver_df084fc68237` as the evaluated
  sign-coherent carrier and predict that observed-response completion could
  release only auxiliary posterior asymmetry. The completed `f878` rollout
  now validates the useful part of that hypothesis: it preserves the
  `39.1104` capture time while reducing command energy from `50060.7` to
  `50044.8`, RMS force from `57.21` to `54.19`, and RMS moment from `783.64`
  to `754.87`. Its mean distance changes only from `1.91494L` to `1.91533L`.
  Maximum joint excursions do not improve and both rate and acceleration caps
  remain reached, so the result supports semantic auxiliary release but not
  actuator-envelope relief.
- The `f878` and `db159` keyframes share the same direct trajectory topology;
  the material distinction is lower integrated effort and wake load on the
  coherent response-gated carrier. No sampled evidence calibrates a force,
  moment, or crossflow sign history well enough to justify a new disturbance
  residual.

## Policy hypothesis before the edit

Use the evaluated `f878` response-gated, route/current-coherent policy as the
carrier and add exactly one mechanism: an alignment-conditioned propulsive
gait envelope. Form separate smooth alignment gates from the persistent-route
and current normalized turn requests. Preserve the carrier exactly whenever
either request is appreciable, including the entire large-error redirect and
every sign-conflicting fast correction. When both requests are small, ease the
oscillator amplitude continuously; fade this additional relief with the
existing approach blend so it does not compound terminal coasting. Keep the
posterior lag, half-cycle agreement selector, response-completion release, and
all steering biases unchanged.

Expected evidence is the same direct target-reaching topology and near-parent
arrival, with lower command energy, force, moment, excursion, or cap contact
during aligned transit. Falsify the mechanism if capture is lost or materially
delayed, if the early redirect changes, or if no effort/load/excursion/cap
measure improves over `f878`. If falsified, do not tune the alignment width or
amplitude floor; preserve the response-gated carrier and first obtain
time-resolved calibration before testing a wake-disturbance residual.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: retain strong bounded steering while target error is large, then reduce the rhythmic gait envelope after observed direction alignment
transferable_invariant: propulsive rhythm and redirect authority should remain intact until both persistent and immediate body-frame route errors agree that correction is complete
nontransferable_details: robot duty ratios, published gains, species-specific C-start shapes, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: preserve the evaluated two-joint carrier and response-gated posterior asymmetry; smoothly ease only oscillator amplitude when both normalized route and current turn requests are small, while fading the extra easing in the terminal approach regime
falsification: reject if direct capture or the early redirect degrades, or if effort, load, excursion, and cap evidence do not improve over the evaluated response-gated carrier

## Pre-evaluation verification

- The required guidance semantic check passes with a material revised lesson
  relative to the assigned optimizer parent.
- The solver editable-boundary check passes; the only changed solver file is
  `candidate_target_policy.jl`, so this workspace contains exactly one
  downstream candidate.
- Static schema validation finds all `15` distinct direct `params.FIELD`
  references among exactly the `15` fields returned by
  `target_policy_params()`. The added alignment relief is bounded to `[0,0.1]`
  by its owned amplitude-floor parameter and two smooth `[0,1]` body-frame
  alignment gates; every large-error state for which either gate is zero uses
  the evaluated carrier amplitude exactly.
- The lightweight Julia include check specified by the check runner was
  invoked, but this image has no `julia` executable (`command not found`, exit
  `127`). No formal CFD was run; EvE will evaluate this candidate after the
  worker exits.
