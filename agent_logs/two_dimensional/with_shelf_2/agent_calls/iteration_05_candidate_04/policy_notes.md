# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet confirms the common upper-right release pose and
  four developed, interacting cylinder wakes. It is identical across sampled
  candidates, so the released trajectory differences are controller evidence.
- The prefilled `solver_e6805fe0c5bc` is the only sampled semantic success. Its
  keyframes show active upstream swimming into the central wake followed by a
  smooth downward-left approach that crosses the target circle, rather than
  passive downstream advection. It reaches the target after `51.47` release
  units with minimum/final distance `0.748L`, progress `0.940`, and head
  displacement `(-11.28,-4.94)L`.
- The closest architectural control, `solver_a84fba8bf04f`, has the same
  heading-response distributed half-cycle steering but no hydrodynamic-load
  gate. It visibly enters the useful wake and passes near the target before
  folding into a nearly vertical downward escape. Metrics confirm a `1.646L`
  closest approach followed by `-13.23L` lateral displacement and
  `left_domain` at `75.09`. Adding the yaw-moment-magnitude gate in the
  successful sample changes the termination class, shortens the route, and
  reduces force/moment RMS from `487/4680` to `426/4084`.
- The success is still load intensive: normalized diagnostics show anterior
  bend `0.721 rad`, both joint velocities at the `4.538 rad/time` hard cap,
  acceleration peaks near the candidate's `29 rad/time^2` soft limit, lateral
  force RMS `426` (about `6.66` after division by `L`), and yaw-moment RMS
  `4084` (about `1.00` after division by `L^2`). The posterior-curvature sample
  `solver_b2565fd6bd70` has much lower `116/1278` loads but misses at `2.43L`
  after a wide oscillatory route, so replacing the successful steering
  scaffold with posterior curvature is not supported.

## Policy hypothesis

Preserve the successful zero-centered traveling bend, heading-response route
request, half-cycle composition, and nonzero steering floor. Extend only the
disturbance gate: combine the magnitude of normalized body-frame lateral force
with normalized yaw moment as a smooth hydrodynamic-load norm. Moment detects
rotational loading; lateral force can detect a strong translational wake event
before or without a proportionate moment. The combined norm attenuates only
the steering residual, never the symmetric propulsive wave, and uses a force
scale placed just above the successful rollout's normalized RMS so ordinary
loads do not indiscriminately suppress steering.

Expected evidence is retained target capture and substantial upstream travel,
with lower force/moment or cap symptoms and no return of the post-pass downward
arc. Falsify the extension if capture is lost, closest approach exceeds the
successful `0.748L` baseline, upstream displacement regresses materially, or
the same load/cap symptoms remain. In that case retain the evidenced
yaw-moment-only gate and test terminal approach relief or sign-resolved wake
feedback only after directional time-history evidence is available.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish direction tracking
source_mechanism: separate persistent target steering from bounded hydrodynamic-disturbance rejection without cancelling rhythmic propulsion
transferable_invariant: normalized load magnitude may reduce only the steering residual during strong wake/body interactions while a nonzero floor preserves route authority and the zero-centered wave preserves thrust
nontransferable_details: published gains, dimensional force and moment scales, robot or species kinematics, prescribed CPG phase, exact vortex phase, and task-specific routes
policy_translation: keep the successful body-frame bearing and heading-response half-cycle controller; replace its yaw-only gate input with a root-sum-square norm of moment_z_L2 and scaled abs(force_body_L[2]), retaining the same smooth floor-bounded gate
falsification: reject if target capture or upstream displacement is lost, if closest approach regresses, or if force, moment, joint-cap, and trajectory evidence do not improve
