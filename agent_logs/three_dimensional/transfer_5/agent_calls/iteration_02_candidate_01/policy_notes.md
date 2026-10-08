# Multi-wake target-policy candidate notes

## Pre-edit evidence diagnosis

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders. Their visible translation is therefore self-propulsion, not
  imposed advection.
- The transferred seed (`solver_24bf67867ea8`) has useful propulsion but loses
  course control. Both visual rows show an organized alternating wake while
  distance falls from `12.3277L` to `4.7800L` at `17.85T`; it then keeps moving
  below the target and exits the lower boundary at `27.49T`, `9.7089L` away.
  Its raw acceleration exceeds the physical limit in `97.9%` of samples and a
  joint-rate limit is active in `18.5%`, so another additive steering residual
  is not an independently available actuator.
- The inherited response-gated full-posture redirect
  (`solver_7ddfece27e92`) is a concrete negative result. The top-down and
  oblique sheets show the early alternating wake fading as the fish settles
  into a sustained bend; mean speed is only `0.229L/T`, action tends toward
  zero, minimum distance is `11.8621L`, and it exits the upper boundary at
  `9.01T`. A separately bounded response-gated allocator
  (`solver_f578f8771e8a`) has the same semantic failure: mean speed
  `0.191L/T`, minimum distance `12.1727L`, upper exit at `7.99T`, and joint
  angle contact in `77.4%` of samples. Response gating and limit enforcement
  do not rescue a redirect that suppresses the traveling-wave carrier.
- The geometry-gated C-bend (`solver_d594e3893325`) is the only sampled
  positive result. Its top-down row retains a coherent reverse-Karman-like
  alternating street through the broad turn, and the oblique Lambda2 row
  confirms a bounded three-dimensional vortex chain through arrival. It
  captures at `25.388T` with `0.74947L` final distance and `2.5572L` mean
  distance. Unlike the failed full-posture redirects, it shifts the anterior
  oscillator equilibrium and tail-tangent target while leaving the oscillator
  active; neither joint reaches the angle limit. Raw command clipping remains
  frequent (`83.1%`) and one joint reaches the rate cap in `15.8%` of samples,
  so this rollout supports the architecture and semantic success, not a claim
  of efficient or universally robust actuation.

## Candidate hypothesis

Replace the failed inherited full-posture blend with the evaluated successful
geometry-gated C-bend architecture. Large normalized body-frame bearing or
target-vector angle will continuously shift the anterior oscillator center and
posterior tail tangent toward compatible curvature, with partial amplitude and
lag relief; alignment releases directly to the unchanged propulsive carrier.
This is one redirect mechanism, not scalar-only tuning. The candidate should
recover the sampled capture topology while preserving a coherent wake outside
the redirect. Falsify the transfer if evaluation loses capture, restores an
upper/lower boundary exit, collapses the alternating wake, creates joint-angle
contact, or materially worsens acceleration/rate saturation without a better
route or arrival.

bookshelf_consulted: true
source_domain: biological C-start turning and robotic-fish mean-curvature steering
source_mechanism: large observed direction error invokes bounded body curvature and continuously releases into the propulsive rhythm as alignment returns
transferable_invariant: posture-level turn authority should reshape but not replace the posteriorly lagged traveling-wave carrier
nontransferable_details: species-specific bend envelopes, published gains and frequencies, exact vortex phases, full-body kinematics, and prescribed maneuver timing or routes
policy_translation: gate an anterior oscillator-center shift and compatible posterior tail-tangent bias with normalized body-frame bearing and target-vector angle, while retaining joint-state phase and bounded continuous release
falsification: reject if capture is lost, the wake becomes a static-bend transient, joint-angle contact appears, or the same boundary-exit topology returns without improved distance and load histories
