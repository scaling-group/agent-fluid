# Candidate diagnosis and hypothesis

## Evidence read before the edit

- I read the assigned-parent guidance, the four sampled solver artifacts, and
  the available inherited optimizer notes/results before selecting the
  mechanism. All four samples are byte-identical v33 policies and keyframe
  sheets, not four independent designs. Each is a finite capture from direct
  uniform still water at `U_infinity=(0,0,0)`, with no cylinders or prewarm,
  at `23.8425T`; score is `-0.535091` and scoring mean/final distance is
  `2.433543/0.746165L`.
- I inspected v33 and the inherited v36 posterior-relief result from release
  through capture in the combined top-down mid-plane-vorticity and oblique 3D
  body/Lambda2 views. Both initially empty fields develop coherent alternating
  vortex streets and compact paired 3D structures behind fish following the
  same broad target-directed arc. Motion is self-propelled, not advection;
  neither run loses wake coherence, encounters a boundary, or becomes
  unstable. Their policy difference is below the sheet resolution, matching a
  regulation/closing-impulse trade rather than a propulsion collapse.
- The inherited trajectory metrics supply the negative controls. V35's
  two-joint carrier observer reduced inside-`3L` mean yaw to `1.610 rad/T` but
  delayed capture to `23.8975T` and worsened mean/final distance to
  `2.434232/0.746866L`. V36 posterior half-cycle relief similarly reduced mean
  yaw to `1.632 rad/T` but delayed capture to `23.8865T` and worsened
  mean/final distance to `2.434335/0.746970L`. Another inherited v36 coupling
  that restored cadence when terminal regulation was active arrived one CFD
  step sooner than v33 (`23.8370T`) but worsened score and mean/final distance
  to `-0.535652` and `2.433974/0.746760L`; inside-`3L` mean/peak yaw also rose
  from `1.680/3.185` to `1.683/3.207 rad/T`. Therefore neither quieter yaw nor
  extra terminal cadence is an adequate improvement criterion.
- The sampled v33 top-down sheet shows little displacement before the wake is
  established. A read-only replay of its eight-sample closing-speed signal
  quantifies the startup opportunity: the existing normalized progress-deficit
  gate averages `0.496`, `0.444`, and `0.212` over `0-1T`, `1-2T`, and `2-4T`,
  while the maximum anterior angle grows from only `0.218 rad` in the first
  interval toward the `0.489 rad` carrier amplitude. Once established, the
  same gate averages less than `0.005` beyond `4T`. This isolates carrier
  spin-up rather than terminal regulation as a distinct testable mechanism.

## Policy hypothesis recorded before the policy edit

Retain v33's target-aware C-bend steering, response release, posterior lag and
amplitude, continuous terminal course bend, phase-selected anterior correction,
cadence schedule, and component-wise smooth acceleration projection. Add one
new state-feedback mechanism to the anterior Van der Pol carrier: increase its
self-excitation only when all three observed conditions agree that the carrier
needs recruitment—target closure is deficient, route turn demand is modest,
and the phase-invariant anterior oscillator radius is below its commanded
amplitude. The radius uses current joint angle and normalized joint velocity,
not time or a prescribed phase. Recruitment vanishes at the established limit
cycle, during strong turns, during the approach schedule, or when closure is
healthy, so it changes convergence to the proven carrier rather than its
steady amplitude, posterior waveform, or terminal cadence.

The hypothesis is that faster still-water carrier establishment will reduce
early distance integral and arrival time while reproducing v33's captured arc,
alternating wake, and terminal yaw/load balance. Falsify the mechanism if it
loses capture or wake coherence; fails to improve v33's score, arrival, and
mean/final distance; materially worsens inside-`3L` yaw or moment; increases
joint angle/velocity or projected-command limit exposure; or remains active
after the oscillator reaches its established radius. No same-worker CFD result
is claimed.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and state-feedback oscillators for self-propelled swimming
source_mechanism: use sensed locomotor state to recruit a rhythmic carrier toward its limit cycle while preserving posterior traveling-wave thrust and separate target steering
transferable_invariant: transient propulsion recovery may change oscillator convergence without changing the established gait amplitude, lag, or route command
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific amplitude envelopes, hardware duty ratios, explicit clock phase, exact vortex phase, and task-specific routes
policy_translation: combine normalized closing deficit, bounded body-frame turn load, and the phase-invariant radius hypot(phi1-center, phi_dot1/omega) to modulate only Van der Pol self-excitation; retain v33 posterior and terminal pathways exactly
falsification: reject if v33-scale capture, distance progress, wake coherence, terminal yaw/load, or actuator envelopes regress, or if recruitment changes the established carrier instead of only its deficient transient
```

The shelf was consulted because the inherited record contains at least three
completed iterations without a new success or better termination class. It
suggested CPG state modulation, but the recorded direct-uniform startup and
closing history—not a published gain—select and bound this translation.

## Validation boundary

- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported for this account and failed before
  inspecting the workspace. I therefore executed its three prescribed checks
  directly and separately.
- The guidance/materiality check passes, confirming that these notes exist and
  `guidance/control_experience.md` differs semantically from the assigned
  parent. The solver boundary check passes with no changes outside the single
  editable policy file.
- The exact Julia contract smoke command cannot start because `julia` is not
  installed. A deterministic static fallback finds all `69` direct
  `params.FIELD` references declared among the `71` fields returned by
  `target_policy_params()`; only metadata fields are unreferenced. Both public
  entrypoints exist, exactly one nonempty candidate exists under `solver/`, and
  static guards find no executable clock/step, randomness, file I/O, mutable
  global state, cylinder-coordinate access, target identity, or fixed route.
  The added clamps analytically bound `effective_drive_mu` to `[0.35,1.05]`.
- The candidate SHA-256 is
  `cd506641984274bc667b1f270399849d511d4129844bdd5159dfd29e6e683d5d`.
  No formal CFD was run; evaluation remains downstream.
