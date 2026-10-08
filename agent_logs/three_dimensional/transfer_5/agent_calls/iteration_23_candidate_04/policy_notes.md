# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- I read the workspace and assigned-parent guidance, all four sampled solver
  artifacts, and the inherited v33/v35/v36 optimizer notes and completed
  results before choosing a mechanism. Every compared rollout used direct
  uniform still water at `U_infinity=(0,0,0)`, with no cylinders or prewarm,
  remained finite, and terminated in capture.
- The four sampled solvers and the assigned-parent exploit are byte-identical
  evaluations of v33. Each reports capture at `23.8425T`, score `-0.535091`,
  scoring mean/final distance `2.433543/0.746165L`, and `236` moving-window
  shifts. They are repeat evidence for one strong controller rather than five
  independent mechanisms.
- I inspected the sampled v33 and inherited v35 combined keyframe sheets from
  release through capture, including both the top-down mid-plane vorticity row
  and the oblique 3D body/Lambda2 row. Both initially quiescent fields develop
  an ordered alternating wake and compact paired three-dimensional structures
  behind visibly self-propelled fish following the same broad target-directed
  arc. Neither shows passive advection, wake breakup, a boundary encounter, or
  instability; their controller difference is below the sheets' resolution.
- The traces make v35 the informative failed intervention. Adding a static
  `0.30` share of raw full-tail tangent rate to v33's carrier observer reduced
  inside-`3L` mean/peak yaw from `1.6800/3.1848` to
  `1.6103/3.0497 rad/T`, mean body-lateral speed from `0.2522` to `0.2391U`,
  and mean moment from `0.006382` to `0.006106`. It nevertheless delayed
  capture from `23.8425T` to `23.8975T`, worsened score and mean/final distance
  from `-0.535091` and `2.433543/0.746165L` to `-0.535811` and
  `2.434232/0.746866L`, and raised peak moment from `0.013730` to `0.013912`.
  Lower periodic yaw or offline decorrelation is therefore not a progress
  surrogate, and another unconditional tail-rate share is excluded.
- Assigned-parent v36 is a second negative boundary: coupling terminal
  regulation to restored cadence crossed one control step earlier but worsened
  score and mean/final distance to `-0.535652` and
  `2.433974/0.746760L`, with slightly worse terminal yaw/lateral/moment means.
  The candidate must not attempt to compensate an observer with a cadence
  reserve or change v33's validated posterior traveling wave.
- On the completed v33 trace, the current carrier-rejected yaw still
  correlates `-0.954` with full-tail tangent rate inside `3L` and has RMS
  `0.635 rad/T`. A replay-only screen of a bounded two-joint rate contribution
  admitted only when full-tail rate opposes the centered anterior carrier
  phase reduces RMS to `0.479 rad/T` while changing residual sign on only
  `18/602` terminal states. The rejected static v35-equivalent replay changes
  sign on `179/602`. This supports testing phase-coherent carrier separation
  while preserving most v33 phase decisions; it does not predict CFD success.

## Policy hypothesis recorded before editing

Preserve v33's target-course feedback, response-released body-frame C-bend,
posterior amplitude and lag, phase-selected anterior correction, cadence, and
component-wise smooth command projection. Change only the carrier-rate
observation used by terminal yaw regulation. Form the full-tail rate from both
observed joints, smoothly bound it by the carrier rate scale, and admit its
small observer contribution with greatest weight when it has the
traveling-wave phase relation evidenced by v33: it opposes the centered
anterior carrier angle. A smooth dimensionless coherence weight keeps
the pathway continuous and reflection-equivariant and rejects inconsistent
rate transients instead of treating them as periodic carrier motion.

The hypothesis is that separating the coherent traveling mode from slow or
steering-induced shape changes will remove some periodic contamination from
v33's terminal yaw residual without v35's loss of useful closing impulse. The
formal evaluation should retain capture, v33-scale arrival and distance
integral, coherent alternating propulsion, and existing actuator exposure,
while preserving or improving terminal yaw and moment. Falsify the mechanism
if capture or wake coherence is lost; score, arrival, or mean/final distance
regresses toward v35/v36; terminal yaw, target-transverse speed, or moment
worsens; or joint/command-limit exposure grows. Replay RMS alone is not
success, and no same-worker CFD result is claimed.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and wake-disturbance separation
source_mechanism: distinguish a coherent traveling-wave carrier from slower route regulation before applying a bounded residual correction
transferable_invariant: periodic carrier rejection should use the observed joint-state phase relation, not cancel every full-tail rate as if it were route error
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, hardware duty ratios, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: preserve v33 and add a normalized body-frame two-joint carrier-rate term whose smooth weight grows when full-tail rate opposes the centered anterior oscillator phase and shrinks for inconsistent motion; bound the term before it enters the terminal yaw observer
falsification: reject if v33-scale capture or distance progress, coherent propulsion, terminal yaw/load, or actuator envelopes regress even when offline carrier correlation decreases
```

The bookshelf supplied the carrier/route separation invariant after several
completed iterations lacked a semantic improvement. It does not justify the
numerical share, a cadence change, or any scalar-only tuning path.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it
  could inspect the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The guidance-materiality check initially found the assigned parent rendered
  twice in `README.md`. Removing the duplicate marker made the parent
  unambiguous; the rerun passes and confirms that these notes exist and
  `control_experience.md` contains a semantic, evidence-backed update.
- The solver boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, with SHA-256
  `01602cf3fa2c639c1724f35e0a85111aa37e5f9a77964f4518830496b23ce677`.
  Its functional diff from evaluated v33 is confined to the bounded,
  phase-coherent carrier observer and its two owned parameters; the returned
  actuator contract is unchanged.
- The prescribed Julia contract smoke test cannot start because no `julia`
  executable is installed. A deterministic static schema audit finds all
  `70` direct `params.FIELD` references among the `72` fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are unreferenced. Static guards find no executable clock,
  step, randomness, file I/O, cylinder identity, mutable global state, or
  memorized route. No formal CFD was run.
