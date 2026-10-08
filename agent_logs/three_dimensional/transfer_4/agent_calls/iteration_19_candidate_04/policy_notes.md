# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver rollouts and both completed assigned-parent rollouts
  satisfy the direct-uniform still-water contract: `U_infinity=[0,0,0]`, no
  cylinders or prewarm, stable dynamics, and capture termination. The two
  sampled instances of the score-leading phase-consistent work policy are
  deterministic at score/mean distance `-0.064599/1.950823L` and capture at
  `18.0125T`.
- I inspected the combined keyframe sheets for the score leader, the sampled
  consensus-qualified amplitude reserve, the unguarded work-reserve comparator,
  and the assigned-parent wave-referenced failure. In every top-down row the
  fish self-propels from still water and establishes a coherent alternating wake
  by `4T`; the oblique Lambda2 row retains compact paired posterior structures
  through capture. No collision, domain exit, wake breakup, or numerical
  instability is visible. The near-identical wake class agrees with the
  diagnostics, so the controller difference should target route/work coupling,
  not cadence, amplitude, or carrier formation.
- The sampled score leader's combined-target phase guard improves the unguarded
  work reserve from score/mean distance `-0.072146/1.958037L` to
  `-0.064599/1.950823L` while preserving first-`3T` distance/speed at
  `12.214593L/0.2519U` and the `0.0391/0.0195` peak force/moment class. Its
  remaining defect is route quality: path/cross-track widen to
  `13.2330L/0.7417L`, near alignment falls to `0.664`, and capture slips to
  `18.0125T`.
- The assigned-parent logs provide the missing evaluation of the previously
  proposed wave-target-only position-error guard. Two completed variants have
  identical dynamics at score/mean distance `-0.080637/1.966422L` and
  `17.8585T` capture. They do straighten the route to `12.9783L` path,
  `0.5621L` maximum head cross-track, and `0.810` near alignment, but first-`3T`
  distance/speed regress to `12.218702L/0.2469U`. The two-view wake and peak
  load class remain coherent/unchanged. Thus excluding mean curvature from a
  position-error reference buys route alignment by suppressing useful early
  posterior work; it is not an acceptable separation mechanism.
- The assigned prefill's consensus-qualified posterior amplitude reserve is
  also inferior: it captures at `17.7870T` with score/mean distance
  `-0.073937/1.959602L` and first-`3T` speed `0.2459U`. Its straighter
  `12.9495L/0.5193L` route does not justify replacing the velocity-aligned work
  pump with amplitude scaling or target-projected translation qualification.
- A replay of the score leader's logged joint states changes no evaluated
  dynamics and is used only to compare guard signals. With the existing
  normalized opposition scale, the failed wave-position-error guard retains
  about `83%` of carrier-energy-gated pump magnitude, while testing whether
  posterior velocity points toward the current lagged wave side retains about
  `99%`. This supports a small veto of clear phase opposition rather than
  another broad withdrawal of startup work; it is not a new CFD result.

## One policy hypothesis

Start from the deterministic score leader and preserve its state-feedback
carrier, posterior lag/amplitude, closure and energy qualifiers, bounded
velocity-aligned work pump, target-derived mean curvature, half-cycle steering,
approach controller, and reversal-preserving actuator governor. Replace only
the phase-consistency reference. Instead of multiplying posterior velocity by
a position error that contains either the mean steering bend or a statically
biased raw posterior angle, test whether measured posterior velocity points
toward the current side requested by the lagged oscillatory wave. Admit reserve
work through phase-consistent half-cycles and withdraw it only when wave side
and velocity oppose. This is normalized joint-state feedback with no clock,
world coordinate, target identity, stored route, or vortex phase.

Expected evidence is retention of capture, coherent two-view wake, the score
leader's early closure and mean-distance class, with less steering-correlated
work and therefore a shorter/narrower route or better near alignment. Reject
the mechanism if capture is lost; first-`3T` distance/speed regress toward
`12.218702L/0.2469U`; mean distance regresses toward `1.966422L`; path,
cross-track, and near alignment fail to improve from
`13.2330L/0.7417L/0.664`; actuator/load class rises; reflection symmetry
fails; or either wake row loses coherence. This candidate has no CFD result yet.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: reinforce a posterior-lagged traveling wave while steering through a separate bounded mean-curvature path
transferable_invariant: phasic energy injection should agree with the observed oscillatory wave direction and should not be qualified by a static steering offset
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body phase patterns, exact vortex phases, and task-specific routes
policy_translation: form the lagged posterior wave side from normalized anterior joint angle/rate, then gate bounded posterior work by its agreement with measured posterior joint velocity without using posterior angle or mean steering bias in the guard
falsification: reject if early closure or mean-distance benefit is lost, route or approach metrics do not compensate, actuator/load class worsens, reflection equivariance fails, or either wake view deteriorates
