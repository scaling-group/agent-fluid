# Joint-speed feasibility projection candidate

## Visual and trace diagnosis before the edit

- All four sampled solver examples satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and are two
  byte-identical pairs.  The unguarded line-of-sight-response pair captures at
  `0.749769L` and `27.6045T`; the prefilled two-joint stopping-margin pair
  captures at `0.749992L` and `27.7695T`.
- In both pairs' top-down mid-plane rows, the fish self-propels leftward behind
  an alternating body-attached wake and then rotates its path down through the
  target.  Their oblique Lambda2 rows retain an organized three-dimensional
  wake through capture.  The near-identical route and continued target
  progress across hundreds of lossless window shifts show that this is a
  productive controller trajectory, not background advection or a moving-
  window artifact.
- The symmetric angle stopping guard is an evidenced improvement even though
  its scalar score changes little.  Relative to the unguarded capture it
  removes three posterior `45 deg` contacts, lowers maximum joint angles from
  `0.7826/0.7854` to `0.7655/0.7632 rad`, lowers speed-cap samples from
  `1183/10038` to `1124/10098`, lowers acceleration-clamp samples from
  `1878/10038` to `1700/10098`, and lowers peak planar force/yaw moment from
  `0.03397/0.01548` to `0.02212/0.01041`.  An inherited posterior-only guard
  also captures at `0.749430L` with low peaks (`0.02154/0.00992`), but leaves
  more anterior angle, speed-cap, and clamp exposure than the symmetric guard.
- The remaining limit residence is not passive overspeed: on the symmetric
  trace every one of the `898` anterior and `226` posterior samples at the
  `260 deg/T` cap still commands acceleration in the same direction as joint
  velocity.  The hard integrator discards those commands, so they add no joint
  motion but reveal missing command feasibility.  The current sampled set has
  no failed keyframe sheet; inherited visual/metric digests place terminal
  waveform and redirect-threshold failures in the same coherent pass-by class,
  so they do not support disturbing the capture-proven target-line response.

## Policy hypothesis

Preserve the sampled traveling-bend carrier, posterior lag, redirect, terminal
miss veto, inertial line-of-sight response, and two-joint angle guard exactly.
Add one reflection-equivariant feasibility projection after their allocation:
for each joint, project only a same-direction acceleration onto the acceleration
that fits inside the remaining normalized joint-speed headroom over a short
parameter-owned response horizon.  Opposing acceleration is never weakened,
and the projection is inactive whenever the requested acceleration already
fits.  At the hard speed boundary it maps only outward acceleration to zero,
matching the motion that the existing integrator already realizes instead of
injecting a new braking pulse.

The falsifiable expectation is repeat capture with the same coherent visual
route, no angle contact, materially fewer speed-cap or same-direction-at-cap
samples, and no increase in acceleration-clamp residence, force, or moment.
Reject the projection if it changes unguarded phases, loses capture, weakens
the late target-line turn, shifts saturation into angle contact, or fails to
reduce its targeted speed-limit exposure.  The current candidate's CFD
evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded residual control of rhythmic locomotion
source_mechanism: preserve a productive traveling-wave carrier while measured actuator state projects only infeasible rhythmic commands back into the physical envelope
transferable_invariant: constraint feedback should leave feasible carrier and steering commands unchanged and remove only command energy that observed joint headroom cannot realize
nontransferable_details: published gains, linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: observed joint speed and the owned speed/acceleration limits define a symmetric short-horizon feasible outward-acceleration bound applied after the body-frame target controller and angle guard
falsification: reject if capture or coherent propulsion is lost, the late target-line route changes materially, speed-limit exposure does not fall, angle contact returns, or acceleration-clamp residence or hydrodynamic loads increase

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Its three prescribed commands were then run
  separately.  The first exposed a duplicated assigned-parent marker in the
  rendered workspace `README.md`; removing that duplicate made the material-
  guidance check pass.  The finite two-joint Julia contract and solver editable-
  boundary checks also pass.  No CFD was run.
- All `41` directly referenced parameter fields are owned by
  `target_policy_params()`.  A high-speed reflected state negates both actions
  exactly.  At a speed-boundary state moving toward neutral, the projection
  maps an otherwise same-direction anterior request from `16.619` to
  `0 rad/T^2`; it leaves an opposing posterior request unchanged.
- Applied algebraically to the sampled symmetric-guard trace, the new filter
  changes `947/5049` anterior and `247/5049` posterior actions, removes every
  same-direction request at an observed speed-cap state, and never weakens an
  opposing request.  Material changes span `1.072--23.414T`, so this is a
  carrier-wide envelope test rather than a terminal patch.  The frozen-state
  audit leaves the separately occurring acceleration-clamp count unchanged;
  it cannot predict the counterfactual joint path, cap residence, loads, or
  capture outcome.
