# Same-half-cycle action-continuity candidate

## Evidence and visual diagnosis before editing

- The four current solver samples satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Their
  combined keyframe sheets are byte-identical. Three policies are byte-
  identical `v40`; the fourth is the documented dormant `v41` selector. They
  therefore reproduce one physical rollout rather than four distinct
  mechanisms: capture at `19.684490 T`, score `-0.261384287`, mean/final
  distance `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and
  only `0.006661 L` of sampled range backtracking.
- I inspected both rows of the combined release-to-capture sheet. The top-down
  row begins in quiescent fluid, shows body motion before the wake develops,
  and then shows coherent alternating posterior shedding along a compact
  target-directed route. This establishes self-propulsion rather than
  advection. The oblique row shows finite localized Lambda2 structures that
  follow the body, not a volume-filling instability. Immediately before
  capture the carrier has handed off to the established curved posture; there
  is no collision, virtual-boundary exit, joint-stop dwell, or wake collapse.
  Metrics agree: the `12/10/8/6/4/2 L` crossings occur at
  `3.806/7.838/10.543/13.057/15.444/17.809 T`, joint excursions remain about
  `0.662/0.531 rad`, and below `4 L` high-command counts are `229/302` with
  finite lateral-force/yaw-moment maxima of about `0.02753/0.01567`.
- The assigned parent's completed action-preview allocator is the most
  informative failure. It also begins from uniform still water, remains
  numerically finite, and retains a recognizable alternating early wake, but
  its compact approach bends into the large loop visible in the top-down row;
  the late oblique structures remain localized and sparse rather than
  unstable. Although its first `10/8/6/4 L` crossings are slightly earlier,
  its `2 L` crossing is later, sampled backtracking grows to `4.456396 L`, path
  length to `30.566383 L`, capture to `44.863487 T`, mean distance to
  `2.860143 L`, and score to `-0.920008223`. It uses `598` moving-window shifts
  versus `243` for `v40`. Thus a bounded same-state selector that predicts
  posterior lag reduction can preserve wake existence yet destroy useful
  route topology through closed-loop flow history.
- The preceding instantaneous posterior convergence selector is consistent:
  it also formed a large loop, captured at `45.848015 T`, and scored
  `-0.929745304`. A response-aligned posterior damping release from the other
  inherited branch remained compact but still regressed to `-0.263092620`.
  Together with the documented cadence, startup-energy, mean-curvature, and
  lag regressions, this closes posterior-error classification, model preview,
  added energy, scalar cadence, and target rewriting as the next mechanism.

## Policy hypothesis

Preserve the complete reproduced `v40` gait, posterior target and lag,
geometry/course steering, saturation alternatives, acceleration ceiling,
intercept corridor, and terminal posture. Add one outer-only command-continuity
projection after the existing allocator. When raw clipping is already rotating
the two-joint action and the newly selected carrier remains in the same action
half-cycle as the observed previous action, measure their normalized direction
change. If that change is material, transfer only a small bounded share toward
the previous action direction, scaled so it cannot exceed the current command
norm. Opposite-half-cycle reversals are untouched, so the oscillator may still
turn over naturally.

This is a state-feedback traveling-bend continuity mechanism, not a scalar
change to cadence, amplitude, damping, curvature, lag, steering authority, or
command limit. It adds no action norm and is exactly absent at and below `4 L`.
The CFD hypothesis is reduced clipping-induced direction jitter without the
response-selector bifurcation, retaining or improving middle-distance progress
and the compact capture. It is falsified by dormancy, terminal leakage, slower
crossings or capture, worse distance integral, a widened route or loop,
increased saturation/load/joint excursion, joint-stop dwell, instability, or
degradation of either wake view.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and classical traveling-wave swimming
source_mechanism: preserve phase-continuous coordination of a directed anterior-to-posterior bend under bounded actuation
transferable_invariant: when saturation distorts a coupled command, preserve short-horizon two-joint directional continuity without blocking the natural half-cycle reversal or adding actuation norm
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact phase lags, vortex phases, full-body waveforms, actuator models, and task-specific routes
policy_translation: use normalized current and observed previous two-joint actions, body-frame outer distance, current clipping distortion, and same-half-cycle agreement to convexly project a small share toward the prior action direction without exceeding current norm
falsification: reject dormancy, any command change at or below 4 L, slower progress or capture, worse distance integral, a widened path or loop, higher saturation or loads, joint-stop dwell, instability, or degradation of the alternating top-down or localized oblique wake

## Candidate boundary

Only the final outer carrier allocation may change. The mechanism consumes the
public `previous_action` observation but introduces no mutable policy state,
clock, step count, fixed coordinate, or route identity. The new CFD evaluation
occurs after this worker exits, so no hydrodynamic improvement is claimed here.

## Deterministic pre-CFD activity and contract checks

Reconstructing the sampled `v40` observations and replaying both policies
changes `764/3579` two-joint commands. Activity spans `0.231000 T`,
`12.324210 L` through `15.438514 T`, `4.000901 L`; there are exactly zero
changes among stored states at or below `4 L`. The maximum per-joint same-state
difference is `0.428559 rad/T^2`, the mean active difference is
`0.036252 rad/T^2`, and the largest candidate output remains the inherited
`30.543262 rad/T^2` software limit. This establishes independent activity and
terminal isolation, not coupled-flow improvement. Because the reference vector
is scaled to no more than the current vector norm and combined convexly, the
new branch cannot increase the pre-terminal carrier norm.

The lightweight Julia contract returns finite two-joint output. A deterministic
grid of `262440` finite states stays within the declared command limit. The
schema audit resolves all `93` direct `params.FIELD` references among the `94`
fields returned by `target_policy_params()`; only metadata `version` is
unreferenced. The semantic guidance check and solver editable-boundary check
pass. The prescribed `check-runner` role was invoked after the edits, but its
pinned `gpt-5.4-mini` model is unavailable for this account and failed before
running a command. Its three exact manifest commands were therefore run
separately and all pass. No formal CFD was run.
