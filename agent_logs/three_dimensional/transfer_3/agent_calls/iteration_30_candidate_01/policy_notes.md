# Reproduce the intercept-supported terminal posture baseline

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. The evaluated
  `v40_intercept_supported_terminal_posture` is the strongest result: capture
  at `19.684490 T`, score `-0.261384287`, mean distance `2.151092787 L`, and
  final distance `0.748302400 L`.
- I inspected the complete combined keyframe sheets for that best result, the
  weakest current terminal-command-coordination result, and the prefilled
  response-opposed result, including both the top-down mid-plane-vorticity row
  and the oblique body/Lambda2 row from release through capture. In each case
  the fish visibly self-propels from quiescent water along the same compact
  target-directed arc. Alternating posterior vortices remain coherent in the
  top-down view and the oblique structures remain compact and finite. There is
  no passive advection, loop, collision, boundary-exit precursor, wake
  collapse, or out-of-plane instability. Immediately before capture the fish
  retains a curved, closing posture and a finite trailing wake; the useful
  distinction is the small terminal trajectory change, not propulsion or wake
  creation.
- The sampled `v41_course_worsening_terminal_response` is behaviorally dormant:
  it reproduces `v40` exactly in score, trajectory, capture time, diagnostics,
  and combined-keyframe hash despite adding a yaw/course selector. It therefore
  supplies a reproduction of the `v40` behavior, not evidence for the new
  selector.
- The two independently active `v41` alternatives both regress. Adding posture
  allocation when joint response opposes the same intercept-supported
  equilibrium delays capture to `19.722988 T` and worsens score/mean/final
  distance to `-0.261856310`, `2.151574012 L`, and `0.748641372 L`.
  Blending terminal commands toward a common-scaled direction delays capture
  to `19.728489 T` and worsens those measures to `-0.261932556`,
  `2.151649804 L`, and `0.748698652 L`. Both preserve finite loads and the wake,
  so these are allocation regressions rather than stability failures.
- All variants retain the identical `4 L` crossing at `15.444014 T`. The
  `v40` path then crosses `1 L` at `19.162004 T`, earlier than the two active
  alternatives at `19.189503 T`. Its below-`4 L` high-command counts are
  `229/302`, compared with `225/299` for response-opposed posture and `226/295`
  for terminal command coordination. Lower clipping incidence alone therefore
  does not identify a better handoff. The inherited `30.58 L` closure-efficiency
  loop further rules out gait-subscale closure ratios as a replacement selector.

## Policy hypothesis

Replace the prefilled response-opposed child with the evaluated
`v40_intercept_supported_terminal_posture` controller exactly. Preserve its
state-feedback traveling bend, geometry-agreed outer response arbitration,
mean-curvature redirect, closure preview, center-course intercept corridor,
small intercept-supported posture handoff, paired terminal release, and all
parameter values. This is one evidence-backed behavioral rollback and
reproduction candidate, not a scalar retune or a stack of another terminal
mechanism.

The expected result is reproduction near `19.684490 T` and score
`-0.261384287`, with the same compact target arc, coherent two-view wake, and
finite load envelope. Falsify the baseline if it does not reproduce, delays or
loses capture, worsens the distance integral, changes the outer trajectory,
returns joint-stop dwell or material load growth, becomes unstable, or degrades
either wake view. The new CFD evaluation occurs only after this worker exits
and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and continuous terminal approach-hold control
source_mechanism: preserve a coordinated traveling-wave carrier, then hand a bounded share to a posture equilibrium only under observed target geometry and approach response
transferable_invariant: when rhythmic propulsion and low-frequency capture posture share two bounded joints, allocation should change through normalized state feedback and only where rollout evidence identifies an independently useful regime
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: retain the evaluated body-frame center-intercept and positive-closure gate that assigns a small coupled share to the existing two-joint mean-curvature posture, while removing unevidenced response-opposed and clipping-direction additions
falsification: reject on failed reproduction, slower or lost capture, worse distance integral, changed outer motion, renewed joint-stop dwell or material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the evaluated `v40` policy; both have
  SHA-256 `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`.
  `solver/` contains exactly one `candidate_target_policy.jl`.
- The lightweight Julia contract returns two finite accelerations. The
  deterministic schema audit resolves all `88` direct `params.FIELD`
  references in the `89`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused by the control algebra. The
  material-guidance and solver edit-boundary checks pass.
- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this account and failed before
  executing a command. Its three non-CFD checks were therefore run directly
  and separately and pass. No formal CFD was run in this workspace.
