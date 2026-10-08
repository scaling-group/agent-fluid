# Reproduced center-translation intercept candidate

## Current evidence and visual diagnosis before candidate selection

- All four assigned solver examples are byte-identical evaluations of the
  `v29` center-translation intercept policy. Each satisfies the frozen Phase-2
  contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite motion through 268
  moving-window shifts, and capture from `12.327720 L` at `25.118523 T`. They
  reproduce score `-0.5280772274`, mean distance `2.429087214 L`, and final
  distance `0.746135294 L` exactly. This is replication of one controller, not
  four distinct improvements.
- I inspected the complete combined sheet for the reproduced policy, including
  the top-down mid-plane vorticity row and oblique body/Lambda2 row from release
  through capture. The fish is self-propelled from quiescent flow: a coherent
  alternating wake develops behind the posterior body along a compact,
  continuously closing arc, followed by a quiet held-bend glide. Neither view
  shows passive advection, a loop, collision, boundary-exit precursor,
  out-of-plane instability, wake collapse, or terminal thrashing.
- I also inspected the inherited head-point-predictor regression as the most
  informative available failure of a controller hypothesis. Its two views are
  visually indistinguishable from the winner at sheet resolution and it still
  captures on the same solver step, but telemetry regresses to score
  `-0.5281959396`, mean distance `2.429180928 L`, and final distance
  `0.746260285 L`; final speed falls from about `0.654015` to `0.653932 L/T`.
  Replacing center-course response with nominally capture-point-matched
  line-of-sight kinematics is therefore not supported by coupled-flow evidence.
- The inherited cadence-recovery experiment is a second independently active
  negative result. Recovering up to `3%` of the below-nominal cadence gap only
  inside the same late intercept response regime preserves capture at
  `25.118523 T`, but worsens score to `-0.5281246771`, mean distance to
  `2.429124662 L`, and final distance to `0.746185303 L`. It also ends with
  slightly smaller commands than the reproduced candidate, so neither lower
  command nor more nominal cadence is evidence of better terminal progress.
- The current trajectory explains why a generic approach-yaw damper is unsafe.
  Below `1.6 L`, center speed stays within about `0.6464--0.6540 L/T`, predicted
  center-course miss contracts monotonically from about `0.685` to `0.228 L`,
  and head-range closure rises from about `0.684` to `0.7125 L/T`. At capture,
  head closure exceeds the entire center-speed magnitude while clockwise turn
  rate remains about `-0.317 rad/T`; the head sweep is contributing useful
  capture-point motion rather than exposing isolated excess yaw. Terminal
  commands remain below about `0.098/0.247 rad/T^2`, with no joint-stop dwell
  or saturation, so extra damping has no evidenced load or stability problem
  to solve.

## Candidate selection and falsifiable hypothesis

Keep the prefilled `v29` center-translation intercept controller unchanged as
the single Phase-2 candidate. Preserve its state-feedback oscillator,
posterior lag, target-angle redirect, scalar closure preview, shared two-joint
mean-curvature equilibrium, helpful-crossflow and settled-response gates, and
bounded paired carrier release. The existing normalized body-frame target
direction and center velocity define the constant-velocity predicted-miss
corridor; only a small miss, positive closure, late proximity, helpful relative
crossflow, and settled joint response permit the inherited `3.5%` release.

This is an evidence-backed promotion of the best reproduced mechanism after two
active semantic alternatives regressed; it is not scalar-only gain tuning.
Do not add yaw/slip damping, change to head-point prediction, restore cadence,
unload the shared mean bend, split joint roles, use beat-side authority, or add
instantaneous-force vetoes in this response regime. Falsify the selection if a
later independent evaluation fails to reproduce capture and the compact wake,
or if an independently gated mechanism improves semantic outcome, score, or
distance without delaying capture, changing the outer path or shared mean bend,
enlarging the release ceiling, restoring joint stops/saturation, increasing
loads, causing instability, or degrading either wake view.

bookshelf_consulted: true
source_domain: biological burst-redirect response, terminal capture control, and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve a proven traveling carrier and release corrective allocation only after measured target-relative response establishes a viable intercept; do not damp a response that is already producing capture-point closure
transferable_invariant: normalized body-frame target geometry, center velocity, range closure, and joint response can distinguish a useful approach hold from an unresolved turn without prescribing phase or route
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes and head lever arms, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: retain the reproduced center-velocity miss corridor and its small coupled release; treat head closure exceeding center speed during a settled bend as a boundary against adding terminal yaw damping or replacing the predictor with noisy line-of-sight reconstruction
falsification: reject on non-reproduction, lost or delayed capture, changed outer motion, worse miss or distance, reduced head closure, enlarged release or changed mean bend, renewed oscillation/joint stops/saturation, load growth, instability, or wake loss

The selected candidate's next CFD evaluation occurs only after this worker
exits and is not claimed as evidence here.
