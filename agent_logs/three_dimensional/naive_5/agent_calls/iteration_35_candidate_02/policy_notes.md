# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture without angle, speed, or applied-acceleration contact,
  so route response, arrival, distance integral, wake organization, and loads
  are more informative than termination class or first-crossing depth alone.
- Both rows of the combined sheets were inspected from release through capture
  for the best-score sample (`solver_7c8c0623a821`), the assigned solver parent
  (`solver_cd2b31e85ca6`), and the deeper-crossing but lower-score geometric
  comparison (`solver_08d41e0117b7`). Their top-down views show genuine
  self-propulsion and an orderly alternating reverse-vortex street followed by
  the same late target-side hook. Their oblique Lambda2 views retain a compact,
  coherent three-dimensional wake. None shows imposed advection, wake breakup,
  a boundary interaction, instability, or moving-window-induced rotation.
  This supports retaining the traveling-bend carrier and feasibility guards.
- The assigned-parent policy is replicated byte-for-byte by
  `solver_c65157fcb0b0` and `solver_cd2b31e85ca6`: both capture at
  `0.749266L` and `25.9710T`, with mean distance `2.498175L`, peak planar
  force/yaw moment `0.018852/0.010104`, and no actuator contacts. This confirms
  deterministic fixed-pose performance, not held-out robustness.
- Sampled post-turn posterior sideslip recovery (`solver_7c8c0623a821`) is only
  a finite tie-break. It captures `0.0550T` earlier, lowers mean distance by
  just `0.000583L`, and displaces the head centerline by at most `0.0219L`.
  The visual route remains the same shallow hook, with nearly unchanged peak
  force/yaw moment (`0.019020/0.010164`). The alternative translation-side and
  bend-phase-qualified policy (`solver_08d41e0117b7`) changes the upstream
  centerline by as much as `0.254L` and reduces projected miss from
  `2.14L` to `1.44L` at `22T`, but captures `0.0440T` later, raises mean
  distance by `0.003339L`, and scores worse. These results do not support
  scalar-strengthening or stacking another posterior vectoring term.
- The sampled traces instead expose an observation inconsistency in the
  inherited target-line response. Because the physical head points along the
  negative body-x axis, the folded bearing convention does not have the
  ordinary forward-axis rotation sign. Yet the policy adds
  `bearing_window_rate + turn_rate_recent` and labels the sum inertial LOS
  rotation. On the assigned trace this quantity is approximately
  `0.65/0.19/0.43` carrier-rate units at `8/16/22T`, whereas the coordinate-free
  kinematic LOS rate `(velocity_body x target_body)/distance^2` is only
  `0.006/0.008/0.025`. The inflated estimate is dominated by tail-beat body
  rotation and repeatedly saturates the navigation demand even while the
  current course-triggered redirect already supplies upstream authority.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, course/miss-
triggered response-released redirect, upstream posterior vectoring, terminal
posterior modulation, coordinated acceleration projection, and angle/rate
viability guards. Change exactly one feedback mechanism: derive target-line
rotation directly from the normalized body-frame target vector and measured
body-frame translation, using
`(velocity_x*target_y - velocity_y*target_x)/distance^2`, normalized by the
carrier rate. Use this kinematically consistent signal for both the established
navigation side and desired yaw magnitude while retaining the positive-response-
deficit comparison, closing gate, phase-selective anterior actuation, and all
existing bounds. At zero translation the signal is naturally zero and the
bearing/course carrier remains responsible for startup; near capture the same
geometric rate grows continuously and retains target-line correction.

The falsifiable expectation is to keep the parent's early progress and coherent,
limit-free wake while reducing the phase-contaminated navigation co-command and
the `20--22T` body-normal drift, yielding an earlier or visibly straighter
capture with a real margin beyond the milliscale cluster. Reject the mechanism
if capture is lost, middle projected miss is not reduced, the route merely
returns another milliscale-equivalent hook, propulsion or wake coherence
degrades, any actuator contact returns, or peak force/yaw moment materially
exceeds `0.01902/0.01016`.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction control and wake-interaction control
source_mechanism: separate slow persistent target geometry from fast alternating body and flow response before modulating a rhythmic carrier
transferable_invariant: a route-response residual should be driven by a coordinate-free translational target-line signal rather than a phase-contaminated body-rotation surrogate
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact vortex phases, and prescribed routes
policy_translation: normalized body-frame target and velocity define inertial line-of-sight rotation; the existing positive yaw-response deficit gates the same joint-state-phased anterior channel under the inherited two-joint bounds
falsification: reject on lost or slower capture, unchanged middle miss, degraded coherent wake, actuator contact, increased load exposure, or another milliscale-equivalent route

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 55-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic 11,664-state grid spanning both lateral reflections,
  forward and folded target geometry, zero and finite translation, negative
  and positive closing speeds, and beyond-limit joint angles/rates remains
  finite and inside the `30 rad/T^2` policy envelope. Paired lateral
  reflections have command error below `1e-10`.
- Re-evaluating the assigned solver parent and candidate on 4,722 reconstructed
  parent-trace states changes 3,333 post-guard command pairs, including 2,983
  by more than `0.05 rad/T^2`; the maximum separation is
  `2.76567 rad/T^2`. The candidate's frozen-state peak remains the parent's
  `29.65805 rad/T^2`. Broad activation is expected because this is a semantic
  correction of the established navigation observation, not a distance-window
  retune. Formal CFD evaluation after this worker exits must determine whether
  the changed response remains productive.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed checks were run
  directly: material-guidance, Julia contract/schema, and solver editable-
  boundary checks all pass. No formal CFD was run.
