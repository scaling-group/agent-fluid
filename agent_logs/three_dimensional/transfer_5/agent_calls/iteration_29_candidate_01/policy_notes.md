# Candidate wake-policy notes

## Evidence diagnosis before editing

- All four sampled solver rollouts and all completed inherited children report
  direct uniform initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, finite dynamics, and capture termination. The sampled set
  therefore has no semantic crash/exit failure. The informative failure is the
  assigned parent's evaluated terminal half-cycle energy-transfer regression,
  compared with the repeated split-observer baseline.
- I inspected the combined sheets from release through termination for the
  repeated best split observer and the assigned-parent regression, including
  both the top-down mid-plane-vorticity row and the oblique body/Lambda2 row.
  Both fish self-propel from rest, establish a coherent alternating wake by the
  middle frames, follow the same smooth target-directed arc, and retain compact
  three-dimensional vortical structures through capture. Neither sheet shows
  passive advection, wake breakup, collision, boundary exit, or instability.
  The visible topology is effectively unchanged, so score, trajectory, load,
  joint, and command histories decide the comparison.
- The repeated split-observer baseline captures at `23.83702T`, score
  `-0.53501328`, scoring mean/final distance `2.433468/0.746096L`, and inside-
  `3L` mean/peak absolute yaw `1.67938/3.19386 rad/T`. Its inside-`3L`
  mean/peak absolute moment is `0.006388/0.013581`, and target-cross-track speed
  is `0.23868/0.56914U` mean/peak.
- The assigned parent's `20%` amplitude-squared transfer between observed
  anterior half-cycles still captures, but one step later at `23.84252T`; score,
  scoring mean distance, and final distance regress to
  `-0.53806167`, `2.435897L`, and `0.749247L`. It lowers inside-`3L` mean/peak
  absolute yaw to `1.67356/3.18388 rad/T`, yet cross-track speed worsens to
  `0.23992/0.57685U` and peak moment rises to `0.013726`. Together with the
  separately inherited envelope-transfer (`-0.536347`) and local-crossflow-gate
  (`-0.536241`) regressions, this rejects another terminal phase, envelope, or
  wake-cue gate as the next intervention: lower yaw alone is not improved
  target control.
- A distinct command-feasibility defect survives both the baseline and parent.
  Across the baseline's `4334` samples, the anterior/posterior rates are at
  least `99%` of the `260 deg/T` cap for `619/246` samples; `83.7%/85.0%` of
  those samples still carry an acceleration command in the same direction as
  the saturated rate. The assigned-parent counts are essentially identical
  (`619/245`, with `83.7%/84.9%` outward). Inside `3L`, the baseline remains
  near the speed cap for `13.15%/9.98%` of samples and near the acceleration cap
  for `17.47%/38.94%`. The coherent wake says not to replace the carrier, but
  the outward commands at the hard rate boundary are locally infeasible and
  motivate a command-space constraint mechanism rather than another gain tune.

## Single candidate hypothesis

Restore and retain the evaluated split-observer policy exactly through raw
head/tail command construction: target-course response, distributed
phase classification, anterior phase-selected correction, response-released
C-bend, posterior lag and amplitude, cadence, and the existing component-wise
smooth acceleration projection all remain unchanged. Add one final two-joint
rate-feasibility layer. For each joint independently, normalize the observed
joint rate by the parameter-owned physical rate limit; only within a narrow
buffer below that limit, smoothly attenuate projected acceleration whose sign
would increase the already-large rate. Acceleration that brakes or reverses a
joint passes unchanged, and all commands below the buffer are exactly the
split baseline.

The tangent-cone projection should remove futile outward acceleration during
hard-limit dwell without changing the requested route or suppressing the
traveling wave away from the boundary. Falsify it if CFD loses or delays
capture, regresses split-baseline scoring mean/final distance, changes the
coherent alternating wake, fails to reduce outward near-cap command exposure,
raises yaw/moment loads, or merely trades speed saturation for angle or
acceleration saturation.

bookshelf_consulted: true
source_domain: actuator-constrained robotic-fish CPG and state-feedback rhythmic locomotion
source_mechanism: preserve a low-dimensional traveling-wave carrier while enforcing physical actuation feasibility at the command boundary
transferable_invariant: retain the propulsive phase and target-feedback structure, but project only locally infeasible outward action away from a normalized state constraint while preserving inward recovery action
nontransferable_details: published controller gains, motor models, dimensional cadence, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: normalize each body-intrinsic joint rate by the parameter-owned velocity limit and smoothly attenuate only same-sign acceleration near that limit after the existing component-wise acceleration projection; preserve braking, the posterior wave, and all body-frame target feedback
falsification: reject if capture/progress or wake coherence regresses, outward near-cap command exposure does not fall, yaw or moment worsens, or another actuator limit receives the displaced burden

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account and failed before inspecting the workspace. Its
  guidance-materiality command passes, as does its solver boundary command.
- Julia is not installed, so the configured runtime smoke command cannot start.
  The deterministic static schema audit finds `71` unique direct
  `params.FIELD` references among `73` returned fields with no undeclared
  reference; only `version` and `control_period` are metadata. Exactly one
  nonempty `candidate_target_policy.jl` exists in `solver/`.
- A direct algebraic audit of the smooth rate guard passes: outward commands
  retain full baseline authority below the `0.98` normalized buffer, receive a
  `0.5` multiplier at `0.99`, and reach zero at the rate boundary, while the
  source predicate leaves every inward/braking command unchanged. Applying
  only this final projection to the baseline's logged rate/command pairs changes
  `546/226` anterior/posterior outward samples (of which `502/199` are at the
  exact rate boundary), reduces their whole-rollout absolute-command sums to
  `92.68%/96.65%` of baseline, and changes zero inward samples. This establishes
  activation and selectivity, not a predicted hydrodynamic outcome. The policy
  has no explicit time/step input, random source, file I/O, cylinder state,
  mutable global state, or memorized route. No formal CFD was run.
