# Carrier-demodulated crossflow candidate

## Visual and metric diagnosis before the edit

- All four sampled solvers satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and finite capture. Three are
  byte-identical copies of the assigned mean-preserving demodulator, capturing
  at `0.747896L` and `16.631994T`; the distinct raw-mean predecessor captures
  at `0.747714L` and `16.637493T`. The assigned parent guidance and inherited
  logs identify state-triggered carrier recruitment as the informative
  failure: it missed at `3.490652L`, receded to `10.765473L`, and left the
  virtual domain at `28.231514T`.
- I inspected both rows of the combined keyframe sheets for the assigned best
  capture, its raw-mean predecessor, and the inherited recruitment failure.
  The captures visibly self-propel toward and bend through the target while
  retaining an alternating top-down vortex street and tail-connected oblique
  Lambda2 structures. The failure also retains a coherent three-dimensional
  wake, but curves away after its approach and exits the domain. This confirms
  that route-response semantics, not advection or gross carrier coherence,
  distinguish the useful trajectory.
- The sampled trajectory exposes a second carrier-contaminated response cue.
  Across the two unique completed captures, least-squares fits of relative
  body-frame crossflow to the mean-free anterior coordinate and anterior joint
  rate explain `91.1--91.2%` of full-episode variance and `99.84%` inside
  `6L`. The fitted full-episode coefficients repeat closely: angle
  `+0.495--+0.497` and rate `+0.123`. Thus the raw crossflow term is mainly the
  fish's own beat-correlated lateral motion, even though the controller treats
  it as a directional slip residual.
- An algebra-only replay with a fixed `0.50*q1_carrier + 0.12*q1_dot`
  reconstruction reduces crossflow standard deviation from
  `0.4003/0.3998U` to `0.1198/0.1188U` over the two captures, and from
  `0.4915/0.4889U` to `0.0921/0.0898U` inside `6L`. It leaves the slow mean in
  the inherited failure nearly unchanged (`+0.0842U` raw, `+0.0830U`
  residual), rather than erasing persistent directional slip. These are
  observation-scale and separation checks, not counterfactual CFD results.

## Single policy hypothesis

Preserve the completed mean-preserving capture controller's full-amplitude
oscillator, posterior traveling-wave lag, body-frame bearing and
target-versus-velocity course geometry, bounded anterior course center,
actuator-calibrated yaw convention, yaw-phase demodulation, and opposing
half-cycle relief. Add one compact semantic mechanism before forming the
crossflow steering term: reconstruct beat-correlated relative crossflow from
the same mean-free anterior carrier angle and its rate, and feed only the
residual to the existing bounded crossflow channel.

This is a state-derived, reflection-equivariant separation of slow directional
slip from fast carrier motion, not scalar-only gain tuning. The expectation is
to retain nominal capture and the connected alternating wake while reducing
within-beat steering reversals and unnecessary posterior acceleration. Falsify
the mechanism if capture is lost, the target-crossing arc changes adversely,
the residual remains strongly carrier-correlated, persistent directional
crossflow is suppressed, or joint contact, near-limit residence, force, moment,
or wake topology worsens against the assigned capture.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and adaptive swimming under wake-induced lateral motion
source_mechanism: preserve a rhythmic propulsive carrier while separating fast carrier-synchronous lateral response from slow persistent route error before feedback modulation
transferable_invariant: feedback should act on a body-frame response residual after removing the repeatable joint-state-correlated carrier component, without cancelling a persistent directional offset
nontransferable_details: published gains, dimensional beat frequency, robot or species kinematics, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: reconstruct normalized relative crossflow from the mean-free anterior angle and anterior joint rate, subtract it, and pass the bounded residual through the existing two-joint posterior steering channel
falsification: reject if carrier correlation persists, fixed-case capture or the connected wake is lost, persistent slip is erased, or saturation, joint contact, force, or moment worsens materially

## Evaluation boundary

The later CFD evaluation should compare semantic capture and arrival first,
then distance integral and target-relative trajectory, carrier correlation of
raw and compensated crossflow, posterior command switching and near-limit
residence, joint contact, peak planar force/moment, and both wake views against
the assigned `16.631994T` mean-preserving capture. Changed-pose and changed-flow
robustness remain untested by the deterministic fixed-case replications.
