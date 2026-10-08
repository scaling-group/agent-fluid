# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the common held release above four mature,
  interacting cylinder streets. Released differences therefore come from the
  controllers rather than wake initialization.
- All four sampled policies actively self-propel along a continuous diagonal
  down-left route and reach the `0.75L` circle. Their body-generated traveling
  wakes and roughly `-11L/-4.6L` head displacements rule out passive advection
  as the main transport mechanism. The current closure-efficiency child is the
  strongest finite sample: it reaches at `45.48`, has `1.724L` mean distance
  and score `0.1564`, and carries `405/4029` force/moment RMS. The aligned-only
  parent reaches at `46.80` with `1.745L` mean distance and `441/4259` loads;
  signed-closing and progress-deficit variants reach at `46.66` and `46.31`
  with `1.731L` and `1.736L` mean distance. Thus positive closing speed
  normalized by observed body speed is the best sampled posterior-envelope
  gate, not merely another scalar realization of the same result.
- The informative inherited failure is the propulsive-priority allocator. Its
  keyframes show the fish cross below the capture circle and collide with the
  lower second-row cylinder at `58.93`; the `1.87L` closest approach,
  `4.29L` mean distance, and `537/4995` force/moment RMS confirm that changing
  the successful sum-then-limit steering composition is unsafe even when mean
  effort falls slightly.
- The current keyframes retain the successful route and enter the interacting
  wake without a late miss, but both joint rates still touch the `4.538`
  hard cap and accelerations approach the candidate's `29` soft limit. A
  larger posterior envelope would therefore confound thrust with added
  saturation. The remaining compact test is wave timing at approximately
  fixed target amplitude, not another amplitude or steering-gain sweep.

## Candidate hypothesis

Preserve the complete current controller: zero-centered anterior oscillator,
predicted body-frame bearing, yaw-moment-magnitude steering gate, distributed
half-cycle residual, positive closure-efficiency posterior envelope, and
sum-then-soft-limit composition. Add one bounded phase-shaping mechanism to
the posterior target. When predicted bearing is aligned and windowed closing
speed is positive relative to body-speed magnitude, increase the existing
posterior quadrature coefficient slightly. Normalize the two-component
anterior-state vector by the ratio of its old and new ideal sinusoidal norms,
so the test primarily rotates posterior wave timing rather than increasing its
amplitude. With no alignment or closure, the exact inherited lag is recovered.

The next CFD rollout falsifies the mechanism if it loses `target_reached`,
returns the inherited below-target collision or either boundary exit, fails to
beat the `45.48` arrival or `1.724L` mean-distance reference, or raises joint
limit contact and hydrodynamic load without compensating closure. A positive
same-snapshot result would support only this normalized phase-shaping
translation, not robustness to changed wake phase, inflow, or geometry.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior wave timing contributes reactive thrust while bounded sensory feedback modulates rhythmic wave shape
transferable_invariant: after a stable traveling wave and route controller exist, change posterior phase from normalized performance feedback while preserving the propulsive rhythm and separating phase from amplitude
nontransferable_details: published phase offsets and gains, dimensional frequencies, species-specific envelopes, robotic linkage geometry, exact vortex phases, and task-specific routes
policy_translation: use predicted-bearing alignment times positive windowed-closing-speed over body-speed magnitude to shift the existing two-joint posterior quadrature coefficient, with analytic sinusoidal norm compensation and the inherited envelope and steering law unchanged
falsification: reject if capture, arrival, mean distance, or useful diagonal topology regresses, or if rate saturation and loads rise without compensating target closure
