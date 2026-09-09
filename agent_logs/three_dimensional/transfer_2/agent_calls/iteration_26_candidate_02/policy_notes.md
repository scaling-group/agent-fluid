# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts are valid direct-uniform still-water releases:
  `direct_quiescent_init=true`, `initialization_mode=uniform_direct`, no prewarm,
  and `U_infinity=(0,0,0)`. All capture, so there is no semantic failure sample;
  the informative failure is instead failure to deliver the actuator-headroom
  purpose of the evaluated governors.
- In both the top-down vorticity and oblique Lambda2 rows, the unguarded assigned
  parent forms a coherent alternating self-propelled wake rather than drifting
  with a background flow. It nevertheless develops a broad late hook and
  captures at `19.162--19.338T`, distance integral `2.06924--2.07622L`, with
  `12.304--12.309L` head paths.
- The strongest sampled shared-carrier governor retains the coherent traveling
  wake and visibly straightens the final approach. Metrics agree: it reaches
  the `10/8/6/2L` milestones at `6.677/9.191/11.539/16.467T`, captures at
  `18.111T`, improves the distance integral to `1.99710L`, shortens the head
  path to `12.198L`, and reduces sub-`2L` mean absolute yaw rate to
  `0.0317 rad/T`. The independently guarded carrier also captures at `18.111T`
  but follows a longer `12.281L` path with `0.373 rad/T` sub-`2L` yaw.
- The shared governor is not yet an actuator protector. Relative to the
  unguarded repeat, anterior residence above 99% of the `260 deg/T` rate bound
  rises from `8.35%` to `10.45%`, while peak planar force/yaw moment rises from
  `0.02537/0.01356` to `0.02729/0.01435`. Its signed joint-power sum can cancel
  simultaneous outward work at one joint with inward work at the other, making
  the common gate weak exactly when either joint needs carrier withdrawal.

## Policy hypothesis

Start from the sampled phase-preserving carrier/steering decomposition because
its trajectory is the strongest finite evidence. Preserve one common scale for
the anterior/posterior carrier, but compute its alignment from the larger
positive normalized per-joint carrier power instead of their algebraic sum.
This should keep posterior phase and all target-conditioned residual steering
while preventing cross-joint cancellation. It is falsified if repeat CFD does
not reduce anterior and posterior near-bound rate residence/outward impulse, or
if the `18.111T`, `1.99710L`, `12.198L`, coherent-wake trajectory class regresses
toward the longer hooked approach or raises the sampled load class.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: Preserve a posterior-lag traveling bend while feedback modulates rhythmic carrier energy separately from target-conditioned steering.
transferable_invariant: Energy withdrawal should preserve the coupled inter-joint phase relationship and act only against observed outward rhythmic work.
nontransferable_details: Published gains, dimensional beat frequencies, species-specific amplitude envelopes, full-body waveforms, exact wake phase, and task routes.
policy_translation: Use normalized joint-rate proximity and the maximum positive per-joint carrier acceleration-times-rate to set one bounded shared carrier scale; retain the existing normalized body-frame target, course, distance, and two-joint steering residuals.
falsification: Reject if both-joint rate headroom and outward impulse do not improve, or if capture, early milestones, short path, terminal yaw, load class, joint margin, or either coherent wake view regresses.
