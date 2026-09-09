# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled episodes satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm). The combined sheets show that the
  successful policy is self-propelled by a compact alternating top-down wake
  with localized oblique Lambda2 structures and a nearly direct targetward
  trajectory. Two executions of that exact policy captured at `15.98--15.99T`
  (`0.7500L` and `0.7472L`), while the simpler predictive-curvature variant
  also captured at `16.01T` (`0.7477L`). Their peak planar force/moment are
  only `0.034--0.037 / 0.017--0.019`, neither joint spends logged time beyond
  `40 deg`, and the carrier remains active despite roughly `26.5--26.8%`
  near-rate-limit occupancy.
- The assigned prefill instead relieves symmetric carrier drive continuously
  near/past the target. Its sheet shows a long curling trajectory and much
  larger, less compact shed structures before `left_domain` at `24.52T`.
  It missed by `2.703L`, ended `7.056L` away, reached both `-45 deg` joint
  stops, spent `36.3%` of samples beyond `40 deg`, and peaked at
  `0.713 / 0.300` planar force/moment. Thus the failure is not insufficient
  runtime: broad approach braking lets steering/static deformation dominate
  the traveling wave and creates a high-load wrong-side loop.
- The inherited logs corroborate the semantic boundary: older near misses
  reached `0.810--1.121L` but still exited left, whereas later sampled
  predictive-miss mechanisms produced captures. A capture and coherent load
  history outweigh longer survival or a quiet scalar-only change.

## Policy hypothesis

Replace the prefill's symmetric approach-hold mechanism with the sampled
response-gated predicted-miss architecture. Body-frame target and velocity
form a bounded pursuit/course request and a constant-course signed miss. That
request recruits mean curvature and a small posterior wave-shape pulse only
when closing geometry warrants it. Carrier-separated yaw response releases
the half-cycle steering share; the full traveling-bend carrier is never
broadly braked. This should recover the repeatedly observed capture topology
while avoiding the prefill's joint-stop lock and high-load loop.

bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and robotic-fish phase-lag control
source_mechanism: posterior emphasis and bounded target-conditioned wave-shape modulation
transferable_invariant: preserve a traveling bend while concentrating a small steering correction in the posterior joint during an observed active stroke
nontransferable_details: published gains, dimensional frequency, species envelope, exact vortex phase, full-body waveform, and task route
policy_translation: normalize stroke phase by `abs(phi_dot[1])/(omega*amplitude)`, gate a bounded posterior target pulse by body-frame predicted miss, closing alignment, and distance, and use carrier-separated yaw response to release the parallel half-cycle channel
falsification: reject if the formal rollout loses capture, repeats a boundary exit or looping topology, exceeds the sampled compact-wake load/joint envelope, or sacrifices targetward translation

The candidate's own CFD result is deliberately not claimed here; it will be
available only to a later worker.
