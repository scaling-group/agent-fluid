# Evidence-identifiable multi-wake candidate

## Pre-selection visual and metric diagnosis

- The four sampled solver examples and the prefilled candidate contain the
  same policy, and their trajectory and combined-keyframe artifacts are
  byte-identical. Each completed rollout starts directly from uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. Each
  captures after `16.604496T` and 237 moving-window shifts, at
  `0.743958L`, with scored distance integral `1.998146L` and score
  `-0.113729`. The assigned population is therefore one reproducible nominal
  trajectory, not four independent response experiments.
- I inspected both rows of the combined sheet from release through capture.
  In the top-down row, the fish accelerates from rest, follows a shallow
  left/down target-closing arc, and leaves an alternating mid-plane vorticity
  street connected to the tail. In the oblique row, compact alternating 3D
  Lambda2 structures remain connected to the posterior body and traveled
  path. Zero imposed flow and the direct-uniform initialization make this
  self-propulsion rather than advection; neither view shows a collision,
  boundary exit, wake breakup, or instability precursor.
- The trajectory supports the visual diagnosis: distance falls from
  `12.3277L` to capture in 3019 steps, the final inertial velocity is
  `(-1.10010,-0.27006)U`, peak joint speed reaches the released
  `4.537856 rad/T` envelope, and final outward posterior acceleration is
  removed by the existing one-sided speed guard while reversal authority is
  retained. Capture occurs with finite force and moment and an intact wake,
  so neither the active final beat nor the narrow speed-limit contact is an
  independently diagnosed defect.
- There is no informative failed visual artifact in the sampled or available
  inherited sheets: all are the same successful image. The valid contrast is
  therefore limited to completed inherited metrics and notes. A
  closure-qualified yaw-response release preserved capture and arrived one
  integration step earlier, but worsened crossing depth, distance integral,
  and score to `0.744276L`, `1.998380L`, and `-0.114037`; a
  carrier-synchronous local-flow subtraction similarly regressed them to
  `0.745252L`, `1.999280L`, and `-0.115121` without a feasibility or load
  benefit. Line-of-sight-rate, bearing, moment, posterior-relief, and
  projected-corridor descendants also failed to improve the demonstrated
  capture.
- The assigned parent and inherited optimizer logs show more than three
  consecutive completed selections with neither a new mechanism nor a
  semantic improvement. This triggers the structured bookshelf review. Its
  traveling-wave carrier, bounded route asymmetry, response residual, and
  terminal-hold families are already implemented or have completed negative
  controls here; the current duplicate nominal evidence cannot identify a
  new error signal for another channel.

## Sole candidate and falsifiable hypothesis

Select the prefilled normalized body-frame two-joint controller byte-for-byte
as the sole candidate. It retains the demonstrated full traveling-wave
carrier, raw target geometry and anterior course center, mean-preserving yaw
and lateral-response demodulation, relative-crossflow feedback,
phase-compatible posterior steering, smooth acceleration bound, and narrow
one-sided joint-speed guard. No sibling candidate, scalar-only retune, or
unevaluated terminal/residual mechanism is introduced.

This is an evidence-constrained null translation, not a same-worker claim of
CFD improvement. The next evaluation should reproduce semantic capture, the
connected wake in both views, arrival, route cost, crossing depth, joint and
action envelope, force, and moment. Falsify preservation if that nominal
envelope fails to replicate. Reopen one compact bounded primitive only after
a completed nonduplicate or held-out pose, target, or flow trajectory exposes
a repeatable response deficit that the incumbent does not handle.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, sensor-modulated robotic-fish CPG direction tracking, wake-interaction control, and prey-capture control
source_mechanism: preserve a productive posterior-lagged rhythmic carrier and recruit separate bounded route, disturbance, or terminal feedback only for an observed response deficit
transferable_invariant: repeated carrier-correlated motion is not itself an error; retain an evidenced traveling carrier until nonduplicate body-frame observations identify a persistent route or response deficit
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, fixed capture schedules, wake geometry, and task-specific routes
policy_translation: retain the existing normalized two-joint carrier and response separation exactly because all current samples are one successful trace and completed terminal or residual perturbations regress route cost without improving feasibility or loads
falsification: introduce one bounded state-feedback primitive only after a nonduplicate or held-out rollout isolates its target error, and reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens

## Evidence boundary

All favorable and negative results above come from completed assigned or
inherited evaluations. The current candidate is unevaluated until this worker
exits. Artifact equality establishes deterministic nominal reproduction, not
robustness to a changed pose, target, inflow, or imposed wake, and the absence
of a failed image is not treated as an image-level comparison.
