# Reproduction candidate for geometry-agreed course allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite free-surge/sway/yaw moving-window dynamics, and capture. The
  two sampled `v37_response_exclusive_allocation` policies are exact
  reproductions at `19.612991 T`, score `-0.282941223`, mean distance
  `2.172435105 L`, and final distance `0.748660505 L`; they are one behavioral
  result rather than two distinct mechanisms.
- Unsigned severe-course support (`v38`) establishes that course information
  is useful but indiscriminate allocation is not. It improves score and mean
  distance over `v37` to `-0.271582682` and `2.162124221 L`, but captures
  `0.385010 T` later, reaches the `4 L` crossing more slowly (`0.8264` versus
  `0.8764 L/T`), and raises global force/moment maxima to about
  `0.03154/0.01678` from `0.02959/0.01558`.
- The signed geometry-agreement gate (`v39`) is the strongest sampled policy.
  It improves score to `-0.262179959` and mean distance to `2.151933490 L`,
  while its final crossing distance `0.749067426 L` is slightly farther than
  either parent's. It crosses `4 L` earlier than both parents at `15.444014 T`
  and faster at `0.8926 L/T`, then captures at `19.783508 T`: about
  `0.214493 T` sooner than unsigned `v38`, though still `0.170517 T` later than
  `v37`. Global force/moment maxima (`0.03017/0.01564`) fall between those
  parents. Below `4 L`, high-command incidence is `318/373`, lower than
  `v37`'s `508/589` and close to `v38`'s `322/390`; final commands are modest
  (`0.166/0.951 rad/T^2`) rather than posterior saturation.
- I inspected every combined keyframe sheet from release to capture, including
  both the top-down mid-plane-vorticity row and the oblique body/Lambda2 row.
  All distinct policies visibly self-propel from quiescent fluid along compact
  target-directed paths, shed coherent alternating posterior vortices, and
  retain finite localized three-dimensional structures. None shows passive
  advection, a loop, collision, boundary-exit precursor, wake collapse, or
  out-of-plane instability. The `v39` path preserves the coherent wake while
  reaching the capture side earlier than `v38` and with less terminal
  acceleration than `v37`; the lower-scoring reproduced `v37` is the
  informative contrast because no sampled rollout has a failed termination.
- The inherited optimizer logs show that `v39` was intentionally a narrow
  cross-timescale test: on evaluated parent traces it removed opposed
  gait-scale course corrections while retaining hundreds of geometry-agreed
  course allocations and was exactly dormant at or below `4 L` on the same
  state. Its now-completed CFD result confirms a semantic and scalar
  improvement, but only once. The most informative next candidate is therefore
  an exact controller reproduction, not a gain increase or another mechanism
  stacked into the same outer allocation regime.

## Policy hypothesis

Adopt the evaluated `v39_geometry_agreed_course_allocation` controller exactly
as the single candidate. Preserve its traveling-bend oscillator, posterior
lag-response selector, bounded target residual, signed course/geometry
consistency gate, mean-curvature redirect, closure preview, terminal intercept
law, limits, and parameter values. This changes the assigned `v37` parent by
one already evidenced mechanism: outside `4 L`, a severe instantaneous center
course miss may transfer bounded priority from posterior response recovery to
the target residual only when its signed correction agrees with slow
body-frame target geometry. It adds no authority, clock, route, world
coordinate, beat-phase rule, force cancellation, or terminal change.

The expected result is independent reproduction of the `v39` compact path,
coherent two-view wake, earlier/faster `4 L` entry, finite loads, and capture
near `19.7835 T` with score near `-0.26218`. Falsify the mechanism if the
candidate does not reproduce materially, loses capture, delays the approach,
worsens the distance integral, returns terminal posterior saturation, grows
loads, destabilizes the fish, or degrades either wake view. Reproduction would
justify treating signed course/geometry agreement as the outer baseline;
non-reproduction would require distrusting the single positive sample before
testing added mechanisms. The new CFD evaluation occurs only after this worker
exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following and wake-interaction control
source_mechanism: separate slow target-directed steering from fast alternating transverse motion before reallocating authority away from inter-joint wave coordination
transferable_invariant: a fast transverse-motion cue may modify a bounded rhythmic controller only when its signed correction agrees with persistent target geometry, and a single positive transfer should be reproduced before adding authority
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact vortex or beat phase, actuator models, target coordinates, capture geometry, and task-specific routes
policy_translation: use the sampled normalized body-frame target angle and signed center-course cross to gate the existing exclusive two-joint response-to-residual allocation outside the terminal band; reproduce the evidenced parameterization without scalar retuning
falsification: reject on non-reproduction, lost or delayed capture, worse distance integral, terminal saturation, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The candidate is byte-identical to the evaluated `v39` policy (shared
  SHA-256 `420835b492f6e9df027122388cfe50c769157184c90cd6a30ef44f6588ef5ec1`),
  so this is an exact controller reproduction rather than an undocumented
  scalar variant. `solver/` contains one `candidate_target_policy.jl`.
- The lightweight Julia contract check returns two finite accelerations with
  the frozen `L=64.0` observation adapter. The deterministic schema audit finds
  `87` unique direct `params.FIELD` references and `88` returned fields, with
  no unresolved reference; only the version label is intentionally unused.
- The material-guidance check passes after removing the rendered root
  `README.md`'s duplicated assigned-parent marker, and the repository boundary
  check confirms that the policy is the only modified solver file. No formal
  CFD was run.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account and failed before running a command.
  Its three configured non-CFD commands were therefore run directly and pass
  after the metadata repair above.
