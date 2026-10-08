# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All finite examples report the required direct-uniform still-water start,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion and wakes
  are therefore produced by the fish rather than imposed advection.
- The strongest sampled candidate, `solver_cc8652ccb895`, preserves an
  organized alternating top-down wake and coherent oblique Lambda2 structures
  while reducing distance from `12.3277L` to `1.1347L`. It passes just below
  the target, turns into a broad counterclockwise recovery loop, and exits the
  upper-left virtual boundary at `41.84T` with distance `9.2831L`. This is a
  meaningful semantic improvement over the transferred carrier
  `solver_c61359212990`, whose similarly coherent propulsive wake reaches only
  `4.7800L` before continuing downward and leaving the lower boundary at
  `27.49T`. The large-error geometry-to-curvature redirect should therefore be
  preserved outside the terminal region.
- The sampled phase-demodulated redirect `solver_6c3918c39ae8` barely improves
  distance (`12.1197L`) and exits the upper boundary after `8.48T`; its compact
  top-down and oblique sheets show an early tight turn with only a short wake.
  The inherited optimizer log contains a second low-speed failure:
  `solver_52c0e4a32139` uses velocity-to-target course error and a gated C-bend,
  reaches only `11.8646L`, and exits the upper boundary at `8.98T`. Its low
  command and joint saturation did not make the course useful. Consequently,
  this candidate will not replace the evidenced geometry controller with
  velocity-course or joint-phase steering at release.
- The best candidate's remaining defect is localized. At `24.00T` and
  `1.8819L`, the head is below the target and still moves mostly left at about
  `0.638U`; at the `26.78T` closest approach the target is already behind in
  the body frame and speed remains `0.643U`. Its full redirect continues the
  same oscillation around biased equilibria. The tail first reaches its
  `45 deg` angle stop at `21.92T`, `2.868L` from the target, and intermittently
  remains there through `29.10T`. At `28.19T`, with the tail at `-45 deg`, the
  observed force and yaw-moment coefficient magnitudes spike to about `0.264`
  and `0.119`, versus maxima near `0.030` and `0.016` for the transferred
  carrier. Acceleration limiting is also still frequent (`32.1%/26.0%` of
  joint samples). Cadence relief alone has not reserved joint excursion for
  terminal curvature.

## Policy hypothesis

Keep the best candidate byte-equivalent while the target is farther than a
normalized terminal band. Inside that band, and only when the existing
body-frame geometry declares a redirect, continuously reallocate the two
joints from the oscillatory carrier toward a damped mean-curvature hold. The
head tracks the existing signed head bias; the posterior joint tracks the
existing total-tail-tangent bias minus the head bias, so both joints share the
bend without consuming the full tail excursion. Retain a small carrier floor
for wake continuity and release smoothly back to the inherited traveling bend
as either distance or target alignment improves. This adds no clock, hidden
mode, world coordinate, route, target identity, or exact wake phase.

Expected evidence is unchanged coherent approach outside the terminal band,
followed by less tail-stop dwell, smaller load spikes, lower excess surge, and
a tighter target-directed turn that crosses the `0.75L` capture circle. Reject
the mechanism if the early `12.3277L` to roughly `4L` approach changes
materially, the fish stalls between `1L` and `4L`, the same near-miss/upper-left
loop remains, or angle/acceleration saturation and terminal load spikes do not
fall.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and robotic-fish target-modulated rhythmic control
source_mechanism: large observed misalignment temporarily reallocates rhythmic propulsion into bounded mean curvature, then releases continuously back to a posterior-lagged beat
transferable_invariant: when propulsion and steering share limited joints, a large target-directed bend must receive joint-excursion authority rather than merely being added to the full oscillatory gait
nontransferable_details: species-specific C-start shapes, published gains, dimensional cadence, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: normalized distance and existing body-frame target-angle feedback blend the two-joint state-feedback carrier into damped tracking of its signed head and tail curvature equilibria while retaining a small propulsion floor
falsification: reject if early propulsion changes, terminal capture or trajectory topology does not improve, the fish stalls, or tail-stop dwell and load spikes persist

## Non-CFD implementation audit

Replaying the completed parent's recorded observations and joint states through
both policies confirms exactly zero command difference at every sample with
distance at least `4L`. The terminal gate first becomes nonzero at `19.62T`
and `3.998L`, averages `0.733` over the parent's inside-`4L` samples, and
reaches one. On those fixed states, convex actuator reallocation reduces
command-envelope incidence from `26.3%/17.4%` to `2.5%/1.9%`; this is only an
activation and boundedness audit, not coupled CFD evidence or a claim of
improved capture.
