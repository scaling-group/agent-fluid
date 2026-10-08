# Closing-stride posterior-emphasis envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, the assigned v31 parent, all
  four sampled solver observations, metrics, diagnostics, trajectories, and
  policies, plus the inherited v37/v38 optimizer notes and completed rollouts.
  The four sampled policies and trajectories are exact v31 reruns, so their
  identical `18.0125T`, `-0.064000`, and `0.748395L` captures establish
  determinism rather than four independent controller mechanisms. Every
  rollout uses direct uniform still water with `U_infinity=(0,0,0)`, no
  prewarm, no cylinders, and no instability.
- I inspected the sampled v31 top-down vorticity and oblique Lambda2 sheets
  from release through capture, then compared both views with the inherited
  posterior-positive-work result. In both controllers the fish self-propels
  along a broad target-directed arc, and the posterior body and caudal fan
  leave an organized alternating wake with compact three-dimensional
  structures. There is no visible wake breakup, passive advection, route-sign
  reversal, boundary interaction, or out-of-plane failure. The informative
  failure is control-semantic: the positive-work gate preserves the same wake
  and capture but does not materially change the terminal carrier state.
- V31 is the closure/score reference: mean and observed distance integrals are
  `1.950346L` and `1.336756L`, center path is `13.2149L`, and capture occurs at
  only `0.1297` course alignment with `0.8806U` speed, `0.8077 rad/T` absolute
  yaw, and `69.29/75.89%` near anterior/posterior acceleration-ceiling
  residence. The remaining defect is a fast, cross-course terminal carrier,
  not inadequate transit propulsion.
- Three inherited progress-selected energy translations did not beat v31.
  Common amplitude contraction scored `-0.064492` and raised near ceiling
  residence to `69.80/76.14%`; posterior positive-work withdrawal scored
  `-0.064699` and left terminal alignment/yaw essentially unchanged at
  `0.1301/0.8088 rad/T`. A phase-invariant taper of only the posterior gain
  above the base traveling wave produced the clearest physical response:
  final alignment/yaw/speed improved to `0.1978/0.3096 rad/T/0.8554U`, path
  shortened to `13.2121L`, and near posterior ceiling residence fell to
  `74.24%`. Its broad closing-speed selector delayed capture to `18.0235T`
  and regressed mean/observed distance to `1.950923L/1.336854L`, so the
  envelope channel is useful but its approach-wide scheduling is not.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd route controller, joint-state
cadence, posterior lag, mean-bend allocation, course-consensus duty surface,
half-cycle steering, and reversal-preserving rate governor. Add one compact
terminal mechanism: taper only `posterior_wave_gain - 1` when the positive
windowed closing distance over one nominal beat is a large fraction of the
remaining normalized range. Keep the base posterior traveling wave, mean
tangent, frequency, phase lag, anterior oscillator, and steering untouched.

This combines the inherited selector that is weak in the outer approach and
strong below `1L` with the only recent envelope channel that materially
improved terminal yaw, alignment, speed, and posterior load. Offline projection
on v31 gives mean/max authority `0.197/0.633` inside `2.10L`, effective
posterior gain in `[1.061,1.167]`, and exact zero outside the approach, while
receding, or in the aligned capture corridor. Compared with the evaluated
speed/slip envelope, its mean authority is lower from `2.10--1.50L`
(`0.056` versus `0.075`) and higher below `1L` (`0.296` versus `0.226`).
Expected evidence is v31-like outer closure and arrival with the inherited
envelope's terminal-state and non-migrating posterior-load benefit. Falsify if
transit changes before `2.10L`, capture or observed closure regresses
materially, the gate acts during recession or an aligned approach, cadence or
lag changes, terminal alignment/yaw/speed and posterior ceiling residence do
not improve together, load migrates anteriorly, reflection fails, or either
coherent wake view deteriorates.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior-thrust allocation and sensor-modulated robotic-fish CPG control
source_mechanism: retain the traveling rhythm and posterior propulsion while sensory target progress continuously relieves only surplus tail excursion during terminal approach
transferable_invariant: preserve state-derived cadence, posterior lag, signed mean curvature, and the base traveling wave while reducing only excess posterior amplitude when one beat would close a large fraction of remaining range
nontransferable_details: published gains, dimensional beat frequencies, species-specific amplitude envelopes, linkage geometry, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: form a reflection-invariant closing-stride fraction from positive body-frame target closure, nominal period, and normalized remaining distance; taper only posterior_wave_gain above one during a moving misaligned approach
falsification: reject if pre-approach output or cadence changes, capture or observed closure regresses materially, the selector acts while receding or aligned, terminal alignment/yaw/speed and non-migrating limit residence fail to improve together, reflection fails, or either wake view worsens
```

## Lightweight validation after editing

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. I executed its immutable checks directly.
  The guidance check first found two copied-parent markers in the rendered
  workspace `README.md`; removing only the duplicate marker made the assigned
  parent unambiguous. The notes/material-guidance check and solver boundary
  check then passed.
- Julia is not installed, so the runner's executable include/action probe
  cannot run. No CFD was attempted. Static checks find exactly one definition
  of each public function, cover all `69` direct `params.FIELD` references
  with the `71` fields returned by `target_policy_params`, find balanced
  delimiters, and find no elapsed time, step counter, randomness, file I/O,
  cylinder input, fixed target coordinate, or memorized-route input.
- The envelope has an explicit inactive path that uses the original posterior
  gain exactly. Offline selector replay over the completed v31 trace gives
  zero authority outside `2.10L`; within the approach it is active on `68.27%`
  of samples, averages `0.1971`, peaks at `0.6325`, and keeps effective
  posterior gain in `[1.0613,1.1667]`. Algebraically, nonpositive closing
  speed, zero center speed, course alignment at or above the full-corridor
  threshold, and lateral reflection leave the expected inactive or invariant
  result. These are reachability and contract checks on completed evidence,
  not a performance claim for the pending CFD evaluation.
