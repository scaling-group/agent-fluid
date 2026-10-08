# Candidate diagnosis and hypothesis

## Evidence read before architecture

- All four sampled observations confirm direct uniform still-water initialization
  at `U_infinity=0`; there is no prewarm or imposed advection. The best sampled
  score is `-0.247735` with capture at `18.271T`, while the other three samples
  also capture at about `18.276T`. The assigned parent's inherited completed
  rollout instead exits the left domain after approaching only `5.621L`, so
  preservation of the sampled capture topology is the primary semantic guard.
- In the top-down rows, the capture family develops a regular alternating
  vorticity street by `4T`, maintains a visibly traveling posterior bend through
  the long target-directed transit, and reaches the capture circle without a
  pass-and-hook or coast. In the oblique rows, compact alternating Lambda2
  structures remain attached to a sinuous self-propelled track through `16T`
  and capture. The sheets are nearly indistinguishable across the four samples.
- The trajectory cross-check confirms self-propulsion: peak body speed is
  `1.329U` while peak local-flow speed is only `0.0315U`. The fixed-width brake
  sample touches `-45 deg` posterior angle and peaks at `0.17183` force and
  `0.07699` yaw moment; velocity-conditioned variants stay near `-43 deg` and
  reduce those peaks to `0.03716/0.01907` without losing capture.
- The in-policy hard-clamp sample and the otherwise identical downstream-clamp
  sample have the same trajectory, capture, extrema, and loads. Only the logged
  request changes from `59.87/88.41` to `31.42 rad/T^2`; applied near-limit
  occupancy remains about `51.3/46.4%`. Thus another clamp or scalar drive gain
  change is not an evidenced controller improvement.

## Single candidate

Preserve the successful wrapped body-frame velocity-course steering, terminal
posterior carrier/steering allocation, and global kinetic stopping-margin
projection. Add one carrier-specific mechanism: an odd, continuously
differentiable soft-knee projection on the zero-centered anterior oscillator
acceleration and lagged posterior carrier acceleration before steering is added.
Commands below the knee are unchanged; larger carrier demands approach a
bounded sub-limit ceiling. Target-course steering remains a separate residual,
and the later stopping projection retains access to the full physical envelope.
This should preserve carrier phase and the established route while preventing
the rhythmic component itself from spending half the rollout on an actuator
hard clip.

Expected evidence: retain capture and the alternating top-down/oblique wake;
keep posterior angle inside the existing approximately `-43 deg` clearance and
force/moment at or below `0.0372/0.0191`; materially reduce applied near-limit
occupancy from `51.3/46.4%`. Reject the transfer if capture becomes a near miss
or domain exit, the wake loses its traveling alternation, peak speed collapses,
the residual steering is clipped as often as before, or the safety/load bounds
regress.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and residual CPG path-following
source_mechanism: preserve a low-dimensional rhythmic carrier while applying bounded feedback residuals through a separate command channel
transferable_invariant: keep propulsion phase in joint state, bound the carrier before the actuator, and avoid erasing target feedback by conflating it with saturated rhythmic demand
nontransferable_details: published oscillator gains, clock phase, species-specific envelopes, dimensional frequencies, learned routes, and exact vortex timing
policy_translation: soft-knee only the state-feedback anterior and lagged-posterior carrier accelerations; retain normalized body-frame velocity-course steering as a separate residual and retain full-envelope kinetic stopping protection
falsification: reject if capture or alternating shedding is lost, applied near-limit occupancy is not materially reduced, posterior clearance drops below the sampled velocity-barrier family, or peak force and yaw moment exceed 0.0372 and 0.0191
