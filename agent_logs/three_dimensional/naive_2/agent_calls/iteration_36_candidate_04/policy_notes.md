# Phase-normalized projected-reserve candidate

## Visual and metric diagnosis before editing

The four sampled evaluations and the assigned parent's completed rollout all
satisfy the frozen-flow contract: direct uniform initialization in still water
with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
capture termination. I inspected each combined keyframe sheet from release to
capture, including both the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The score-best tail-only residual and the weaker carrier-
phase/receiver-safe variants all visibly self-propel down-left on the same
direct route. Their top-down sheets retain a coherent alternating wake, and
their oblique sheets retain a compact body-connected three-dimensional vortex
train. None shows passive advection, wake breakup, boundary interaction, or an
instability. There is no current termination failure to compare, so the
tail-only residual is the informative actuator-quality failure and the
directional allocator is the strongest sampled compromise. The established
carrier, far-field route, and geometry/response handoff should be preserved.

Trajectory and diagnostic cross-checks distinguish redirect allocation from
propulsion:

- The tail-only residual is fastest and score-best (`15.1403T/-0.01094`) but
  crosses on a `0.651L` head-relative constant-course miss, reaches
  `0.04041/0.01902` peak normalized planar force/moment, and keeps the
  posterior joint above `40 deg` for `1.269%` of samples.
- Absolute tail reserve produced the best sampled margin (`0.362L`) but was
  slower (`15.4464T`) and exchanged limit exposure between joints
  (`0.285/0.996%` anterior/posterior dwell).
- Signed residual-direction reserve preserved capture at `15.3385T`, improved
  the margin to `0.461L`, removed anterior dwell, reduced posterior dwell to
  `0.681%`, and kept peak force/moment at `0.03959/0.01889`.
- The competing carrier-phase allocator captured earlier (`15.2107T`) but
  widened miss to `0.631L` and increased posterior dwell to `1.878%`, with
  `0.03930/0.01922` peak loads. Previous total action therefore does not
  identify the direction of the additive residual, which always enters as a
  signed coefficient of `abs(carrier)`.
- The assigned parent's receiver-safe spillover retained capture at
  `15.2823T/-0.01727` and eliminated both joints' `>40 deg` dwell, but its miss
  widened from the directional allocator's `0.461L` to `0.516L` and peak
  force/moment remained `0.03988/0.01906`. Shedding unsafe spillover protects
  state but does not recover the centered absolute-reserve course.

The evidence rejects another previous-action phase gate, absolute receiver
gate, scalar residual adjustment, or carrier change. It supports retaining the
signed incremental-residual semantics while making the state capacity
anticipatory: a joint approaching a boundary should lose outward residual
authority before its instantaneous angle reaches the soft boundary, while a
residual opposing that approach must remain available.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst redirect
source_mechanism: preserve a rhythmic propulsive carrier while bounded target-relative redirect authority is admitted and released using observed actuator state
transferable_invariant: keep the traveling carrier intact and gate only the incremental steering residual by whether phase-normalized joint state predicts compatible directional reserve
nontransferable_details: published gains, dimensional beat settings, hardware duty ratios, species-specific kinematics, full-body envelopes, exact vortex phases, and task-specific routes
policy_translation: retain the sampled signed predicted-miss residual and replace instantaneous signed angle capacity with signed `q + qdot/omega` projected capacity on both joints, while retaining directional rate capacity and shedding unassignable authority
falsification: reject if capture or the compact direct route is lost, terminal miss exceeds `0.461L`, anterior dwell reappears, posterior dwell is not below `0.681%`, peak normalized force/moment materially exceeds `0.040/0.019`, or arrival materially worsens beyond `15.34T`

## Single candidate hypothesis

Start from the sampled signed residual-direction allocator. Preserve its
state-feedback oscillator, posterior lag and pulse, normalized body-frame
pursuit/course blend, constant-course predictor, shared response-plus-miss
handoff, residual magnitude, and smooth acceleration envelope. Change one
mechanism: evaluate each joint's angle reserve at `q + qdot/omega`, a
phase-normalized one-radian projection of its observed state, while retaining
the residual-direction rate gate. This projection grants a restoring residual
near a boundary but withholds an outward residual before the beat carries the
joint into that boundary. Tail authority remains primary; only unavailable
tail share reaches a projected-safe head, and any remainder returns to the
unmodified carrier.

Support requires capture with predicted miss at or below `0.461L`, no anterior
`>40 deg` dwell, posterior dwell below `0.681%`, peak normalized planar
force/moment no worse than approximately `0.040/0.019`, and arrival comparable
to the `15.28--15.34T` allocation class. The mechanism is bounded,
reflection-equivariant, and uses normalized body-frame geometry plus joint
state without a clock, route, target identity, exact vortex phase, or world
coordinate. Formal CFD is deferred to EvE; this worker cannot claim the new
candidate's rollout as evidence.

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass without CFD. A deterministic `16,875`
state grid spanning normalized target/velocity geometry, heading response, and
both joints' angle/rate state produced finite commands strictly inside the
owned `30 rad/T^2` smooth envelope with exact left/right reflection (maximum
error `0.0`). Projected reserve changed `9,205` grid states relative to the
sampled instantaneous signed allocator, with maximum command difference
`6.4682 rad/T^2`, confirming an active observation/feedback mechanism rather
than a comment or scalar-only edit. These checks are algebraic only; capture,
wake, joint dwell, loads, and terminal margin remain downstream falsification
tests.
