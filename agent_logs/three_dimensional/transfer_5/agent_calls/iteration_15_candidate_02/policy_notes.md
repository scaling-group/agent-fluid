# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned-parent guidance, all four sampled solver evaluations, and the
  inherited optimizer rollouts were read before selecting a mechanism. Every
  evaluated run used direct uniform still water at `U_infinity=(0,0,0)`, no
  cylinders or prewarm, remained finite, and terminated in capture.
- The combined keyframe sheets were inspected in both views for the strongest
  sampled finite run, the sampled posterior-relief tradeoff, and the inherited
  stroke-redistribution child. From an empty release field, each fish visibly
  self-propels along the same broad target-directed arc, builds a coherent
  alternating top-down vortex street and paired oblique Lambda2 structures by
  `12T`, and retains the wake through capture. No wake breakup, advection-only
  motion, or visually distinct route explains the small score differences;
  terminal trajectory, load, and joint histories must decide the intervention.
- The v24 continuous-course baseline captures at `23.8315T` with scoring mean
  distance `2.434073L`. Inside `3L`, it has mean/peak absolute filtered yaw
  `1.6839/3.2076 rad/T`, mean body-lateral speed `0.2535U`, and mean absolute
  body-lateral force/yaw moment `0.009075/0.006402`. The sampled load-selective
  posterior counter-tangent has the best score (`-0.535298`) and the same
  arrival, but raises peak yaw to `3.2645 rad/T`, body-lateral speed to
  `0.2544U`, and peak moment to `0.014385`; it is progress evidence, not a clean
  yaw/load remedy.
- Unconditional yaw-supporting posterior half-cycle relief is the informative
  mechanism tradeoff. It retains capture and wake coherence while reducing
  terminal mean/peak yaw to `1.6060/3.0632 rad/T`, body-lateral speed to
  `0.2414U`, and mean moment to `0.006137`, without angle-limit or projected-
  command exposure. Its capture is later at `23.8755T`, consistent with losing
  useful posterior impulse.
- Three inherited attempts fail to make that posterior relief selective in a
  progress-saving way. Reinforcing-moment gating remains at `23.8755T` and
  worsens score/mean distance to `-0.537144/2.435252L`; target-course gating
  mostly reverts to baseline yaw (`1.6789 rad/T`) and still worsens score to
  `-0.536153`; equal relief/boost redistribution also remains at `23.8755T`
  and worsens score/mean distance to `-0.536206/2.434499L`, although it retains
  the relief child's mean yaw (`1.6028 rad/T`) and lateral-speed cleanup
  (`0.2410U`). Repeated posterior authorization or compensation is therefore
  not the next useful axis.

## Policy hypothesis recorded before policy edit

Use evaluated v24 as the behavioral base: preserve its state-feedback
traveling-wave carrier, posterior lag, response-released target C-bend,
continuous target-course terminal bend, and smooth component-wise command
projection. Add one bounded actuator-allocation mechanism. Carrier-rejected
excess yaw chooses a counter direction and observed posterior tangent chooses
the yaw-supporting half-cycle, but that residual shifts only the anterior
oscillator center. Posterior wave amplitude, lag, and cycle-scale authority are
not directly relieved, boosted, or gated.

This tests whether the anterior joint can supply phase-selected steering while
the posterior joint preserves reactive thrust. Falsify it if capture or the
coherent alternating wake regresses; if arrival and scoring mean distance do
not remain at v24 scale; if terminal yaw/lateral/load metrics fail to improve
over v24; or if joint-angle, joint-speed, or projected-command exposure worsens.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and robotic-fish asymmetric turning control
source_mechanism: allocate route and corrective curvature anteriorly while preserving posterior traveling-wave authority for thrust, with correction selected from observed beat side rather than a clock
transferable_invariant: when posterior stroke modification demonstrably trades yaw cleanup for progress, preserve posterior amplitude and lag and move one bounded phase-selected steering residual to the anterior joint
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target geometry retains the continuous course bend; carrier-rejected yaw supplies correction sign, observed q1+q2 supplies half-cycle state, and only the anterior oscillator center receives the bounded near-target counter-curvature
falsification: reject if capture or wake coherence regresses, v24-scale arrival/distance integral is not retained, terminal yaw/slip/load does not improve, or actuator-limit exposure grows
```

## Non-CFD validation

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account and failed before inspecting the workspace. Its
  material-guidance and solver-boundary commands were run directly and pass.
  The guidance check initially exposed a duplicated marker for the same
  assigned parent in the rendered workspace `README.md`; removing only that
  duplicate made parent resolution unambiguous and the check pass.
- The exact Julia policy smoke command cannot start because no Julia executable
  exists in this workspace. A deterministic static schema audit found all 68
  direct `params.FIELD` references among the 70 fields returned by
  `target_policy_params()`; only metadata fields `version` and
  `control_period` are intentionally unreferenced. Static guards found no
  clock, step counter, randomness, file I/O, fixed route, or cylinder identity.
- Replaying the new gate algebra on all 600 inside-`3L` states of the evaluated
  v24 trace activates the anterior residual in 233 states (`38.8%`). Its mean
  active oscillator-center shift is `0.58 deg` and its maximum is `1.78 deg`,
  below the parameterized `4 deg` bound; it is identically zero outside the
  proximity gate. Posterior amplitude and lag formulas are bitwise unchanged
  from v24. No CFD was run.
