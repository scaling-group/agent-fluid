# Course-aligned outer burst release

## Evidence and visual diagnosis before the policy edit

- All four current solver samples satisfy the frozen flow contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`. Three
  contain the evaluated `v40_intercept_supported_terminal_posture`; the fourth
  contains a nominal course-worsening response branch but produces the exact
  same trajectory, score, metrics, and combined keyframe sheet. The reproduced
  result captures at `19.684490 T`, scores `-0.261384287`, and has mean/final
  distance `2.151092787 L`/`0.748302400 L`.
- I inspected the complete combined top-down vorticity and oblique body/Lambda2
  sheets for the reproduced `v40` result and the inherited active
  response-opposed terminal variant. Both visibly self-propel from quiescent
  water along the same compact target-directed arc, shed a coherent alternating
  posterior wake, and retain finite localized three-dimensional structures.
  Neither shows passive advection, collision, boundary-exit precursors,
  out-of-plane motion, wake collapse, or numerical instability. The active
  terminal variant is the informative lower-quality contrast: its visually
  similar outer wake still captures later at `19.722988 T` and regresses score
  to `-0.261856310`, localizing its failure to terminal allocation rather than
  propulsion-family loss.
- The reproduced trajectory is monotone in its final approach and has no joint
  stop. Below `1.6 L`, neither joint has a stored command above
  `30 rad/T^2`; the supported posture handoff is already quiet and successful.
  Over the full rollout, however, commands exceed `30 rad/T^2` on
  `1368/1973` anterior/posterior samples, while the visible outer wake and
  distance history show useful propulsion. This supports preserving the
  terminal law and testing a bounded outer allocation mechanism, not another
  posture-handoff refinement.
- Inherited completed logs close the terminal response locus. Extra posture
  during outward joint motion, extra carrier during that motion, and extra
  posture during decreasing coupled error all capture later and score between
  `-0.261772172` and `-0.261856310`. A signed late course/yaw posture increment
  preserves the capture step but also regresses slightly to `-0.261390567`.
  The sampled hard-conjunction branch is exactly dormant. Separately, an outer
  phase-lag feasibility governor turns the compact route into a stable large
  loop and captures only at `46.145020 T` with score `-0.915605503`. Therefore
  this candidate leaves posterior lag, terminal posture allocation, and total
  authority unchanged.

## Policy hypothesis

Start from reproduced `v40`. Preserve its state-feedback oscillator, posterior
lag target, target-angle redirect, response-exclusive saturation allocator,
geometry/course residual, terminal intercept corridor, damped mean-bend
posture, carrier floor, and acceleration cap. Add one outer-only
redirect-to-cruise mechanism: when directly observed center translation is
established, aligned with the body-frame target ray, and positively closing
range, recover a small share of carrier cadence. Withhold the increment during
large-angle redirect, material course miss, startup, and at or below `4 L`.

This is a response-conditioned gait-mode transition rather than a scalar-only
frequency change. The realized body-frame center course and closure decide
whether the propulsive burst is released; distance merely protects the proven
terminal controller. Expected behavior is a small cadence increment during
useful outer translation without changing the target-owned turn sign or the
posterior phase relation. Falsify it on dormancy or near-constant activation,
any equal-state command change at or below `4 L`, changed posterior lag,
slower/lost capture, worse distance integral, materially increased saturation
or loads, a loop, joint-stop dwell, instability, or degradation of either wake
view. The new CFD result is not available in this worker and is not claimed as
evidence.

bookshelf_consulted: true
source_domain: biological C-start or burst redirect and closed-loop robotic-fish CPG direction tracking
source_mechanism: strong target-owned redirect followed by response-supported release into propulsive rhythm
transferable_invariant: target geometry should own redirect, while normalized realized course alignment and positive closure should release bounded propulsion only after useful response appears
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, full-body waveforms, exact beat or vortex phase, target coordinates, capture radius, and task-specific routes
policy_translation: use body-frame center-course error, normalized speed, range closure, redirect activity, and an outer distance gate to add one small continuous cadence share without changing posterior lag, steering equilibrium, terminal allocation, or command authority
falsification: reject on dormancy or constant activation, action at or below 4 L, changed lag or turn sign, slower or lost capture, worse distance integral, saturation or load growth, looping, joint stops, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Equal-state replay against evaluated `v40` on the reproduced trajectory
  changes `1906/3579` stored states, all between `12.3245 L` and `4.0009 L`;
  no state at or below `4 L` changes. The normalized response support ranges
  from about `5.35e-8` to `1.0` on active states with mean `0.597`, and is zero
  on the remaining states. Maximum two-joint command difference is
  `1.9279 rad/T^2`; candidate outputs stay inside the unchanged
  `30.5433 rad/T^2` software cap. This establishes material, varying outer
  activity and terminal equal-state noninterference, not a coupled rollout.
- A deterministic `311040`-state grid spanning distance, body-frame target and
  center-course angles, speed, closure, and both joint positions and rates
  finds `17184` active differences. All outputs are finite and bounded, and no
  tested state at or below `4 L` differs from `v40`; maximum difference is
  `1.7540 rad/T^2`. These checks establish gate selectivity and safety only.
- The prescribed check-runner agent was invoked after the material edits, but
  its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before running a command. Direct, separate execution of its three
  configured checks passes after removing one inherited duplicate assigned-
  parent marker from the rendered root `README.md`: notes/material guidance,
  the exact finite two-output Julia contract, and the solver edit boundary all
  pass. A separate deterministic schema audit resolves all `92` direct
  `params.FIELD` references against the `93` returned fields; only the version
  label is intentionally unused. No formal CFD was run in this workspace.
