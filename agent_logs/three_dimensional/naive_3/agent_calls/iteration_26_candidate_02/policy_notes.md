# Paired positive-work speed-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations report direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The combined sheets for
  the strongest soft-envelope capture, the assigned parent, and the prior
  reallocation candidate were inspected from release through capture. Their
  top-down rows retain a coherent alternating red/blue street, and their
  oblique rows retain compact three-dimensional Lambda2 structures behind the
  caudal region. Peak swimming speed is `1.373--1.404U` while peak local flow
  is only `0.0297--0.0325U`, so the motion is self-propelled rather than
  moving-window advection.
- The unguarded soft-envelope controller remains the strongest sampled route:
  capture at `16.943T`, mean distance `2.08985L`, and peak force/yaw moment
  `0.03609/0.01766`. Its residual defect is exact `260 deg/T` speed contact in
  `115/109` anterior/posterior samples. The assigned parent's phase-local
  `0.94` positive-power guard removes all exact contacts, retains capture and
  the alternating wake, and reaches `17.115T` with mean distance `2.09800L`,
  peak speed `1.404U`, and loads `0.03564/0.01782`.
- The inherited log proposed sending guarded anterior acceleration into the
  posterior carrier. Its completed sample also removes exact contacts, but
  reaches only `17.275T`, mean distance `2.09808L`, and peak speed `1.373U`;
  it recovers only `0.055T` and about `0.004L` mean distance from the inherited
  direct `0.90` guard and does not beat the narrower assigned-parent guard.
  The logged phase data explain why carrier-direction agreement was too weak a
  transfer condition. At every one of the baseline's `115` anterior speed
  contacts, the posterior command is not simultaneously doing positive joint
  work. At `96` of `109` posterior contacts, however, the anterior command is
  doing positive work, and its speed is below `90%` of the envelope. Above the
  parent's `0.94` risk onset, the same contrast is `1/199` feasible
  anterior-to-posterior samples versus `131/179` feasible
  posterior-to-anterior samples. Reallocating into braking is not a supported
  way to recover guarded propulsive work.

## Policy hypothesis

Preserve the assigned parent's body-frame target/course feedback,
zero-centered anterior oscillator, posterior lag and steering reserve, high
knee acceleration shoulder, `0.94` phase-local speed guards, and posterior
kinetic angle-margin projection. Add one bounded posterior-to-anterior
allocation after the two speed guards. Only when the posterior guard has
removed positive joint work, the anterior command is already positive-work,
and anterior speed remains below the evidenced `0.90` receiver ceiling, move
`0.35` of the removed acceleration magnitude into the existing anterior
command direction. The routine command still passes through the evidenced
`0.95` soft ceiling; only this state-gated transfer may use a small explicit
reserve up to `0.99` of the physical acceleration envelope. The fraction is
retained from the prior allocation test so this evaluation changes the
observed direction and phase semantics rather than introducing another
carrier-gain sweep. A non-CFD replay of this projection on the strongest
logged trace admits `119/3081` transfers, with mean `1.096` and maximum
`1.278 rad/T^2`; capping at the old soft ceiling would instead average only
`0.003 rad/T^2`. This establishes that the candidate mechanism is selective
and material but does not predict its closed-loop CFD result.

Expected result: retain capture, zero exact speed contact, bounded
accelerations, and both alternating wake views while recovering route work
relative to the assigned parent's `17.115T` and `2.09800L`. Falsify the
mechanism if capture or coherent shedding is lost, either speed limit is
touched, arrival or mean distance fails to improve, anterior angle use grows
materially, or force/yaw moment exceeds the unguarded soft-envelope reference
`0.0361/0.0177`.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and phase-modulated rhythmic locomotion
source_mechanism: sensor feedback changes bounded cycle-resolved actuation while preserving a coupled propulsive rhythm
transferable_invariant: actuator-limited work should be redirected only into an observed phase-compatible channel with measured state headroom, while braking and rhythm reversal remain untouched
nontransferable_details: published gains, dimensional cadence and amplitude, species-specific kinematics, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speeds and signs of phi_dot times assembled phi_ddot; when the posterior positive-work guard removes acceleration, transfer a bounded fraction only into an already positive-work anterior command below its observed receiver-speed boundary and within a sub-hard-envelope acceleration reserve
falsification: reject if speed contact returns, capture or alternating three-dimensional shedding is lost, route metrics do not beat the assigned parent, anterior angle use grows materially, or loads exceed the soft-envelope reference
```
