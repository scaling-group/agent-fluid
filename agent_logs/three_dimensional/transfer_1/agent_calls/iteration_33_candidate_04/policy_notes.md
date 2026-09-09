# Step 33 target-policy diagnosis

## Evidence read before the edit

- All four sampled rollouts are direct-uniform still-water cases with
  `U_infinity=(0,0,0)`, no cylinders, and capture at `0.7480--0.7495L` after
  `18.199--18.749T`. Their top-down rows show organized alternating signed
  vortices from release through capture; their oblique rows show bilateral
  Lambda2 structures and continuing body undulation at the terminal frame.
  With no imposed current, the `0.87--0.91L/T` mean terminal speed and active
  wakes establish self-propulsion rather than advection or terminal coasting.
- The assigned parent's exact burden-conditioned allocation repeat is the
  informative visual failure. Its carrier remains active in both views and
  its peak planar force, yaw moment, and local crossflow remain inside the
  sampled capture envelope, but it reaches only `1.8544L`, turns onto the
  recurrent lower branch, and exits at `31.3665T` with final distance
  `10.1364L`. Together with its earlier `0.7474L` capture, that allocator is
  `1/2`; actuator burden is not a repeat-backed terminal discriminator.
- The sampled anterior-transfer policy also captures, but at `18.7495T` it is
  slower than both sampled exact speed-reserve captures and leaves action
  clipping and speed-limit residence inside rather than below their envelope.
  The prefilled fixed transfer is therefore not retained or scalar-tuned.
- Body-frame trace reconstruction gives a separable route-response signature.
  At the first `4L` crossing, the four sampled captures have absolute achieved-
  course error `0.050--0.113 rad`, whereas the parent failure is already at
  `0.369 rad`; at `3L`, captures span `0.128--0.275 rad` and the failure is
  `0.489 rad`. Across the `2.75--4L` annulus, mean absolute course error is
  `0.275--0.285 rad` for the captures versus `0.844 rad` for the failure, yet
  the current response logic can still release steering on correct-sign yaw
  alone. The wake is healthy, so this indicates loss of closed-loop route
  authority rather than insufficient propulsion.

## Candidate hypothesis

Restore the exact intercept-guarded speed-reserve carrier and original
head/tail steering shares. Add one continuous error-aware veto to the existing
response release: a correct-sign yaw response may reduce steering only while
the raw achieved-course error is also within a bounded alignment corridor.
Large persistent course error therefore keeps the existing full steering
residual active; no new steering magnitude, carrier attenuation, spatial
allocation, target-bearing residual, or phase shaping is introduced.

Expected result: keep sampled capture paths effectively on the established
carrier while preventing the high-error lower branch from interpreting an
instantaneous correct-sign yaw response as completion of the redirect.
Falsify the mechanism on an exact-policy miss, survival of the same lower
branch, weakened wake, later capture, or force, moment, clipping, speed-limit
residence, or terminal speed outside the repeat-backed envelope. Offline trace
replay is only a locality check and is not claimed as CFD evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: retain the propulsive rhythm during a bounded redirect and release directional feedback only after observed route error has reduced
transferable_invariant: correct-sign yaw response alone is insufficient evidence to release steering while normalized body-frame achieved-course error remains large
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, CPG phase equations, exact vortex phases, and task-specific routes
policy_translation: preserve the posteriorly lagged two-joint carrier and existing body-frame course servo, and continuously veto its yaw-response release as a function of absolute achieved-course error
falsification: reject if repeat capture reliability, far-field closure, either coherent wake view, arrival, loads, terminal speed, or actuator-envelope behavior worsens or if the lower-pass topology survives

## Dry checks after editing

- Replaying the recorded states through the release modules in the
  `2.75--4L` annulus reduces mean response release only from
  `0.113--0.130` to `0.101--0.128` on the four sampled captures. On the
  parent's persistent-error failure it reduces release from `0.0540` to
  `0.0057`, affects 109 otherwise released rows, and fully vetoes 97. This
  establishes selectivity on inherited traces, not a counterfactual CFD path.
- Direct Julia probes give zero veto for a capture-like `0.114 rad` course
  error, a continuous `0.170` veto weight at `0.493 rad`, and full veto for a
  `1.190 rad` error. Sign-reflected observations return equal veto weights and
  exactly sign-reflected joint accelerations; all actions are finite.
- The required guidance-difference, parameter-schema/policy-contract, and
  editable-boundary checks pass. No CFD rollout was run in this workspace.
