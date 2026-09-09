# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release while four developed cylinder wakes interact around the target. It
  is shared initial-condition evidence, not evidence for a candidate-specific
  vortex-phase rule.
- All four sampled released sheets end in `target_reached`; no sampled failure
  keyframe is available. The prefilled and strongest sheets have the same
  useful topology: a coherent body-generated traveling wake, self-propelled
  diagonal motion down and upstream, and one broad correction through the
  merged wakes into the capture circle. Mean body velocity x near `-0.241`
  versus mean local-flow x from `-0.174` to `-0.180` confirms that this is not
  passive downstream advection. The inherited propulsive-priority collision
  remains the nonvisual failure boundary: it passed below capture and collided
  at `58.93` after a `1.872L` closest approach with `537/4995` force/moment
  RMS, so the base wave and broad propulsion allocation must remain intact.
- The prefilled course-consistency policy reaches at `45.612`, with `1.7222L`
  mean distance, score `0.158830`, and `453/4406` force/moment RMS. Gating only
  positive course amplification by yaw load reaches at `45.105`, improves mean
  distance to `1.7191L`, and lowers loads to `416/4183`. Requiring both yaw
  headroom and oscillator-normalized joint-rate headroom is the strongest
  sampled policy: `45.260`, `1.7153L`, score `0.165009`, and `439/4342` loads.
  Replacing yaw headroom with a distance gate does not combine those benefits:
  it returns to `45.611`, `1.7208L`, and raises loads to `475/4653`. All four
  still touch the `4.538` rad/time joint-rate cap. This supports carrying the
  best positive-only yaw/rate allocator forward and keeping terminal logic out
  of its posterior propulsion residual.

## Policy hypothesis

Start from the strongest sampled allocator and change only how the existing
route channel predicts heading response near capture. The fixed six-unit
heading look-ahead is appropriate while the target is far away, but once
normalized distance divided by observed body speed is shorter, projecting yaw
for the full horizon can predict past the target. Cap the response horizon by
that state-estimated time-to-target before applying the existing response
limit. This is continuous body-frame state feedback, is neutral over the far
transit, and does not alter the traveling wave, posterior lag, closure-earned
residual, yaw/rate gates, or soft limiter.

The candidate is falsified if it loses first-crossing capture, regresses the
sampled `1.7153L` mean-distance trajectory without a material load benefit,
arrives later than the `45.612` prefill, or recreates the inherited below-target
collision family. A success on this one prewarmed snapshot would still not
establish robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: biological response-gated redirect and closed-loop robotic-fish path following
source_mechanism: release a large redirect into ordinary rhythmic tracking as observed geometry and heading response enter the terminal approach
transferable_invariant: preserve the established propulsive rhythm and bound route-response prediction by the remaining target geometry rather than projecting the current turn beyond the target
nontransferable_details: published gains, species-specific burst kinematics, robot linkage geometry, dimensional speeds, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: cap the heading-response look-ahead by normalized target distance divided by normalized observed body speed, then feed the resulting predicted body-frame bearing into the existing yaw-gated two-joint half-cycle steering law
falsification: reject if target capture or diagonal topology is lost, mean distance or arrival regresses without lower load, or the terminal correction increases joint-limit contact or hydrodynamic loads without a shorter useful route
