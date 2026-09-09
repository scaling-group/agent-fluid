# Step 35 target-policy diagnosis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `capture` at `0.7492--0.7499L` after `18.4525--18.7495T`.
- The highest-score sampled rollout, `solver_ac993a461b7c`, is the requested
  exact replay of `dogfish3d_outer_unsupported_bearing_v1`. Its combined sheet
  shows continued body undulation, a strong alternating top-down vortex street,
  and bilateral oblique Lambda2 structures through capture. In stationary
  directly initialized water, its inertial target approach is self-propulsion,
  not advection. It captured at `0.74986L` after `18.6560T`, so together with
  the inherited first capture at `0.74975L` after `18.3205T`, this mechanism is
  now `2/2` on exact bytes.
- That replay remains inside the repeat-backed envelope: head/tail action
  clipping is `68.75%/70.70%`, exact speed-limit residence is
  `10.32%/11.29%`, and peak planar force/yaw moment magnitudes are
  `0.03143/0.01648`. The two sampled exact baseline captures have corresponding
  ranges `68.46--68.48%/70.64--71.00%`, `10.44--10.49%/11.30--11.39%`, and
  about `0.0312/0.0163`, so the qualifier preserves rather than cures the
  evidenced actuator and load regime.
- The prefilled `dogfish3d_unsafe_intercept_anterior_transfer_v1` also retains
  both organized wake views and captures, but later at `18.7495T`; its
  `68.76%/70.75%` clipping and `10.74%/11.62%` speed-limit residence provide no
  actuator benefit. Inherited step-27--29 lower exits and the assigned parent
  lesson already reject fixed anterior/posterior transfer as the next repair.
- The informative inherited failure is the closing-speed-triggered
  mean-curvature redirect at `1.2402L`. Its early wake matches the captured
  carrier, but it later follows the lower branch to `left_domain` at
  `10.1095L`; the late combined frames show a slowly varying bend and little
  new alternating wake. Detection of an opening pass therefore did not confer
  useful recovery authority.

## Candidate hypothesis

Restore the exact `dogfish3d_outer_unsupported_bearing_v1` bytes for a third
reliability trial. The controller keeps the repeat-backed state-feedback
carrier, posterior lag, steering allocation, intercept guard, and sparse speed
reserve. Its single extra mechanism admits normalized body-frame target bearing
only in the outer terminal annulus and only when achieved-course error is near
zero; it is absent in the far field and inner capture corridor.

Two exact captures support this qualifier more strongly than the sampled
fixed-transfer alternative, but the baseline's historical branching means
`2/2` is not yet a robustness claim. Do not tune the qualifier or stack a new
terminal residual in this trial. Confirm it only if the third exact evaluation
captures while retaining both active wake views and the established
actuator/load envelope. Falsify it as a reliable repair if the repeat follows
the lower branch, weakens propulsion, or worsens clipping, speed residence,
force, or moment materially.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: add bounded target-vector direction feedback without replacing the independently sustained propulsive oscillator
transferable_invariant: when achieved-course error is momentarily uninformative, admit only the unsupported part of normalized body-frame target bearing while preserving the traveling bend
nontransferable_details: published gains, dimensional cadence, CPG phase equations, robot morphology, species kinematics, exact vortex phases, and task-specific routes
policy_translation: exactly repeat the outer-terminal unsupported-bearing qualifier over the two-joint state-feedback carrier, leaving the far field, inner intercept guard, posterior lag, and speed reserve unchanged
falsification: reject reliability if the third exact run misses or retains the lower branch, either wake weakens, or clipping, speed residence, force, or moment leaves the repeat-backed envelope
```

## Dry checks after the edit

- Candidate SHA-256 is
  `3265a7883db6fef3024a08b1b27b3f691751843a48f8dbda262052818d17d901`,
  exactly matching sampled `solver_ac993a461b7c`, the finite direct-uniform
  `0.74986L` capture selected for repetition.
- The deterministic schema guard finds all `45` direct `params.FIELD`
  references among the `47` fields returned by `target_policy_params()`.
- The mandated check runner passes guidance semantics, the lightweight Julia
  policy contract, and the editable boundary. Julia was reached through the
  workspace's documented lease-wrapper directory on `PATH`.
- No CFD was run; the third exact closed-loop outcome remains future evidence.
