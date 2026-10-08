# Mean-preserving yaw-demodulation candidate

## Visual and metric diagnosis before the edit

- The assigned parent and all four sampled solvers report direct-uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. I inspected both rows of the combined sheets for the assigned
  capture (`solver_28465671dc6c`), the best finite sampled capture
  (`solver_5ef271950e5a`), and the inherited carrier-recruitment failure
  (`solver_7a764cc19afc`). The two captures show self-propelled targetward
  motion, an alternating top-down vortex street, and tail-connected oblique
  Lambda2 structures through termination. The failure retains an organized
  three-dimensional wake but bends past the target and exits the lower virtual
  boundary, so gross propulsion and wake coherence do not distinguish success.
- The assigned raw-mean demodulator captures at `0.747714L` and `16.637493T`,
  with observed distance integral `1.380093L`, peak planar force/moment
  `0.036873/0.018564`, maximum joint magnitudes `0.550013/0.560251 rad`, and
  at least one speed/acceleration within the stated near-limit bands for
  `27.504%/74.050%` of logged steps. This is the proven route carrier and must
  not be replaced wholesale.
- The best sampled policy changes no scalar and reconstructs carrier yaw from
  `q1_carrier = q1 - head_course_center` rather than raw `q1`. It repeats
  capture at `0.747896L` and arrives one logged step earlier at `16.631994T`.
  Its observed distance integral falls to `1.378485L`; peak planar
  force/moment fall to `0.036777/0.018272`; maximum joints fall to
  `0.547719/0.555689 rad`; and near-limit speed/acceleration residence falls to
  `27.282%/73.942%`. The differences are small, but all preserve or improve
  the relevant boundary while the visual route and wake class stay intact.
- The inherited state-triggered negative-damping child is the informative
  failure: despite its coherent alternating wake and lower whole-episode
  near-limit residence, it misses at `3.490652L`, recedes to `10.765473L`,
  and exits at `28.231514T`; posterior excursion rises to `0.739916 rad`.
  Therefore faster state-based carrier recruitment is not a safe way to
  improve arrival for this route-sensitive controller.

## Single policy hypothesis

Promote the completed best-sample policy as this workspace's sole candidate.
Preserve the full-amplitude state-feedback oscillator, posterior traveling-wave
lag, body-frame bearing/course/crossflow route, bounded anterior course center,
actuator-calibrated yaw convention, and phase-selective tail relief. Make only
the demonstrated semantic change: estimate fast carrier-correlated yaw from
the mean-removed anterior coordinate `q1_carrier`, so the slow course center
remains in the measured directional response rather than being cancelled by
the demodulator.

This is an evidence-backed promotion of a completed sampled solver, not a claim
about the unevaluated child. Expect capture near the inherited `16.63T` route
with the alternating connected wake intact. Falsify reuse if capture fails,
the compensated residual remains correlated with carrier phase, the route or
wake topology changes materially, or joint contact, near-limit residence,
force, or moment exceeds the raw-mean capture envelope. Do not combine this
test with startup recruitment or scalar tuning.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and phase-compatible turning asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while slow directional feedback acts through a distinct bounded steering channel
transferable_invariant: remove only the mean-free joint-state-correlated carrier response so the slow body-frame route response remains observable to feedback
nontransferable_details: published gains, dimensional beat frequency, robot or species kinematics, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: form the existing normalized anterior oscillator coordinate by subtracting its bounded course center, reconstruct carrier yaw from that coordinate and joint velocity, and feed only the residual to the established two-joint posterior response tracker
falsification: reject if fixed-case capture does not repeat, residual carrier correlation persists, targetward route or connected wake degrades, or saturation, joint contact, force, or moment worsens materially

## Evaluation boundary

The post-worker CFD run should compare capture and arrival first, then observed
distance integral, target-relative trajectory, carrier correlation of the yaw
residual, joint contact and near-limit residence, peak planar force/moment, and
both wake views against the assigned `solver_28465671dc6c` capture and the
completed `solver_5ef271950e5a` implementation being promoted.
