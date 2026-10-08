# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled solvers are finite captures from direct uniform still-water
  initialization (`U_infinity=0`) with no cylinders. They reproduce the exact
  `22.154001T` arrival, `0.748384L` crossing, `2.105583L` mean distance, and
  `-0.210952` score. Three carry the fixed-lead recovery policy; the prefilled
  fourth extends proximity preview into posterior recovery, but differs only
  at floating-point roundoff in the trajectory. This is a concrete negative
  result: posterior-recovery prediction has no semantic authority on the
  encountered route and should not receive another scalar or gate refinement.
- The complete combined sheet shows self-propulsion rather than advection: a
  compact alternating mid-plane street develops by `4T`, remains attached to
  the swimming path, and is accompanied by discrete three-dimensional
  Lambda2 structures through the `22.15T` capture. The path is a smooth
  target-reaching S-curve, not a collision or boundary-exit trajectory. The
  paired sample with the same top-down row but black oblique panels is a render
  artifact; its identical numerical result is not independent 3D-wake
  confirmation. No sampled policy failure sheet is available in this
  workspace, so inherited lower/upper exits are used only as numerical and
  logged negative controls, not as newly inspected visual evidence.
- Numerical cross-checks agree with the complete sheet: mean action is about
  `59.932`, exact anterior/posterior rate-cap occupancy is `11.49/6.41%`, and
  peak normalized force/moment are `0.030897/0.015839`. Propulsion therefore
  remains useful and bounded. The candidate should not alter the carrier,
  posterior recovery magnitude, or reactive-rudder ceiling.
- The remaining opportunity is geometric. Along the final approach the full
  normalized head-relative target angle averages about `0.62 rad` over
  `16--20T` and `0.75 rad` over `20--22.15T`, reaching about `1.1 rad` at the
  crossing. In contrast, the fixed `0.25L` denominator in the folded bearing
  reduces its final signal to about `0.04--0.08 rad`; together with rhythmic
  sideslip, the existing slow-course request can have an away-from-target mean
  over `21--22T`. The full-angle posterior rudder still secures capture, but
  the anterior slow curvature center loses finite-distance pursuit authority.

## Policy hypothesis

Preserve the complete sampled controller and add one bounded approach-course
translation. As normalized distance falls from `2.5L` to `1.25L`, smoothly
blend at most 20% of the wrapped difference between full head-relative target
angle and folded bearing into only the anterior slow-course observation. This
keeps the launch and middle route executable-identical, preserves the
through-water slip correction and all posterior paths, and restores a small
target-signed mean curvature without imposing a clock, route, or world-frame
direction. Reject the hypothesis if capture is later than `22.154001T`, mean
distance exceeds `2.105583L`, the preterminal S-route or complete two-view wake
changes materially, or action, saturation, force, or moment exceed the sampled
envelopes.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and biological/robotic turning by bounded curvature bias
source_mechanism: preserve a propulsive rhythm while mapping observed target-direction error into a bounded mean bend, with a distinct near-target regime
transferable_invariant: finite-distance target geometry should retain a smooth target-signed mean steering component without suppressing the traveling carrier
nontransferable_details: published CPG gains, fish-specific kinematics, dimensional distances, prescribed phases, exact vortex timing, and task-specific routes
policy_translation: use normalized body-frame distance and full target angle to blend a capped correction into the anterior course center only; retain joint-state phase, through-water slip feedback, and every posterior allocation unchanged
falsification: reject if arrival or mean distance fails to beat 22.154001T/2.105583L, or if the established route, two-view wake, saturation, action, force, or moment envelope worsens
