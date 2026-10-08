# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled solver evaluations satisfy the frozen rollout contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and inertial moving-window transport. All capture with
  zero angle, rate, or applied-acceleration contacts. The three duplicated
  assigned-parent samples byte-match in policy, trajectory, and combined
  visual sheet; they establish deterministic fixed-pose behavior rather than
  three independent trajectory tests.
- I inspected the combined sheets from release through capture for the
  assigned parent (`solver_071e142a4dfe`), the strongest distinct sampled
  candidate (`solver_edce799cc5f9`), and the informative inherited
  posterior-duty failure (`solver_f3fc5dcaa799`) in both the top-down
  mid-plane vorticity/body row and the oblique body/Lambda2 row. Each fish
  visibly self-propels from rest and leaves an orderly alternating planar wake
  with compact three-dimensional vortices through the late target-side hook.
  There is no passive advection, boundary precursor, wake breakup, numerical
  instability, or moving-window-induced rotation. The closing-gated
  posterior-duty trace is visibly behind at `24T` and follows a longer hook,
  so its regression is controller response rather than carrier loss.
- The assigned parent captures at `0.748598L` and `25.5090T`, with score
  `-0.556475`, mean distance `2.457773L`, and distances/course-projected misses
  of `2.5563/2.143L` at `22T` and `1.4748/1.160L` at `24T`. Replacing its
  instantaneous middle slip and adverse-force residuals with the sampled
  phase-rejected posterior reaction leaves the trace identical through `16T`
  and almost identical at `20T`, then improves those pairs to
  `2.5498/2.077L` and `1.4492/1.126L`. It captures earlier at `0.748585L` and
  `25.3495T`, raises score to `-0.555926`, and slightly lowers mean distance to
  `2.456908L`.
- Metrics support the visual comparison. Both policies have the same sampled
  peak speed, joint angle/rate/action, planar force, and yaw moment to the
  reported precision (`0.708934U`, `0.770926 rad`, `4.517689 rad/T`,
  `29.867953 rad/T^2`, `0.020625`, and `0.010651`) and no hard-limit contacts.
  Across the parent's `1.75--4.5L` middle corridor, target-normal velocity is
  strongly beat-synchronous with normalized anterior rate (correlation
  `-0.973`), so reacting to raw instantaneous sideslip confounds persistent
  course response with carrier cadence. The sampled replacement subtracts
  that cadence estimate and adds posterior authority only on one
  geometry-consistent tail-rate half-cycle.
- The inherited optimizer log supplies a complementary negative test not yet
  captured in durable guidance. Delaying an opposite-bend posterior duty term
  until measured whole-body closing developed still captured later at
  `26.1580T`, worsened mean distance to `2.469999L`, and reached only
  `2.6670L` and `1.6009L` at `22/24T`, despite improving instantaneous course
  error and retaining a coherent wake with zero contacts. The failure rules
  out low-speed startup activation as the sole cause of posterior-duty loss:
  duplicating anterior residence asymmetry at joint 2 trades away propulsive
  progress even after translation is established.

## One-candidate policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, upstream
anterior course-duty steering, course/miss-triggered response-released
redirect, target-line response, capture modulation, coupled command
projection, and angle/rate viability guards. Replace only the already
falsified instantaneous middle slip/force residual pair with the sampled
phase-rejected posterior reaction. In the closing `1.75--4.5L` corridor, the
controller subtracts a joint-state cadence estimate from normalized
target-normal velocity, requires the residual to agree with body-frame route
geometry, and extends only the posterior reaction half-cycle. This retains
posterior wave direction and uses neither a static bend, clock phase, global
route, nor instantaneous hydrodynamic load to choose the steering side.

The falsifiable expectation is reproduction of the distinct sampled trace:
unchanged upstream progress, lower distance and projected miss by `22/24T`,
capture near `25.3495T`, the same coherent top-down and oblique wake, zero
actuator contacts, and peak loads no greater than `0.020625/0.010651`. Reject
the mechanism if the new evaluation falls back to the parent's `25.5090T`
trace, loses capture or wake coherence, changes the upstream route, restores
any limit contact, or increases force/moment exposure. A fixed-pose replicate
does not establish held-out geometric robustness.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and reactive traveling-wave swimming
source_mechanism: separate persistent sensor-derived course error from beat-synchronous lateral motion before modulating the posterior propulsive wave
transferable_invariant: route geometry should own steering side while a fast cadence-correlated response is phase-rejected and only one compatible posterior half-cycle receives bounded residual authority
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific kinematics, exact vortex phases, clock phase, and task-specific routes
policy_translation: use normalized body-frame target/velocity geometry, anterior joint rate normalized by carrier scale, and posterior joint-rate sign to gate the sampled bounded middle-corridor reaction while preserving the state-feedback lag carrier
falsification: reject if late distance and projected miss do not reproduce, upstream propulsion changes, capture or coherent three-dimensional wake is lost, or actuator and load exposure exceed the sampled regime
```

## Non-CFD audit after the policy edit

- The candidate byte-matches the distinct sampled phase-reaction artifact at
  SHA-256 `7b79dd4e34ae7ffafcfcc739c609be86c685988904de2e6053c4721a2bef6cc0`.
  The next CFD evaluation is therefore a fixed-condition replication, not
  same-worker performance evidence or a held-out robustness test.
- The prescribed Julia contract returns two finite accelerations. All 65
  direct `params.FIELD` references are owned by the 65-field object returned
  from `target_policy_params()`.
- The material-guidance check and solver editable-boundary check pass. The
  required independent check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this account; its three prescribed
  commands were therefore run directly and separately, following the
  established inherited fallback. No formal CFD was run.
