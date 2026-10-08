# Replicated-best carrier after projected-corridor falsification

## Visual and metric diagnosis before candidate selection

- All four sampled solvers contain the same policy and byte-identical combined
  keyframe sheets. Each satisfies the released experiment contract: direct
  uniform quiescent initialization, `U_infinity=(0,0,0)`, zero cylinders, no
  prewarm snapshot, finite moving-window dynamics, and capture. Each reaches
  `0.743958L` at `16.604496T` with score `-0.1137286`, scored distance
  integral `1.998146L`, and 237 storage-window shifts. These repeats establish
  fixed-case reproducibility, not robustness to another pose or flow.
- I inspected both rows of the sampled combined sheet from release to capture.
  The top-down row shows acceleration from still water, targetward translation
  on a shallow crossing arc, and a coherent alternating mid-plane vorticity
  street. The oblique row shows compact alternating three-dimensional Lambda2
  structures connected to the posterior body and traveled path. Thus the fish
  is self-propelled; there is no inherited wake, passive advection, collision,
  boundary exit, wake breakup, or numerical instability before capture.
- The most informative completed inherited comparison is the projected-capture
  corridor yaw hold. I inspected its two-view sheet as well: it retains the
  same qualitative shallow arc and tail-connected alternating wake, and it
  captures at the same `16.604496T`. Nevertheless, it worsens score from
  `-0.1137286` to `-0.1146249`, distance integral from `1.998146L` to
  `1.998871L`, final crossing distance from `0.743958L` to `0.744813L`, and
  changes the moving-window shift count from 237 to 236. Wake coherence is
  therefore not evidence that the terminal gate improved control.
- That completed negative joins two earlier inherited terminal interventions.
  Releasing up to 35% of fast yaw response under high alignment captured one
  step earlier but regressed to score `-0.1140375` and integral `1.998380L`;
  adding phase-compatible posterior relief under closure deficit captured at
  `16.609995T` but regressed to `-0.1142150` and `1.998537L`. Alignment,
  closure deficit, and projected interception span materially different gate
  semantics, yet none beats the unmodified response-demodulated carrier.
- The sampled parent also reaches the released joint-speed boundary while
  staying inside its smooth acceleration envelope, with mean requested
  accelerations `21.733/22.674 rad/T^2` and peak planar force/moment
  `0.037165/0.018356`. The successful carrier is not an effort optimum, but
  no completed terminal child supplies a lower-cost or better semantic result
  that would justify changing its propulsion or response separation here.

## Sole candidate selection

Keep exactly the prefilled joint-phase-demodulated yaw/lateral-response policy,
byte-identical to the four strongest sampled captures. It preserves the full
anterior traveling carrier, raw target bearing and anterior course center,
mean-preserving yaw and lateral response demodulation, posterior route and
crossflow feedback, phase-compatible half-cycle steering, smooth acceleration
bound, and final-one-percent one-sided joint-speed guard. Do not add another
terminal hold, redirect, target-rate feedforward, geometric demodulator, or
moment residual.

This is an evidence-backed candidate selection, not a claim that an unevaluated
change improves the fixed case. Expected test: reproduce capture, the connected
two-view wake, and the sampled target-cost and actuator envelopes. Falsify the
selection if the next rollout loses capture, changes wake class, or fails to
reproduce arrival, distance cost, crossing depth, joint contact, feasible
action, force, or moment. A nominal repeat remains insufficient evidence of
held-out pose or flow robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking, asymmetric flapping, and terminal prey-capture control
source_mechanism: separate a productive rhythmic carrier from observed route feedback and recruit terminal modulation only for a demonstrated approach deficit
transferable_invariant: preserve a productive traveling wave and its bounded response separation when completed target-relative terminal gates do not improve semantics or cost
nontransferable_details: published gains, dimensional beat frequency, species or robot kinematics, exact vortex phase, capture thresholds, and source-task routes
policy_translation: retain the sampled normalized body-frame two-joint controller and decline scalar retuning or another terminal gate after alignment, closure-deficit, and projected-corridor interventions all regressed
falsification: reject this preservation choice if capture or connected-wake replication fails, or if a held-out pose or flow reveals a response deficit that a separately observed mechanism can correct without degrading the carrier

## Evaluation boundary

No CFD result is claimed for this workspace. The candidate's favorable evidence
comes from four completed sampled rollouts; all terminal negative controls come
from completed inherited logs. Later evaluation must compare semantic capture
first, then arrival, scored and observed distance integrals, crossing depth,
trajectory topology, two-view wake connectivity, joint contact, near-limit
residence, requested action, force, and moment against the exact samples. The
present fixed-pose still-water evidence cannot establish general robustness.
