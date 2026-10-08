# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- The assigned prefill parent (`solver_2a272b23001c`) and every current sampled
  solver use direct uniform still water (`U_infinity=[0,0,0]`), no cylinders or
  prewarm, stable dynamics, and `capture` termination. The parent captures at
  `17.6935T` with score/mean distance `-0.075561/1.960960L`, center path
  `12.8750L`, maximum head cross-track `0.4571L`, and near/final course
  alignment `0.881/0.637` according to the inherited diagnosis.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the parent, the energy-only reserve (`solver_aa78a1c20ec5`), and the sampled
  score leader (`solver_dc881bcb1d49`). All three self-propel from rest, form a
  coherent alternating mid-plane street by `4T`, and retain compact paired 3D
  posterior structures through capture. There is no passive advection, wake
  breakup, collision, or visible numerical instability. The useful difference
  is therefore the early route imprint, not gross wake formation.
- Replacing posterior target amplification with closure-qualified,
  velocity-aligned posterior work produced the best sampled score/mean
  distance (`-0.072146/1.958037L`) and retained the early `0--3T` benefit
  (`12.214522L`, `0.2519U`), with slightly lower peak planar force/yaw moment
  (`0.039/0.019`). It nevertheless widened the route to `13.0071L` path and
  `0.6102L` cross-track, and ended nearly tangentially
  (`-0.003` alignment, `-3.068 rad/T` yaw). Thus useful posterior work can
  also reinforce a phase-plane direction that fights the unchanged lagged
  wave/steering target and leaves an early course displacement.
- Two inherited completed release experiments rule out broader observation
  gates. Qualifying posterior work by established posterior response regressed
  from `-0.072146` to `-0.082282` despite retaining capture; replacing range
  closure by target-projected body translation caused a `left_domain` failure
  at score `-11.5034` after reaching only `0.9166L`. Do not repeat either
  response-magnitude or translation-semantic release without new evidence.
- An offline replay of the sampled work-reserve trajectory finds the existing
  closure/carrier reserve active for about `8.9%` of samples. Roughly `23.4%`
  of its gate-weighted authority occurs while posterior velocity points away
  from the instantaneous lagged posterior target. A smooth one-sided
  tracking-work guard with normalized transition scale `0.08` would retain
  about `90.8%` of total and first-`3T` reserve authority while removing only
  that contradictory work direction. This replay is a policy-signal
  diagnostic, not CFD evidence.

## One policy hypothesis

Start from the sampled-best closure-qualified posterior-work architecture and
preserve its anterior phase-plane carrier, lagged posterior target, odd
mean-curvature and half-cycle steering paths, route observer, approach handoff,
cadence schedule, and reversal-preserving output governor. Add one
phase-consistency guard: normalize `(tail_target - phi2) * phi_dot2` by the
posterior angle/rate envelope, retain full work authority when posterior motion
reduces the current target error, and smoothly withdraw only velocity-aligned
work that moves farther from that target. The guard adds no clock, stored
phase, world coordinate, or target identity.

Expected evidence is retention of the work reserve's early distance and mean
distance benefit with route/cross-track and terminal yaw closer to the assigned
parent. Reject the mechanism if capture or first-`3T` progress regresses,
course/path metrics do not improve, acceleration-limit residence or loads
increase, reflection symmetry fails, or either visual wake view loses
coherence. The new candidate has not received CFD evaluation, so these are
predictions rather than results.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion combined with sensor-modulated robotic-fish CPG control
source_mechanism: reinforce posterior oscillatory work while preserving the traveling-wave relation and keeping mean steering on a separate feedback path
transferable_invariant: extra posterior work should not amplify measured motion that is carrying the joint away from its current lagged wave and steering target
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body phase patterns, exact vortex phases, and task-specific routes
policy_translation: multiply the existing closure-qualified posterior velocity work by a bounded one-sided guard from normalized posterior target error times posterior joint rate
falsification: reject if early closure or score-distance benefit is lost, route and terminal yaw do not improve, actuator/load class worsens, or the coherent top-down and oblique wake deteriorates
