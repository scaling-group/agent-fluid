# Replicated carrier after local-flow demodulation falsification

## Visual and metric diagnosis before candidate selection

- All four assigned solver examples contain the same policy and byte-identical
  combined keyframe sheets. Each satisfies the released direct-uniform
  still-water contract with `U_infinity=(0,0,0)`, no cylinders, no prewarm,
  finite moving-window dynamics, and capture. Each arrives at `16.604496T`,
  reaches `0.743958L`, scores `-0.1137286`, and has a scored distance integral
  of `1.998146L`. The four repeats establish fixed-case reproducibility, not
  held-out pose, flow, or wake robustness.
- I inspected both rows of the assigned combined sheet from release through
  capture. The top-down row shows self-propelled left/down target closure on a
  shallow crossing arc and a coherent alternating mid-plane vorticity street.
  The oblique row shows compact, finite, tail-connected three-dimensional
  Lambda2 structures along the traveled path. There is no passive advection,
  inherited wake, collision, boundary exit, wake breakup, or instability.
- The most informative completed comparison is the inherited local-flow
  carrier-residual child. I inspected both rows of its combined sheet as well.
  It preserves the same visible route and alternating connected wake and still
  captures at `16.604496T`, but makes the crossing shallower at `0.745252L`,
  raises distance integral to `1.999280L`, worsens score to `-0.1151214`, and
  changes the moving-window shift count from 237 to 236. Wake similarity is
  therefore not evidence that its disturbance decomposition improved control.
- That child subtracted only a fitted anterior-phase component from the local
  lateral-flow part of posterior crossflow feedback after the existing approach
  gate opened. Its mean absolute actions (`21.7330/22.6726 rad/T^2`) are
  practically the same as the sampled carrier's (`21.7334/22.6738 rad/T^2`),
  its two near-speed-limit residence fractions are identical at the reported
  precision, peak planar force changes only from `0.037165` to `0.037137`, and
  peak moment slightly increases from `0.018356` to `0.018413`. The target-cost
  regression has no material effort, feasibility, or load benefit to trade.
- The assigned parent already warned that high carrier correlation alone does
  not justify transforming another cue. Inherited completed terminal holds,
  redirects, line-of-sight-rate additions, bearing demodulation, and moment
  residuals also retained finite wakes or capture while scoring worse. The new
  local-flow result extends that boundary to the remaining crossflow component:
  the nominal successful trace exposes no semantic deficit that justifies
  another observer, gate, or scalar retune.

## Sole candidate selection

Promote the exact prefilled joint-phase-demodulated yaw/lateral-response policy
as this workspace's one candidate. It is byte-identical to all four strongest
assigned captures. Preserve its full anterior traveling-wave carrier, raw
body-frame target geometry, raw-course anterior center, mean-preserving yaw and
lateral demodulators, posterior route/crossflow/yaw response, phase-selective
half-cycle relief, smooth acceleration bound, and final-one-percent one-sided
joint-speed guard. Do not add the falsified local-flow carrier subtraction or
another nominal terminal intervention.

This is an evidence-constrained negative selection rather than a claim that an
unevaluated architecture improves the fixed case. Expected test: reproduce
capture, the connected two-view wake, `16.604496T` arrival, `1.998146L`
distance integral, and the sampled joint/action/load envelope. Falsify the
selection if the next rollout loses capture, changes wake class, or fails to
reproduce those metrics. A nominal repeat remains insufficient evidence of
robustness to a changed pose, flow, gait, or observation adapter.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-interaction/adaptive-swimming studies
source_mechanism: keep a productive rhythmic carrier and slow route request separate from bounded feedback on externally caused flow disturbances
transferable_invariant: remove an internally generated carrier signature from a disturbance cue only when a completed response test improves target behavior or loads without damaging the traveling wave
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, prescribed routes, and source-specific wake geometry
policy_translation: retain the evaluated normalized body-frame two-joint carrier and its demonstrated yaw/lateral response separation, but decline local-flow phase subtraction after the completed child regressed without a semantic or load benefit
falsification: reopen local-flow residual control only if held-out wake or pose evidence exposes a crossflow-response failure, and reject it unless capture or trajectory cost improves while wake connection, joint feasibility, effort, force, and moment remain acceptable

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Its favorable evidence
belongs to the four completed assigned rollouts; the local-flow negative result
and other mechanism controls belong to inherited completed logs. Later
evaluation should compare capture first, then arrival, distance integral,
crossing depth, trajectory topology, both wake views, joint contact, near-limit
residence, requested action, force, and moment against the exact assigned
carrier. The present fixed-pose still-water evidence cannot establish held-out
robustness.
