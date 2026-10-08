# Reproduction of response-exclusive outer allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture. The assigned-parent
  target-residual allocator is reproduced exactly twice and captures at
  `21.735992 T`, score `-0.3012661700`, mean distance `2.194857233 L`, and
  final distance `0.749404609 L`.
- I inspected the combined and view-specific sheets for the assigned parent
  and the strongest finite sample from release through capture. Their
  top-down rows show self-propelled target approach with coherent alternating
  posterior vorticity, while their oblique rows retain finite localized
  Lambda2 structures without passive advection, collision, a loop,
  boundary-exit precursors, wake collapse, or out-of-plane instability. The
  parent sheds a productive outer wake but settles into a long, strongly
  curved held-bend glide between about `17 T` and capture. The sampled winner
  keeps an undulatory response longer and reaches the capture circle near
  `19.6 T` on a more compact trajectory.
- The response-conditioned common limiter improves the parent to capture at
  `20.096998 T`, score `-0.2975685868`, and mean distance
  `2.188311614 L`. The response-exclusive allocator is stronger again: it
  captures at `19.612991 T`, scores `-0.2829412229`, and lowers mean distance
  to `2.172435105 L`. It crosses the stable `4/3/2/1 L` thresholds at about
  `15.664/16.890/18.089/19.316 T`, versus
  `15.835/17.666/19.497/21.252 T` for the parent. Thus its gain is a
  meaningfully faster useful trajectory, not a looser termination class or a
  scalar-only action reduction.
- The faster trajectory carries a cost that must remain explicit. Below
  `4 L`, the winner reaches `30 rad/T^2` on `508/589` stored anterior/posterior
  commands and has force/moment maxima about `0.02847/0.01519`, versus only
  `21/8` such commands and `0.01615/0.00871` for the quiet parent. Same-state
  terminal dormancy of an outer allocator therefore does not imply realized
  terminal noninterference after it changes the entry state.
- The inherited phase-space extension supplies a concrete negative boundary.
  Adding posterior target-velocity error to the position-response support
  retained a coherent wake and capture, but the keyframes show a wider late
  bend into the target and telemetry regresses to capture at `23.859020 T`,
  score `-0.4312533481`, and mean distance `2.329508832 L`. Do not append a
  derivative-like coordination cue to the current winner without independent
  evidence that it improves, rather than merely elaborates, posterior response.

## Policy hypothesis

Promote the sampled response-exclusive allocator unchanged as this workspace's
single candidate. Preserve the normalized body-frame guidance, state-feedback
oscillator, posterior lag target, captured terminal equilibrium, crossflow and
center-intercept support, and paired terminal release. Outside `4 L` only,
posterior lag-target error selects between two complementary actuator
priorities: poor response receives the direction-preserving common-limit
increment, while settled response releases the drive-first target residual.
The priorities transition convexly and cannot stack at full strength.

This is an exact reproduction of an evidence-backed allocation mechanism, not
scalar gain tuning. It adds no clock, route, world coordinate, target identity,
new derivative reconstruction, force cancellation, cadence change, mean-bend
change, beat-side selector, or joint-role split. Exact reproduction is more
informative than another extension because the winner has one sampled CFD
result and materially higher terminal activity. Falsify it if the rollout
does not reproduce capture near `19.6 T` and the improved distance integral,
if global or terminal loads grow, if joint-stop dwell or instability appears,
or if either wake view loses coherence.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve anterior-to-posterior bend coordination while allocating bounded actuator authority between rhythmic coordination and slower target correction
transferable_invariant: when rhythmic coordination and target correction share a bounded two-joint actuator envelope, observed response state should select complementary allocation priorities instead of blindly stacking them
nontransferable_details: published gains, dimensional cadence, full-body waves, species-specific kinematics, exact joint or vortex phase, actuator models, capture geometry, and task-specific routes
policy_translation: reproduce the sampled normalized posterior-lag selector that gives direction-preserving common limiting priority during poor response and drive-first body-frame target-residual priority after response settles, only outside the normalized terminal band
falsification: reject on non-reproduction of the faster capture and lower mean distance, excessive terminal saturation or loads, delayed or lost capture, joint-stop dwell, instability, changed useful trajectory, or degraded top-down or oblique wake coherence

The candidate's new CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The candidate is byte-identical to the evaluated response-exclusive sample
  (`SHA-256 9f21637ae24bacb1d08414b797745f9247a3afee5abedc36ef17ebe96c2f8372`).
  This is an exact reproduction check, not new CFD evidence.
- The material-guidance check, finite two-acceleration Julia contract, solver
  edit-boundary check, and deterministic parameter-schema audit pass. All `84`
  direct `params.FIELD` references resolve in the `85`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account and failed before executing a command.
  Its three configured checks were therefore run directly and separately. No
  formal CFD was run in this workspace.
