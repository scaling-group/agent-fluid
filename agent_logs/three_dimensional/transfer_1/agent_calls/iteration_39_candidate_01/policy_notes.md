# Step 39 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver evaluations satisfy the released experiment contract:
  direct uniform `U_infinity=(0,0,0)`, no cylinders, and no prewarm. They all
  capture at `0.74846--0.74986L` after `18.2875--18.6560T`. Their combined
  sheets show self-propulsion from release, a persistent alternating top-down
  vorticity street, and bilateral oblique Lambda2 structures through capture.
- The assigned parent is the outer-terminal unsupported-bearing qualifier. Its
  sampled run captured at `0.74986L` and `18.6560T`, but inherited exact replay
  passed at `1.18462L` and exited below while retaining both organized wake
  views. It is therefore a concrete `1/2` negative and should not be replayed
  or scalar-tuned.
- The most informative inherited failure is the hard capture-corridor
  certificate: direct-uniform, stable, and visibly self-propelled, with a
  coherent alternating street and bilateral 3D structures before and after its
  `1.67826L` closest pass. It then turns below the target and exits at
  `10.28354L`; the failure is terminal path geometry, not advection, carrier
  collapse, collision, or instability.
- Both immediately inherited step-38 mechanisms subsequently achieved a new
  semantic success. Partial outer steering retention captured at `0.74852L`,
  and the bounded outer-terminal LOS-rate residual captured at `0.74605L`;
  both arrived at `18.29849T` with the same coherent two-view wake. The LOS
  residual had the better of their scores (`-0.15938` versus `-0.16280`) and
  stayed close to the repeat-backed actuator/load envelope: head/tail action
  clipping `68.50%/70.51%`, speed-limit residence `10.58%/11.66%`, and peak
  body-force/moment coefficients `0.01475/0.02916/0.01593`.
- One threshold capture is not robustness evidence. The earlier qualifier's
  capture-then-failure record makes an exact-byte repeat more informative than
  tuning the LOS residual or stacking it with partial retention. Scalar score
  is also not the selection criterion: the LOS candidate's mean distance
  (`2.04677L`) was worse than the sampled parent's `2.03725L`, despite its
  earlier capture.

## Candidate hypothesis

Install exactly the inherited `dogfish3d_outer_los_rate_intercept_v1` bytes
without tuning or an additional mechanism. The controller preserves the raw
achieved-course servo, response-conditioned inner intercept guard, sparse
outward-only carrier reserve, steering shares, and posteriorly lagged traveling
bend. Its sole additional mechanism is a bounded residual that opposes inertial
line-of-sight rotation while the fish is approaching between `4L` and `1.5L`;
it fades to zero before the capture sphere and never becomes post-pass recovery.

This candidate tests whether the inherited capture survives an independent
direct-uniform repeat. Treat capture plus preservation of the established wake,
actuator, and load envelope as support; reject the mechanism if it misses or
exits, changes far-field closure, weakens either wake view, or materially
worsens clipping, speed residence, force, or moment. No same-worker CFD result
is claimed.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic CPG
source_mechanism: bounded line-of-sight-rate interception feedback superposed on an independently sustained propulsive rhythm
transferable_invariant: use observed target-response geometry for a small steering residual while keeping the propulsive traveling bend independently active
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: derive normalized inertial LOS rate from body-frame target and velocity cross product; apply one bounded approaching outer-terminal residual through the existing two-joint steering shares and release it before inner capture
falsification: reject if exact repeat loses capture, retains the coherent lower-exit topology, degrades either wake, or moves actuator and load metrics outside the repeat-backed envelope

## Non-CFD validation

- The installed solver file is byte-identical to the inherited evaluated LOS
  candidate (SHA-256 `fa1e73606ad3cccf13d12579377fd177abd8f6fa5b6fc00b42c1d1b501503db6`).
- The required guidance check passes with a material reusable update.
- Julia 1.12.6 loads the candidate and returns the finite two-joint action
  `(-15.078363043496848, -1.6932057383289447)` for the prescribed contract
  probe. Static checking finds all 48 direct `params.FIELD` references among
  the 50 fields returned by `target_policy_params()`.
- The solver editable-boundary check passes. No CFD was run.
