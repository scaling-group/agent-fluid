# Terminal measured-bearing-response candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, inertially still moving-window fill, and capture
  termination. Three samples are byte-identical copies of the assigned parent
  and reproduce the complete trajectory: capture at `16.93205T`, score
  `-0.20004481`, and crossing distance `0.74389L`.
- I inspected the combined sheets for the replicated parent and the
  informative weaker bidirectional allocator from release through capture,
  including the top-down mid-plane vorticity row and the oblique body/Lambda2
  row. Both advance continuously toward the target behind an alternating
  red/blue street and compact three-dimensional caudal structures. Neither
  shows passive advection, held-joint coasting, wake collapse, collision, or
  boundary exit. The traces agree: the parent reaches `1.3912U`, whereas peak
  sampled local flow is only `0.03270U`.
- The parent keeps joint speeds below the `260 deg/T` stops at
  `4.5192/4.5239 rad/T`, with posterior angle `0.59921 rad` and peak
  force/yaw moment `0.03693/0.01835`. Mirroring adverse-yaw arbitration onto
  the anterior-to-posterior carrier transfer still captures `0.00587T`
  earlier, but worsens score to `-0.20096611`, crossing distance to
  `0.74483L`, and terminal yaw-rate peak from `4.4430` to `4.4536 rad/T`,
  without reducing posterior excursion. The nearly unchanged two-view wake
  supplies no evidence for making the actuator-specific load rule symmetric.
- The inherited optimizer evidence supplies a second negative boundary. A
  capture-corridor policy withdrew posterior mean steering only below about
  `2L` when measured velocity predicted a safe closing intercept. It retained
  capture and the coherent two-view wake, but regressed to score
  `-0.20433673` and crossing distance `0.74805L`; arrival changed only to
  `16.92585T`, while terminal yaw rate slightly increased to `4.4452 rad/T`
  and joint/load peaks were unchanged. A predicted intercept is therefore not
  evidence that the established steering command is redundant.
- The replicated trace nevertheless has a localized response defect: below
  `2L`, instantaneous yaw reaches `4.443 rad/T`, and the inherited exact
  observation replay reports that the eight-state body-frame bearing-window
  rate opposes the saturated course request in `155` of the final `183`
  samples. This suggests damping an observed angular response while retaining
  target intent, rather than another load selector or steering release.

## Single-candidate policy hypothesis

Preserve the replicated zero-centered anterior oscillator, posterior traveling
lag, full body-frame target/velocity-course request, terminal posterior
acceleration reserve, smooth acceleration shoulder, high-onset positive-power
speed guards, directional signed-yaw work allocation, receiver headroom, and
posterior stopping-risk projection. Add exactly one mechanism: inside a smooth
`2L` approach gate, form a bounded residual from `bearing_window_rate` only
when its sign opposes the current course-based turn request. Apply that residual
to posterior mean steering, but keep the undamped request for the established
signed-yaw allocation logic. Thus the carrier and base target command remain
active, and full authority returns continuously when the measured response no
longer opposes the request.

This is measured-response terminal damping, not scalar-only gain tuning.
Expect the broad route and alternating three-dimensional wake to remain
unchanged, capture to survive, and terminal angular oscillation to fall below
`4.443 rad/T`. Seek score and distance-integral improvement over
`-0.20004481/2.08513L` without arrival later than `16.932T`, posterior angle
above `0.5993 rad`, joint contact, or force/yaw-moment peaks above
`0.0370/0.0184`. Falsify the mechanism if it repeats the corridor-release
regression, changes the broad route, loses capture or coherent shedding,
increases limit/load use, or fails to reduce terminal yaw.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological terminal approach control
source_mechanism: retain the propulsive rhythm and target command while a bounded measured-response residual damps excessive near-target angular motion
transferable_invariant: separate the productive traveling carrier and target intent from an observed angular response, and oppose only the response component that conflicts with the requested correction
nontransferable_details: published gains, dimensional rates and beat frequencies, species-specific kinematics, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: within a normalized body-frame distance gate, use bounded windowed target-bearing rate only when it opposes the current velocity-course request; modify posterior mean steering while preserving joint-state carrier dynamics and all safety projections
falsification: reject if capture or broad-route equivalence is lost, alternating 3D shedding degrades, terminal yaw is not reduced, or arrival, distance integral, joint use, force, or yaw moment regress beyond the replicated parent
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD activation check after the edit

Reconstructing the adapter's eight-state body-frame bearing window over all
`3,079` recorded parent states gives `155` nonzero residuals, exclusively from
`15.932T` through capture. The mean absolute turn-request change is `0.13025`
and the maximum is `0.19278`, below the declared `0.20` bound. A static schema
scan finds all `32` `params` fields both defined and used, and the executable
candidate is identical to the inherited terminal-response implementation
apart from comments. This establishes finite, localized mechanism overlap on
prior states; it does not evolve the fluid or predict a CFD improvement.
