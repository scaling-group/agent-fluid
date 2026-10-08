# Course-consensus posterior duty-ratio candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned optimizer and
  solver parents, all four sampled policies, scores, observations, metrics,
  diagnostics, trajectories, combined keyframe sheets, and inherited worker
  notes. Every sample is a finite capture from direct uniform still water with
  `U_infinity=[0,0,0]`, no cylinders or prewarm, and the moving-window
  contract intact.
- Across both the top-down vorticity and oblique Lambda2 rows, all four fish
  visibly self-propel from rest and retain the same coherent alternating wake
  and compact three-dimensional posterior structures through capture. There
  is no passive advection, boundary interaction, wake breakup, standing
  reciprocal wiggle, or out-of-plane instability. The remaining differences
  are terminal control effects inside the last `2.10L`, not propulsion loss.
- The best sampled v20 yaw-power policy reaches capture at `18.0070T` with
  score/mean distance `-0.064028/1.950358L`, center path `13.2108L`, final
  alignment `0.1092`, final absolute yaw `0.9840 rad/T`, and `75.83%` near
  posterior acceleration-ceiling residence. The assigned solver parent's
  target-normal positive-work governor lowers the latter to `62.28%` and
  final absolute yaw to `0.8980 rad/T`, but delays capture to `18.0180T`,
  widens the path to `13.2426L`, lowers final alignment to `0.0855`, and
  regresses score/mean distance to `-0.064336/1.950623L`.
- The assigned optimizer parent's target-normal-power mean-bend allocator is
  essentially tied with v20 in arrival and score
  (`18.0070T`, `-0.064035`) and shortens path to `13.1972L`, but it does not
  supply the predicted terminal damping: final alignment/yaw are
  `0.1036/1.1215 rad/T`. Together with v24's whole-wave relief result
  (`-0.064407`, alignment/yaw `0.0975/1.2697 rad/T`), three placements of
  instantaneous target-normal power fail to improve distance integral and
  alignment/yaw together. The signal is a useful diagnostic but behaves as a
  carrier-phase-contaminated online selector in this gait.

## Single policy hypothesis

Start from the best sampled v20 controller and preserve its odd target-to-
curvature map, state-feedback anterior oscillator, posterior lag and emphasis,
phase-consistent reserve, alignment-qualified posterior envelope, half-cycle
steering, and reversal-preserving rate governor. Add one different actuator
primitive from the bookshelf: during only a moving, misaligned approach, use
agreement between the normalized signed target-versus-velocity course error
and the existing signed turn command to qualify a bounded posterior duty-ratio
modulation. The observed joint-rate phase strengthens one posterior half-cycle
and weakens the opposite half-cycle by the same bounded factor around unity.
It neither adds another course-error turn magnitude nor chronically suppresses
the posterior carrier.

The selector is exactly inactive at and beyond `2.10L`, at rest, or when the
route and course signals disagree. Lateral reflection reverses turn command,
course error, and tail-motion phase: the agreement authority and duty factor
remain invariant while the joint commands reverse. Expected evidence is
v20-identical transit and coherent two-view wake, retained capture and distance
integral, and a better joint terminal alignment/yaw/path tradeoff without the
posterior ceiling reduction being purchased by a chronic loss of closure.
Falsify if pre-approach output changes, mean duty authority is not centered,
capture or score regresses materially, terminal alignment and yaw do not
improve together, saturation migrates forward, reflection fails, or either
wake row deteriorates.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control
source_mechanism: use asymmetric flapping or duty-ratio modulation for turning while retaining the underlying rhythmic carrier
transferable_invariant: redistribute bounded posterior effort between observed opposing half-cycles around unity instead of adding a shared course-error bend or suppressing the whole propulsive wave
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame turn/course agreement only as an approach selector, then combine the existing odd turn command with observed normalized tail-rate phase to apply a bounded reflection-equivariant posterior-wave duty factor
falsification: reject if transit changes, duty is chronically one-sided, capture or distance integral regresses, alignment and yaw do not improve together, actuator pressure migrates, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. Running its immutable
  checks directly gives `PASS` for the repaired guidance-materiality check and
  `PASS` for the solver boundary. Julia is not installed, so the executable
  include/action smoke probe cannot run. No CFD was run.
- Static checks find one definition of each public function, all `66` direct
  `params.FIELD` references among the `68` fields returned by
  `target_policy_params`, balanced delimiters, a nonempty candidate, and no
  explicit elapsed time, step count, randomness, file I/O, cylinder or target
  coordinate, or memorized route input.
- Offline replay of only the new selector on the sampled v20 trace leaves all
  `2,881` samples at or beyond `2.10L` at exactly zero authority and a unity
  duty factor. It activates on `48.35%` of the `393` approach samples; approach
  authority is mean/maximum `0.1721/0.6425`, while the realized duty factor is
  mean/minimum/maximum `1.0031/0.9861/1.0187`. Algebraic sign probes confirm
  that lateral reflection preserves the agreement authority and duty factor,
  and that the factor remains within its configured `[0.84,1.16]` bound.
  These are selectivity and contract checks, not a claim about pending CFD.
