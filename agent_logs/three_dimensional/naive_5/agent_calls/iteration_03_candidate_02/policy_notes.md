# Candidate wake-policy notes

## Evidence diagnosis before policy edit

All four sampled rollouts satisfy the Phase 2 evidence contract: direct
uniform still water with `U_infinity=[0,0,0]`, no cylinders or prewarm, and
an inertial moving window.  The moving-window shifts track fish motion and do
not explain the trajectory differences.

The assigned parent `solver_0334e73ca6df` is the first semantic improvement in
this lineage.  Its anterior half-cycle asymmetry reaches `5.156L` at
`25.036T`, survives to `39.088T`, and scores `-11.409`, versus minima near
`12.1--12.3L` and upper exits near `9T` for the naive, mean-curvature, and
posterior half-cycle samples.  The top-down row shows a long, coherent
alternating street and sustained leftward self-propulsion; the oblique row
confirms compact three-dimensional caudal structures remain attached to a
nearly straight wake.  In contrast, `solver_28659f83df74` visibly folds into
a C-shaped upward turn with a short curved wake, reaches only `12.263L`, and
leaves the upper boundary at `8.602T`.  The inherited posterior-gated sibling
likewise reaches only `12.321L` and exits upward at `9.003T`, so moving the
same mechanism to the posterior joint is a concrete negative result.

The parent's improvement is incomplete and actuator-distorted.  Its bearing
crosses from `+0.155` to negative by about `3T`, yet body-frame lateral speed
is already positive and the fish continues drifting upward.  It passes the
target x-station at roughly `y=14.68L`, `5.15L` above the target, then swims to
the left boundary.  Its instantaneous yaw-rate error switches inside the
gait, while acceleration is clamped on `57.9%` of samples, joint speed is at a
cap on `48.6%`, and an angle cap appears on `1.35%`.  Peak lateral force and
yaw-moment coefficients (`0.0229` and `0.0108`) are comparable to the
saturated naive carrier, although the rollout remains numerically stable.
Thus the reusable success is the anterior phase-selective steering location
and coherent traveling wake, not the parent's bang-bang yaw-rate loop.

## Policy hypothesis

Keep the parent's centered `0.90T`, `18 deg` state-feedback carrier and lagged
posterior wave.  Replace instantaneous yaw-rate tracking with a bounded course
request formed from body-frame bearing and measured body-frame lateral speed:
the latter should reverse the requested half-cycle as soon as upward slip
appears, before bearing grows to order one.  Reinforce only the compatible
anterior half-stroke, but continuously fade that addition near soft joint-angle
or joint-speed margins and smoothly bound the posterior target.  This retains
the mechanism that produced long-range propulsion while making course
correction depend on normalized observations and preventing steering from
manufacturing thrust through hard-limit clipping.

Falsify the translation if bearing still grows negative after its first zero
crossing, positive lateral slip persists through the target x-station, the
trajectory loses the parent's substantial distance progress, either visual
row loses its coherent alternating wake, or speed/acceleration saturation
remains material.  A successful direction is a downward-curving useful
trajectory with improved minimum distance and much lower cap occupancy, not
merely longer survival.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking by asymmetric flapping and sensor-feedback modulation
source_mechanism: phase-selective amplitude asymmetry allocates steering within a continuing propulsive rhythm
transferable_invariant: preserve the traveling wave, use body-frame course error and observed lateral response to select the useful half-stroke, and withdraw added authority as the actuation envelope is approached
nontransferable_details: published gains, clock-driven phase, robot linkage geometry, exact duty ratios, species kinematics, dimensional speeds, vortex phase, and task-specific routes
policy_translation: infer half-cycle from anterior joint velocity; combine bounded bearing with normalized body-frame lateral velocity; reinforce only the requested anterior half-cycle; fade reinforcement with observed angle and speed margins; keep a bounded lagged posterior target
falsification: reject if upward slip and large negative bearing persist, minimum distance regresses toward 12L, the alternating 3D wake collapses, or actuator-cap occupancy remains material
```
