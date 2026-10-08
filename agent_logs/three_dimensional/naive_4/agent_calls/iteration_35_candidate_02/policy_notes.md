# Moment-to-yaw response handoff candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. No failed-termination sheet is
  allocated, so the weaker finite captures and inherited regressions are the
  informative negative controls.
- I inspected the combined sheets for the sampled best
  (`solver_2acfcfa19ef8`) and weakest (`solver_0d0db1d9cf71`) from release to
  capture. Their top-down rows both show a release transient developing into a
  coherent alternating caudal wake behind a smooth target-directed arc. With
  zero background flow, the translation is self-propulsion rather than
  advection. Their oblique body/Lambda2 rows retain compact alternating 3D
  caudal structures without visible wake collapse, collision, domain exit, or
  out-of-plane instability. The sheets are visually indistinguishable at this
  resolution, so the score difference is a response-allocation result rather
  than evidence for a new gait or stronger visible vortices.
- The assigned parent (`solver_883a064fe477`) and the moment-only policy
  (`solver_2acfcfa19ef8`) produce identical traces and sheets: capture at
  `15.735508T`, final/minimum distance `0.744372L`, distance integral
  `1.919818L`, `231` window shifts, and score `-0.037222`. Thus the parent's
  translational terminal rewrite is trajectory-equivalent in this rollout.
  The distinct no-moment translational policy captures at `15.768509T`, with
  `0.745720L`, `1.924067L`, `232` shifts, and score `-0.041674`. Inherited
  analysis also shows that moment rejection advanced every
  `8/6/4/2/1.25L` milestone while retaining the coherent two-view wake.
- Extra authority is not the supported next move. The sampled lateral-load
  consensus extension still captures, but regresses from the parent to
  `15.746509T`, distance integral `1.921600L`, final distance `0.744715L`, and
  score `-0.039050`. The inherited adverse-axial-load relief likewise delayed
  capture and worsened distance integral despite reducing some load and limit
  statistics. These results reject another corroborating-load increment or a
  scalar-only increase in curvature.
- On the winning trace, the carrier-demodulated moment gate has nontrivial
  route support on 603 samples. On 150 of those samples the independently
  demodulated yaw response is already target-aiding; ten samples later the
  mean absolute target-versus-course error is `0.0353 rad` lower. This is a
  retrospective association, not a causal claim, but it identifies measured
  response support for a conservative handoff: preserve anticipatory moment
  rejection until target-aiding yaw appears, then release only that
  supplemental curvature while leaving base redirect and propulsion intact.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: apply bounded redirect authority for a large observed course error, then release supplemental curvature continuously when the requested yaw response appears
transferable_invariant: preserve the traveling-bend carrier and target-directed base turn while handing anticipatory steering authority to measured body-frame response instead of continuing to add curvature after response is established
nontransferable_details: published gains, dimensional yaw scales, species-specific burst kinematics, exact tail or vortex phase, clock-defined maneuver stages, source wake geometry, and task-specific routes
policy_translation: retain the assigned parent's normalized joint-phase moment residual and all existing propulsion/navigation; attenuate only its supplemental posterior mean curvature with a smooth gate when carrier-demodulated normalized yaw is target-aiding, reopening the moment correction automatically if that response disappears
falsification: reject if capture is delayed or lost, any route milestone or distance integral regresses, the coherent two-view wake or force envelope degrades, posterior limiting grows without route benefit, or the handoff merely reproduces the assigned-parent trajectory
```

## One candidate hypothesis

Produce exactly one candidate by preserving the parent's anterior oscillator,
posterior traveling wave, positive axial-response allocation, target/course
steering, base redirect, approach shaping, terminal line-of-sight damping,
mean-first actuation, and exact actuator projection. Change only the winning
moment-residual branch: its existing bounded curvature remains available when
non-carrier moment opposes a reliable requested turn, but it is smoothly
handed off as carrier-demodulated yaw becomes target-aiding. The base redirect
and yaw-opposition correction are not attenuated, and loss of the aiding yaw
response immediately restores the moment branch without a clock or mutable
state.

The response scale is reused from the parent's normalized yaw feedback rather
than introduced as a literature gain. The falsifiable expectation is to keep
the moment policy's earlier route while avoiding redundant curvature on the
150 evidenced response-aiding states, improving distance integral or arrival
without sacrificing capture, wake coherence, or the established load
envelope. Formal CFD remains post-exit evidence, so no outcome for this
candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `e3bc1c643e2c5e00a7bbaa9a94a593d97a53e81e780d5f0e94227a7a041b4deb`.
  Static schema validation finds exactly 56 fields returned by
  `target_policy_params()` and the same 56 direct `params.FIELD` references,
  with no missing or unused field. The prescribed lightweight Julia contract
  returns two finite bounded accelerations.
- A deterministic 243,000-state sweep across target side and distance, joint
  position and velocity, body-frame translation, moment, and yaw response
  changes feasible action relative to the parent on 42,138 states. Its maximum
  action difference is `5.05276 rad/T^2`; every action remains finite and
  bounded, and lateral reflection error is exactly zero in the sweep.
- Counterfactual reconstruction on the assigned-parent trace changes only 77
  posterior commands and no anterior commands, from `0.5720T` to `14.5695T`.
  Mean and maximum changed-command magnitudes are `0.0208` and
  `0.1584 rad/T^2`. This confirms small, feasible, non-clamp-equivalent support
  but does not predict the unevaluated closed-loop response.
- Guidance materiality, the lightweight policy contract, and the solver
  editable-boundary check pass. The materiality check initially exposed two
  identical assigned-parent markers in the rendered workspace `README.md`;
  removing only the duplicate repaired that inherited metadata defect without
  changing the assigned parent. The configured check runner was invoked, but
  its pinned `gpt-5.4-mini` model is unavailable for this account; its three
  prescribed commands were therefore run directly and separately. No CFD was
  run.
