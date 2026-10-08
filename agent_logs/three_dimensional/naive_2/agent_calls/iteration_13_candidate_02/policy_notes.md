# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations report `uniform_direct`, zero background
  velocity, no cylinders, finite dynamics, and the same `left_domain`
  termination through the upper virtual boundary. This is self-propulsion in
  still water, not advection or a prewarm artifact.
- I inspected the combined top-down/oblique sheets for the strongest sampled
  closest approach (`solver_929554cd32fb`, minimum `4.530L`) and the best
  scalar-score failure (`solver_4482d3d05d9c`, minimum `5.126L`). Both show a
  coherent alternating mid-plane wake connected to compact three-dimensional
  tail structures from release through the late rollout. Neither shows loss
  of the carrier before the fish bends upward and misses the target corridor.
  The actuator-calibrated sample has a visibly stronger late redirect, but it
  still reaches the same upper boundary.
- Trajectory cross-checks put closest approach near `17.25T` in both samples.
  The calibrated sample is then moving at `0.725U`, versus `0.826U` for the
  distance-relief failure, and has lower peak force/moment (`0.0306L^2`,
  `0.0157L^3` versus `0.0345L^2`, `0.0178L^3`). Reconstructed residence with
  either joint above 95% of the acceleration envelope is `59.3%` versus
  `70.3%`. Thus the visible wake is productive but the direction-response
  loop, not propulsion generation, remains the missing capability.
- The assigned full-wave parent (`solver_04fb14eb6f13`) reaches `4.867L` and
  exits at `21.72T` while using raw yaw rate and bearing-response release.
  Sampled inherited results show that a simultaneous textbook cross-product
  and yaw-error sign change was worse (`6.850L`, earlier upper exit), whereas
  actuator-calibrated yaw response with the empirical course convention
  reached `2.299L` and delayed the same exit to `28.41T`. Its closure-gated
  descendants still did not capture, so this candidate isolates the response
  mechanism and retains the complete carrier.

## Candidate hypothesis

Preserve the anterior Van der Pol oscillator, posterior state-derived lag,
crossflow residual, small anterior course redistribution, and smooth action
bound. Remove the parent's bearing-response release and replace raw yaw-rate
addition with a bounded physical response servo: the existing body-frame
route request commands yaw opposite posterior mean curvature, and
`actual_yaw - requested_yaw` corrects that curvature. This is one structural
mechanism change; it does not add a distance schedule, stroke attenuation, or
scalar-only gain search.

Expected result: retain the coherent full-wave wake and the parent's force
scale while reproducing the inherited deeper approach and delaying or changing
the upper-exit topology. Falsify the mechanism if minimum distance is not
better than `4.867L`, if upper exit is not delayed beyond `21.72T`, if the
carrier visibly breaks, or if force, moment, joint-rate, or near-limit action
residence materially exceed the parent.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and fish turning by bounded gait asymmetry
source_mechanism: sensor feedback modulates a mean-curvature steering channel while a rhythmic carrier continues to propel
transferable_invariant: keep propulsion and steering separated, map normalized body-frame route error to bounded curvature, and close the loop on measured turning response
nontransferable_details: published gains, oscillator frequencies, species-specific envelopes, exact tail phases, and source-task paths
policy_translation: keep the two-joint state-feedback traveling wave; drive posterior mean curvature from body-frame bearing and speed-qualified course error, then compare a bounded requested physical yaw with normalized recent yaw using the empirically observed opposite curvature-to-yaw polarity
falsification: reject if the prior coherent wake or approach is lost, loads or saturation rise materially, or the fish repeats the same upper-exit route without a deeper approach or delayed exit
