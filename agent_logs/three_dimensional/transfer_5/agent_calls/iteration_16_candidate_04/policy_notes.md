# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- The assigned parent, every sampled solver, and the inherited evaluated
  children satisfy the frozen contract: direct uniform still water at
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture.
- The combined sheets were inspected from release through capture. In the
  assigned parent, the best sampled score, and the inherited posterior-
  redistribution child, the initially empty top-down field develops a coherent
  alternating vortex street and the oblique row develops compact paired
  Lambda2 structures behind a translating fish by `12T`. Each fish visibly
  self-propels along the same broad target-directed arc and retains its wake
  through capture. There is no advection-only motion or wake breakup; the
  controller differences are below keyframe resolution and must be decided by
  terminal trajectory, load, and joint histories.
- The assigned parent's posterior half-cycle amplitude relief captures at
  `23.8755T` with scoring mean/final distance `2.433993/0.746615L`. Relative
  to the evaluated v24 continuous-course baseline, it lowers inside-`3L`
  mean/peak absolute yaw from `1.6839/3.2076` to `1.6060/3.0632 rad/T`, mean
  body-lateral speed from `0.2535U` to `0.2414U`, and mean absolute moment from
  `0.006402` to `0.006137`, but arrives `0.044T` later.
- The assigned parent's proposed equal posterior relief/boost was subsequently
  evaluated. It preserves the cleanup (`1.6028/3.0654 rad/T` yaw,
  `0.2410U` body-lateral speed, `0.006126` mean moment) but does not recover any
  arrival: capture remains `23.8755T`, while score, mean distance, and final
  distance worsen to `-0.536206`, `2.434499L`, and `0.747290L`. Together with
  the inherited moment- and course-selected relief failures, this rejects more
  posterior relief authorization or compensation as the next axis.
- The sampled v33 anterior half-cycle counter-curvature is the new positive
  result. It preserves the coherent carrier and untouched posterior amplitude
  and lag, has the best sampled score `-0.535091`, improves scoring mean/final
  distance to `2.433543/0.746165L`, and captures at `23.8425T`. Against v24 it
  gives small but consistent inside-`3L` cleanup in mean/peak yaw
  (`1.6800/3.1848 rad/T`), body-lateral speed (`0.2522U`), mean moment
  (`0.006382`), and peak moment (`0.013730`), without angle-limit or new
  projected-command exposure. Its residual is therefore a useful anterior
  steering primitive, though its arrival remains `0.011T` behind v24.

## Candidate hypothesis recorded before policy edit

Use evaluated v33 as the sole behavioral base. Preserve its target-aware
state-feedback oscillator, posterior lag and amplitude, response-released
C-bend, continuous body-frame terminal course bend, phase-selected anterior
counter-curvature, and component-wise smooth acceleration projection. Add one
compact response-release layer to the anterior residual: while carrier-
rejected excess yaw and observed `phi1+phi2` still select the counter-yaw
half-cycle, normalize anterior joint velocity by the current oscillator speed
and continuously release the center shift after `phi_dot1` moves in the
requested counter direction. Motion opposite the correction leaves full
authority.

This translates the already successful redirect invariant--strong bounded
curvature until an observed response develops, then release into the traveling
carrier--to v33's terminal anterior actuator. It should preserve the posterior
thrust and v33 distance benefit while recovering its small arrival cost and
avoiding unnecessary counter-curvature late in a responding stroke. Falsify
the mechanism if capture or alternating-wake coherence is lost; arrival and
distance metrics fail to match or improve on v33; its modest terminal
yaw/lateral/load cleanup is lost; or joint-angle, joint-speed, or projected-
command exposure worsens.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and sensor-modulated robotic-fish CPG turning
source_mechanism: apply bounded curvature during a large observed directional error and release it continuously when joint-state response appears so the traveling carrier resumes
transferable_invariant: separate a target-derived corrective bend from the propulsive carrier and withdraw the correction after observed motion develops in the requested direction
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target and yaw feedback retain v33's correction sign, observed two-joint tail tangent selects the half-cycle, and anterior velocity normalized by the state-feedback oscillator speed releases only the anterior center shift without a clock, memory, or posterior-wave edit
falsification: reject if capture or wake coherence regresses, if v33-scale distance and arrival are not retained, if terminal yaw/lateral/load cleanup disappears, or if actuator-limit exposure grows
```

The new candidate has no same-worker CFD evidence; its formal result is for a
later generation to evaluate and distill.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it
  could inspect the workspace. Its material-guidance and solver-boundary
  commands were run directly and pass. The guidance check first exposed the
  duplicated rendered marker for the same assigned parent in `README.md`;
  removing only that duplicate made parent resolution unambiguous.
- The deterministic schema audit found all 70 direct `params.FIELD` references
  among the 72 fields returned by `target_policy_params()`; only metadata
  fields `version` and `control_period` are intentionally unreferenced. Static
  guards found no time/step state, randomness, file I/O, cylinder identity, or
  mutable global state.
- A `531,441`-state algebraic grid over signed yaw demand, observed tail side,
  and normalized anterior velocity bounds the new response gate to
  `[0.40,1.00]` and the center shift to `4 deg`. Sign-reflected states have
  exactly opposite curvature, full correction is retained before joint motion
  responds, and posterior target/amplitude/lag expressions remain identical to
  evaluated v33.
- The Julia smoke command cannot start because no Julia executable or local
  Julia toolchain exists in this workspace. No formal CFD was run.
