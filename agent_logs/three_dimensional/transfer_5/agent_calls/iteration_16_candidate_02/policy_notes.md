# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts and the relevant inherited descendants were read
  before selecting the candidate. Each evaluation used direct uniform still
  water at `U_infinity=(0,0,0)`, no cylinders or prewarm, remained finite, and
  terminated in capture. Thus none of the observed motion is background
  advection or a stale-flow artifact.
- The combined keyframe sheets were inspected from release to capture in both
  views. The best sampled run (`solver_2546ece173ab`) and the informative
  posterior-relief parent (`solver_3b8f345c391b`) both start with an empty flow
  field, visibly translate toward the target, form a coherent alternating
  top-down vortex street and compact paired oblique Lambda2 structures, and
  retain that wake through the curved terminal approach. The other sampled
  sheets show the same useful topology. Policy differences are below the
  visual sheet's resolution, so trajectory, load, joint, and score histories
  decide the intervention.
- The assigned prefill's posterior half-cycle amplitude relief captures at
  `23.8755T` with score `-0.535565` and scoring mean distance `2.433993L`.
  Inside `3L` it improves mean/peak absolute yaw to `1.6060/3.0632 rad/T`,
  mean body-lateral speed to `0.2414U`, and mean absolute lateral force/yaw
  moment to `0.011351/0.006137`, but it does so by removing useful posterior
  stroke authority and arrives about `0.044T` later than the inherited v24
  continuous-course baseline.
- Three inherited descendants show that posterior selectivity is not the
  progress-saving mechanism. Reinforcing-moment gating retains the late
  `23.8755T` arrival and worsens score to `-0.537144`; target-course gating
  mostly restores baseline-scale yaw while scoring `-0.536153`; and equal
  posterior relief/boost redistribution preserves the parent's yaw cleanup
  but still arrives at `23.8755T` and scores `-0.536206`. These are concrete
  negative results against another posterior gate, redistribution, or scalar
  relief retune.
- The anterior half-cycle allocation in `solver_2546ece173ab` is the only
  sampled descendant that moves this tradeoff favorably. It preserves the
  posterior traveling-wave amplitude and lag, captures at `23.8425T`, and has
  the best sampled score/mean distance/final distance
  (`-0.535091`, `2.433543L`, `0.746165L`). Its terminal mean/peak yaw is
  `1.6800/3.1848 rad/T`: it does not retain the relief parent's full yaw
  cleanup, but it trims the inherited v24 peak (`3.2076 rad/T`) while keeping
  progress near the v24 arrival. Mean body-lateral speed and mean absolute
  lateral force/moment remain finite at `0.2522U`, `0.011756`, and `0.006382`;
  no angle-limit or projected-command exposure is introduced.

## Policy hypothesis recorded before policy edit

Replace the prefilled posterior amplitude-relief candidate with the evaluated
anterior half-cycle counter-curvature structure from the strongest sampled
finite run. Preserve the state-feedback traveling-wave carrier, posterior lag
and amplitude, response-released body-frame C-bend, continuous terminal course
bend, and smooth component-wise command projection. Carrier-rejected excess
yaw provides the counter direction, and the observed two-joint posterior
tangent selects the yaw-supporting half-cycle; only the anterior oscillator
center is shifted during that half-cycle.

This is a structural actuator reallocation, not scalar-only tuning. The
evidence-backed expectation is capture with the sampled coherent wake and a
better distance integral than the assigned posterior-relief parent, while
avoiding the repeated progress loss caused by modifying posterior amplitude.
The source rollout is prior evidence, not same-worker CFD evidence. Falsify
this transfer if the post-worker evaluation loses capture or wake coherence,
does not reproduce v24-scale arrival and the sampled distance improvement, or
shows materially worse terminal yaw, lateral load, joint-limit exposure, or
projected-command exposure than the sampled anterior-allocation rollout.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and robotic-fish asymmetric turning control
source_mechanism: allocate bounded corrective curvature anteriorly while preserving posterior traveling-wave amplitude and lag for reactive thrust
transferable_invariant: when posterior stroke modification trades yaw cleanup for progress, preserve cycle-scale posterior authority and move the phase-selected steering residual to an anterior actuator
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target geometry retains the continuous course bend; carrier-rejected yaw sets correction sign, observed q1+q2 selects the supporting half-cycle, and only the anterior oscillator center receives bounded counter-curvature without clock or memory
falsification: reject if capture or coherent wake formation regresses, v24-scale arrival and distance integral are not retained, terminal yaw or lateral load worsens materially, or actuator-limit exposure grows
```

## Validation boundary

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  Its material-guidance and solver-boundary checks were then run directly and
  pass.
- The Julia contract command cannot start because no Julia executable is
  installed. A deterministic static schema audit found all 68 direct
  `params.FIELD` references among the 70 fields returned by
  `target_policy_params()`; only metadata fields are unreferenced. Static
  guards found no clock/step source, randomness, file I/O, cylinder identity,
  or fixed-route call. Exactly one nonempty `candidate_target_policy.jl`
  exists under `solver/`.
- The candidate is byte-identical to the evaluated sampled anterior-allocation
  policy (SHA-256
  `76326f8c68a66de9ac6ae47fcb039608cf5cf954ff1bd07c6846e557d4d48a0d`),
  providing a stronger contract/behavior anchor than an unexecuted algebraic
  variant. No CFD was run in this worker; the formal post-worker evaluation
  remains the test of materialization in the new artifact.
