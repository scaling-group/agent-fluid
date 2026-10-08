# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis before editing

- I read the assigned-parent guidance, all four sampled solver results, the
  inherited optimizer notes, and the current candidate before selecting a
  mechanism. Every sample is a finite capture from direct uniform still water
  at `U_infinity=(0,0,0)`, without cylinders or prewarm. The four policy files
  and combined keyframe sheets are byte-identical v33 repeats, and their scored
  metrics are numerically identical. They therefore establish reproducibility
  of one controller rather than four independent comparisons.
- I inspected the shared combined sheet from release through capture in both
  required views. The initially empty top-down mid-plane field develops a
  spatially ordered alternating vortex street behind a fish that translates
  and turns toward the target. The oblique Lambda2 row develops compact paired
  three-dimensional structures that remain attached to the same broad curved
  approach through capture. There is no visual evidence of passive advection,
  wake breakup, virtual-boundary approach, or instability.
- Sampled v33 captures at `23.8425T` with score `-0.535091`, scoring mean/final
  distance `2.433543/0.746165L`, and progress `0.939473`. Inherited diagnostics
  report inside-`3L` mean/peak absolute yaw of `1.6800/3.1848 rad/T`, mean/peak
  absolute moment `0.006382/0.013730`, and mean body-lateral speed `0.2522U`.
  Its coherent carrier and phase-selected anterior correction are therefore
  useful behavior to preserve, not defects to replace wholesale.
- The inherited v35 result is the informative failed intervention absent from
  the duplicate sample set. Adding a `0.30` full-tail-rate share to the v33
  terminal observer reduced inside-`3L` mean/peak yaw to
  `1.6103/3.0497 rad/T`, mean lateral speed to `0.2391U`, and mean moment to
  `0.006106`, but regressed score/arrival/mean/final distance to
  `-0.535811/23.8975T/2.434232L/0.746866L`. Thus a cleaner terminal residual is
  not a progress objective. The assigned-parent replay also found that v33's
  materially active phase-selected correction coincides with greater radial
  closure (`0.700L/T` versus `0.672L/T` without material support), so another
  terminal carrier-suppression or closure gate is poorly supported.
- A fresh replay exposes a distinct route-level signal before that terminal
  gate. After subtracting v33's existing anterior phase proxy from the
  target-line transverse velocity, mean residual cross-track speed is
  `-0.156U` over `10–8L`, `-0.160U` over `8–6L`, and `-0.118U` over `6–4L`;
  the corresponding bounded course-angle means are about `-0.260`, `-0.260`,
  and `-0.190 rad`. The residual tapers to `-0.060U` by `4–3L`. This persistent
  same-sign midcourse drift is separate from the alternating carrier and is
  present on the successful trajectory before any v33/v35 difference begins.

## Candidate hypothesis recorded before policy edit

Preserve v33's evaluated joint-state oscillator, response-released body-frame
C-bend, posterior amplitude and lag, terminal course/yaw logic, phase-selected
anterior correction, and component-wise smooth command projection. Add one
bounded midcourse course-angle feedback path: project the body-frame swimming
velocity onto the instantaneous target line, subtract the already validated
anterior carrier proxy from its transverse component, convert the remaining
transverse/radial velocity ratio to a bounded angle, and add a small mean-turn
request. Ramp this path out from `5L` to zero at the existing `3L` terminal
boundary so it cannot directly reproduce v35's terminal closure loss.

This is a new observation-to-curvature mechanism, not scalar tuning of the
carrier. The expectation is less persistent midcourse sideslip and a shorter
approach while the wake, terminal controller, and actuator topology remain
unchanged. Falsify it if capture or coherent alternating wake formation is
lost; arrival, score, or mean/final distance regress from reproducible v33;
the pre-`3L` carrier-rejected cross-track residual does not decrease; terminal
yaw/moment or v33-scale closure worsens; or joint/command exposure grows.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and target-course control
source_mechanism: retain a rhythmic propulsive carrier while slow observed course error supplies a bounded steering bias
transferable_invariant: persistent target-relative velocity misalignment can modulate mean curvature independently of the joint-state traveling wave, while fast carrier motion is rejected rather than cancelled
nontransferable_details: published gains, dimensional cadence, hardware duty ratios, species-specific kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: form a scale-free course angle from normalized body-frame target and velocity, subtract v33's state-derived anterior carrier proxy, taper the bounded request out before the validated terminal controller, and leave posterior amplitude and lag unchanged
falsification: reject if pre-terminal cross-track drift is not reduced without preserving v33-scale capture, arrival, distance integral, coherent wake, terminal yaw/load, and actuator-envelope behavior
```

The shelf supplied only the separation between rhythmic propulsion and slow
sensor-derived direction feedback. All signs, scales, and scheduling boundaries
come from the completed v33 trajectory and inherited v35 falsification. The
candidate has no same-worker CFD evidence; formal evaluation occurs after this
worker exits.

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before it could
  inspect the workspace. Its prescribed checks were therefore executed
  directly and separately. The guidance-materiality check initially exposed
  two identical assigned-parent markers in the rendered root `README.md`;
  removing only the duplicate made the parent unambiguous, and the rerun passes.
- The solver-boundary check passes and confirms that only the permitted target
  policy differs from the frozen solver baseline. Exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`.
- Julia is not installed, so the exact lightweight contract smoke command
  cannot start. The deterministic static guard finds all `72` directly
  referenced `params.FIELD` names among the `74` fields returned by
  `target_policy_params()`; only metadata fields are unreferenced. Static scans
  find no clock, step, random input, file I/O, mutable global state, cylinder
  identity, or fixed route.
- Replay of the added observation path on the completed v33 trace bounds the
  new request to `0.252`, compared with the existing turn-request limit of
  `6.0`, and confirms it is exactly zero in all `602` sampled states at or
  inside `3L`. No CFD was run.
