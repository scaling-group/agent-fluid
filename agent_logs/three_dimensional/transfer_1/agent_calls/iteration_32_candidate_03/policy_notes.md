# Candidate diagnosis and hypothesis

## Evidence read before selecting the candidate

- All four sampled runs satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable CFD,
  and capture at `0.7466--0.7494L` after `18.20--18.75T`. The two exact
  speed-reserve samples use policy SHA-256
  `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`.
- I inspected every combined sheet from release through termination. In both
  rows the fish is self-propelled: top-down vorticity develops into a strong,
  regular alternating reverse street, while the oblique Lambda2 views retain
  compact bilateral shed structures through capture. The wake does not show
  terminal carrier collapse, passive advection, collision, or instability.
  The small terminal pose/phase differences among exact and modified policies
  therefore do not support changing the carrier, cadence, or posterior lag.
- Metrics and traces agree with the images. The exact speed-reserve samples
  capture at `0.74664L/18.3205T` and `0.74939L/18.6010T`, remain near
  `0.83--0.91L/T` on final approach, and repeatedly touch the action and joint-
  speed envelopes. The fixed anterior-transfer sample captures later at
  `18.7495T` without a distance, load, clipping, or speed-residence advantage;
  the posterior wave-shape sample captures here, but inherited evidence makes
  that mechanism only `2/3` and includes a coherent-wake `1.2589L` miss.
- The assigned parent's inherited notes proposed a stricter, conditional
  tail-to-head steering transfer only when posterior normalized speed/action
  pressure exceeded anterior pressure and the steering residual worsened
  posterior motion. Its completed evaluation is a stable lower-domain exit:
  score `-11.2989`, closest pass `1.5231L`, final distance `10.4210L`. That
  semantic regression falsifies the remaining conditional spatial-allocation
  hypothesis for this controller; the parent artifact contains no wake sheet,
  so no unsupported wake claim is made about that failure.
- Inherited guidance also records failures of cadence relief, terminal carrier
  attenuation, projected miss replacement, phase allocation, yaw damping,
  posterior phase shaping, mean-curvature tracking, and course observers.
  With the new parent result, none supplies evidence stronger than the raw
  achieved-course, intercept-guarded speed-reserve policy.

No sampled solver is a visual failure; the informative failure is the assigned
parent's completed conditional-transfer evaluation, interpreted only through
its score and termination evidence. The current candidate's later CFD result
is not claimed here.

## Policy hypothesis and selection

Select the exact prefilled speed-reserve policy, byte for byte, as the single
candidate. It preserves the repeat-backed achieved-course servo, response and
intercept gates, bounded additive steering, traveling-bend carrier, and sparse
outward-carrier reserve. This is a deliberate restoration after a semantic
failure, not a scalar gain change and not a claim that the baseline is fully
robust. Its mixed inherited record remains the falsification boundary.

Expected result: retain the sampled broad target acquisition, active two-view
wake, and capture-capable terminal branch without repeating the parent's
`1.5231L` allocation-induced miss. Reject the restoration as a durable default
if further exact evaluations materially reduce capture reliability or show a
new wake, load, or actuator failure; only then test a genuinely new observation
or primitive rather than another allocation or scalar variant.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posteriorly lagged traveling bends sustain reactive thrust while bounded target feedback acts as a steering residual
transferable_invariant: preserve a coherent traveling carrier when distance progress and both wake views show useful self-propulsion
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: retain the normalized body-frame achieved-course residual, two-joint lagged carrier, intercept guard, and state-conditioned outward-carrier reserve without adding another spatial allocator
falsification: reject if exact repeats lose capture reliability, change the lower-pass topology adversely, weaken either wake, or worsen clipping, speed residence, force, or moment beyond the sampled envelope
