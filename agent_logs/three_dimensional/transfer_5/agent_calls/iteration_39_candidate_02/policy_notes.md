# Candidate diagnosis and hypothesis

## Inherited evidence

- All sampled observations confirm direct uniform still-water initialization:
  `U_infinity=[0,0,0]`, no prewarm, no cylinders. Motion in both visual rows is
  therefore self-propulsion rather than advection.
- The top-down sheets show a persistent alternating red/blue wake from release
  through capture. The oblique Lambda2 sheets likewise show a coherent chain of
  three-dimensional shed structures rather than a weak wake, collapse, or
  instability. The fish turns along the same smooth target arc in every sampled
  variant; the last frames show vigorous lateral/yaw motion immediately before
  capture, not collision or domain exit.
- The full slow-course observer is replicated exactly by `a95f7416a3de` and
  `343870fd8107`: capture at `23.4410T`, score `-0.501691`, scoring mean/final
  distance `2.399184/0.746948L`. It retains the inherited coherent wake while
  improving the stabilization-envelope parent's earlier/mean/load measures
  documented in guidance.
- Withdrawing only the main-request course residual over the full `3.0--0.75L`
  terminal-control band (`bc6f1708043d`) gives the best sampled scalar score,
  `-0.501134`, and final distance `0.746369L`, but no earlier capture. Relative
  to the replicated full observer, inside `3L` mean absolute yaw rises from
  `1.68733` to `1.68837 rad/T`, mean/peak target-line cross-track speed from
  `0.22592/0.58298U` to `0.22619/0.58481U`, and peak moment from `0.013886` to
  `0.014319`. The gain is a terminal endpoint trade, not a semantic improvement.
- A progress-qualified withdrawal confined to the last `1L`
  (`42a8e74d0972`) is effectively the baseline: the same capture sample, score
  `-0.501677`, mean distance `2.399172L`, with slightly worse inside-`3L`
  cross-track motion. Together these results falsify another distance window,
  qualification gate, or scalar handoff retune.

## Policy hypothesis

Keep the full-observer carrier, propulsion/stabilization handoff, terminal
desired-yaw reference, phase-selected anterior correction, and posterior wave.
Change only the slow main-route observer: augment its existing anterior-rate
carrier estimate with the other normalized oscillator quadrature,
`phi1/drive_amplitude`. On the replicated trace, the sampled target-line
cross-track carrier is approximately `0.8*phi_dot1/omega - 0.20*phi1`; the
bounded normalized translation `-0.10U*clamp(phi1/drive_amplitude)` reduces the
offline residual RMS from `0.1384U` to `0.1081U` overall and from `0.1302U` to
`0.0861U` inside `3L`, while retaining the signed slow mean (`-0.0763U` to
`-0.0702U`). This is an observer-structure test, not a steering-gain increase.
The established rate-only residual remains in terminal desired-yaw
classification and continuous terminal course braking so the new quadrature
has one falsifiable role.

bookshelf_consulted: true
source_domain: robotic-fish coupled-oscillator and averaging control
source_mechanism: represent rhythmic locomotion with an observed oscillator phase plane, then apply slow path feedback to the carrier-separated residual
transferable_invariant: a periodic carrier generally needs displacement and normalized-rate quadratures for phase-complete rejection before slow route feedback
nontransferable_details: clocked CPG phase, published gains and frequencies, robot or species kinematics, full-body waves, and task-specific paths
policy_translation: add one bounded phi1/drive_amplitude quadrature to the existing phi_dot1/omega target-line carrier estimate only in the main route request; preserve terminal observer roles and both-joint traveling-wave actuation
falsification: reject if capture is later than 23.4410T, coherent wake or actuator feasibility is lost, or score/mean distance, inside-3L yaw and cross-track motion, and peak moment do not jointly match or improve the replicated full observer
