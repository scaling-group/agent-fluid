# Slip-synchronous posterior phase-reset candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled scores,
  observations, metrics, diagnostics, trajectories, and policies, plus the
  assigned-parent and sampled-worker notes. Every sample is a finite capture
  from direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and no boundary or numerical termination.
- I inspected every combined keyframe sheet, including the top-down vorticity
  and oblique Lambda2 rows from release to capture. The scalar-leading v31
  duty-ratio policy and the informative v26 slip-synchronous regression both
  visibly self-propel from rest, maintain a coherent alternating wake and
  compact three-dimensional posterior structures, and show no passive
  advection, standing reciprocal wiggle, wake breakup, or out-of-plane
  instability. The other two sheets have the same topology. The remaining
  distinction is therefore terminal transverse control, not propulsion
  creation.
- The sampled v20 reference captures at `18.0070T` with score/mean distance
  `-0.064028/1.950358L`, center path/head cross-track
  `13.2108L/0.7317L`, and final alignment/absolute yaw
  `0.1092/0.9840 rad/T`. Phase-free target-normal-power mean-bend allocation
  tightens path/cross-track to `13.1972L/0.7189L`, but does not improve
  alignment/yaw (`0.1036/1.1215 rad/T`). Balanced posterior duty-ratio
  modulation gives the best sampled score, `-0.064000`, but lengthens the
  path to `13.2149L` and only reaches `0.1297/0.8077 rad/T` terminal
  alignment/yaw.
- The slip-synchronous v26 policy is the only sampled variant with a clear
  joint terminal improvement: it raises final alignment to `0.1728`, lowers
  absolute final yaw to `0.6545 rad/T`, shortens the v20 path/cross-track to
  `13.2064L/0.7265L`, and reduces near posterior acceleration-ceiling
  residence from `75.83%` to `74.11%`, while preserving capture and both
  coherent wake views. Its whole-wave feathering nevertheless delays capture
  to `18.0125T` and regresses mean distance/score to
  `1.950469L/-0.064149`. This supports its measured slip/joint-phase selector
  but not attenuation of the entire posterior wave target.

## Single policy hypothesis

Start from the evaluated v26 route controller, odd curvature map,
state-feedback anterior oscillator, posterior lag and emphasis,
phase-consistent reserve, conserved forward mean-bend allocation,
half-cycle steering, and reversal-preserving rate governor. Retain its
reflection-invariant selector: normalized target-normal body speed times
normalized summed joint rate identifies the posterior half-cycle whose tail
motion reinforces cross-course slip. Replace only whole-wave amplitude
feathering with a bounded sensory phase-reset. While that selector is active
inside the established moving, misaligned approach, shift the instantaneous
posterior target opposite the signed cross-course motion. This asks the
posterior joint to reverse the counterproductive half-cycle sooner while
leaving nominal posterior wave gain, lag, cadence, mean bend, reserve, and the
opposite half-cycle unchanged.

The reset is continuous, exactly zero outside `2.10L` and at zero
cross-course motion, and reflection equivariant because target-normal speed,
summed joint rate, and the signed target shift all reverse together. Expected
evidence is v20/v26-class transit and wake coherence, retained capture, the
v26 terminal alignment/yaw improvement, and less distance-integral loss than
whole-wave feathering. Falsify if far/middle output changes; capture, mean
distance, or approach closure regresses materially; alignment, yaw, slip,
path, and non-migrating limit residence do not improve together; the reflected
response is not reflected; or either wake row deteriorates.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and phase-lag or wave-shape modulation
source_mechanism: use sensory feedback to advance the reversal of a counterproductive stroke while retaining the underlying rhythmic carrier
transferable_invariant: separate slow target geometry from observed joint-state phase and apply a bounded phase correction only to the stroke portion that reinforces lateral error
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: gate on normalized body-frame target-normal speed and normalized summed joint rate, then shift the posterior target opposite the signed slip only during the reinforcing approach half-cycle without scaling cadence, lag, mean bend, or nominal wave gain
falsification: reject if transit changes, capture or distance integral worsens materially, terminal slip/alignment/yaw/path do not improve together, actuator pressure migrates without benefit, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Running its immutable checks directly gives
  `PASS` for guidance materiality and `PASS` for the solver editable boundary.
  Julia is not installed, so the executable include/action smoke probe could
  not run. No CFD was run.
- Static checks find one definition of each public function, all `63` direct
  `params.FIELD` references covered by the `65` fields returned from
  `target_policy_params`, balanced delimiters, a nonempty candidate, and no
  explicit elapsed time, step count, randomness, file I/O, cylinder
  coordinate, target coordinate, or memorized route input.
- Offline replay of the new selector on the evaluated v26 trace leaves all
  `2,881` samples at or beyond `2.10L` at exactly zero reset. It activates on
  `50.25%` of the `394` approach samples; approach reset authority is
  mean/maximum `0.1055/0.4567`, and the posterior target shift has
  mean-absolute/RMS/maximum magnitude
  `0.01539/0.02670/0.06684 rad`. Algebraic reflection probes preserve
  selector authority and reverse both the signed reset and target shift.
  These establish selectivity, boundedness, and symmetry only; the CFD outcome
  remains pending for the next worker.
