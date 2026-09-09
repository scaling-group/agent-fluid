# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned examples and both inherited contrast rollouts use direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. The assigned set contains four captures. Its
  strongest scalar example, `solver_649d7e789a5a`, is one of two
  executable-identical half-cycle redistribution policies; it captures at
  `18.8265T`, has mean distance `2.08855L`, and scores `-0.20041`. Its repeat
  captures at `18.8815T` with mean distance `2.08896L`. The prefilled
  rearward-route multiplier also captures, but inherited reconstruction shows
  its normalized forward target fraction never becomes negative, so the
  added branch is dormant and establishes no recovery mechanism.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the strongest assigned capture, the inherited unbudgeted compound
  failure, and the inherited curvature-budgeted recovery. The strongest
  capture develops an alternating body-attached street from quiescent water,
  bends that street toward the target, and retains compact alternating caudal
  Lambda2 structures through first crossing. Its translation is
  self-propelled, not advection. The compound failure retains an equally
  energetic street and compact caudal structures but bends away after the
  target becomes broadside; it reaches only `1.90495L`, then exits left at
  `31.1905T` and `9.45478L`. Wake coherence therefore does not establish route
  correctness.
- The inherited failure combines two individually capture-compatible
  mechanisms: half-cycle envelope redistribution and a forward-qualified
  additive broadside curvature reserve. Its reconstructed combined normalized
  request reaches about `1.196` near `1.995L`; acceleration contact remains
  `64.24%/70.96%`, and lower rate contact is not useful because capture is
  lost. The later curvature-budgeted reserve recovers capture at `19.0135T`
  but has mean distance `2.09973L` and score `-0.21170`, worse than the two
  clean redistribution captures. Thus budgeting repairs the catastrophic
  composition boundary but supplies neither a new success class nor an
  integral improvement.
- The strongest capture still has high actuation demand (about
  `60.85%/73.27%` anterior/posterior acceleration contact and
  `11.07%/14.93%` rate contact). Prior pointwise rate barriers, posterior-only
  allocation changes, instantaneous velocity residuals, distance release,
  and redirect compounds either lost capture or failed to improve the route.
  The current evidence therefore supports a controlled replication of the
  simplest low-integral mechanism, not another uncalibrated feedback stack.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological traveling-wave turning
source_mechanism: observed beat-side allocation adds bounded turn asymmetry while retaining the posterior-lagged propulsive wave
transferable_invariant: target-owned mean curvature may be redistributed across observed displacement half-cycles without a clock, while both joints retain their coupled traveling-wave roles
nontransferable_details: published gains, species-specific kinematics, dimensional cadence, prescribed duty ratio, exact vortex phase, full-body envelopes, and task-specific routes
policy_translation: retain the sampled displacement-only half-cycle steering and common-envelope redistribution on the established two-joint carrier; remove the unexercised rearward route branch and add no second gait modifier
falsification: reject a robustness claim if the exact executable candidate loses capture, repeats the inherited near-miss-to-left-exit topology, loses either coherent wake row, or leaves the sampled 2.08855--2.08896L mean-distance band without a semantic benefit
```

The shelf was consulted because the inherited sequence has three completed
iterations without a new semantic improvement. No additional primitive is
adopted: the available phase-lag, wake-residual, and approach mechanisms lack
supporting signal calibration here, and stacking another modifier contradicts
the completed interaction failure.

## Single-candidate policy hypothesis

Produce exactly one controlled-replication candidate: use the executable
half-cycle envelope-redistribution policy from the two strongest sampled
captures and delete the dormant rearward-route multiplier from the prefill.
Target lateral geometry still owns turn sign and common mean amplitude relief;
observed anterior displacement redistributes steering and relief between beat
halves; one-sided recent-yaw response can release but never invert the request;
posterior lag, damping, the established `4/10 deg` curvature shares, and the
exact final acceleration projection remain unchanged.

This is an architecture simplification and robustness test, not scalar-only
gain tuning. It introduces no new gain, time, step count, world coordinate,
target identity, route memory, flow residual, posterior-only allocation, or
terminal compound. Formal CFD occurs only after this worker exits. Credit the
candidate only if another direct-uniform evaluation retains capture and both
wake views; do not infer that the dormant-branch removal caused scalar changes.
