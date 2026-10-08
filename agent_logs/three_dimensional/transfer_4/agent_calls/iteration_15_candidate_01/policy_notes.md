# Candidate diagnosis and hypothesis

## Evidence diagnosis

- The assigned parent (`solver_dc881bcb1d49`) and the most informative
  sampled comparator (`solver_1fb60267421e`) both satisfy the direct-uniform
  still-water contract (`U_infinity=[0,0,0]`) and terminate by capture. The
  parent has the best sampled score and mean score-distance
  (`-0.0721464`, `1.958037L`); the comparator reaches sooner but has worse
  score and mean distance (`17.6935T`, `-0.0755610`, `1.960960L`).
- In both combined keyframe sheets, the fish translates under its own joint
  motion from release, establishes a coherent alternating reverse-street-like
  mid-plane wake by `4T`, and retains compact paired oblique Lambda2 structures
  through capture. There is no imposed-flow advection, wake collapse, visible
  numerical instability, or terminal collision. The sheets are visually
  close enough that the distance and route histories, rather than vortex size
  alone, determine the useful difference.
- Velocity-aligned posterior work in the parent preserves the energy-only
  reserve's early benefit (`0--3T` mean distance/speed
  `12.214522L/0.2519U`) and improves the sampled mean-distance objective, but
  its route remains longer and wider than the closure-qualified wave-amplitude
  comparator (`13.0071L/0.6102L` versus `12.8750L/0.4571L` center path/maximum
  head cross-track). Near/final course alignment is also weaker
  (`0.787/-0.003` versus `0.881/0.637`). Peak planar force and yaw moment do
  not identify a load failure (`0.039`, `0.019` for the parent), and the
  coherent wake argues against reducing carrier cadence or amplitude.
- The inherited lineage already shows that cadence suppression, phase-load
  gating, shared damping, and terminal alignment/closure gates either regress
  the score or silently use a faster fallback observation. The remaining
  supported defect is not insufficient posterior work; it is failure to
  withdraw the short recovery contribution as soon as the posterior joint has
  actually established its response.

## Policy hypothesis

Preserve the parent's target guidance, posterior-priority traveling-wave
target, closure qualification, work sign, and actuator governor. Add one
state-feedback release condition to the posterior work reserve: normalize the
observed posterior angle-rate orbit by the requested posterior wave envelope,
and multiply the existing work authority by a smooth deficit in that measured
posterior response energy. This is a response-qualified burst, not gain
tuning: it gives the initially weak posterior joint the same bounded work
direction, then removes extra work once the joint itself demonstrates a
developed oscillatory response. It uses only joint state and existing
body-frame closure feedback.

Falsification: reject the mechanism if it erases the parent's first-`3T`
distance/speed advantage, worsens mean distance or capture time, fails to
reduce path/cross-track and improve approach alignment, increases force,
moment, or limit residence, or disrupts either top-down or oblique wake
coherence. Because this candidate has not yet received CFD evaluation, these
are predictions rather than results.

bookshelf_consulted: true
source_domain: Lighthill tail-end reactive propulsion combined with biological burst-redirect and sensor-modulated robotic CPG control
source_mechanism: posterior emphasis supplies reactive thrust, while a transient burst is released when the commanded joint response appears
transferable_invariant: qualify extra posterior work by measured response and withdraw it continuously after that response is established
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, full-body phase patterns, exact vortex phases, and prescribed routes
policy_translation: compute a normalized posterior angle-rate response energy from phi2 and phi_dot2 and use its smooth deficit to release the existing closure-qualified posterior work pump
falsification: reject if early closure is lost, route or capture metrics regress, actuator or load class worsens, or the coherent two-view wake deteriorates
