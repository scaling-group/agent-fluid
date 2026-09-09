# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, no prewarm, and capture. The combined keyframes show
  self-propelled motion rather than advection: a compact alternating wake grows
  from the tail in both the top-down vorticity and oblique Lambda2 rows, remains
  coherent through the broad initial turn, and follows the fish to capture.
- The unguarded response-aware repeats `solver_bf9554cfba28` and
  `solver_a47435301f18` capture at `19.162/19.338T`, with distance integrals
  `2.06924/2.07622L`, paths `12.309/12.304L`, and peak planar-force/yaw-moment
  coefficients `0.02537/0.01356` and `0.02535/0.01335`. Their keyframes show a
  larger late hook immediately before capture.
- The joint-wise carrier guard `solver_a860be11e4d6` and shared carrier-energy
  governor `solver_f7169bba556d` both advance capture to `18.111T` and distance
  integral to `2.00209/1.99710L`; their keyframes show the same coherent wake
  class and a more direct approach. This gain is well outside the sampled
  unguarded repeat envelope, so governing carrier energy is a useful mechanism,
  not merely a scalar-score fluctuation.
- The two guarded implementations expose a tradeoff. The shared governor has
  the shorter path (`12.198L` versus `12.281L`) and better integral, but the
  joint-wise guard has lower mean commands (`18.46/17.13` versus
  `18.84/17.54 rad/T^2`), lower greater-than-90%-rate residence
  (`16.1/10.0%` versus `17.6/13.7%`), and slightly lower peaks
  (`0.02716/0.01414` versus `0.02729/0.01435`). Both peak loads remain above
  the unguarded class. The shared governor forms its trigger from signed total
  carrier power, so positive work at one joint can be cancelled by negative
  work at the other even while a rate is close to the envelope.
- Inherited optimizer logs contain only scalar summaries for the assigned
  parent and earlier candidates; sampled inherited guidance records that other
  rate-governor formulations have regressed. Thus the positive conclusion is
  specific to separating carrier from steering and retaining response-aware
  targeting, not to arbitrary rate suppression.

## Policy hypothesis

Keep the complete response-aware targeting scaffold and the exact
carrier/steering decomposition. Preserve one common scale for both carrier
commands, but compute its alignment from the sum of each joint's nonnegative
carrier work, rather than the positive part of their signed sum. Normalizing by
the declared action and rate scales keeps the signal dimensionless and bounded.
This should prevent cross-joint cancellation, recover some of the joint-wise
guard's command/rate/load reduction, and retain the shared governor's phase
relationship and short route. No terminal gate, steering residual, or gait gain
is added.

Falsification: reject the mechanism if evaluation loses capture or coherent
wake structure, delays the `10/8/6L` milestones beyond the unguarded repeat
envelope, exceeds the guarded `18.111T` timing/integral class without a material
actuator/load benefit, widens path beyond about `12.31L`, reduces joint margin,
or fails to lower outward rate-envelope work and posterior rate residence from
the shared-governor parent. A repeat is needed before attributing small changes
within the two guarded samples to this power aggregation alone.

bookshelf_consulted: true
source_domain: Taylor traveling-wave swimming and Lighthill elongated-body reactive propulsion
source_mechanism: coordinated anterior-to-posterior wave propagation preserves directed reactive thrust
transferable_invariant: regulate carrier energy without independently distorting the two-joint phase relationship or suppressing target-conditioned steering
nontransferable_details: published gains, dimensional frequencies, full-body envelopes, species kinematics, exact wake phase, and task routes
policy_translation: use normalized joint-rate proximity and the sum of nonnegative joint-wise carrier action-velocity products to apply one bounded common scale to both carrier accelerations
falsification: reject if the coherent traveling wake, early milestones, capture, short path, or joint margin regresses, or if rate residence and load do not improve relative to the shared signed-power governor
