# Phase-consistent posterior-work candidate

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, current sampled solver policies, scores,
  observations, compact metrics, diagnostics, trajectories, combined keyframe
  sheets, and inherited optimizer notes. All four sampled episodes use direct
  uniform still water with `U_infinity=(0,0,0)`, no prewarm or cylinders,
  remain stable, and terminate by capture at `17.7870--18.0125T`.
- In both the top-down vorticity and oblique Lambda2 rows, every fish moves by
  self-propulsion from rest, establishes a coherent alternating traveling wake,
  and retains compact three-dimensional posterior structures through capture.
  No sheet shows passive advection, wake breakup, collision, or out-of-plane
  instability. Route and distance histories, rather than gross wake existence,
  discriminate the candidates.
- The assigned closure-qualified posterior-work parent captures at `17.8695T`
  with score/mean distance `-0.072146/1.958037L`, center path `13.0071L`,
  maximum head cross-track `0.6102L`, and mean approach/final course alignment
  `0.7875/-0.0027`. It reaches the acceleration ceiling for `69.74/65.31%`
  of samples and the 96%-rate region for `14.87/5.66%`; extra posterior work
  is therefore a distance-positive carrier-establishment mechanism, not an
  established desaturation or terminal-alignment mechanism.
- The sampled one-sided phase-consistency guard is the score leader. It
  preserves the coherent two-view wake and capture, improves score to
  `-0.064599` and mean distance to `1.950823L`, and ends with positive course
  alignment `0.0678` and lower yaw magnitude `1.089 rad/T`. The boundary is
  equally important: it delays capture to `18.0125T`, lengthens path/cross-track
  to `13.2330L/0.7417L`, and leaves acceleration-ceiling residence at
  `69.47/66.05%`. Thus it validates selective withdrawal of contradictory
  posterior work for integrated closure, but not route straightening or load
  relief.
- The consensus-qualified wave-target reserve is the useful balanced negative
  control: it captures at `17.7870T` on a shorter `12.9495L` path with
  `0.5193L` cross-track and `0.8366` mean approach alignment, but its score and
  mean distance (`-0.073937/1.959602L`) do not beat the assigned parent. The
  energy-only wave reserve is weaker on both score and route. The sampled
  evidence therefore does not support stacking a new terminal steering,
  cadence, or scalar-amplitude intervention onto the validated phase guard.

## One policy hypothesis

Promote the completed score-leading phase-consistent posterior-work policy as
one candidate. Preserve the assigned parent's anterior phase-plane oscillator,
lagged posterior target, odd mean-curvature and half-cycle steering, qualified
far/middle route observer, approach handoff, cadence schedule, closure/carrier
reserve gates, and reversal-preserving rate governor. Add only the evaluated
one-sided work guard: normalize `(tail_target - phi2) * phi_dot2` by the
posterior angle/rate envelope, retain posterior velocity-aligned work while
motion reduces current tracking error, and withdraw it smoothly while motion
increases that error. This is state-dependent energy allocation rather than
gain tuning, and uses no clock, coordinates, mutable state, target identity,
or memorized route.

Expected evidence is deterministic reproduction of stable capture, a coherent
posteriorly lagged wake in both views, and score/mean distance near the sampled
`-0.0646/1.9508L`. Falsify the mechanism if rerun evidence loses capture or
the early/integrated distance benefit, worsens the already long route or load
class materially, violates reflected body-frame behavior, or disrupts either
wake view. Do not interpret a rerun as evidence that the guard independently
improves route directness, arrival, or desaturation.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: reinforce posterior oscillatory work while preserving the commanded traveling-wave relation and keeping mean steering separate
transferable_invariant: extra posterior work should not amplify measured motion that carries the joint away from its current lagged wave and steering target
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, target coordinates, and task-specific routes
policy_translation: multiply only the existing closure-qualified posterior velocity-work reserve by a bounded one-sided guard from normalized posterior tracking-error power
falsification: reject if capture or integrated distance regresses, if route/load deterioration becomes material, if reflection behavior fails, or if the coherent top-down or oblique wake deteriorates
