# Slip-synchronous posterior phase-reset candidate

## Evidence and two-view diagnosis before editing

- All four sampled evaluations are finite captures from direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm, no
  cylinders, and no numerical or boundary termination. The assigned prefill
  is the v25 target-normal-power mean-bend allocator
  (`18.0070T`, score/mean distance `-0.064035/1.950361L`).
- I inspected the combined sheets for the scalar-leading v31 duty-ratio
  controller, the informative v26 slip-synchronous regression, and the
  assigned v25 prefill, reading both the top-down mid-plane vorticity row and
  the oblique 3D Lambda2 row from release to capture. In every case the fish
  advances from rest toward the target while a coherent alternating wake
  develops behind its posterior body and caudal fin. The oblique structures
  remain compact and three-dimensional, with no passive advection, reciprocal
  standing wiggle, wake breakup, or out-of-plane instability. At the keyframe
  cadence the three wakes and routes are visually almost indistinguishable;
  their useful distinction is terminal phase/attitude behavior in the traces.
- The v20 reference captures at `18.0070T` with score/mean distance
  `-0.064028/1.950358L`, center path `13.2108L`, and final
  alignment/absolute yaw `0.1092/0.9840 rad/T`. The assigned v25
  force-power selector shortens the path to `13.1972L` but worsens final
  alignment/yaw to `0.1036/1.1215 rad/T`, so a phase-free hydrodynamic
  power gate on mean-bend placement is not supported as terminal damping.
- The v26 slip/joint-phase selector improves final alignment/yaw to
  `0.1728/0.6545 rad/T`, shortens the v20 path to `13.2064L`, and lowers
  near posterior acceleration-ceiling residence from `75.83%` to `74.11%`;
  however, attenuating the whole posterior wave delays capture to `18.0125T`
  and regresses mean distance/score to `1.950469L/-0.064149`. The v31
  centered duty-ratio alternative reaches the best sampled score,
  `-0.064000`, but lengthens the path to `13.2149L` and ends at only
  `0.1297/0.8077 rad/T` alignment/yaw. Together these results support the
  kinematic slip/phase selector, while leaving open how to act on it without
  shrinking useful wave authority.
- The inherited optimizer log proposes that missing actuator translation and
  establishes selectivity without claiming CFD performance: replay on the v26
  trace leaves all `2,881` samples at or beyond `2.10L` at exactly zero,
  activates on `50.25%` of `394` approach samples, limits the posterior
  target shift to `0.06684 rad`, and reverses the signed response under
  lateral reflection.

## Single policy hypothesis

Use the evaluated fast-route controller, odd target-to-curvature map,
state-feedback anterior oscillator, posterior lag/emphasis, phase-consistent
reserve, conserved forward mean-bend allocation, half-cycle steering, and
reversal-preserving rate governor. During only the moving, misaligned
approach, use agreement between normalized target-normal body speed and
normalized summed joint rate to identify a posterior half-cycle that reinforces
cross-course slip. Shift the instantaneous posterior target opposite that
signed slip. This is a bounded sensory phase reset intended to advance only
the counterproductive reversal; it does not scale cadence, nominal posterior
wave gain, lag, total mean bend, reserve, or the opposite half-cycle.

The controller remains continuous and reflection equivariant: the phase gate
is invariant when lateral observations and joint motion reflect, while the
signed target shift reverses. Expected evidence is unchanged far/middle
output, retained coherent propulsion and capture, v26-like terminal
alignment/yaw improvement, and less distance-integral loss than whole-wave
feathering. Falsify if transit commands change; capture, closure, or mean
distance regress materially; terminal slip, alignment, yaw, path, and
non-migrating actuator residence fail to improve together; the reflected
response does not reflect; or either wake row deteriorates.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and phase-lag or wave-shape modulation
source_mechanism: sensory feedback advances the reversal of a counterproductive stroke while preserving the underlying rhythmic carrier
transferable_invariant: separate slow target geometry from observed joint-state phase and apply a bounded phase correction only to the stroke portion that reinforces lateral error
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, target location, capture radius, and task-specific routes
policy_translation: gate on normalized body-frame target-normal speed and normalized summed joint rate, then shift the posterior target opposite signed slip during only the reinforcing approach half-cycle without scaling cadence, lag, mean bend, or nominal wave gain
falsification: reject if transit changes, capture or distance integral worsens materially, terminal slip/alignment/yaw/path do not improve together, actuator pressure migrates without benefit, reflection fails, or either coherent wake view worsens
```

## Lightweight validation after editing

- The mandated check-runner was invoked without CFD, but its pinned
  `gpt-5.4-mini` model is unsupported on this ChatGPT account. Running its
  available checks directly gives `PASS` for guidance materiality and `PASS`
  for the solver editable boundary. Julia is not installed, so the executable
  include/action smoke probe cannot run in this workspace.
- Static checks find one nonempty `candidate_target_policy.jl`, one definition
  of each public function, all `63` direct `params.FIELD` references covered
  by the `65` fields returned from `target_policy_params`, and balanced
  delimiters. No explicit elapsed time, step count, random input, file I/O,
  cylinder coordinate, target coordinate, or memorized route was added.
- An algebraic reflection probe preserves phase-gate magnitude while reversing
  target-normal motion, the signed reset, and the posterior target shift. The
  terminal distance gate is exactly zero at and beyond `2.10L`. These checks
  establish contract, selectivity, boundedness, and symmetry only; the new
  CFD outcome remains pending for a later worker.
