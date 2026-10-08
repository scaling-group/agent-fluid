# Phase-conflict-qualified anterior steering allocation

## Visual and quantitative diagnosis before policy editing

- I read the assigned parent guidance, all sampled scores, policies,
  observations, metrics, diagnostics, trajectories, and inherited optimizer
  notes/results before selecting an edit. Every inspected rollout is contract
  valid: direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows of the
  combined keyframe sheets for the sampled-best v16 posterior envelope, the
  repeated v12 baseline, the v17 direct-course regression, and the v19
  anterior-allocation follow-up. All visibly self-propel from rest. Their
  top-down rows develop coherent alternating streets, and their oblique rows
  retain compact three-dimensional posterior structures through capture.
  There is no passive advection, collision, boundary interaction, wake breakup,
  or out-of-plane instability; the remaining discriminator is terminal
  feedback and actuator allocation rather than gross wake generation.
- The sampled v16 alignment-qualified posterior envelope remains the score and
  mean-distance leader at `-0.064545/1.950801L`, with capture at `18.0235T`,
  center path/cross-track `13.2111L/0.7232L`, final alignment `0.1818`, final
  speed `0.8511U`, and final absolute yaw `0.4200 rad/T`. It is the base to
  preserve.
- Three completed terminal follow-ups constrain the next mechanism. Direct
  course-to-curvature feedback (v17) regressed final alignment/yaw to
  `0.1640/0.5884 rad/T` and score/mean distance to
  `-0.064645/1.950875L`. Closing course error through a desired-yaw-rate loop
  (sampled v18) shortened path to `13.1958L` but regressed score/mean distance
  to `-0.064955/1.951091L` and final alignment/yaw to
  `0.1161/1.0763 rad/T`. Neither changed the coherent two-view wake.
- The sampled v19 broad anterior allocation supplies a useful but incomplete
  actuator result. Moving a distance/speed/alignment-gated share of the
  existing mean bend forward improved v16 final alignment from `0.1818` to
  `0.1957`, final absolute yaw from `0.4200` to `0.2875 rad/T`, path from
  `13.2111L` to `13.2086L`, cross-track from `0.7232L` to `0.7207L`, and
  slightly reduced RMS force/moment and near acceleration-ceiling residence.
  But applying the shift throughout both beat halves regressed score/mean
  distance to `-0.064778/1.950985L`. The allocation direction is promising;
  its chronic within-approach authority is not.

## Single candidate hypothesis

Start from evaluated v16. Preserve its odd target-to-curvature polarity,
state-feedback anterior carrier, posterior lag/emphasis, phase-consistent
reserve, far/middle route observer, terminal posterior envelope, half-cycle
steering, and reversal-preserving rate governor. Retain v19's algebraic
conservation of total signed mean bend, but qualify the anterior shift by one
additional joint-state condition: activate it only on the beat half where the
posterior mean steering target opposes the unshifted lagged traveling-wave
target. A smooth normalized product of those two targets measures conflict;
when they agree, allocation is exactly zero and the evaluated v16 target is
recovered.

The geometric allocation gate is exactly zero outside `2.10L`, at rest, and on
an aligned target course. The phase-conflict gate uses observed joint angle and
rate rather than time or a prescribed vortex phase. At every instant the
anterior and posterior mean contributions still sum to the original odd total
mean bend; only its longitudinal location changes on destructive-interference
half-cycles. Expected evidence is unchanged transit and coherent two-view wake,
retained capture and v16 mean-distance class, plus the terminal yaw/alignment
benefit of v19 without its distance-integral regression. Falsify if behavior
moves before approach, total mean bend is not conserved, capture or score is
lost, path/alignment/yaw fails to improve jointly, saturation merely migrates
anteriorly, reflection equivariance fails, or either wake row deteriorates.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and robotic-fish mean-curvature plus half-cycle steering
source_mechanism: preserve lagged posterior excursion for reactive thrust while allocating mean turning curvature away from the posterior only during an observed conflicting beat phase
transferable_invariant: posterior motion should retain lag and emphasis for propulsion, while a bounded steering redistribution should conserve signed total mean bend and yield when it does not conflict with the propulsive wave
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body curvature distributions, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: in the normalized body-frame approach gate, multiply the bounded v19 mean-bend shift by a smooth conflict measure from the odd mean target and the unshifted lagged two-joint wave target; preserve v16 exactly on the compatible half-cycle and outside approach
falsification: reject if transit changes, algebraic total mean curvature is not conserved, v16 capture or mean distance regresses, terminal path/alignment/yaw does not improve, load migrates without benefit, lateral reflection fails, or either coherent wake view worsens

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account. Running its immutable
  checks locally gives PASS for the material guidance update and solver
  boundary; only `candidate_target_policy.jl` differs inside `solver/`.
- No Julia executable is installed or discoverable, so the exact include and
  finite-action probe cannot run in this shell. The deterministic schema guard
  passes: all `64` distinct direct `params.FIELD` references resolve among the
  `66` unique fields returned by `target_policy_params`; the candidate remains
  non-empty, contains each public function once, and contains no clock, step,
  randomness, file I/O, mutable global, cylinder coordinate, or world-route
  cue.
- Replaying the new gate on the evaluated v16 trajectory gives exactly zero
  allocation for every sample at or beyond `2.10L`. Below approach, the v19
  geometric allocation gate still averages `0.2863`, but phase conflict is
  present on only `53.28%` of samples. The combined authority averages
  `0.1262`, so the capped mean-bend share averages `0.0442` rather than v19's
  `0.1002`, with maximum `0.2105`; this verifies that the edit materially
  reduces chronic allocation without eliminating conflict-phase authority.
  Algebraically `mean_head_tangent + mean_tail_tangent` equals the unchanged
  odd `total_mean_tangent`; lateral reflection flips both joint state and mean
  target, preserving conflict magnitude and flipping both allocated means.
  These are contract and activation checks, not CFD evidence; EvE must test the
  capture and trajectory hypothesis after this worker exits.
