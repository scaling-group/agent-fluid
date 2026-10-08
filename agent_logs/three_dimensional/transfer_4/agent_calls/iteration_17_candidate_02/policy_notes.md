# Steering-neutral posterior phase certificate

## Evidence and visual diagnosis before editing

- I read the assigned parent guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, trajectories, and available inherited
  optimizer notes. Every current sample uses direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and
  `capture` termination. There is no literal failed termination in the current
  sample, so weak route and terminal states are the informative negative
  controls; inherited logs additionally supply completed capture regressions
  and one `left_domain` failure.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for all four samples, comparing the score-leading phase-consistent work
  policy with the energy-only reserve, the assigned consensus-qualified
  parent, and the unguarded posterior-work policy. Every fish self-propels from
  rest, forms a coherent alternating mid-plane street by about `4T`, and
  retains compact three-dimensional posterior structures through capture.
  There is no visible passive advection, wake breakup, collision, or
  out-of-plane instability. The controller defect is therefore the route
  imprint of recovery work, not missing propulsion or wake coherence.
- The phase-consistent work guard is the strongest sampled scalar result. It
  improves score/mean distance from the unguarded work policy's
  `-0.072146/1.958037L` to `-0.064599/1.950823L`, retains essentially the same
  first-`3T` distance/speed (`12.214593L/0.2519U` versus
  `12.214522L/0.2519U`), and leaves RMS yaw/force/moment and actuator-limit
  classes nearly unchanged. This validates local direction consistency as a
  useful posterior-work mechanism rather than a scalar gain effect.
- The same result falsifies the prior expectation that combined-target phase
  consistency would repair the route. Capture slips from `17.8695T` to
  `18.0125T`, center path and maximum head cross-track grow from
  `13.0071L/0.6102L` to `13.2330L/0.7417L`, and mean approach alignment falls
  from `0.787` to `0.664`; final alignment remains weak at `0.068`. Because the
  current phase certificate uses `mean_tail_tangent + tail_wave_target`, its
  release boundary moves with steering even though the extra work is intended
  as propulsion recovery.
- The assigned consensus-qualified wave reserve captures at `17.7870T` on a
  shorter `12.9495L` path with `0.837` approach alignment, but its first-`3T`
  distance/speed regress to `12.220562L/0.2459U` and score/mean distance to
  `-0.073937/1.959602L`. Inherited completed results also show that posterior
  response-magnitude qualification regresses to `-0.082282`, a blanket
  steering-load complement regresses to `-0.095199`, and substituting
  target-projected center translation for range closure causes `left_domain`
  after a `0.9166L` near miss. These results reject another progress
  conjunction, achieved-response threshold, or unsigned steering veto.
- An offline signal replay on the score-leading trajectory indicates that a
  zero-mean wave-error certificate would retain about `91%` of the work
  authority retained by the current combined-target certificate while
  removing only the portion whose release decision is changed by the steering
  offset. This is a trajectory-local policy-signal diagnostic, not CFD
  evidence.

## One policy hypothesis

Start from the sampled-best phase-consistent posterior-work controller and
preserve its anterior phase-plane carrier, closure and carrier-energy
qualification, lagged posterior wave, odd mean-curvature steering,
beat-synchronous steering, route observer, approach handoff, cadence schedule,
and reversal-preserving rate governor. Change one semantic connection: compute
the one-sided posterior tracking-work certificate against the zero-mean lagged
`tail_wave_target`, while the actual posterior tracking target continues to
include `mean_tail_tangent`. Thus extra velocity-aligned work is admitted by a
propulsive-wave reference and cannot acquire direct authority from the
steering offset; base tracking and steering authority remain unchanged. The
change uses normalized joint angle/rate state and the existing body-frame
feedback with no clock, stored phase, coordinates, target identity, random
state, or new scalar gain.

Expected evidence is retention of the phase-consistent policy's first-`3T`
closure and score-distance advantage, with path, cross-track, capture time,
and approach alignment moving toward the assigned parent's route class.
Falsify the mechanism if score or early closure returns to the unguarded or
consensus-gated class, route/terminal state does not improve, actuator or load
class worsens, reflection symmetry fails, or either visual wake row loses its
coherent traveling structure. The new candidate has not received CFD
evaluation, so these are predictions rather than results.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and sensor-modulated robotic-fish CPG steering
source_mechanism: a posteriorly lagged traveling bend supplies propulsion while mean offset and half-cycle modulation provide a distinct steering channel
transferable_invariant: qualify extra posterior propulsive work against the zero-mean traveling-wave response so steering offset does not become a second recovery-work gate
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body phase patterns, exact vortex phases, target coordinates, and task-specific routes
policy_translation: preserve the bounded closure-qualified work pump and combined tail tracking target, but compute its one-sided phase certificate from normalized posterior motion relative to the lagged wave target before mean curvature is added
falsification: reject if early score-distance benefit is lost, route and approach state fail to improve, actuator or load class worsens, reflection behavior breaks, or top-down and oblique wake coherence deteriorates
