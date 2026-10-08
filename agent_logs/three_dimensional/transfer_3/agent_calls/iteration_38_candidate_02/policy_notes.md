# Posterior-convergence allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled solver examples satisfy the Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. They have
  byte-identical trajectories and combined keyframe sheets and reproduce the
  same `v40` behavior at `19.684490 T`, score `-0.261384287`, mean/final
  distance `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and
  only `0.006661 L` of sampled range backtracking. Three policies are
  byte-identical `v40`; the fourth policy difference is dormant. The four
  examples therefore establish deterministic replay of one physical rollout,
  not four distinct controller mechanisms.
- I inspected both rows of the sampled combined sheet from release through
  capture. The top-down row shows self-propelled target progress from a
  quiescent release and a coherent alternating wake by the middle approach;
  the oblique row shows finite, localized three-dimensional Lambda2 structures
  following the body. The compact path continues into a quiet curved posture
  through the capture circle without collision, exit, wake collapse, or
  volume-filling instability.
- The assigned-parent divergence allocator is the closest completed active
  contrast. Its two-view sheet retains the coherent wake and compact topology,
  and capture is `0.098999 T` earlier, but its outer-distance crossings from
  `10 L` through `4 L` are each about `0.066--0.148 T` later. It regresses
  score and mean distance to `-0.272400020` and `2.162221182 L`; terminal
  high-command counts also rise from `229/302` to `280/380`. Thus adding
  common limiting when posterior error is growing does not improve the whole
  approach, even though final arrival alone looks faster.
- Two inherited completed low-response energy mechanisms provide the most
  informative visual failures. They advance the first `12 L`, `10 L`, and
  `8 L` crossings, but later change the compact glide into a visibly wider
  curved sweep, capture only at `22.962509 T` and `23.408014 T`, and regress
  scores to `-0.330184330` and `-0.380336665`. Their top-down wakes remain
  coherent and their oblique structures remain finite, so early threshold
  progress and wake existence do not establish a useful mechanism: direct
  oscillator-energy injection perturbs the coupled trajectory long after its
  response gate releases.
- The surviving control opportunity is allocation rather than more rhythmic
  energy, phase-lag rewriting, mean curvature, or terminal response logic.
  `v40` selects common limiting from posterior position error alone. That
  cannot distinguish a large error already converging toward the declared
  traveling-bend target from an equally large error diverging from it.

## Policy hypothesis

Preserve `v40`'s oscillator, posterior target and lag, geometric steering,
command ceiling, intercept corridor, and terminal posture exactly. During
outer saturation only, form a normalized posterior convergence-power cue from
the signed target error and posterior velocity. When the posterior joint is
moving toward its existing target, smoothly discount a bounded fraction of
position-only lag support so the established target-residual allocator can
take over slightly earlier. Diverging or stationary response receives no
credit, and the actual-distance outer gate makes the mechanism exactly zero at
and below `4 L`.

This is a new state-dependent priority selector, not a permanent gain change:
it adds no energy, bend, phase offset, course command, or authority. The CFD
hypothesis is faster middle-distance progress with the same compact two-view
wake and quiet terminal capture. It is falsified by dormancy, slower or lost
capture, worse distance integral, a widened/looping path, terminal command
changes, increased saturation or loads, joint-stop dwell, instability, or
degradation of either wake view.

bookshelf_consulted: true
source_domain: classical traveling-wave fish swimming and closed-loop robotic-fish CPG control
source_mechanism: preserve a directed posterior-lagged bend while sensory response determines how rhythmic and steering objectives share bounded actuation
transferable_invariant: a large coupled-state error that is already converging should not receive the same protective allocation as an error that is stationary or diverging
nontransferable_details: published oscillator gains, dimensional frequencies, species envelopes, exact phase lags, vortex phases, robot geometry, and task-specific routes
policy_translation: normalize posterior target error by drive amplitude and posterior velocity by amplitude-times-state-derived frequency; use positive error-velocity product to discount only a bounded share of outer position-error support while preserving the existing two-joint commands and terminal law
falsification: reject if the branch is dormant, changes any command at or below 4 L, delays or loses capture, worsens distance progress or loads, changes the compact path, causes joint-stop dwell or instability, or degrades the alternating top-down or localized oblique wake

## Candidate boundary

Only the outer response selector may change. The convergence credit is capped
at a declared fraction of position-only lag support and is continuously gated
by the same normalized joint state and outer-distance support already used by
the allocator. No formal CFD result is claimed in this note; evaluation occurs
after the worker exits.

## Deterministic pre-CFD activity check

Reconstructing the sampled parent observations and replaying both policies
changes `391/3579` two-joint commands. Every changed state is outside the
protected terminal band (`0` changes at or below `4 L`); the first and last
active reconstructed states are at `12.324604 L` and `4.135197 L`. The maximum
per-joint command difference is `0.324059 rad/T^2`, the mean active difference
is `0.101382 rad/T^2`, and all candidate outputs are finite. This establishes
that the selector is independently active and isolated, not that its CFD
trajectory will improve.

## Static contract verification

The prescribed `check-runner` role was invoked but its pinned model is not
available for this account, so it could not start. Its three manifest commands
were then run separately and repeated by an available independent read-only
agent. After removing one redundant duplicate of the same assigned-parent
marker from the rendered workspace README, both runs pass the material
guidance/notes check, finite two-joint Julia contract, and solver editable-
boundary check. The deterministic schema audit resolves all `91` direct
`params.FIELD` references against the `92` fields returned by
`target_policy_params()`. No formal CFD rollout was run.
