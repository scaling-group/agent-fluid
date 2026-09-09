# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled rollouts are valid direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot. The
  top-down and oblique rows show self-propelled motion and body-connected
  alternating wakes, so the trajectory differences are controller evidence,
  not passive advection.
- The inherited phase-compensated shared half-cycle controller
  `solver_77835bec7423` is a large semantic improvement. Its top-down row shows
  a long, nearly horizontal target-directed track and a coherent staggered
  wake through `27.43T`; the oblique Lambda2 row confirms that the wake remains
  three-dimensional and attached to productive tail beats. It reaches
  `3.174L`, compared with `9.527--11.347L` for the other sampled failures, and
  replaces their early upper-boundary exits at `9.25--10.41T` with a later
  left-boundary exit.
- The remaining defect is a fast lateral pass rather than lost propulsion.
  At the closest sample (`18.095T`) the head is `(8.680,12.658)L`, leaving the
  target about `(-1.62,-2.73)L` in the fish body frame despite being slightly
  ahead longitudinally. The fish then holds center `y` near `12.8--13.1L` and
  cruises past the target to center `x=0.800L`. Mean speed rises to `0.800L/T`
  from `0.453L/T` for the response-gated parent; anterior/posterior joint rates
  occupy the hard-limit neighborhood in `12.0%/12.5%` of samples, and the
  action cap is occupied in `11.2%/26.4%`. Thus the phase compensation should
  be preserved, but its improved straight propulsion has exposed insufficient
  turn radius and approach control.
- The current restricted bearing uses `abs(target_body_L[1])`, so it does not
  distinguish a target ahead from one behind. After the pass the existing
  controller can therefore relax when lateral error is small even though the
  target is almost directly aft. The normalized vector itself supports a
  full-circle, reflection-equivariant pursuit angle without using coordinates
  or a route.
- Inherited logs rule out carrier braking as a general reserve mechanism: the
  earlier rate barrier removed hard-rate occupancy but reduced mean speed to
  `0.279L/T`, regressed closest approach to `11.643L`, and repeated the upper
  exit. They also show that persistent mean curvature can collapse useful
  translation. Any drive relief here must therefore be conditional on both
  approach distance and misalignment, and must restore the evidenced carrier
  continuously when alignment returns.

## Single candidate hypothesis

Preserve the inherited joint-state carrier, posterior lag, phase-compensated
yaw residual, and shared half-cycle steering. Replace the restricted bearing
with a full-circle pursuit angle computed from normalized `target_body_L`.
Add one smooth approach-redirect gate from normalized distance and absolute
pursuit angle: near the target while badly misaligned, reduce only the
symmetric carrier contribution while leaving the signed half-cycle term
intact. This state-gated trade converts the already saturated steering request
into a bounded burst redirect without a static curvature equilibrium; as the
target aligns, the original propulsive carrier returns automatically.

The candidate is falsified if it loses the coherent alternating wake or early
leftward progress, fails to beat the `3.174L` closest approach, still exits the
left boundary without a target-return arc, or suppresses speed as broadly as
the inherited `0.279L/T` rate-barrier failure. Capture, a better termination
class, or a clearly tighter second approach would be semantic support; a score
change alone would not.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish terminal approach control
source_mechanism: large observed angular error temporarily trades symmetric propulsive drive for bounded turning authority, then releases continuously back to cruise as alignment recovers
transferable_invariant: normalized distance and full body-frame target angle can gate a reversible shift from symmetric traveling-bend propulsion toward retained signed half-cycle steering
nontransferable_details: published C-start gains, maneuver duration, species curvature, robot duty ratios, exact vortex phase, dimensional speed, and any task-specific route
policy_translation: compute a full-circle pursuit angle from `target_body_L`; preserve phase-compensated shared half-cycle feedback and smoothly attenuate only its symmetric carrier when distance is small and angular error is large
falsification: reject if wake coherence or early progress collapses, minimum distance is not below `3.174L`, the fish cannot arc back after passing, or broad drive suppression reproduces the slow rate-barrier failure
