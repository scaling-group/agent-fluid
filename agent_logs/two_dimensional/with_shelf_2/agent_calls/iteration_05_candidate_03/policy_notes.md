# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet supplies a common initial condition: the fish is
  held at the upper-right release pose while four fully developed vortex
  streets interact around the target. Released-sheet differences can therefore
  be compared as controller evidence rather than different initial wakes.
- The prefilled posterior-total-curvature policy actively swims upstream but
  does not capture. Its sheet first approaches the wake corridor, then curls
  upward and leaves the domain after `84.22` release-time units. Metrics agree:
  minimum/mean/final distance are `2.430/6.644/6.201L`, head displacement is
  `(-10.515,+1.801)L`, and force/moment RMS are only `116/1278`. Its low load
  is not a semantic improvement: joint 2 still reaches `0.727` rad, both joint
  rates reach the hard cap, and the target remains missed.
- The response-aware distributed half-cycle policy without load gating is a
  useful matched failure. It enters the target neighborhood and reaches
  `1.646L`, but then folds into a near-vertical lower exit after `75.09` units;
  force/moment RMS rise to `487/4680` and both joint rates hit the cap. Thus its
  heading response improves route geometry but does not by itself stop a large
  wake/body yaw event from amplifying the steering asymmetry.
- Adding a smooth, nonzero-floor gate from `abs(moment_z_L2)` to only that
  steering asymmetry changes the matched rollout to `target_reached`: the sheet
  shows a continuous self-propelled diagonal arc into the useful wake corridor,
  capture occurs after `51.47` units at `0.748L`, and mean distance falls to
  `1.820L`. Upstream/lateral displacement becomes `(-11.276,-4.936)L`; force
  and moment RMS fall relative to the ungated matched policy to `426/4084`.
  Velocity-cap contact and substantial yaw load remain, so the evidence
  supports the steering/load separation, not a claim of globally gentle or
  efficient swimming.

## Candidate hypothesis

Replace the prefilled posterior-curvature failure with the evaluated
response-aware distributed half-cycle controller and its single steering-only
yaw-load gate. Current body-frame bearing minus bounded observed heading
response supplies the slow route request. Joint-state feedback retains the
zero-centered traveling bend; a smooth magnitude gate reduces only the
half-cycle steering residual when normalized yaw load is large, never deleting
propulsion or all steering. This candidate intentionally reproduces the
sampled successful mechanism instead of adding an unevaluated scalar or a
second architecture change.

The formal rerun should preserve the diagonal approach and first-crossing
success. Falsify the candidate if it loses upstream propulsion, fails to beat
the prefill's `2.430L` closest approach, returns to either upper- or
lower-boundary exit, or becomes unstable. Even if it repeats success, later
workers should treat persistent velocity-cap contact and `4084` moment RMS as
unresolved; test a separately evidenced smooth propulsive-envelope or
sign-resolved disturbance mechanism rather than increasing half-cycle gains.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish direction tracking
source_mechanism: retain rhythmic propulsion while reducing only target-steering modulation during large observed hydrodynamic yaw loads
transferable_invariant: slow normalized body-frame target error should request the route, while normalized load magnitude bounds the steering residual during strong disturbances without cancelling the propulsive wave
nontransferable_details: published gains, species-specific kinematics, robotic CPG topology, dimensional load scales, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: form bounded turn demand from bearing minus observed heading response, apply it as two-joint half-cycle acceleration asymmetry, and multiply only that asymmetry by a smooth floor-bounded function of abs(moment_z_L2)
falsification: reject if upstream propulsion or closest approach regresses, target reach is lost, load/cap symptoms become unstable, or the trajectory returns to a boundary-exit topology
