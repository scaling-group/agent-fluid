# Steering-priority posterior-work candidate

## Evidence and visual diagnosis before editing

- I read the assigned guidance, all four sampled policies, scores,
  observations, compact metrics, diagnostics, trajectories, and inherited
  optimizer notes. Every sampled rollout satisfies the frozen contract:
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, stable planar dynamics, and `capture` termination. There is no
  literal termination failure in this sample, so the less direct route and
  weak terminal course states are the informative negative controls.
- I inspected both rows of the combined keyframe sheets for the best-scoring
  posterior-work rollout, the assigned closure-qualified prefill, and the
  anterior-energy-only reserve. All three fish move by self-propulsion from
  rest, form a coherent alternating top-down wake, and retain compact oblique
  posterior Lambda2 structures through capture. No sheet shows passive
  advection, wake breakup, collision, or out-of-plane instability. The visual
  evidence supports preserving the established traveling carrier; trajectory
  and joint/load evidence must discriminate the reserve mechanisms.
- The assigned closure-qualified wave-amplitude reserve captures at
  `17.6935T`, score/mean distance `-0.075561/1.960960L`, on a `12.8750L`
  center path with `0.4571L` maximum head cross-track. Its mean approach and
  final course alignments are `0.881/0.637`, and final yaw rate is only
  `-0.046 rad/T`.
- The sampled velocity-aligned posterior-work reserve is the strongest finite
  result by score and mean distance (`-0.072146/1.958037L`) and preserves the
  energy-only reserve's first-`3T` distance/speed benefit
  (`12.214522L/0.2519U`). Its extra work does not change the lagged posterior
  target or mean steering curvature, and both wake views remain coherent.
  However, its route is longer and wider than the assigned prefill
  (`13.0071L` path and `0.6102L` cross-track), approach alignment falls to
  `0.787`, and it crosses almost tangentially (`-0.003` alignment,
  `-3.068 rad/T` yaw) at `17.8695T`. This is evidence for retaining the work
  primitive while separating recovery work from active steering demand.
- Reconstructing the public controller on the sampled work trajectory shows
  that meaningful reserve work is confined to approximately the first
  `2.18T`, but its work-weighted normalized steering load is about `0.31`
  and reaches `0.55`. A parameter-free smooth complement of that already
  normalized load would retain roughly seventy percent of the sampled work
  proxy while withdrawing the extra contribution during the largest route
  corrections. This is a structural authority allocation; it does not lower
  the base carrier, its posterior lag/emphasis, or steering authority.

## One policy hypothesis

Start from the sampled closure-qualified velocity-aligned posterior-work
controller because it has the best completed mean-distance result. Preserve
its anterior phase-plane oscillator, posterior traveling-wave target, odd
mean-curvature and half-cycle steering, error-qualified far/middle observer,
ordinary approach controller, cadence schedule, and reversal-preserving rate
governor. Multiply only the extra posterior-work authority by the complement
of a smooth normalized absolute turn load. At negligible turn demand, the
score-positive recovery work is unchanged; as steering demand grows, the
recovery channel yields continuously while the base traveling carrier and
both steering actuators retain full authority. This uses existing normalized
body-frame guidance and joint state, with no clock, route memory, coordinates,
target identity, or new scalar tuning.

Expected evidence is retention of a material fraction of the posterior-work
rollout's early distance/speed and mean-distance gains, with center path,
cross-track, approach/final alignment, capture time, and terminal yaw moving
toward the assigned closure-qualified controller. Falsify the mechanism if
early closure returns to the no-reserve class, mean distance or arrival
regresses, the longer/wider route remains, actuation or force/moment class
worsens, the new gate introduces a directional asymmetry beyond the inherited
controller, or either visual wake row loses its coherent traveling structure.

bookshelf_consulted: true
source_domain: biological burst-redirect transitions and sensor-modulated robotic-fish oscillators
source_mechanism: redirecting curvature and posterior propulsion are coordinated as distinct control roles, with burst authority released continuously from observed state rather than elapsed time
transferable_invariant: allocate bounded recovery energy without competing with a simultaneous body-frame steering request, while preserving the established traveling carrier and full steering authority
nontransferable_details: published gains, dimensional cadence, species-specific burst kinematics, exact vortex phases, full-body envelopes, target coordinates, and prescribed routes
policy_translation: multiply only the closure-qualified velocity-aligned posterior-work reserve by one minus a smooth normalized absolute turn load; leave base posterior tracking, odd steering, cadence, and approach feedback unchanged
falsification: reject if early distance and mean-score gains disappear, route or terminal course state does not improve, actuator/load class worsens, the gate introduces new sign asymmetry, or top-down/oblique wake coherence degrades
