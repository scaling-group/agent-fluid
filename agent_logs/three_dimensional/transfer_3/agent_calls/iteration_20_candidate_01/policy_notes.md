# Reproduced intercept policy after cadence-recovery falsification

## Evidence and visual diagnosis before candidate selection

- All four sampled solver folders are byte-identical evaluations of the
  `v29` center-translation intercept policy and satisfy the frozen Phase-2
  contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics through 268
  moving-window shifts, and capture from `12.327720 L` at `25.118523 T`.
  They reproduce score `-0.5280772274`, mean distance `2.429087214 L`, and
  final distance `0.746135294 L` exactly. The four copies are replication
  evidence for one controller, not evidence for four distinct mechanisms.
- I inspected the complete combined sheet for the reproduced policy and the
  inherited cadence-recovery regression, including the full top-down
  mid-plane vorticity row and oblique body/Lambda2 row from release through
  capture. Both fish self-propel from quiescent flow along the same compact,
  continuously closing arc. Each forms a coherent alternating planar wake
  and finite three-dimensional vortex packets, then enters a quiet held-bend
  glide. Neither view shows passive advection, a loop, a boundary-exit
  precursor, out-of-plane instability, wake collapse, or terminal thrashing.
  The small regression is not visually resolvable at sheet scale, so the
  terminal telemetry is decisive.
- The separately completed cadence candidate retained the same capture step
  but regressed to score `-0.5281246771`, mean distance `2.429124662 L`, and
  final distance `0.746185303 L`. Inside `1.6 L`, its mean speed fell from
  `0.6496241` to `0.6496076 L/T`, final speed fell from `0.6540152` to
  `0.6539744 L/T`, and peak lateral-force magnitude rose from about
  `0.0020942` to `0.0021453`, even though terminal command maxima fell from
  about `0.09772/0.24610` to `0.09643/0.24160 rad/T^2`. Thus recovering up to
  `3%` of the below-nominal cadence gap under the already validated intercept
  gate did not restore useful propulsion; lower command was not an
  improvement when closure and load worsened.
- The inherited head-point/line-of-sight reconstruction is a second completed
  negative contrast: it also retained capture at `25.118523 T` while
  regressing further to score `-0.5281959396`, mean distance `2.429180928 L`,
  and final distance `0.746260285 L`. Together these results support the
  directly observed center-velocity corridor and show that neither a rate
  reconstruction nor a second terminal propulsion modulation should be
  layered onto the stable glide without an independently evidenced deficit.

## Policy hypothesis

Promote the reproduced `v29` center-translation intercept controller unchanged
as the single candidate. Preserve its joint-state oscillator, posterior lag,
target-angle redirect, scalar closure preview, shared two-joint mean-curvature
equilibrium, helpful-crossflow and settled-response gates, normalized
constant-velocity miss corridor, `3.5%` coupled carrier release, and command
limits. The cadence experiment was active and exactly outer-noninterfering in
stored-state replay, but its completed CFD result falsified the proposed
propulsive benefit. The source therefore remains byte-identical to the four
sampled winners rather than adding another terminal gate or a scalar gain
change.

Falsify this conservative selection if a subsequent evaluation does not
reproduce capture and the compact wake-supported path, or if a genuinely
independent state-feedback mechanism improves a semantic outcome, distance,
or score without altering the outer trajectory, shared mean bend, bounded
release, loads, stability, or wake coherence. The selected candidate's next
CFD evaluation occurs only after this worker exits and is not claimed as
evidence here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and terminal capture control
source_mechanism: preserve a coordinated traveling rhythm while target-relative response gates only a bounded approach release; rhythmic frequency changes are separate interventions that require their own measured propulsion deficit
transferable_invariant: once normalized body-frame translation demonstrates a stable intercept, preserve the proven two-joint traveling-bend scaffold and use the smallest response-conditioned release that retains closure
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: retain the evaluated center-velocity predicted-miss corridor as the sole optional condition on the small coupled terminal carrier release; do not restore cadence after the active bounded cadence experiment reduced speed and worsened distance
falsification: reject on non-reproduction, changed outer motion, delayed or lost capture, worse distance or miss, altered mean bend or cadence, renewed oscillation or joint stops, load growth, instability, or wake loss

## Non-CFD validation

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account. Its three configured commands were
  therefore run directly and separately. The guidance semantic-difference
  check, finite two-joint Julia contract check, and solver boundary check all
  pass; no CFD was run.
- A separate deterministic schema audit finds all 77 direct `params.FIELD`
  references declared by `target_policy_params()`. The selected policy is
  non-empty and remains byte-identical to all four reproduced sampled winners.
