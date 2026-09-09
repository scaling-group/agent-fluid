# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  execute the identical half-cycle envelope-redistribution controller and
  capture at `18.6505--18.8815T` with mean distance
  `2.08855--2.09222L`. The rearward-route multiplier captures at `18.9640T`
  and `2.09072L`, but its target stays forward, so its added branch supplies
  non-interference rather than recovery evidence. The current batch contains
  no semantic failure and cannot support scalar gain selection by score.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best-score clean redistribution capture and the faster prefill
  capture. Both begin in visibly quiescent water, self-propel with energetic
  alternating top-down streets that bend toward the target, and retain compact
  paired caudal Lambda2 structures through first crossing. Neither view shows
  advection, wake collapse, collision, domain exit, or instability. The
  current candidate therefore must preserve the traveling-bend carrier and
  cannot claim a wake-production deficit.
- Cross-checking all four traces shows structural demand but no sampled load
  outlier: anterior/posterior acceleration contact is about
  `60.85--61.17%`/`72.97--73.27%`, and peak planar moment is
  `0.01603--0.01663`. The assigned-parent inherited allocator result is the
  informative negative comparator absent from the sampled sheets: a `15%`
  steering-residual-priority/common-carrier projection lowered acceleration
  contact to `39.23%`/`57.05%` and kept an energetic two-view wake, yet reached
  only `2.43664L` and exited left at `29.7110T` and `9.22177L`. Lower clipping
  is therefore not useful when carrier/steering coordination changes the route.
- The surviving captures expose a different, repeatable observation defect.
  Removing a centered one-period trend from each trace gives rigid-heading
  residual versus anterior-joint-displacement slopes of
  `-0.6461-- -0.6483 rad/rad`, with correlations `-0.9523-- -0.9533`; the
  corresponding normalized body-lateral target residual has slopes
  `-0.6389-- -0.6479` and correlations `-0.9509-- -0.9522`. Thus the raw
  target-lateral route signal includes a strong beat-frequency body-axis
  oscillation rather than only persistent route error. In trace replay, a
  bounded partial displacement compensation reduces the route request's
  one-period residual RMS from `0.411--0.426` to `0.321--0.335`, while mean
  two-joint command change is only `0.657--0.674 rad/T^2` and the maximum is
  at most `5.166 rad/T^2`. This replay calibrates an ablation; it is not CFD
  evidence of improved closed-loop behavior.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric-flapping steering
source_mechanism: use observed oscillator state to separate the rhythmic body motion from the slower sensor-driven direction command while preserving a coordinated posterior-lagged traveling wave
transferable_invariant: a target-signed mean-turn request should represent persistent body-frame route error, while observed joint displacement should account for beat-synchronous body-axis motion instead of letting that fast motion repeatedly rewrite the route request
nontransferable_details: published gains, robot geometry, dimensional cadence, clock phase, species-specific kinematics, prescribed envelopes, exact vortex phases, and task-specific routes
policy_translation: preserve normalized body-target geometry, correcting-yaw release, displacement-only half-cycle allocation, differential curvature, posterior lag, and hard acceleration projection; rotate the normalized target vector through one small bounded offset inferred from centered anterior-joint displacement before computing the persistent lateral route request
falsification: reject if capture or either coherent wake row is lost, if the trajectory leaves the established 2.0886--2.0922L mean-distance band without a distinct robustness or demand benefit, if route oscillation or peak planar loads increase, or if another left-exit topology appears despite the compensated signal
```

## Single-candidate policy hypothesis

Add exactly one body-wave target-axis compensation to the evaluated
half-cycle redistribution carrier. A preliminary raw target request supplies
only the existing anterior mean-bias center. The anterior displacement about
that center then rotates the target vector by at most `7 deg`, with a partial
`0.25 rad/rad` compensation gain. The persistent route request is computed
from this compensated normalized body-frame vector. The raw lateral fraction
continues to schedule the already-evaluated common amplitude relief, isolating
the new mechanism to route sensing rather than silently changing propulsion.

This is a state-feedback observation translation, not scalar-only carrier
tuning. It adds no time, step count, world coordinate, target identity,
instantaneous velocity or flow residual, broadside/rearward recovery channel,
terminal stage, posterior-specific allocation, rate barrier, saturation
allocator, mutable state, or prescribed wake phase. Formal CFD occurs only
after this worker exits. Credit the mechanism only if capture and both wake
views survive and route/load behavior improves outside current repeat spread.
