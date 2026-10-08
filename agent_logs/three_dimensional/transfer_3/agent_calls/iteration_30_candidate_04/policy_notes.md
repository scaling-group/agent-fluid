# Low-speed posterior-lag recovery

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 evidence contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The two
  exact best rollouts are the evaluated
  `v40_intercept_supported_terminal_posture` and the behaviorally dormant
  `v41_course_worsening_terminal_response`; both capture at `19.684490 T`,
  score `-0.261384287`, mean distance `2.151092787 L`, final distance
  `0.748302400 L`, and center path length `12.951133 L` in the released
  trajectory table.
- The assigned guidance parent was produced with
  `v41_intercept_terminal_command_coordination`, while the solver prefill is
  `v41_response_opposed_intercept_posture`. Their newly available evaluations
  are concrete negative results relative to `v40`. Terminal command-ratio
  coordination captures at `19.728489 T`, score `-0.261932556`, mean distance
  `2.151649804 L`, and center path length `12.975468 L`; the
  response-opposed posture increment captures at `19.722988 T`, score
  `-0.261856310`, mean distance `2.151574012 L`, and center path length
  `12.964956 L`. Neither improves termination, distance, arrival, or path. The
  inherited worker notes establish that both branches were active, bounded,
  and confined to the intended terminal state, so these are coupled-response
  regressions rather than dormant-code results.
- I inspected the complete combined keyframe sheets for the best `v40` rollout
  and the lower-quality terminal-coordination rollout from release through
  capture, including every top-down mid-plane-vorticity and oblique
  body/Lambda2 panel. Both fish visibly self-propel from quiescent water along
  the same compact target-directed arc, establish a coherent alternating wake,
  and retain finite localized three-dimensional structures. Neither shows
  passive advection, collision, a boundary-exit precursor, a loop, wake
  collapse, joint-stop posture, or out-of-plane instability. The sheets are
  nearly identical at their coarse sample times; the terminal variants change
  the final trajectory and arrival slightly, not the wake family.
- The trajectory and diagnostics agree with that visual reading. All policies
  have finite global force/moment envelopes of about
  `0.0305--0.0307/0.0156--0.0157` in the released coefficient columns, no
  angle-stop contact, and the same milestone
  crossings through `4 L` (`7.837503/10.543495/13.057009/15.444014 T` for
  `10/8/6/4 L`). Their differences begin only inside the terminal regime. The
  `v40` trace exposes a separate unresolved locus before those shared
  milestones: by `2 T` range has decreased only about `0.031 L` and center
  speed is about `0.135 L/T`; at `4 T` speed is about `0.363 L/T` and a
  coherent traveling wake is forming. This supports a state-triggered
  low-speed wave-establishment test, not more terminal authority or a global
  cadence/gain increase.
- The assigned-parent and prefill logs also show why the candidate returns to
  exact evaluated `v40` before adding the new branch: terminal ratio
  preservation changed 216 stored winner states and response-opposed posture
  changed 158, yet both delayed capture. The course-worsening allocation is
  exactly identical to `v40` in CFD, so a nominal selector without realized
  activation is not a new useful mechanism.

## Policy hypothesis

Start from the evaluated `v40_intercept_supported_terminal_posture`, preserving
its oscillator, geometry-agreed outer allocator, target residual, command
limit, center-course intercept, closure preview, terminal mean bend, and quiet
posture handoff. Add one state-feedback wave-establishment mechanism outside
the existing `4 L` terminal band: when measured body translation is low, the
target is ahead in the body frame, and large-angle redirect is quiet, increase
only the posterior joint's existing velocity-lag contribution to its target.
Release the increment smoothly as translation reaches the empirically observed
`0.30 L/T` scale. The branch is also multiplied by the existing outer gate, so
it is exactly zero throughout the validated terminal controller.

This is a phase-lag/wave-shape change, not scalar-only cadence or amplitude
tuning. It retains the anterior state-feedback oscillator and mean curvature,
adds no acceleration residual or authority, and cannot activate for a target
behind the fish, a strong redirect, or terminal capture. The expected benefit
is earlier formation of the already productive posterior traveling bend and
earlier `10/8 L` crossings without changing the compact route or terminal
handoff. The new CFD evaluation happens only after this worker exits and is not
claimed here.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion together with state-modulated robotic-fish CPG control
source_mechanism: posterior tail kinematics and phase lag carry propulsive wave authority, while observed state should modulate rather than clock the rhythmic command
transferable_invariant: when translation is not yet established but body-frame target geometry supports forward swimming, temporarily emphasize posterior lag in the existing traveling bend and release that emphasis as self-propelled speed develops
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes and full-body kinematics, exact Strouhal values, explicit oscillator phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: outside the normalized terminal band, combine low body-frame course speed, positive normalized target-forward component, and quiet geometry redirect into a bounded support that scales only the existing posterior velocity-lag target term; preserve the anterior oscillator, mean bend, limits, and all terminal algebra
falsification: reject if the branch is dormant or effectively constant, acts at or below `4 L` or for a target not ahead, delays the `10/8 L` crossings or capture, worsens distance integral or path, raises saturation, angle/rate contact or loads, changes the compact route, destabilizes the rollout, or degrades top-down wake coherence or finite oblique structures

## Non-CFD implementation audit

- Replaying the evaluated `v40` and this candidate on reconstructed body-frame
  states from the `v40`, response-opposed-posture, and terminal-coordination
  traces changes exactly `575` states in each trace, from about
  `0.0055--3.3990 T` and `12.3277--12.1043 L`. The maximum equal-state
  two-joint command change is about `2.3566 rad/T^2`; the inferred lag-support
  mean/maximum is about `0.520/1.000`, and its largest posterior target shift
  is about `0.0161 rad`. Every sampled state at or below `4 L` is exactly
  `v40`-identical.
- A deterministic `72,900`-state grid spanning range, body-frame target angle,
  translation speed, closure, and both joint positions and rates finds `7,776`
  active differences from `v40`, with maximum command change about
  `3.1405 rad/T^2`. All outputs are finite and remain within the declared
  `1750 deg/T^2` command limit. All `40,500` terminal states and all `46,656`
  states with established speed or full redirect are exactly parent-identical.
  These are activity, selectivity, boundedness, and equal-state noninterference
  checks, not coupled-flow evidence.
- The deterministic schema audit resolves all `91` direct `params.FIELD`
  references in the `92`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused. The prescribed check-runner
  was invoked, but its pinned `gpt-5.4-mini` model is unsupported on this
  account and failed before executing a command, as in the inherited logs.
  Its three exact commands were then run directly and separately: guidance
  materiality, the lightweight Julia two-output contract, and the solver edit
  boundary all pass. No formal CFD was run in this workspace.
