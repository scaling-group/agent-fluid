# Terminal course-slip approach feedback

## Completed evidence and visual diagnosis before editing

- All four sampled solver rollouts are finite captures from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The
  two v49 samples are byte-identical and capture at `17.48449 T`, score
  `-0.0616520`, with total/observed distance integrals
  `1.947439/1.331949 L`.  The prefilled v50 geometric qualifier remains the
  best completed policy: it captures at `17.41299 T`, score `-0.0595203`,
  integrals `1.945327/1.329976 L`, and final distance `0.745094 L`.
- The sampled v51 decisive geometric qualifier is an informative mechanism
  regression rather than an episode failure.  It improves the observed-route
  integral to `1.328924 L` and is closer than v50 from `6-12 T`, but it trails
  by `0.01760 L` at `16 T`, captures later at `17.45149 T`, and crosses
  shallowly at `0.748203 L`; its larger `0.617630 L` terminal-hold term makes
  total integral and score regress to `1.946554 L` and `-0.0612916`.
- Inherited optimizer results close two other release-law variants.  Blending
  the qualifier by forward-axis response captures at `17.45699 T` but worsens
  total/observed integrals to `1.950225/1.331805 L`, score `-0.0651528`, and
  peak normalized moment to `0.016484`.  Re-normalizing completion across the
  centerline deadband captures at `17.51199 T` and worsens both integrals to
  `1.949506/1.334166 L`, score `-0.0636766`.  Together with v51, three
  distinct completed variants fail to improve v50, so another geometric,
  axial-response, or deadband reshaping of the same posterior release is not
  the next test.
- I inspected every sampled combined sheet from release through capture.  The
  top-down rows show active self-propulsion on smooth target-signed arcs:
  compact startup vorticity grows into a coherent alternating posterior street
  without reversal, collision, or wake collapse.  Every current sampled
  oblique row is black after frame 000, which is an evidence/rendering failure,
  not evidence of a 3D-wake change.  I therefore also inspected the inherited
  readable v48 comparator.  Its oblique row shows compact paired caudal
  Lambda2 structures through capture and anchors the carrier as a coherent
  two-view mechanism that should be preserved.
- The remaining completed-trace issue is terminal course rather than missing
  thrust.  At v50 capture the head-to-target radial closing component is about
  `0.658 L/T`, while the tangential component is still about `0.485 L/T`;
  sampled v51 is similar at about `0.634/0.510 L/T`.  V50 maximum speed is
  already `0.98310 L/T`, acceleration-limit residence is about `40.1%`, and
  peak normalized force/moment remains `0.032252/0.016092`, so neither more
  carrier drive nor another propulsion-release handoff is supported.

## One-candidate policy hypothesis

Preserve completed v50's state-feedback carrier, posterior lag, selective
crossflow pose confidence, base route and redirect steering, launch residuals,
carrier-first spillover, half-cycle steering, geometric posterior-response
qualification, approach return of supplementary curvature, and componentwise
actuator projection.  Add one terminal course-slip feedback mechanism to the
existing route request.  Form a reflection-odd, dimensionless signed sine
between the body-frame head-to-target vector and body velocity.  Gate its
bounded correction by both the existing near-approach confidence and observed
positive closing response, so it is exactly absent beyond the established
`2.1 L` approach region and when the fish is not closing.  The correction
steers the course vector toward the target line; it does not change carrier
frequency, amplitude, lag, posterior release, or direct propulsion.

The next CFD rollout should be identical to v50 on the broad route, retain its
coherent target-signed wake and `16 T` lead, then reduce terminal tangential
slip enough to cross earlier or more deeply and lower the terminal-hold/total
integral without exceeding the sampled speed, saturation, force, or moment
envelope.  Falsify the mechanism if the trajectory changes outside the
approach region, closing weakens, capture becomes later or shallower, terminal
oscillation or saturation grows, the target-signed arc or readable two-view
wake degrades, or the completed envelope is materially exceeded.  Formal CFD
occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: terminal capture control and closed-loop robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while damping measured yaw or slip during final approach instead of retuning the carrier
transferable_invariant: once broad target-directed propulsion works, use bounded observed course-to-target misalignment only near capture and only while closing, leaving the carrier active
nontransferable_details: published gains, dimensional maneuver timing, species-specific kinematics, full-body CPG state, exact vortex phase, and task-specific routes
policy_translation: compute a normalized signed cross product of the body-frame target and velocity vectors and add one bounded near-approach closing-gated steering correction through the existing two-joint route allocation
falsification: reject if broad-route actions change, radial closure or capture regresses, terminal tangential slip is not reduced, switching becomes beat-sensitive, or speed, saturation, normalized force, moment, or the readable two-view wake exceeds the completed envelope
```

## Evidence boundary

All numerical outcomes and visual claims above come from completed sampled
solver evidence, the assigned-parent guidance, and inherited optimizer logs.
The terminal course-slip controller below is one unevaluated policy hypothesis;
no same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v52_terminal_course_slip_feedback`.  All `69`
  distinct direct `params.FIELD` references resolve among the `71` fields
  returned by `target_policy_params()`; the two returned metadata fields not
  directly referenced are `version` and the inherited `control_period`.
- A deterministic `46,080`-state comparison with completed v50 is byte-exact
  in all `23,040` far-approach cases and all `23,040` non-closing cases.  It
  changes finite bounded actions on `7,872` closing approach states, with a
  maximum sampled action difference of `0.97877 rad/T^2`; the new course-slip
  signal and its gated correction have zero reflection-sign error.
- Reconstruction on the completed v50 trace gives exactly zero correction
  until distance first enters `2.1 L` at about `15.763 T`.  The correction is
  supported on the final `301` logged rows, remains continuous and bounded,
  and reaches `-0.19354` request units at capture where normalized signed
  course slip is `-0.59371` and closing remains positive.  This establishes
  implementation support and sign only, not a predicted CFD outcome.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its exact three checks were run locally
  and separately: material guidance/notes, the lightweight Julia policy
  contract, and the solver editable-boundary check pass.  The guidance check
  first exposed a duplicated assigned-parent marker in the rendered workspace
  `README.md`; removing only that duplicate repaired provenance.  No formal
  CFD was run.
