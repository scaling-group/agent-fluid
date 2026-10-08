# Response-energy-aligned intercept-posture handoff

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 evidence
  contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and capture. There is no failed termination in this sample, so
  the active but lower-quality response allocations are the informative
  mechanism failures rather than a failure-class trajectory.
- The assigned prefill is `v41_response_opposed_intercept_posture`. Relative
  to the reproduced `v40_intercept_supported_terminal_posture`, its extra
  posture share when either joint moves away from the damped bend preserves
  the common `4/3/2 L` crossings but delays the `1 L` crossing from
  `19.162004 T` to `19.189503 T` and capture from `19.684490 T` to
  `19.722988 T`. Score, mean distance, and final distance regress from
  `-0.261384287`, `2.151092787 L`, and `0.748302400 L` to
  `-0.261856310`, `2.151574012 L`, and `0.748641372 L`.
- The inherited parent logs add the completed causal inverse:
  `v42_response_permissive_intercept_posture` retains up to four percentage
  points more carrier during the same outward joint response. It recovers a
  little score and arrival time relative to `v41` but remains worse than
  `v40`, capturing at `19.711988 T` with score `-0.261822240`, mean distance
  `2.151500419 L`, and final distance `0.748728991 L`. It also lengthens the
  path to `12.984927 L` versus `12.951133 L` for `v40` and raises below-`4 L`
  high-command counts to `231/304` from `229/302`. Thus outward response is
  not a useful direction selector for either more posture or more rhythm.
- Three sampled evaluations behaviorally reproduce the `v40` result: two are
  byte-identical policies and the signed course/yaw allocation candidate is
  trajectory-identical because its added branch is dormant. Together they
  reproduce capture at `19.684490 T`, score `-0.261384287`, and no joint-stop
  dwell. This makes the flat `12%` closure- and center-intercept-supported
  posture share the evidence-backed baseline, not either response variant.
- I inspected the complete combined keyframe sheets for the strongest `v40`
  rollout, the assigned `v41` regression, and the inherited `v42` regression,
  including every top-down mid-plane-vorticity and oblique body/Lambda2 view
  from release through capture. Each fish visibly self-propels from quiescent
  water along the same compact target-directed arc, sheds a coherent
  alternating posterior wake, and retains finite localized three-dimensional
  structures. None shows passive advection, a loop, collision, boundary-exit
  precursor, wake collapse, instability, or out-of-plane motion. The sheets'
  close agreement, identical outer crossings, and numerical differences only
  after `2 L` localize the unresolved question to terminal actuator handoff,
  not propulsion, route selection, or wake-disturbance rejection.
- The terminal load tradeoff is not a reason to prefer either regression.
  `v41` slightly lowers high-command and rate-contact counts but raises the
  late lateral-force maximum to about `0.02772`; `v42` lowers lateral-force
  and yaw-moment maxima to about `0.02727/0.01563` but arrives later on a
  longer path. The best `v40` remains finite at about `0.02753/0.01567`, has
  no joint stops, and reaches capture sooner. Lower command or load magnitude
  alone is not evidence of better allocation.

## Policy hypothesis

Start from the reproduced `v40_intercept_supported_terminal_posture`,
preserving its state-feedback traveling bend, geometry/course-agreed outer
allocator, center-course intercept corridor, closure preview, damped
two-joint mean-bend target, carrier floor, coupled limiting, and command cap.
Replace the assigned prefill's outward-response increment with one
response-aligned handoff: take the joint-space inner product of the measured
two-joint velocity and error from the already computed posture target,
normalize that signed approach rate by the declared oscillator amplitude
squared times its state-dependent frequency, and smoothly add at most four
percentage points to the existing intercept posture share only while the
coupled squared posture-error energy is decreasing.

The joint-space inner product keeps the increment coordinated: it is exactly
zero when the net two-joint response is stationary or moving away from the
posture, zero outside the actual `4 L` band, zero without positive closure and
a valid center intercept, and combined with stronger large-angle redirect by
`max` rather than addition. This tests continuous rhythm-to-posture transfer
in a response regime not exercised by the two completed outward-motion
variants; it does not infer beat/vortex phase, split joint roles, alter mean
curvature, restore cadence, cancel force, or memorize a route. Expect
unchanged outer motion and wake family with less conflict during already
convergent bend formation, preserving or advancing capture. Falsify the
mechanism if it is dormant or effectively constant, changes a state at or
beyond `4 L`, acts without closure/intercept support or while total posture
error is nondecreasing, overrides a stronger redirect, delays or loses
capture, worsens the distance integral, adds stop dwell or material loads,
causes instability, or degrades either wake view. The new CFD evaluation
occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction tracking and continuous biological redirect-to-cruise or terminal approach-hold transitions
source_mechanism: use measured oscillator response to hand off continuously from rhythmic propulsion to a bounded low-frequency posture
transferable_invariant: when rhythm and posture share actuators, increase posture allocation only when the observed coupled joint response is reducing total error to that posture, while preserving the established rhythm-to-posture balance during opposed response
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: inside the existing normalized body-frame proximity-, positive-closure-, and center-intercept-supported branch, use the joint-space inner product of measured velocity and unchanged posture error as a smooth normalized gate for one bounded coupled handoff increment
falsification: reject on dormancy or constant activation, action outside the supported terminal regime or while total posture error is nondecreasing, slower or lost capture, worse distance integral, stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Pre-implementation selectivity refinement

- A first non-CFD replay used the stricter minimum of two per-joint
  convergence supports. Although the raw support varied on `403` stored
  `v40` states, stronger redirect and the existing gates left only `12`
  changed commands, all between `1.615` and `2.222 L`, with maximum difference
  about `0.393 rad/T^2`. Given the inherited `80`-state carrier rescue's
  negligible coupled effect, this strict veto risks another effectively
  dormant candidate and was rejected before finalizing the policy.
- The selected coupled inner product is proportional to the negative
  derivative of total squared posture error. On the same completed trace it
  provides varying support and can affect `93` states between about `1.601`
  and `3.627 L`, without widening any geometry, proximity, closure, or
  authority gate. This is an architecture/selectivity change, not evidence of
  improved CFD behavior.

## Non-CFD implementation audit

- Loading evaluated `v40` and the final candidate in separate Julia modules
  and replaying reconstructed body-frame states from the completed
  `v40`, assigned `v41`, dormant course/yaw, and inherited `v42` trajectories
  changes `93/93/93/95` stored states respectively. On `v40`, all changes are
  confined to approximately `1.601--3.627 L`; every changed state has positive
  closure, nonzero center-intercept support, and a positive joint-space
  posture-error/velocity inner product. The maximum equal-state two-joint
  command difference is about `1.166 rad/T^2`. Raw response support spans
  approximately `1.1e-8--1.0` on active states rather than acting as a
  constant switch.
- A deterministic `216000`-state grid spanning target range and body-frame
  angle, center-course angle and speed, closure, both joint positions, and
  both joint rates finds `7176` active differences from evaluated `v40`, with
  maximum difference about `1.443 rad/T^2`. Every output is finite and within
  the declared command limit. No state at or beyond `4 L`, without positive
  closure or intercept support, or with nonpositive coupled posture-error
  decrease changes. These checks establish boundedness, activity, and gate
  selectivity only; they do not establish coupled-flow improvement.
- The prescribed lightweight Julia contract passes and returns exactly two
  finite accelerations. The deterministic schema audit resolves all `90`
  direct `params.FIELD` references in the `91`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
  The mandated check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before executing a command. Its material-guidance, exact Julia
  policy-contract, and solver-boundary commands were therefore run directly
  and separately, and all pass. The candidate SHA-256 is
  `2488236270fea5307a4275f1d59167609413488b4086f0a9798987df97bdb1a0`.
  No formal CFD was run in this workspace.
