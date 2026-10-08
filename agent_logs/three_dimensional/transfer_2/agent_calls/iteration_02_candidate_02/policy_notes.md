# Multi-wake target-policy diagnosis

## Evidence read before the edit

- The assigned parent, `solver_a1d9e06dfe8a`, is a valid direct-uniform
  still-water rollout (`U_infinity=(0,0,0)`, no cylinders or prewarm). Both
  rows of its combined keyframe sheet were inspected: the top-down row shows
  a coherent alternating vortex train and the oblique Lambda2 row shows
  compact three-dimensional shedding that remains attached to a translating
  fish. The candidate should preserve that self-propelled carrier.
- The parent removed hard acceleration clipping: neither returned action
  reaches 99% of `1800 deg/T^2`, versus about 71%/78% of seed samples. It still
  reaches 99% of the joint-speed limit on about 16.5%/14.6% of samples, but
  remains finite and reaches `0.692 U`. Its failure is route control: distance
  only falls from `12.328L` to `8.752L`, its heading swings from `0.51` to
  `-0.65 rad`, and it exits the upper boundary at `14.911T`. The progress-loss
  redirect therefore changed the seed's route topology without preserving the
  useful close approach; it is not evidence for adding more redirect gain.
- The strongest finite comparison, `solver_dc5e319e8345`, retains the seed's
  coherent wake and improves minimum distance slightly (`4.660L` versus
  `4.780L`) but still passes below the target, recedes to `9.604L`, and exits
  through the lower boundary at `28.369T`. Its inherited note says it released
  only the geometry term after a correct-sign yaw response. The completed
  rollout shows that response release inside the old competing
  acceleration/curvature stack was not enough to change the failure class.
- The informative negative comparison, `solver_dc5bdf69e4ab`, replaced the
  steering stack with a polarity-selected line-of-sight mean tail curvature.
  It turns upward almost immediately, improves only to `12.206L`, and exits the
  upper boundary at `7.887T` despite a coherent wake. Thus a bend/yaw polarity
  inferred from one correlated trajectory is not a safe open-loop steering
  rule; mean curvature needs feedback from the observed turn response.
- Local-flow magnitudes are small relative to swimming speed in all sampled
  runs (parent maximum about `0.029U`, seed maximum about `0.026U`). With no
  cylinders, the evidence does not support adding a wake-phase or crossflow
  rejection branch.

## Policy hypothesis

Keep the parent's `0.80T`, 22-degree joint-state oscillator, posterior lag,
and soft action limit because they produce a coherent wake without evaluator
acceleration clipping. Replace its progress-loss redirect, derivative-heavy
route stack, direct acceleration steering, and half-cycle steering with one
response-shaped line-of-sight mean-curvature loop. Normalized body-frame
bearing and target-vector angle request a bounded desired yaw rate. The error
between that request and measured recent yaw drives the posterior mean tangent,
so a correct-sign response continuously releases curvature and an excessive or
wrong-sign response commands braking/reversal through the same physical
channel.

Expected evidence is retention of the parent's bounded coherent carrier,
initial down-left progress comparable to the seed, and a yaw reversal before
the seed's `4.7L` pass-by becomes a lower-boundary escape. Falsify the mechanism
if the fish repeats either the early upper exit of the parent/polarity probe,
the seed-like lower pass-and-recede topology, or if within-beat yaw feedback
destroys the alternating wake or causes persistent actuation saturation.

bookshelf_consulted: true
source_domain: Closed-loop robotic-fish CPG direction tracking and biological burst redirection.
source_mechanism: Target error initiates bounded mean curvature, then sensed heading response releases or reverses that curvature before delayed body and wake dynamics overshoot.
transferable_invariant: Preserve the propulsive rhythm while route-scale curvature is conditioned on both persistent target error and the observed turn response.
nontransferable_details: Published gains, dimensional cadence, species-specific body envelopes, exact burst timing, vortex phase, actuator dynamics, and task-specific routes.
policy_translation: Convert normalized body-frame line-of-sight error to a bounded desired yaw rate and drive posterior mean tangent from desired-minus-observed yaw rate within the two-joint state-feedback contract.
falsification: Reject the transfer if the coherent carrier is lost, acceleration or velocity saturation becomes persistent, or the rollout retains either sampled non-target-directed boundary-exit topology.

## Pre-evaluation checks

- A synthetic body-frame sign probe gives negative mean tail tangent when a
  positive line-of-sight error has no yaw response, near-zero/released
  curvature when negative yaw reaches the requested rate, positive braking
  curvature when that yaw is excessive, and stronger negative correction for
  wrong-sign positive yaw. This is an algebraic policy check, not CFD evidence.
- The material-guidance check, Julia policy contract, finite two-action check,
  parameter-schema guard, and solver boundary check pass. Formal CFD remains
  deferred to the evaluator after this worker exits.
