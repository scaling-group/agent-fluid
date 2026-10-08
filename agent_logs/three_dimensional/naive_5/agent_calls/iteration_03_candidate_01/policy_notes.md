# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled observations report direct uniform initialization at
  `U_infinity=(0,0,0)`, no cylinders, and finite `left_domain` termination.
  The assigned-parent optimizer artifact is unchanged in this workspace and
  its inherited log identifies `solver_0334e73ca6df` as the strongest sampled
  child (`-11.4092`, minimum distance `5.1559L`).
- In both visual rows, the naive seed (`solver_5c7c5c0e3ed9`) is visibly
  self-propelled rather than advected: it creates a compact alternating wake,
  but curls upward and exits at `8.547T` after improving only `0.250L`.
  Its trace reaches the joint-speed cap and repeatedly requests acceleration
  beyond the envelope. The posterior half-cycle candidate
  (`solver_28659f83df74`) stays sub-limit but preserves the same tight curl,
  reaches only `12.263L`, and exits at `8.602T`; moving the phase-selective
  actuator to the tail did not supply useful steering in that formulation.
- The best child applies half-cycle steering at the anterior joint. Its
  top-down row shows a long coherent reverse-vortex street and sustained
  leftward translation; the oblique row confirms body motion and a stable 3D
  wake rather than a moving-window artifact. It travels for `39.088T` and
  reduces distance from `12.328L` to `5.156L`, a different and much more useful
  trajectory than the inherited upper curl.
- That child nevertheless stays in the high-y corridor (`13.780L` to
  `14.961L`). At closest approach its center is approximately
  `(9.40,14.68)L` and reconstructed body-frame bearing is `-1.50 rad`; it then
  passes the target longitudinally and exits the left boundary with final
  distance `10.235L`. Its joint trace is also not sub-limit in practice:
  joint speed is at the cap on about `52.8%` of samples and applied acceleration
  is at the candidate's `30 rad/T^2` clamp on about `58.1%`.
- Reconstructing the sampled controller's own feedback shows the mechanism
  fault: once bearing is strongly negative, the desired normalized turn has a
  fixed positive sign, but instantaneous beat-scale `heading_rate` repeatedly
  reverses the rate error. Mean `turn_side` remains only about `0.11` to `0.13`
  from `8T` through `32T` even as mean bearing grows from `-0.54` to below
  `-1.2 rad`. The loop therefore acts mainly as within-beat yaw damping and
  fails to turn the sustained geometric error into cross-track motion.

## Policy hypothesis

Preserve the only demonstrated long-range carrier and the anterior
phase-selective actuator, but separate persistent route demand from beat-scale
yaw. Drive half-cycle side directly from bounded body-frame bearing whenever
the target is materially off-axis. Restrict instantaneous heading-rate damping
to a narrow centerline gate, where preventing a new curl matters more than
maintaining large turn authority. Use a smaller half-cycle acceleration than
the sampled child's peak because the geometric request will no longer be
cancelled on alternate yaw-rate excursions.

This should bend the useful leftward trajectory downward before its
longitudinal target crossing while retaining an alternating traveling wake. It
is falsified if the result returns to an approximately `9T` upper exit, if
minimum distance remains near `5.16L` with high-y longitudinal overshoot, if
the wake loses coherent propulsion, or if limit residence/load spikes increase
despite the smaller phase-selective command.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning
source_mechanism: target-error-driven asymmetric flapping or duty-ratio modulation
transferable_invariant: preserve a propulsive traveling rhythm while persistent direction error selects and strengthens one observed half-cycle
nontransferable_details: published gains, clocked CPG phase, robot geometry, species kinematics, dimensional cadence, and task-specific routes
policy_translation: use normalized body-frame bearing to select an anterior joint-state half-cycle, with yaw damping only near target alignment
falsification: reject if target-directed cross-track progress does not improve, the prior tight curl returns, propulsion collapses, or actuator/load saturation worsens
