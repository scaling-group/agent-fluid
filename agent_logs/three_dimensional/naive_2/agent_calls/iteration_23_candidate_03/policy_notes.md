# Closure-alignment-gated posterior redirect candidate

## Evidence and visual diagnosis before the edit

- The assigned parent guidance and prefilled policy are the completed
  approach-gated lateral carrier-residual controller. The three byte-identical
  sampled copies capture from direct-uniform still water at `16.604496T`, with
  score `-0.1137286345`, final/minimum head distance `0.743958L`, and scored
  mean distance `1.998146L`. The distinct sampled predecessor, which lacks
  only lateral residualization, also captures but one `0.0055T` step later,
  with score `-0.1155603837` and mean distance `1.999656L`. These exact
  repeats support a narrow fixed-case route benefit, not robustness or load
  relief: the residualized parent raises peak planar force/moment from about
  `0.03583/0.01776` to `0.03716/0.01836` and slightly raises near-limit
  residence.
- All four sampled observations and both immediate inherited descendants
  confirm `U_infinity=(0,0,0)`, uniform direct initialization, no cylinders,
  no prewarm, finite dynamics, and an active moving window. I inspected both
  rows of the combined keyframe sheets for the sampled best, its weaker
  predecessor, and the two inherited regressions. The top-down views show
  self-propelled shallow target arcs with coherent alternating vorticity; the
  oblique views show compact tail-connected three-dimensional Lambda2
  structures through capture. There is no advection, collision, boundary
  exit, wake breakup, or instability. The useful distinction is crossing
  timing and path integration, not wake class.
- The inherited generation supplies a controlled negative result absent from
  the sampled scalar list. Subtracting fitted anterior phase from posterior
  bearing with coefficients `(-0.62,-0.015)` delayed capture to `16.785990T`
  and regressed score/mean distance to `-0.1216585/2.005314L`; the stronger
  `(-0.92,-0.022)` version delayed capture to `17.094002T` and regressed to
  `-0.1213566/2.006259L`. Both retained connected wakes and bounded loads.
  Carrier-correlated raw bearing is therefore not disposable observation
  noise in this controller; do not repeat or scalar-tune either demodulator.
  The inherited phase-demodulated line-of-sight-rate feedforward result
  (`-0.118996`) likewise argues against adding another kinematic predictor.
- Reconstructing the parent's normalized body-frame signals exposes a more
  localized opportunity. The lateral-residual target-versus-velocity course
  error reaches about `+0.66 rad` at `1.21--1.28L`, where radial alignment is
  only about `0.79`, then returns near alignment before capture. With the
  proposed normalized gate, the extra route-state term is zero outside the
  inherited `6.5L` approach schedule, averages only about `0.027` in magnitude
  inside `2L`, peaks at `0.125` in that off-course interval, and falls below
  `0.012` inside `1L`. This supports testing a response-triggered redirect
  without changing propulsion or forcing terminal coasting.

## Single candidate hypothesis

Preserve the full anterior oscillator, raw-course anterior center, raw bearing,
joint-phase yaw/lateral residual observers, posterior mean and half-cycle
structure, and one-sided speed guard. Add one reflection-equivariant posterior
redirect mechanism: form radial alignment from the normalized target vector
and phase-demodulated body velocity; when the fish is moving and alignment is
lost on approach, smoothly add a small signed residual-course term to
`route_turn_state`. Correct alignment, near-rest motion, the far route, and the
final sub-`1L` crossing receive little or no addition. Unlike the repeatedly
falsified closing-aware wave relief, this gate does not reduce carrier energy;
it opens a separate bounded steering channel.

The falsifiable expectation is capture with the same alternating, connected
wake and no degradation of the demonstrated route before `6.5L`, while the
`1.2--1.3L` course excursion is shortened enough to improve arrival or scored
distance. Reject the mechanism if capture is delayed or lost, if the same
off-course segment remains, if the final arc or wake class deteriorates, or if
joint contact, near-limit action, force, or moment grows beyond the parent's
already narrow tradeoff. This workspace claims no new CFD result.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and terminal capture control
source_mechanism: preserve the traveling carrier while a speed-qualified loss of targetward response gates a separate bounded steering correction
transferable_invariant: propulsion and redirection should remain separate channels, with extra course authority released continuously once normalized radial alignment recovers
nontransferable_details: published controller gains, species kinematics, dimensional frequencies, exact vortex phases, maneuver timing, and prescribed routes
policy_translation: use body-frame target and phase-demodulated velocity to compute radial alignment; on approach only, gate a small signed posterior course term without attenuating either joint's carrier
falsification: reject if the inherited pre-approach route, capture, distance integral, final crossing, connected wake, joint envelope, saturation, force, or moment worsens, or if the evidenced off-course interval is unchanged

## Non-CFD validation

- The required guidance-materiality check passes, including the transient note
  and evidence-backed reusable lesson.
- The solver boundary check passes with only
  `candidate_target_policy.jl` edited relative to the frozen baseline.
- All 34 direct `params.FIELD` references are returned by
  `target_policy_params()`. A faithful mock of the check-runner state returns
  two finite accelerations and its reflected state negates both actions;
  delimiters are balanced.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its prescribed Julia smoke command was
  then attempted directly and could not start because this workspace image
  has no `julia` executable. No CFD was run.
