# Progress-qualified approach propulsion candidate

## Visual and quantitative diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, stable dynamics, and capture termination. I inspected the
  top-down vorticity and oblique Lambda2 rows for the assigned
  error-qualified controller and the weaker unqualified line-of-sight
  controller. Both self-propel from rest, retain a coherent alternating
  mid-plane street, and shed compact three-dimensional posterior structures
  through capture. There is no passive advection, collision, wake breakup, or
  out-of-plane instability; trajectory feedback, rather than wake existence,
  separates them.
- Three samples are semantic-identical reruns of the error-qualified policy
  and reproduce exactly: capture at `17.7265T`, score `-0.08139542`, mean
  distance `1.967391L`, and final distance `0.747287L`. Treat them as
  determinism evidence, not three controller mechanisms. The unqualified
  line-of-sight residual captures at `17.8750T`, score `-0.08710319`, and mean
  distance `1.973290L`.
- Inherited optimizer logs explain the difference. Qualifying the route
  residual by current normalized target error and making it zero throughout
  the `2.1L` approach reduces maximum straight-line cross-track from about
  `0.545L` to `0.512L`, reaches the approach boundary with `0.018L`
  cross-track, raises approach/final course alignment from about
  `0.814/0.113` to `0.899/0.601`, and lowers final yaw magnitude from
  `3.153` to `0.901 rad/T`. The current trajectory confirms a productive
  `0.885U` mean approach speed and `0.899` mean course alignment, so neither
  another route correction nor terminal yaw/slip injection is supported.
- The remaining propulsion handoff is unnecessarily binary. Inside `2.1L`,
  the current carrier keeps its far cadence only above a narrow
  `0.82..0.96` instantaneous course-alignment band; below `0.82` it falls
  back to the distance ramp even while motion still closes on the target.
  The sampled winner is still closing at `0.601` course alignment and
  `0.898U` speed at capture. Thus the evidence supports testing continuous
  allocation by measured useful translation, without changing steering,
  posterior emphasis, or the successful far/middle route observer.

## One policy hypothesis

Preserve the assigned error-qualified line-of-sight guidance, odd curvature
map, anterior phase-plane oscillator, posterior lag/emphasis, half-cycle
steering, and direction-selective rate governor. Replace only the terminal
carrier's thresholded course classification with a bounded progress-quality
gate: the positive normalized dot product of body-frame velocity with the
body-frame target direction, smoothly mapped from zero to one and suppressed
at low speed. Outside approach the existing full far gate is unchanged;
inside approach, the carrier retains cadence in proportion to observed target
closure and falls continuously back to the distance ramp for tangential or
receding motion. This is a normalized observation-to-propulsion allocation
mechanism, not scalar gain tuning, and adds no clock, coordinates, mutable
state, target identity, or memorized route.

Expected evidence is retention of capture, the coherent two-view posterior
wake, sub-`0.55L` cross-track, and the current high approach alignment while
shortening arrival or lowering mean distance by avoiding premature terminal
cadence withdrawal. Falsify the candidate if capture, route directness,
distance integral, alignment, force/moment scale, or joint-limit residence
worsens materially, or if continuous propulsion carries a tangential course
past the capture boundary.

bookshelf_consulted: true
source_domain: classical far/middle/near swimming control and sensor-modulated robotic-fish rhythmic locomotion
source_mechanism: preserve a stable traveling-wave carrier while continuously allocating near-target drive by measured useful target-directed translation
transferable_invariant: terminal propulsion should fade with loss of normalized target closure rather than an arbitrary narrow direction threshold, while route and steering feedback remain separate
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, evidence-specific routes, and source-task switching distances
policy_translation: smoothly map positive body-frame target-to-velocity alignment into the existing approach carrier gate, retain the distance fallback and low-speed suppression, and leave both joint steering channels unchanged
falsification: reject if capture, distance integral, route directness, actuator-load class, reflection symmetry, or top-down and oblique wake coherence regress
