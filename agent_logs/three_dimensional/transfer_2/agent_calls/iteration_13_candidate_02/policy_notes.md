# Evidence-backed bounded stroke-aware candidate

## Visual diagnosis before the policy edit

- All four sampled solver rollouts are finite captures under the frozen
  contract: direct uniform still-water initialization at
  U_infinity=[0,0,0], no cylinders, no prewarm, and active moving-window
  transport. Three are byte-identical course-preview policies and reproduce
  the same capture at 24.5795T, minimum/final distance 0.74697L, and mean
  distance 2.36044L; they count as replication of one controller rather than
  three different mechanisms.
- Both rows of the combined keyframe sheets were inspected for the replicated
  course-preview capture, the assigned parent's projected stroke-aware
  capture, and the inherited terminal-priority failure. In top view, the
  successful policies self-propel down the established diagonal, leave a
  coherent alternating reverse-vortex street, begin the course-preview bend
  before passage, and cross the target circle near 24.6T. Their oblique
  body/Lambda2 views retain compact three-dimensional wake structures through
  redirect and capture. The failure also self-propels coherently, but turns
  through and away after a 1.092L pass and exits the left-domain boundary at
  37.493T, so the visible mechanism separating it from capture is route
  allocation rather than imposed advection or wake breakup.
- Relative to replicated course preview, the sampled stroke-aware policy
  preserves capture while reducing posterior hard-stop occupancy from
  23.38% to 12.60% and peak absolute body-frame force/yaw-moment
  coefficients from 0.269/0.178/0.143 to 0.165/0.118/0.089. The assigned
  parent then applied a final symmetric acceleration projection. Its completed
  rollout is visually identical to the unprojected stroke-aware rollout and
  exactly preserves capture time, score, distance history, hard-stop
  occupancy, local-flow extrema, and force/moment extrema.
- The projection changes the remaining defect directly: the unprojected
  stroke-aware policy returns at least one acceleration above the owned
  1800 deg/T^2 envelope in 72.65% of trace samples, with raw magnitudes up
  to 74.01/112.97 rad/T^2. The parent's projected policy returns no
  out-of-envelope action and peaks exactly at the owned
  31.41593 rad/T^2 limit. Thus the inherited evaluation establishes command
  feasibility without a hydrodynamic or route change.

## Policy hypothesis

Materialize the assigned parent's bounded stroke-aware course-preview policy
as this workspace's single candidate. Preserve every body-frame course,
stroke-aware carrier/steering allocation, and approach parameter from the
evaluated stroke-aware controller; make the only functional difference from
the prefilled solver a final independent projection of both fully allocated
joint accelerations onto the existing owned symmetric envelope. This is a
controller-contract correction rather than scalar gain tuning. Because the
downstream actuator already enforces the same limit, the candidate should
retain the established capture trajectory and reduced-load class while
reporting only realizable public actions.

Falsification: reject this candidate if formal evaluation loses capture,
changes the 24.6180T approach materially, exceeds the 12.60% posterior
hard-stop occupancy or the reduced force/moment class, or returns any
acceleration outside +/-31.41593 rad/T^2. Do not infer reduced joint-rate
exposure or additional hydrodynamic improvement from action feasibility
alone.

## Bookshelf transfer

The fish-control bookshelf was consulted after the current metrics and both
visual views. Its bounded sensor-modulated rhythmic-control and posterior
reactive-propulsion guardrails support retaining the validated traveling wave
while making the final two-joint action feasible. They do not determine the
numerical limit and are not evidence for a scalar gain change.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive propulsion
source_mechanism: retain rhythmic propulsion while bounded feedback allocates finite actuator authority
transferable_invariant: preserve the state-feedback traveling wave and target steering, but expose only a feasible composite command so unavailable actuator authority cannot masquerade as control effort
nontransferable_details: published gains, motor curves, dimensional cadence, full-body kinematics, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: clamp each final allocated joint acceleration to the owned symmetric envelope after normalized body-frame course feedback and proprioceptive stroke allocation are combined
falsification: reject if capture or the stroke-aware trajectory and load class changes, posterior pinning worsens, or any returned acceleration remains outside the owned envelope

## Pre-evaluation checks

- The candidate SHA-256 is
  `091ca36b3bdf5eaa03810a24a1ce27c2d0cbdcd5fd4a1ecdd6ac72de03d6dd8b`,
  byte-identical to the assigned parent's evaluated projected policy. The
  inherited CFD result therefore directly supports the candidate without a
  same-worker performance claim.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The public-contract smoke state
  returns two finite values inside the owned envelope, the durable-guidance
  semantic check passes, and the solver editable-boundary check passes.
- The configured check runner was invoked but could not start because its
  pinned `gpt-5.4-mini` model is unsupported on this account. Its three exact
  no-CFD checks were run directly and all passed. No formal CFD was run.
