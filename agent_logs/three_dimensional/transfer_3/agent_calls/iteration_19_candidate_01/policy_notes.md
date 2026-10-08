# Reproduced center-translation intercept release

## Evidence and visual diagnosis before candidate selection

- All four sampled rollouts are byte-identical evaluations of the current
  `v29` center-translation intercept policy. Each satisfies the frozen
  experiment contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics through 268
  moving-window shifts, and capture from `12.327720 L` at `25.118523 T`.
  They reproduce score `-0.5280772274`, mean distance `2.429087214 L`, and
  final distance `0.746135294 L` exactly, so they are replication evidence for
  one mechanism rather than four different mechanisms.
- I inspected the complete combined keyframe sheet, including every top-down
  mid-plane vorticity panel and every oblique body/Lambda2 panel from release
  through capture. The fish is self-propelled from quiescent flow: an
  alternating coherent wake develops behind the posterior body, follows a
  compact continuously closing arc, and subsides into a quiet held-bend glide
  near the target. Neither view shows passive advection, a loop, collision,
  domain-exit precursor, out-of-plane excursion, terminal thrashing, or
  numerical instability.
- All sampled keyframe sheets have the same SHA-256 and all sampled policies
  have the same SHA-256. Consequently this sample contains no distinct visual
  failure example to compare with the strongest finite rollout. The most
  informative inherited negative contrast is instead the completed `v31`
  head-point/line-of-sight predictor, for which only optimizer notes and score
  evidence are available here; no unmatched failure image is inferred.
- Telemetry supports preserving the outer carrier and settled terminal bend.
  The reproduced policy has no joint-stop dwell; inside `4 L` it issues no
  command above `30 rad/T^2`, with action maxima about
  `29.6048/26.7236 rad/T^2`, and inside `1.6 L` its maxima fall to only
  `0.09772/0.24610 rad/T^2`. The top-down and oblique wakes agree with that
  transition from productive propulsion to a stable terminal glide. The
  broader outer carrier does reach its declared `30.5433 rad/T^2` software
  bound frequently, but its wake and target path are already useful; without
  a completed allocation comparison, replacing its saturation structure
  would risk changing both propulsion and steering at once.
- The assigned-parent optimizer log records a genuine semantic test after a
  non-CFD replay: `v31` replaced the center-translation miss with a
  head-point estimate reconstructed from range closure and matched-window
  line-of-sight rate. Its gate changed 118 of 226 stored terminal commands,
  remained exactly inactive outside `1.6 L`, and retained the same `3.5%`
  release ceiling. The later CFD result nevertheless regressed to score
  `-0.5281959396` and final distance `0.746260285 L`, while retaining capture.
  Thus matching the predictor nominally to the head capture point did not
  survive coupled-flow evaluation; the rate reconstruction or its changed
  activation is not a justified replacement for the reproduced center-course
  invariant.

## Policy hypothesis

Promote the reproduced `v29` center-translation intercept policy unchanged as
the single candidate. Preserve its state-feedback oscillator, posterior lag,
target-angle redirect, closure preview, shared two-joint mean-curvature
equilibrium, helpful-crossflow and settled-response gates, and bounded paired
carrier release. The existing normalized body-frame target direction and
center velocity form a constant-velocity predicted-miss corridor; only a
small miss, positive closure, late proximity, helpful relative crossflow, and
settled joints permit the inherited `3.5%` release.

This is an evidence-backed conservative promotion, not scalar gain tuning.
The bookshelf was consulted because the lineage has repeated the same capture
topology across consecutive completed iterations. Its approach-hold and
coordinated-rhythm principles are already represented in the evaluated
candidate, while its possible yaw/slip damping, joint-role split, force
rejection, and phase-allocation translations are contradicted or unsupported
by the current evidence. Falsify this selection if another independent rollout
does not reproduce capture and the compact wake-supported trajectory, or if a
future independently gated mechanism improves semantic outcome, score, or
distance without changing the outer path, shared mean bend, release ceiling,
loads, stability, or wake coherence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve a coordinated traveling carrier and relax corrective allocation only after observed target-relative translation demonstrates a viable intercept
transferable_invariant: normalized body-frame target geometry and translational response may gate a bounded release without changing the established two-joint rhythm or mean bend
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, head lever arms, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: retain the evaluated center-velocity predicted-miss corridor as the sole optional condition on the small coupled terminal carrier release; do not adopt a new shelf primitive after the head-point rate reconstruction regressed
falsification: reject on non-reproduction, changed outer motion, delayed or lost capture, worse distance or miss, enlarged release, altered mean bend, renewed oscillation or joint stops, load growth, instability, or wake loss

The selected candidate's next CFD evaluation occurs only after this worker
exits and is not claimed as evidence here.

## Non-CFD validation

- The prescribed check-runner agent was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. Its three configured
  commands were therefore run directly and separately, without CFD.
- The guidance check initially exposed a rendered-workspace defect: the same
  assigned parent was marked as copied to `guidance/` twice in `README.md`.
  Removing only the duplicate marker made the semantic parent comparison pass.
- The lightweight Julia contract returns two finite accelerations with the
  frozen `L=64.0` observation adapter, and the solver boundary check passes.
  The selected policy remains byte-identical to all four reproduced best
  sample policies; this audit does not claim a new coupled-flow result.
