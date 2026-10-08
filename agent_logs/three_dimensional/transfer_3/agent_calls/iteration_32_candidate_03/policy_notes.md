# Coupled response-energy terminal handoff candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase-2 initialization contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and `capture` termination. There is
  no failed termination class in this sample, so the active but lower-quality
  assigned prefill is the informative mechanism failure.
- I inspected the complete combined keyframe sheets for the strongest finite
  `v40_intercept_supported_terminal_posture` rollout and the assigned
  `v42_response_permissive_intercept_posture` regression, including both the
  top-down mid-plane-vorticity row and the oblique body/Lambda2 row from
  release through capture. In both views the fish visibly self-propels from
  quiescent water along the same compact upper-side target arc. It sheds a
  coherent alternating posterior wake in the top-down view and retains finite,
  localized three-dimensional structures in the oblique view. Neither rollout
  shows passive advection, a loop, collision, boundary-exit precursor, wake
  collapse, out-of-plane motion, or instability. Their nearly indistinguishable
  sheets and identical `4/3/2 L` crossing times localize the difference to the
  terminal actuator handoff rather than propulsion, route selection, or wake
  rejection.
- Three sampled candidates produce byte-identical trajectories and keyframe
  sheets: two copies of `v40` and `v41_course_worsening_terminal_response`,
  whose signed course/yaw allocation branch is dormant. They capture at
  `19.684490 T`, score `-0.261384287`, and have mean/final distance
  `2.151092787/0.748302400 L`. The reproduced baseline path is
  `12.951133 L`, with below-`4 L` high-command counts `229/302`, rate-contact
  counts `39/57`, no joint-stop dwell, and finite lateral-force/yaw-moment
  maxima about `0.027533/0.015673`.
- The assigned `v42` prefill reverses an earlier failed posture increment by
  retaining up to four percentage points more carrier whenever either joint
  moves away from the supported terminal posture. That branch is active but
  still regresses: capture is delayed to `19.711988 T`, score to
  `-0.261822240`, mean/final distance to `2.151500419/0.748728991 L`, and the
  path lengthens to `12.984927 L`; terminal high-command counts rise to
  `231/304`. Its slightly lower force/moment maxima do not offset the slower,
  longer approach. Together with the inherited `v41` result, outward joint
  response is rejected as a selector for either more posture or more carrier.
- The assigned-parent notes identify the remaining disjoint response regime:
  total two-joint error to the already validated posture is decreasing. Their
  non-CFD replay found a coupled error/velocity inner-product gate varying on
  `93` stored `v40` states between about `1.601` and `3.627 L`, while a strict
  per-joint conjunction changed only `12` commands. This establishes useful
  selectivity, not CFD improvement, and motivates transferring the coupled
  form rather than another hard logical conjunction.

## Policy hypothesis

Start from the triply reproduced `v40` policy, preserving its state-feedback
traveling bend, geometry/course-agreed outer allocator, center-course
intercept corridor, closure preview, damped two-joint mean-bend target,
carrier floor, coupled limiter, and command cap. Add at most four percentage
points to the existing intercept-supported posture share only when the
joint-space inner product of posture error and measured joint velocity is
positive. Normalizing by the declared oscillator amplitude squared times its
state-dependent frequency makes this a dimensionless response gate
proportional to decreasing total squared posture error.

The increment remains behind the existing actual-distance, positive-closure,
and center-intercept gates and combines with stronger large-angle redirect by
`max`; it neither changes mean curvature nor assigns a separate role to one
joint. Expect identical outer motion and wake family with less rhythm/posture
conflict during already convergent bend formation, preserving or advancing
capture. Falsify on dormancy or effectively constant activation, any equal-
state action at or beyond `4 L`, action without closure/intercept support or
while coupled posture error is nondecreasing, changed outer trajectory,
delayed or lost capture, worse distance integral, joint-stop dwell, material
load growth, instability, or degradation of either wake view. Formal CFD will
run only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction tracking and continuous biological redirect-to-cruise or terminal approach-hold transitions
source_mechanism: use measured oscillator response to hand off continuously from rhythmic propulsion to a bounded low-frequency posture
transferable_invariant: when rhythm and posture share actuators, increase posture allocation only while the observed coupled joint response is reducing total error to that posture
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: within the existing normalized body-frame proximity-, positive-closure-, and center-intercept-supported branch, use the joint-space inner product of measured joint velocity and unchanged posture error as a smooth normalized gate for one bounded coupled handoff increment
falsification: reject on dormancy or constant activation, action outside the supported terminal regime or while coupled posture error is nondecreasing, slower or lost capture, worse distance integral, stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The finalized policy is byte-identical to the assigned parent's previously
  audited response-energy candidate (SHA-256
  `2488236270fea5307a4275f1d59167609413488b4086f0a9798987df97bdb1a0`),
  transferring that bounded mechanism without adding a second candidate or a
  same-regime controller. This identity does not constitute CFD evidence.
- A fresh deterministic `262440`-state grid comparison against evaluated
  `v40`, spanning distance, closure, target and course angles, speed, both
  joint positions, and both joint rates, finds `2424` active differences with
  maximum component change `1.443038 rad/T^2`. Every candidate output is
  finite and within the declared cap. Every changed state is below `4 L`, has
  positive closure and nonzero center-intercept support, and has a positive
  joint error/velocity inner product, so total coupled posture-error energy is
  decreasing. These checks establish activity, boundedness, and gate
  selectivity only.
- The lightweight Julia contract returns exactly two finite accelerations.
  The deterministic schema audit resolves all `90` direct `params.FIELD`
  references in the `91`-field parameter object; only the version label is
  intentionally unused. The solver-boundary check passes, and the guidance
  checker confirms a material reusable change from the assigned parent.
- The prescribed check-runner was invoked after both required files changed,
  but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account
  and failed before executing a command. Its three exact non-CFD commands were
  therefore run directly and separately and pass. No formal CFD was run in
  this workspace.
