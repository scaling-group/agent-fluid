# Joint-rate viability candidate

## Evidence read before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and capture. The two policy
  hashes each repeat exactly, so the useful comparison is the unguarded
  line-of-sight closure (`solver_0ce6bb065e92`, `0.749769L` at `27.6045T`)
  against the assigned guarded parent (`solver_d4e666268ba9`, `0.749992L` at
  `27.7695T`).
- In both combined-sheet rows, the parent self-propels from rest with an
  organized body-attached alternating wake, translates continuously toward
  the target, and makes a late correct-sign bend through the capture circle.
  The oblique Lambda2 structures remain attached to the oscillating body and
  trail behind it, while 264 lossless window shifts follow the world path;
  this is coherent three-dimensional propulsion rather than storage-window
  advection. No sampled failure sheet exists in this workspace. The inherited
  failure digest therefore supplies the contrast: terminal wave, recoil, and
  instantaneous-intercept variants kept similarly coherent wakes but passed
  at `0.828--1.096L` and exited left.
- The symmetric stopping-margin guard is evidence-backed progress: relative
  to the unguarded capture it removes the three `45 deg` posterior contacts,
  lowers acceleration-clamp samples from `1878/10038` to `1700/10098`, reduces
  peak planar force/yaw moment from about `0.03397/0.01548` to
  `0.02212/0.01041`, and slightly improves mean distance from `2.615648L` to
  `2.615460L`. It also reduces speed-cap samples, but only from `1183/10038` to
  `1124/10098`; both joints still reach `260 deg/T`. Moving the angle threshold
  farther inward would conflate angle and rate defects and risks perturbing the
  captured route.

## Policy hypothesis

Keep the capture-proven carrier, body-frame target/course selector, same-sign
redirect, terminal miss veto, inertial line-of-sight positive-response-deficit
branch, posterior follower, and two-joint angle-stopping guard unchanged. Add
one symmetric rate-viability barrier after the angle guard. For each observed
joint independently, measure normalized speed headroom. Only if the current
combined command would accelerate in the same direction as a near-limit joint,
smoothly blend that outward component toward a small inward command; all
inward commands and all states below the soft rate boundary remain exactly the
parent controller. This is a separate feedback mechanism, not a retune of the
carrier or navigation gains.

The falsifiable expectation is repeat capture with the same coherent broad
route, no angle contact, and fewer exact speed-cap and acceleration-clamp
samples without increased planar force or yaw moment. Reject the mechanism if
capture becomes `left_domain`, the late target-directed bend or alternating
wake changes materially, speed-cap residence is merely replaced by oscillation
at the soft boundary, propulsion slows enough to worsen mean distance, or any
joint/load envelope measure regresses. Formal CFD occurs only after this worker
exits, so none of those outcomes is claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated rhythmic robotic-fish control and finite-envelope locomotion
source_mechanism: preserve a productive traveling-wave carrier while a bounded state residual removes only commands that consume exhausted actuator-rate headroom
transferable_invariant: intervene symmetrically and only when normalized observed joint rate plus command direction predicts further motion into a finite speed envelope
nontransferable_details: published CPG gains, species-specific kinematics, dimensional frequencies, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: normalized absolute joint speed gates an inward-only modification of same-direction acceleration on each joint, downstream of the captured body-frame steering and angle guard
falsification: reject if repeat capture, coherent propulsion, speed-cap reduction, or load and joint-envelope preservation fails relative to the assigned guarded parent

## Non-CFD implementation audit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its three prescribed commands were therefore
  run directly and separately. After removing one duplicate rendered parent
  marker from the workspace `README.md`, the guidance-semantic check, finite
  two-joint Julia contract, deterministic parameter-schema check, and solver
  editable-boundary check all pass. All 42 direct `params.FIELD` references are
  owned by `target_policy_params()`.
- Applying only the new rate-barrier algebra to the recorded guarded-parent
  trace changes `931/5049` joint-1 and `259/5049` joint-2 commands; all but
  two changes exceed `0.1 rad/T^2`. There are zero frozen-state cases that
  strengthen acceleration in the direction of joint motion and zero output
  bound violations. This is a locality and direction audit, not a
  counterfactual rollout prediction.
- A synthetic state below the soft rate boundary exactly reproduces the
  assigned parent. A near-limit state with an outward posterior command changes
  that joint from `+30.0` to about `-1.994 rad/T^2` while leaving the already
  inward anterior command unchanged. Reflecting target/velocity lateral
  components, rates, joint angles, and joint velocities negates both candidate
  commands to floating-point tolerance. These checks establish material
  activation, boundedness, and reflection equivariance only; no CFD was run.
