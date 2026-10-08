# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=0`; no prewarm snapshot or cylinder wake is present. I
  inspected both the top-down vorticity and oblique Lambda2 rows in each
  combined keyframe sheet, with particular comparison of the assigned parent
  `solver_b3b6be8f076f` and the finite near miss `solver_4f3d51f38935`.
- The assigned parent retained a coherent self-propelled wake but held a
  same-sign bend in the high corridor, reached only `4.2785L`, and exited the
  upper margin at `27.07T`. Its global projected-intercept and closing-speed
  release qualification therefore latched a redirect at range rather than
  fixing the trajectory.
- The bend-attainment release plus local terminal veto in
  `solver_4f3d51f38935` preserved the broad downward path and coherent 3D wake,
  avoided angle contact, kept peak planar force/yaw moment near
  `0.0214/0.0098`, and approached to `0.8328L`. It missed the `0.75L` capture
  circle by `0.0828L` and then exited left.
- The near-miss trajectory exposes a specific gate mismatch. At about
  `24.74T`, range was `1.93L`, speed about `0.65L/T`, and the current course
  projected a `1.60L` miss, yet the fixed `1.75L` terminal zone was still off;
  bend/yaw release left redirect weight near `0.18`. At closest approach
  (`27.47T`), speed remained about `0.66L/T`, projected miss was about `0.81L`,
  and closing speed had reversed. The images show a clean fly-by, not wake
  collapse or moving-window advection.
- Inherited optimizer scores reinforce a plateau rather than a scalar reason
  to increase drive: three completed descendants reached `0.8298L`,
  `0.9269L`, and `0.8328L` without capture and all terminated left-domain.

## Policy hypothesis

Start from the evidenced bend-attainment-release near-miss controller, not the
assigned parent's far-field latch. Add one predictive terminal interception
mechanism: inside a capped body-length approach zone, combine the normalized
velocity/target cross product with the observed time to closest approach. A
large projected miss whose closest approach is imminent should (1) veto bend
or yaw release, (2) override weak body-bearing entry authority, and (3) deepen
the same sign-calibrated two-joint redirect. The gate fades to exactly zero at
range or when the projected course enters the capture corridor, preserving the
sampled carrier and broad route.

Expected result: begin useful redirect authority before the `1.93L` state,
move the head at least `0.083L` farther into the capture circle, and terminate
with success without recreating the parent's high-corridor static bend.
Falsification: reject the mechanism if minimum distance is not below `0.75L`,
if it latches outside the approach zone, if the downward route or 3D wake is
lost, or if angle contact, peak load, or speed/acceleration-limit residence
materially exceeds the sampled near miss.

bookshelf_consulted: true
source_domain: biological and robotic-fish terminal capture and burst redirect
source_mechanism: far/middle/near approach scheduling with an observed-state C-start redirect and near-target drive/turn relief
transferable_invariant: a tight capture problem needs a bounded near regime that anticipates stopping or turning distance, applies observed-error redirect authority, and releases when the measured intercept becomes safe
nontransferable_details: published gains, dimensional response times, species-specific C-start kinematics, exact vortex phases, and task-specific routes
policy_translation: in the two-joint contract, use normalized body-frame target and velocity to estimate projected miss and time to closest approach; only within a capped body-length zone, smoothly override bearing entry and veto bend/yaw release with the established sign-corrected same-sign redirect
falsification: reject if capture remains above 0.75L or if the gate causes far-field latch, trajectory-topology loss, wake degradation, angle contact, load spikes, or materially greater actuator-limit residence
