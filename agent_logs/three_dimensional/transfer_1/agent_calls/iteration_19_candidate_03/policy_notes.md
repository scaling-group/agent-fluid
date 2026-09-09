# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four current sampled evaluations are exact-byte repeats of the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` policy. They satisfy the
  direct-uniform still-water contract (`U_infinity=(0,0,0)`, no cylinders and
  no prewarm) and captured at `0.7466--0.7499L` over
  `18.2050--18.6725T`. This extends the inherited repeat record from `3/3` to
  `4/4`; no sampled semantic failure is present in the current population.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the highest-scoring current repeat (`solver_6b0e320e2f55`), the latest and
  most marginal current repeat (`solver_6845c208b686`), and the inherited
  half-cycle failure (`solver_eabef54fa5c2`). Both captures self-propel through
  termination with a coherent alternating wake and compact three-dimensional
  structures. The half-cycle controller also retains an active wake, but
  turns below the target after a `1.6860L` pass and exits the lower boundary;
  its failure is steering topology rather than advection, carrier collapse,
  or instability.
- The four baseline traces retain about `0.83--0.91L/T` speed at capture while
  action clamps on roughly `68.5--68.7%` / `70.6--71.0%` of rows and both
  joints reach the speed limit. Terminal geometry nevertheless varies widely:
  the latest repeat crosses nearly tangentially, with reconstructed projected
  miss about `0.75L` and target/velocity alignment about `0.05`, whereas
  another repeat crosses nearly aligned. Robust capture therefore does not
  justify changing the carrier, route error, or steering allocation merely to
  reduce clamp fraction.
- In inherited optimizer evidence, distance-only terminal yaw damping changed
  the repeat-backed capture topology into a stable lower exit with minimum
  distance `1.4601L`. A distinct yaw brake using the same
  phase-compensated-yaw observation but gated by both projected capture
  corridor and approach alignment captured at `0.7486L` and `18.381T`; its
  top-down and oblique rows retain the alternating traveling wake. Its action
  clamp (`68.8%` / `70.8%`) and speed-limit residence (`10.4%` / `11.6%`) do
  not establish an actuator benefit over the four-repeat baseline, so the
  result supports compatibility only, not superiority.

## One candidate hypothesis

Repeat the exact evaluated geometry-gated yaw-brake policy without changing
its gains or gates. It leaves the repeat-backed achieved-course route error,
intercept release veto, traveling bend, and sparse outward-carrier reserve
unchanged. Only after normalized target/velocity projection says the fish is
inside an approaching capture corridor does it add a small residual opposing
phase-compensated body yaw. This tests whether the mechanism's one capture is
repeatable while avoiding the evidenced failure of distance-only damping and
the confounding of scalar retuning.

Expected test: preserve far-field closure and both coherent wake views, then
capture without exceeding the baseline action/speed and force/moment envelope.
The mechanism is useful only if exact repeats retain capture and eventually
show less terminal path variation, better arrival/distance integral, or lower
loads; a single additional threshold crossing alone is not an improvement
claim.

Falsification: reject the mechanism and restore the exact speed-reserve
baseline if this repeat loses capture, weakens the traveling wake, increases
loads or saturation, or if repeated captures remain indistinguishable from or
worse than the baseline in terminal geometry and score. Do not respond to a
failure by widening the distance gate or tuning the damping scalar in
isolation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal capture control
source_mechanism: preserve rhythmic propulsion while interception geometry gates a bounded yaw-damping residual
transferable_invariant: rotational damping must remain subordinate to the active propulsive wave and activate only when measured approach geometry already supports capture
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact beat or vortex phase, and task-specific coordinates or routes
policy_translation: retain the normalized body-frame achieved-course and two-joint traveling-bend baseline; multiply projected-corridor and approach-alignment gates before adding a bounded residual opposing joint-compensated yaw
falsification: reject if exact repeats lose capture, alter far-field closure, weaken the wake, raise loads or actuator saturation, or fail to provide a repeatable terminal benefit over the four-capture baseline
