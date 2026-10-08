# Candidate wake-policy notes

## Evidence diagnosis before editing

- All four sampled rollouts are finite captures from valid direct-uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm. Three v37 samples are bit-identical at `23.83702T`, score
  `-0.53501328`, and final distance `0.746096L`; the only distinct sampled
  comparator is the slightly weaker v33 capture at `23.84252T`, score
  `-0.53509095`, and final distance `0.746165L`. Because the workspace contains
  no crash, exit, or near-miss rollout, v33 is the most informative weaker
  finite comparison rather than an invented failure class.
- I inspected both rows of the combined v37 and v33 keyframe sheets from
  release through capture. The top-down vorticity views show motion from rest
  under self-actuation, the same smooth target-directed arc, and a spatially
  ordered alternating wake. The oblique body/Lambda2 views show compact
  three-dimensional structures persisting through the terminal bend. Neither
  policy is passively advected, loses its wake, collides, exits, or becomes
  unstable. Their difference is below sheet resolution, so trajectory and
  actuator histories decide the next mechanism.
- The inherited completed comparisons reject more phase anticipation,
  anterior half-cycle energy redistribution, and local-crossflow arbitration.
  Each retained capture but regressed progress, final distance, or peak moment
  relative to v37; the last worker therefore restored v37 exactly. Those
  negative results argue against another steering, phase, or hydrodynamic-proxy
  branch while the replicated carrier remains successful.
- A separate feasibility defect survives in the sampled v37 trajectory. Joint
  1 is recorded at the `260 deg/T` speed cap for `11.58%` of all rows and joint
  2 for `4.59%`; inside `3L` the exposures are `10.32%` and `8.15%`. Every
  cap row has a same-sign acceleration command that attempts to drive farther
  out of the velocity envelope. The current component-wise acceleration
  projection limits commands to about `31.26/31.39 rad/T^2`, but it cannot
  remove this state-dependent discarded effort.

## Single candidate hypothesis

Retain v37's target-course/phase observer split, response-released C-bend,
posterior traveling wave, cadence, terminal correction, and smooth acceleration
projection exactly. Add one final component-wise velocity-envelope guard. It
reads each joint's normalized speed relative to a policy-owned velocity limit,
turns on only near that limit, smoothly removes only acceleration pointing
farther outward, and leaves inward acceleration unchanged. This is a distinct
state-feedback feasibility layer: it does not tune the carrier, steering gain,
route, phase, or morphology.

The guard should remove commands that the hard joint-speed constraint would
discard, reduce velocity-cap exposure or command waste, and preserve the
evaluated target path and alternating wake. Falsify it if CFD loses or delays
capture, regresses v37-scale score/mean/final distance, changes wake coherence,
fails to reduce speed-cap exposure, increases yaw or moment, or creates a new
angle/acceleration-limit symptom. Lower command effort alone is insufficient
if target progress or the carrier degrades.

bookshelf_consulted: true
source_domain: state-feedback robotic-fish oscillators under bounded actuation
source_mechanism: preserve the traveling-wave carrier while applying sensor feedback only at the actuator-envelope boundary
transferable_invariant: use observed joint phase and normalized joint speed to remove only outward effort that cannot contribute once a velocity boundary is active, while retaining inward phase recovery
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, exact vortex phases, dimensional actuator values, and task-specific routes
policy_translation: after the established smooth acceleration projection, apply a continuous per-joint guard based on absolute joint speed divided by a policy-owned limit; attenuate only commands with the same sign as joint velocity and leave the two-joint carrier and body-frame target feedback unchanged
falsification: reject if replicated still-water CFD loses v37-scale capture/progress or wake coherence, does not reduce velocity-cap exposure, or worsens yaw, moment, joint-angle, or acceleration feasibility

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
  I ran its prescribed checks directly. The guidance-materiality check passes
  after removing the duplicated assigned-parent marker from the rendered
  workspace `README.md`, and the solver-boundary check passes.
- No Julia executable is installed, so the lightweight Julia contract smoke
  command cannot start. A deterministic static audit finds `71` unique direct
  `params.FIELD` references among `73` returned fields with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit clock/step input, random source, file I/O, cylinder state,
  mutable global state, or memorized route.
- Applying the final guard algebra to the completed v37 trajectory affects
  only outward near-cap commands: `12.60%` of anterior rows and `5.21%` of
  posterior rows. It removes all `502/199` outward commands recorded exactly
  at the respective speed cap while leaving inward commands unchanged. This is
  an offline contract check, not a new CFD result; the future rollout must
  establish whether cap exposure falls without changing propulsion or capture.
- Exactly one nonempty `candidate_target_policy.jl` exists. Its SHA-256 is
  `0f83669f3836f6e3e546c4382d578f6b97e711d9b527bd670e3ca7d58f50ffd6`.
  No formal CFD was run.
