# Bearing-divergence recovery candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, finite dynamics, and semantic `capture`.  The assigned
  terminal-allocation parent captures at `18.754995 T`, score `-0.169802`,
  total distance integral `2.057785 L`, and observed integral `1.450366 L`.
  The strongest sampled bearing-divergence controller captures at
  `18.403006 T`, score `-0.140449`, total integral `2.027810 L`, and observed
  integral `1.418099 L`: an earlier arrival by `0.351990 T`, integral
  reductions of `0.029974/0.032267 L`, and a score gain of `0.029353`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the strongest rollout, the assigned parent, and the slowest sampled
  bidirectional-allocation comparator from release through capture.  Every
  fish is visibly self-propelled from quiescent water along the same smooth
  target-signed arc, with compact startup structures followed by a coherent
  alternating posterior wake in both views.  The winner is subtly farther
  along the useful arc at matched frames; none shows passive advection, wake
  collapse, collision, domain exit, numerical instability, or a prewarm
  artifact.  Thus the evidence favors route correction, not carrier changes.
- The controller-algebra replay over recorded states agrees with the visual
  diagnosis without constituting new CFD evidence.  Relative to the parent,
  bearing-divergence recovery leads in distance by about
  `0.061/0.149/0.242/0.252 L` at `4/8/12/16 T`.  Mean speed rises modestly
  from `0.6861` to `0.6961 L/T`, maximum speed falls from `0.9492` to
  `0.9476 L/T`, any-joint acceleration-limit residence changes from `41.94%`
  to `42.14%`, peak normalized force remains `0.03068`, and peak normalized
  yaw moment changes only from `0.01564` to `0.01587`.
- Inherited logs provide the negative boundary for stacking.  Full reverse
  transfer of posterior-rejected steering produces the slower `18.765995 T`
  capture; closing-response arbitration and terminal-only reverse allocation
  both reproduce `18.754995 T` rather than a new trajectory.  Earlier
  whole-wave route-rate rejection is much worse: it drives a coherent wake
  along the wrong-sign route and exits at `8.4755 T` with minimum distance
  `12.2107 L` and peak normalized force/moment `0.3025/0.1347`.  The candidate
  therefore keeps head-only rate rejection and one-way head-to-tail residual
  allocation, and does not combine weak scalar or allocation variants with
  the winning route mechanism.

## One-candidate policy hypothesis

Replace the assigned parent with the completed bearing-divergence controller.
Preserve its state-feedback traveling carrier, posterior lag, whole-wave pose
projection with deliberate means retained, head-only route-rate correction,
raw half-cycle detector, closing-response cadence release, approach schedule,
carrier-first projection, and head-to-tail rejected-steering allocation.  Its
single distinguishing mechanism adds bounded target-signed curvature only
while the de-gaited body-frame bearing is outside the centerline band and its
windowed trend is moving farther from zero; geometric contraction releases
the term and normalized approach distance attenuates it near capture.

This is an evidence-backed promotion rather than a speculative combination.
Expect capture near `18.403 T`, the lower distance integral, and the same
coherent wake and speed/action/load envelope.  Falsify transfer if a repeated
rollout loses capture, materially trails the parent's middle/late closure,
reverses the target-signed arc, disrupts the alternating wake, or materially
exceeds approximately `0.948 L/T`, `42.14%`, `0.03068`, and `0.01587` for
maximum speed, any-joint limit residence, peak normalized force, and moment.

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control
source_mechanism: retain a bounded corrective bend while observed target geometry is worsening and release it when geometric response contracts the error
transferable_invariant: persistent body-frame line-of-sight divergence may gate extra target-signed curvature independently of the traveling carrier, with release determined by measured geometric response rather than elapsed time or exact beat phase
nontransferable_details: published gains, species-specific C-start kinematics, full-body envelopes, clocked CPG phase, dimensional cadence, exact vortex phases, linkage geometry, and prescribed routes
policy_translation: preserve the sampled two-joint posterior-lag carrier and add a bounded mean-turn contribution only for out-of-band de-gaited bearing whose normalized windowed trend has the same sign, attenuating it continuously on approach
falsification: reject if capture or middle/late closure regresses, the target-signed coherent wake changes, or speed, saturation, normalized force, or yaw moment materially exceeds the sampled envelope

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  The materialized candidate receives formal CFD
only after this worker exits; no same-worker evaluation claim is made.
