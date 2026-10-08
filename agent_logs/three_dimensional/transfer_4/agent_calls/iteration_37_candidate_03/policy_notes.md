# Closing-stride posterior positive-work governor

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned-parent notes and
  completed rollout, and all four sampled scores, observations, metrics,
  diagnostics, trajectories, and policies. Every evaluated case is a finite
  capture from direct uniform still water with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and no boundary or numerical failure. Two sampled
  v31 policies are byte-identical deterministic reruns; the remaining sampled
  mechanisms are v20 yaw-power relief and v26 slip-synchronous feathering.
- I inspected every sampled combined keyframe sheet and the assigned-parent
  v37 sheet from release through capture. In both the top-down mid-plane
  vorticity row and oblique Lambda2 row, the fish self-propels from rest, turns
  toward the target, and retains a coherent alternating traveling wake with
  compact three-dimensional posterior structures. The visually informative
  failure is therefore not wake breakup, passive advection, a wrong turn sign,
  or instability; it is v37's unsuccessful translation of a terminal-energy
  hypothesis despite preserving the useful wake and capture topology.
- Sampled v31 remains the scalar/closure reference at `18.0125T`,
  score/mean distance `-0.064000/1.950346L`, observed distance integral
  `1.336756L`, path/head cross-track `13.2149L/0.7327L`, and final
  alignment/speed/absolute yaw `0.1297/0.8806U/0.8077 rad/T`. It is a fast but
  oblique crossing, with near acceleration-ceiling residence of
  `69.29/75.89%` for the anterior/posterior joints.
- Sampled v26 shows that selectively reducing one posterior half-cycle can
  improve path, alignment, yaw, speed, and posterior ceiling residence to
  `13.2064L`, `0.1728`, `0.6545 rad/T`, `0.8623U`, and `74.11%`, but its
  observed integral and score regress to `1.336771L/-0.064149`. That supports
  phase-selective posterior relief as a physical channel, but inherited
  evidence rules out another slip-duty gain or phase-reset variant.
- The assigned-parent v37 closing-stride amplitude envelope also preserves
  the two-view wake and `18.0125T` capture. Relative to v31 it modestly improves
  path/cross-track and final alignment/speed/yaw to
  `13.2127L/0.7321L` and `0.1536/0.8743U/0.6775 rad/T`, but worsens mean
  distance/score to `1.950743L/-0.064492` and increases near
  acceleration-ceiling residence to `69.80/76.14%`. Contracting the oscillator
  amplitude target changes its phase-plane error and does not remove the
  measured actuator bottleneck. Another amplitude-floor or selector-threshold
  tune is not evidence-backed.

## Single policy hypothesis

Start from evaluated v31. Preserve its odd body-frame route controller,
state-feedback cadence, posterior lag and emphasis, phase-consistent reserve,
approach posterior relief, conserved mean-bend allocation, course-consensus
duty surface, half-cycle steering, and reversal-preserving rate governor. Reuse
only v37's dimensionless closing-stride event, but translate it into a
posterior positive-work governor: during a moving, misaligned approach with a
large fraction of remaining range closing per nominal beat, continuously
withdraw only the portion of the posterior drive acceleration whose product
with observed posterior joint rate is positive. Leave velocity-opposing
posterior commands, all steering acceleration, anterior drive, cadence,
amplitude target, mean curvature, posterior/anterior ratio, and lag unchanged.

This is a phase-invariant energy-allocation mechanism: changing stroke phase or
reflecting the lateral geometry preserves the positive-work classification and
scalar selector, while signed joint states and commands reflect. Expected
evidence is exact v31 output outside `2.10L`, retained capture and observed
closure, lower terminal posterior acceleration-ceiling residence and speed,
and better yaw/alignment without the amplitude envelope's increase in limit
residence. Falsify if any pre-approach output changes; capture is lost; arrival,
observed distance integral, path, or cross-track regress materially; the gate
acts while receding or aligned; deceleration/reversal or steering is weakened;
limit residence migrates forward; or either coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological terminal-approach gait modulation
source_mechanism: preserve a coupled traveling rhythm while sensory progress feedback withdraws propulsive energy input near the target
transferable_invariant: reduce only positive mechanical work during a high-closing-stride misaligned approach while retaining rhythm timing, traveling-wave lag, signed mean curvature, and reversal authority
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, linkage geometry, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: use normalized windowed closing speed times nominal period divided by remaining distance to scale only posterior drive acceleration aligned with posterior joint rate; leave anterior drive, posterior braking/reversal, steering, cadence, amplitude target, mean bend, and lag unchanged
falsification: reject if transit changes, capture or observed closure regresses materially, the gate acts while receding or aligned, posterior residence and terminal speed/yaw/alignment do not improve without forward load migration, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account. I ran its immutable
  checks directly. The guidance check initially exposed two identical copied-
  parent markers in the rendered workspace `README.md`; removing only the
  duplicate made the assigned parent unambiguous. The guidance-materiality and
  solver-boundary checks then passed.
- Julia is not installed, so the runner's executable include/action probe
  cannot run. No CFD was attempted. Static checks find one definition of each
  public function, cover all `70` direct `params.FIELD` references with the
  `72` fields returned by `target_policy_params`, confirm balanced delimiters
  and a nonempty candidate, and find no explicit elapsed time, step count,
  randomness, file I/O, cylinder observation, fixed target coordinate, or
  memorized-route input.
- Offline replay of the reflection-invariant closing-stride selector on the
  evaluated v31 trace gives exactly zero authority outside `2.10L`, while
  receding, and in the aligned corridor. It is positive on `68.27%` of
  approach samples. Combining it with normalized positive posterior power,
  using logged applied acceleration as a conservative reachability proxy,
  selects `34.77%` of approach samples, reaches `0.5807` withdrawal authority,
  and schedules a minimum positive-work scale of `0.7967`. Across v20, v26,
  and v37 the corresponding activity is `34.61%--36.55%` and minimum scale is
  `0.7956--0.8034`. These are selector reachability and boundedness checks on
  completed traces, not claims about the pending CFD response.
- Under lateral reflection, course alignment, closing stride, normalized
  posterior acceleration-rate product, withdrawal authority, and work scale
  are invariant, while posterior state, drive acceleration, and final command
  reverse sign. The gate is continuous at zero mechanical power and leaves all
  velocity-opposing posterior drive plus the separately added steering command
  untouched.
