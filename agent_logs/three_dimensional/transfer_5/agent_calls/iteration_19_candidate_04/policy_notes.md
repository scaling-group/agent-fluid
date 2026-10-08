# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver results, and inherited
  optimizer notes/results were read before selecting a mechanism. Every sampled
  rollout is a finite capture from direct uniform still water at
  `U_infinity=(0,0,0)`, with no cylinders or prewarm. The four sampled solver
  artifacts are byte-identical evaluated v33 policies with the same score and
  keyframe sheet, so they establish repeatability rather than four independent
  mechanisms.
- The combined sheets for the strongest sampled v33 capture and the informative
  evaluated v35 carrier-observer regression were inspected from release through
  capture in both the top-down vorticity and oblique Lambda2 views. Both begin
  from an empty quiescent field, visibly self-propel on the same broad
  target-directed arc, develop a coherent alternating mid-plane vortex street
  and paired three-dimensional structures, and retain the wake through capture.
  No advection-only motion, wake breakup, collision, exit, or instability
  explains their difference; it is below the keyframe sheets' visual resolution.
- Repeated v33 captures arrive at `23.8425T` with score `-0.535091`, scoring
  mean/final distance `2.433543/0.746165L`, and inside-`3L` mean/peak absolute
  filtered yaw `1.6800/3.1848 rad/T`, body-lateral speed `0.2522/0.5212U`, and
  mean/peak absolute yaw moment `0.006382/0.013730`. The evaluated v34 fixed
  anterior transfer improves terminal regulation but regresses score and
  mean/final distance to `-0.535920` and `2.434212/0.747022L`. The evaluated v35
  two-joint carrier observer cleans the same terminal summaries further to
  `1.6103/3.0497 rad/T` yaw, `0.2391/0.4807U` lateral speed, and `0.006106`
  mean moment, yet arrives around `23.8975T` and regresses score/final distance
  to `-0.535811/0.746866L`. Offline carrier decorrelation therefore did not
  transfer into useful closed-loop progress, and smaller terminal yaw is not by
  itself the next objective.
- V33 keeps posterior amplitude and lag intact and applies its bounded anterior
  residual in 232 replayed inside-`3L` states. In 133 of those states the
  residual acceleration direction opposes anterior joint velocity, with a
  larger mean center shift (`0.663 deg`) than the 99 motion-supporting states
  (`0.437 deg`). Thus a concrete remaining axis is the energetic phase of the
  already successful anterior correction, not another posterior admission,
  fixed allocation share, route observer, cadence gain, or wake-force gate.

## Policy hypothesis recorded before policy edit

Retain the exact evaluated v33 state-feedback carrier, response-released
body-frame C-bend, continuous terminal course correction, carrier observer,
posterior amplitude and lag, cadence, correction direction, tail-side phase
selection, and smooth component-wise command projection. Add one bounded
work-aware filter inside the anterior residual: correction whose signed
direction agrees with current anterior joint velocity passes unchanged, while
opposing correction is smoothly attenuated to a nonzero floor using velocity
normalized by the current oscillator amplitude and frequency.

This tests whether phase-selecting the already useful steering residual by its
incremental joint-work sign can preserve v33's capture correction while avoiding
unnecessary braking of the propulsive rhythm. Fixed-trace replay with a `0.55`
floor and `0.35` normalized velocity scale preserves every motion-supporting
shift and reduces total absolute shift by about `14.3%`; that is an activation
and boundedness check, not CFD evidence. Falsify the candidate if capture or the
coherent alternating wake regresses; score, arrival, or mean/final distance is
worse than repeated v33; terminal yaw/slip/load returns beyond v33 scale; or
joint-angle, joint-speed, or projected-command exposure increases.

```text
bookshelf_consulted: true
source_domain: Lighthill reactive-thrust role separation and robotic-fish asymmetric CPG turning
source_mechanism: preserve posterior traveling-wave thrust while applying a bounded steering asymmetry on an observed motion-supporting beat phase
transferable_invariant: when corrective steering risks braking a productive traveling wave, preserve posterior amplitude and lag and attenuate only anterior correction that opposes the observed anterior motion
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, actuator power models, exact vortex phases, and task-specific routes
policy_translation: normalized two-joint state supplies tail-side phase and signed anterior velocity; the evaluated body-frame target and carrier-rejected yaw logic remains unchanged, and only the bounded anterior oscillator-center residual receives a smooth work-aware attenuation
falsification: reject if capture or wake coherence regresses, v33-scale progress is not retained, terminal yaw/slip/load worsens beyond v33, or actuator-limit exposure grows
```

The shelf contributes only the actuator-role and observed-phase invariant. The
sign convention, normalization, attenuation bounds, and reason for changing the
controller come from completed L64 rollouts and fixed-trace replay. No formal CFD
is run in this worker; the candidate's evaluation belongs to a later worker.

## Non-CFD validation after editing

- The required `.codex/agents/check-runner.toml` agent was invoked, but its
  pinned `gpt-5.4-mini` model is unsupported on this account and failed before
  inspecting the workspace. Its three prescribed checks were therefore run
  directly and separately.
- The guidance check initially found that the rendered workspace `README.md`
  marked the same assigned parent twice. Removing only the duplicate marker
  made parent selection unambiguous; the rerun passes and confirms both these
  notes and a material reusable change in `guidance/control_experience.md`.
- The solver-boundary check passes. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`, and its diff from the
  evaluated v33 artifact is confined to metadata, the two owned work-gate
  parameters, the anterior work-phase gate, and returned diagnostics. The
  posterior target, lag, damping, and actuator equations are unchanged.
- Julia is not installed, so the prescribed executable contract smoke test
  cannot start. A deterministic schema audit finds all 70 direct
  `params.FIELD` references among the 72 fields returned by
  `target_policy_params()`; only metadata fields are unreferenced. Delimiter
  and block counts are balanced, and static guards find no clock, elapsed time,
  step counter, randomness, file I/O, cylinder identity, fixed target, or
  mutable route state.
- Adversarial finite phase inputs keep the new gate finite in `[0.55,1.0]` and
  pass all motion-supporting corrections unchanged. The final candidate SHA-256
  is `7791266c63286f3445e6acd44ca92f6bdc26c58870226be573ef84d0812e4e0b`.
