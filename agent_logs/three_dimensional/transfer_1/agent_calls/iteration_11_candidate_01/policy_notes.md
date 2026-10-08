# Common-mode gait-rejection promotion

## Evidence and visual diagnosis before editing

- All four sampled solvers and the assigned-parent rollout are finite captures
  from direct-uniform still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm.  Three samples reproduce the v26 parent at `23.9305 T`, mean
  distance `2.45000 L`, and score `-0.55178099`.  The strongest sample applies
  the existing joint-state carrier estimate to body-frame bearing trend as well
  as observed yaw; it captures at `23.6390 T`, lowers mean distance to
  `2.44217 L`, and improves score to `-0.54450554`.
- I inspected both the top-down vorticity and oblique Lambda2 rows from release
  through capture for the strongest sample, its v26 parent, and the inherited
  low-speed posterior-position failure.  All three are visibly self-propelled:
  compact startup structures become an alternating posterior wake, and the
  fish follows a continuous targetward arc.  The strongest sample retains the
  parent's coherent three-dimensional wake and closes the middle/late route
  slightly sooner.  The position-seed sheet instead straightens the route near
  the middle frames before making a later terminal turn; it shows neither
  passive advection nor numerical instability, so its regression is a control
  transition failure rather than a flow-contract failure.
- Trajectory metrics support that reading.  The strongest sample is slightly
  behind the parent at `4/12 T` (`11.9855/8.4411 L` versus
  `11.9368/8.4209 L`) but ahead by `16/20 T` (`6.0003/3.2546 L` versus
  `6.0297/3.3829 L`).  Its peak planar force and yaw moment remain identical
  to the parent at `0.02974/0.01484`, while maximum speed rises modestly from
  `0.7837` to `0.8100 L/T` and any-command-limit residence from `45.62%` to
  `48.21%`.
- The assigned optimizer's posterior-position seed is a concrete negative
  control.  It improves distance at `2/4/8/12 T` to
  `12.2685/11.8757/10.2454/8.2600 L`, but loses the lead by `16/20 T`
  (`6.0999/3.8015 L`), delays capture to `24.7885 T`, worsens mean distance to
  `2.46154 L`, and raises peak force/moment to `0.03140/0.01567`.  Early
  launch distance alone therefore does not justify another posterior seed.

## One-candidate policy hypothesis

Promote the strongest sampled controller as the single candidate.  Preserve
the v26 completion-gated redirect, posterior traveling bend, carrier-first
steering allocation, and finite acceleration projection.  Apply the already
observed head-joint carrier-yaw estimate consistently to both recent body yaw
and body-frame bearing trend before macroscopic route feedback.  This rejects
one beat-correlated common mode without adding another propulsion gain,
startup stage, wake-phase tracker, coordinate, clock, or mutable oscillator.

Expected evidence is reproduction of the sampled `23.6390 T` capture, lower
distance integral, coherent wake, and unchanged force/moment envelope.  Reject
the mechanism if a repeat or held-out target pose loses capture, arrives later
than the v26 parent, reverses the turn sign, materially increases limit
residence or loads, or damages the alternating posterior wake.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish oscillators and wake-disturbance residual control
source_mechanism: separate slow target-direction feedback from fast locomotor-cycle contamination using observed oscillator state
transferable_invariant: when one bounded joint-state rhythm contaminates multiple route-feedback channels, remove the same observed common-mode estimate consistently before judging macroscopic steering response
nontransferable_details: published gains, robot geometry, clocked CPG phase, species-specific kinematics, exact vortex phases, and prescribed routes
policy_translation: add the existing bounded head-joint-rate carrier estimate to raw body-frame bearing trend as well as raw recent yaw, then retain the normalized target feedback and two-joint acceleration contract
falsification: reject if capture time or mean distance fails to beat v26, if the turn direction regresses, or if wake coherence, actuator-limit residence, speed, force, or moment worsens materially

## Evidence boundary

All numerical and visual claims above are completed sampled or inherited CFD
evidence.  This worker does not claim a new same-worker CFD result; formal
evaluation occurs after exit.
