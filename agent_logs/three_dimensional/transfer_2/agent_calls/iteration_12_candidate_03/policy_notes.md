# Actuator-consistent stroke-aware candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm, finite dynamics, and moving-window transport. Three samples are
  byte-identical course-preview controllers with the identical capture at
  `24.5795T`, `0.74697L`, and mean distance `2.36044L`; they replicate one
  mechanism rather than three independent improvements.
- Both rows of the combined keyframe sheets were inspected for the replicated
  course-preview capture and the behaviorally distinct stroke-aware capture.
  In the top-down view both self-propel along the same early diagonal and shed
  a coherent alternating reverse-vortex street; the redirect starts before
  passage and the head crosses the capture circle near `24.6T`. The oblique
  body/Lambda2 row shows compact three-dimensional wake structures through the
  redirect and capture. There is no imposed advection, wake breakup, or
  numerical instability to repair. The stroke-aware sample is the informative
  weaker comparator because no sampled rollout is a semantic failure.
- The course-preview policy pins the posterior joint at `-45 deg` for `23.38%`
  of samples from about `18.62T` onward. The evaluated stroke-aware allocator
  breaks that long pinning into recovery beats, retaining capture at
  `24.6180T` and `0.74872L` while cutting hard-stop occupancy to `12.60%` and
  the documented peak absolute body-frame force/yaw-moment class from
  `0.269/0.178/0.143` to `0.165/0.118/0.089`. It is a load improvement despite
  its small score loss (`-0.462756` versus `-0.460673`).
- That guard does not solve command feasibility: raw acceleration-envelope
  exposure remains `72.65%` versus `72.84%`, and joint-rate exposure remains
  `15.10%` versus `15.15%`. The assigned-parent phase-selective recovery log
  then records capture at only `0.749001L` (score `-0.462859`), while the
  inherited course-alignment handoff sibling captures at `0.749838L` (score
  `-0.464278`). Those two completed conditional handoffs retain semantics but
  consume more of the already narrow capture margin. They do not justify
  another phase threshold, alignment gate, or scalar relief change.

## Policy hypothesis

Materialize the evaluated stroke-aware allocator, then add one final
actuator-feasibility projection shared by both joints. Clamp each fully
allocated acceleration to the same owned `1800 deg/T^2` envelope already used
by the steering-priority allocator and enforced by the downstream actuator.
This leaves the course-preview geometry, stroke guard, propulsive carrier,
steering magnitudes, and all switching surfaces unchanged. Since downstream
dynamics already apply the same hard envelope, the candidate should retain the
evaluated stroke-aware trajectory, capture, `12.60%` hard-stop occupancy, and
reduced load class while changing raw acceleration-envelope exposure from
about `72.65%` to zero. The projection also makes the public policy output
physically realizable instead of relying on hidden downstream clipping.

Falsification: reject the mechanism if formal CFD loses capture, differs
materially from the stroke-aware approach/arrival, exceeds `12.60%` posterior
hard-stop occupancy, returns to the unguarded force/moment class, or reports
any raw acceleration beyond the owned envelope. Raw-command feasibility alone
does not establish lower joint-rate exposure or better hydrodynamic loading;
those must remain separate diagnostics.

## Bookshelf transfer

The shelf was consulted after inspecting the current metrics and both visual
views. Its bounded rhythmic-control and posterior reactive-thrust guardrails
support making the already selected carrier-plus-steering action feasible;
they do not supply the numerical envelope and are not being used for a scalar
gain edit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: combine rhythmic propulsion with bounded feedback modulation while respecting finite actuator authority
transferable_invariant: preserve the state-feedback traveling wave and steering allocation, but expose only a feasible final joint command so unavailable authority cannot masquerade as control effort
nontransferable_details: published gains, motor torque curves, dimensional cadence, full-body kinematics, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: project both final two-joint accelerations onto the owned symmetric actuator envelope after body-frame course feedback and proprioceptive stroke allocation have been combined
falsification: reject if capture or the stroke-aware trajectory/load class changes, posterior pinning exceeds the evaluated guard, or any returned acceleration remains outside the owned envelope

## Pre-evaluation checks

- The candidate differs functionally from the evaluated v28 stroke-aware
  policy only by applying the owned acceleration projection to its two final
  outputs. A deterministic `18,225`-state grid spanning distance, target side,
  bearing, body-frame velocity, both posterior stroke boundaries, and joint
  rate produced finite bounded actions exactly equal to downstream-clipped v28
  actions; `17,059` probes exercised the new projection.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The prescribed public-contract smoke
  state returns two finite accelerations, the reusable-guidance semantic check
  passes, and the solver editable-boundary audit passes.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three exact no-CFD checks were therefore
  run directly and all passed. No formal CFD was run.
