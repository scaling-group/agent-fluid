# Replicated-best carrier after local-flow residual falsification

## Visual and metric diagnosis before candidate selection

- The four sampled solvers are byte-identical policy and combined-keyframe
  repeats. Each satisfies the released direct-uniform still-water contract
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite
  moving-window dynamics, and capture. Each reaches `0.743958L` at
  `16.604496T` with score `-0.113729`, distance integral `1.998146L`, and 237
  storage-window shifts. This establishes fixed-case reproducibility, not
  held-out pose or flow robustness.
- I inspected the sampled combined sheet and both view-specific sheets from
  release through capture. The top-down views show acceleration from still
  water, targetward self-propulsion on a shallow crossing arc, and a coherent
  alternating mid-plane vorticity street. The oblique views show compact,
  finite, tail-connected three-dimensional Lambda2 structures. There is no
  passive advection, inherited wake, collision, boundary exit, breakup, or
  instability.
- The most informative completed failure is the sampled carrier-synchronous
  local-flow residual child. I inspected both rows of its combined sheet: its
  target-crossing arc and connected alternating wake are visually unchanged,
  and it captures at the same `16.604496T`. Yet subtracting the fitted local
  lateral-flow phase component makes the crossing shallower (`0.745252L`
  versus `0.743958L`), raises distance integral from `1.998146L` to
  `1.999280L`, and worsens score from `-0.113729` to `-0.115121`.
- The residual child offers no compensating actuator or load improvement.
  Its final-one-percent speed residence is identical (`11.59%/16.00%`), mean
  absolute actions are effectively identical (`21.733/22.673 rad/T^2`), peak
  force changes only from `0.037165` to `0.037137`, and peak moment increases
  from `0.018356` to `0.018413`. Thus high joint-phase predictability of local
  flow did not identify a removable disturbance; on this direct-still-water
  carrier it identified part of the useful closed-loop hydrodynamic response.
- The assigned-parent logs already falsify several other nominal refinements:
  two LOS-rate feedforwards, bearing demodulation, moment-residual rejection,
  high-alignment yaw release, closure-deficit posterior attenuation, and a
  projected-capture-corridor release all retain finite wakes but score below
  the exact parent. The evidence does not isolate a remaining nominal deficit
  whose expected benefit justifies perturbing the demonstrated capture arc.

## Sole candidate selection

Keep the prefilled joint-phase-demodulated yaw/lateral-response controller
byte-identical as the one solver candidate. It preserves the full anterior
traveling carrier, raw body-frame target geometry and anterior course center,
mean-preserving yaw and body-sway demodulation, measured relative-crossflow
feedback, posterior route response and phase-selective steering, smooth
acceleration bound, and the one-sided final-band speed guard. Do not extend
phase subtraction into local flow, add another terminal gate, or scalar-tune a
completed negative mechanism.

This is an evidence-constrained negative selection, not a claim that an
unevaluated intervention improves the fixed case. Falsify it if nominal
capture or either visual wake class fails to replicate, or if a held-out pose
or flow reveals a semantic directional deficit that the retained observation
channels cannot correct.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate productive rhythmic locomotion from bounded feedback driven by observed environmental or route residuals
transferable_invariant: preserve an evidenced traveling carrier and do not subtract a carrier-correlated hydrodynamic signal unless completed response evidence shows that the subtraction improves control
nontransferable_details: published gains, dimensional beat frequency, species or robot kinematics, exact vortex phases, prescribed routes, and source-specific wake geometry
policy_translation: retain the normalized body-frame two-joint carrier and its measured relative-crossflow channel exactly after the completed local-flow phase subtraction regressed; adopt no bookshelf gain or scalar retuning
falsification: reject the preservation choice if capture, distance cost, crossing depth, connected three-dimensional wake, joint feasibility, effort, force, or moment fails to replicate, or if held-out flow evidence isolates a removable carrier-flow component

## Evaluation boundary

No CFD result is claimed for this workspace. Later evaluation should first
require capture and the same top-down and oblique wake classes, then compare
arrival, distance integral, crossing depth, joint contact, near-limit action,
force, and moment against the four exact sampled repeats. A changed pose,
imposed flow, success radius, observation adapter, or carrier family is a
falsification test rather than evidence that this nominal replication is
broadly robust.
