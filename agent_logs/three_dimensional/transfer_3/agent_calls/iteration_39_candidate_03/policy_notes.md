# Action-preview traveling-bend allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled solvers satisfy the frozen Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. Their combined
  keyframe sheets and trajectories are byte-identical. Three policies are
  byte-identical `v40` and the fourth added a dormant selector, so this is one
  reproduced physical result rather than four distinct mechanisms: capture at
  `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and only
  `0.006661 L` of sampled range backtracking.
- I inspected both rows of the sampled release-to-capture sheet. The top-down
  row shows self-propelled compact target motion from quiescent water and a
  coherent alternating posterior wake by the middle approach. The oblique row
  shows finite localized Lambda2 structures following the fish, not a
  volume-filling instability. Immediately before capture the fish is in the
  established quiet curved posture; there is no collision, boundary exit,
  wake collapse, or joint-stop dwell. Metrics agree: the trajectory crosses
  `4 L` at `15.444014 T`, and the terminal law reduces the below-`4 L`
  `|action|>30 rad/T^2` counts to `229/302` while retaining capture.
- The assigned parent's posterior-convergence allocator is the most
  informative failure. Its first `10/8/6 L` crossings are slightly earlier
  than `v40`, and both wake views remain coherent and finite, but the fish
  first approaches the capture neighborhood and then enters the large loop
  visible in the top-down row. Sampled range backtracking grows to `4.441875
  L`, path length to `30.804515 L`, capture is delayed to `45.848015 T`, and
  score/mean distance regress to `-0.929745304`/`2.871654683 L`. Discounting
  lag support from the sign of instantaneous posterior error-velocity power
  therefore misclassifies coupled response even though an equal-state replay
  had shown `391` outer command changes.
- The inherited mature-carrier feasibility governor is a complementary
  negative result. A bounded `3%` cadence reduction, active on `448` sampled
  parent states only above `4 L`, preserves the compact topology but delays
  capture to `20.322491 T` and regresses score/mean distance to
  `-0.266846005`/`2.157538110 L`. Together these outcomes close scalar cadence
  attenuation and response classification from posterior velocity alone. The
  unresolved evidence-backed locus is bounded command allocation using the
  effect of the candidate actions on the moving two-joint bend target.

## Policy hypothesis

Preserve `v40`'s gait, posterior lag formula, geometry/course steering,
acceleration ceiling, intercept corridor, and complete terminal law. During
outer saturation only, predict the anterior and posterior joint state over a
small fraction of the declared control period under the already selected
carrier command and its existing response-preserving and target-residual
alternatives. Reconstruct the next posterior target from the predicted
anterior state, so feasibility is measured relative to the moving
traveling-bend target rather than from posterior velocity alone. If and only
if one existing alternative predicts a material reduction in normalized
posterior tracking error while clipping is rotating the two-joint command,
transfer a small bounded share toward the better prediction.

This adds no oscillator energy, lag, mean curvature, target residual,
authority, route state, or clock. The actual-distance outer gate makes it
exactly silent at and below `4 L`. The CFD hypothesis is improved middle
progress without changing the compact two-view wake or quiet terminal capture.
It is falsified by dormancy, slower `10/4/2 L` crossings or capture, worse
distance integral, a widened path or loop, any terminal-command change,
increased saturation or loads, joint-stop dwell, instability, or degradation
of either wake view.

bookshelf_consulted: true
source_domain: classical traveling-wave fish swimming and closed-loop robotic-fish CPG control
source_mechanism: retain a directed anterior-to-posterior bend while sensory feedback allocates bounded actuation according to predicted coupled-joint response
transferable_invariant: evaluate follower feasibility relative to the moving upstream-generated bend target, and preserve the allocation that is predicted to propagate rather than distort that traveling relation
nontransferable_details: published oscillator gains, dimensional frequencies, species envelopes, exact phase lags, vortex timing, robot geometry, full-body waveforms, and task-specific routes
policy_translation: use normalized two-joint angle and velocity, the existing response-preserving and target-residual allocation options, state-derived omega, and a short fraction of the declared control period to predict the next posterior lag; apply only a small outer allocation transfer toward the better option when it predicts less lag under clipping
falsification: reject if the selector is dormant or terminal-active, delays or loses capture, worsens distance progress or loads, changes the compact path, causes joint-stop dwell or instability, or degrades the alternating top-down or localized oblique wake

## Candidate boundary

Only an outer action-preview selector may change. Its preview is kinematic,
bounded, state-derived, and compares two allocations already present in the
parent; it does not prescribe a trajectory or infer an exact vortex phase. No
formal CFD result is claimed here because evaluation occurs after this worker
exits.

## Deterministic pre-CFD activity check

Reconstructing the sampled `v40` observations and replaying both policies
changes `296/3579` two-joint commands. The changed states span the outer
carrier from `1.017500 T`, `12.325914 L` through `15.229510 T`, `4.188545 L`;
there are exactly zero changes among the `772` stored states at or below
`4 L`. The maximum per-joint same-state difference is
`0.054608 rad/T^2`, the mean active difference is `0.012678 rad/T^2`, and all
candidate outputs are finite and within the existing acceleration ceiling.
This establishes independent activity, boundedness, and exact terminal
isolation, not a coupled-flow improvement.

## Static contract verification

The prescribed `check-runner` role was invoked, but its pinned `gpt-5.4-mini`
model is unavailable for this account and failed before running a command. I
then ran its three manifest checks separately: the material guidance/notes
check passes, the lightweight Julia two-joint contract returns finite output,
and the solver editable-boundary check passes. A direct deterministic schema
audit resolves all `92` direct `params.FIELD` references against the `93`
fields returned by `target_policy_params()`; only metadata `version` is
unreferenced. No formal CFD rollout was run.
