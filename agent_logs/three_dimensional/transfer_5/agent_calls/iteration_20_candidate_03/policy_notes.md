# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer notes/results were read before selecting a mechanism.
  All four samples are byte-identical evaluations of v33. Each used direct
  uniform still water at `U_infinity=(0,0,0)`, without cylinders or prewarm,
  remained finite, and captured at `23.8425T` with score `-0.535091`, scoring
  mean/final distance `2.433543/0.746165L`, and no instability.
- The shared combined keyframe sheet was inspected from release to capture in
  both views. The top-down row begins with an empty field, then shows a fish
  translating along the target-directed arc while shedding a coherent
  alternating vortex street. The oblique row develops compact paired Lambda2
  structures behind the bending body and retains them through the curved
  terminal approach. The motion is self-propelled, not background advection;
  neither wasteful wake breakup nor a collision/exit precursor is visible.
  There is no distinct sampled visual failure: the four sheets have the same
  SHA-256, so inherited v35 is used only as the most informative completed
  controller regression and not as an independently inspected current image.
- Sampled v33 has inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`, mean body-lateral speed `0.2522U`, and mean/peak
  absolute moment `0.006382/0.013730`. Its phase-selected anterior correction
  preserves posterior traveling-wave amplitude and lag and is the strongest
  sampled progress/regulation balance.
- The inherited completed v35 result is the relevant negative boundary. Adding a
  `0.30` full-tail-rate share to the yaw observer reduced inside-`3L` mean/peak
  yaw to `1.6103/3.0497 rad/T` and body-lateral speed to `0.2391U`, but delayed
  capture to `23.8975T` and worsened score and mean/final distance to
  `-0.535811` and `2.434232/0.746866L`. Cleaner carrier decorrelation therefore
  cannot justify another observer-rate share or posterior relief edit.
- A new replay of v33's `602` inside-`3L` trajectory states identifies a
  narrower phase defect rather than a carrier-separation defect. Each of its
  eight local absolute-yaw peaks above `2.4 rad/T` occurs `0.061--0.115T`
  after the observed full-tail tangent crosses neutral. At every one of those
  peaks the existing angle-only anterior half-cycle gate is inactive. A
  quadrature rotation of tail angle and normalized tail rate by `0.9 rad`
  spans the measured body/wake response lag; intersecting that response-phase
  gate with the currently opposing angle side adds only a bridge (active in
  `145/602` replay states, mean/max normalized bridge `0.00333/0.06414`) and
  leaves the evaluated v33 gate unchanged everywhere else. These replay
  figures select and bound the test; they are not CFD improvement evidence.

## Candidate hypothesis recorded before policy edit

Preserve v33's state-feedback traveling-wave carrier, response-released
body-frame C-bend, continuous target-course feedback, carrier-rejected yaw
demand, posterior amplitude and lag, existing anterior half-cycle correction,
and component-wise smooth acceleration projection. Add one compact mechanism:
rotate observed full-tail tangent angle and normalized tangent rate into a
lagged response-phase coordinate, then use the intersection of that coordinate
with the currently opposing angle side to bridge the short interval after the
tail crosses neutral. The bridge shifts only the anterior oscillator center;
it never modifies the posterior waveform or the yaw observer.

The hypothesis is that response-phase alignment will keep the already useful
anterior correction engaged through the measured delayed yaw peak without
repeating v35's removal of useful closing impulse. Falsify it if capture or the
coherent alternating wake is lost; score, arrival, or mean/final distance moves
toward or beyond v35; terminal yaw/lateral/load metrics fail to improve over
v33; or joint and projected-command exposure grows. No formal CFD is run in
this worker, so the candidate's outcome belongs to a later generation.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and elongated-body reactive response
source_mechanism: derive beat phase from joint angle and velocity, preserve posterior traveling-wave thrust, and apply a bounded steering residual at a distinct actuator coordinate
transferable_invariant: actuator state can supply a clock-free quadrature phase coordinate, and a measured lag between tail kinematics and body yaw should be handled in phase selection rather than by cancelling the propulsive carrier
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: rotate normalized q1+q2 and (phi_dot1+phi_dot2)/omega by an evidence-derived response lag; retain v33's body-frame demand and angle-side gate, and add only their bounded lag-bridge product to the anterior oscillator center
falsification: reject if v33-scale capture, distance progress, or coherent wake is lost, or if terminal yaw/load and actuator histories do not improve despite the replay-aligned phase bridge
```

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting the workspace. Its deterministic checks were run directly.
- The guidance-materiality check passes after removing the duplicated rendered
  marker for the same assigned parent from `README.md`. It confirms that these
  notes exist and that `guidance/control_experience.md` contains a material,
  evidence-backed reusable update.
- The solver boundary check passes and confirms that
  `candidate_target_policy.jl` is the only solver difference from the frozen
  baseline. Exactly one nonempty candidate exists under `solver/`.
- The Julia contract smoke command cannot start because no Julia executable is
  installed. A deterministic static audit finds all `69` direct
  `params.FIELD` references among the `71` fields returned by
  `target_policy_params()`, with no undeclared reference; only metadata fields
  `version` and `control_period` are intentionally unreferenced. Static guards
  also find both public entrypoints and no mutable global state, randomness, or
  file I/O. The replay bounds the combined phase gate in `[0,1]` before the
  inherited smooth command projection. No CFD was run.
