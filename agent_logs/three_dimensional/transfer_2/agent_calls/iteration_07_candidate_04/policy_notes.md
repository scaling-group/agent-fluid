# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled episodes use valid direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  shifts, and stable dynamics. Their translation is self-propulsion rather
  than advection.
- Both visual rows separate route control from wake production. The top-down
  sheets show alternating mid-plane vorticity and the oblique sheets show
  organized three-dimensional caudal structures in the compact failures and
  the useful approaches. The opposing-sign controller exits high after a
  `5.357L` closest approach. Aligned steering preserves the wake and improves
  that to `2.579L`, but passes above the target and continues straight to the
  left boundary. Full-vector feedback and joint-state half-cycle asymmetry in
  inherited logs repeat that topology at `2.607L` and `2.413L`; wake coherence
  and more route gain alone are therefore insufficient.
- The distance/closing allocator in `solver_8cbc18979df7` is a positive
  semantic change. It reduces the closest miss to `1.733L`, survives to
  `52.48T` instead of about `30T`, changes the straight left exit into a broad
  return loop, and lowers mean absolute joint commands from about
  `(24.1,23.9)` to `(14.1,14.2) rad/T^2`. Residence above 90% of the smooth
  command bound falls from roughly `(51.6%,55.0%)` to `(20.6%,23.2%)`.
  Far-field propulsion and its wake therefore remain useful, while allocating
  drive away on approach creates real steering headroom.
- The same rollout locates the remaining boundary. At about `20.0T`, the head
  is `(8.78,11.85)L`, only slightly ahead of the target longitudinally but
  still `2.35L` above it; the full target angle is about `-1.47 rad`, speed is
  still `0.75U`, and the joints have settled near only `(6.8,5.6) deg`. At the
  `22.81T` minimum, the target is already astern, the target angle is about
  `-2.01 rad`, speed remains `0.76U`, and the nearly static `(6.2,7.5) deg`
  bend produces only about `0.22 rad/T` of yaw. The fish then circles at about
  `6L` distance with the target persistently `1.7--2.5 rad` off its nose before
  leaving high. The allocator starts a correct-sign turn but its steady bend
  is too weak and too late to redirect the inertial approach into the `0.75L`
  capture disk.

## One-candidate hypothesis

Preserve the evaluated joint-state traveling wave, posterior lag, full signed
body-frame target angle, aligned two-joint bend, smooth command bounds, and
distance/closing drive allocator. Add one continuous response-gated redirect
mode. In the middle and near field, a large normalized target-direction error
progressively shifts the oscillator to a stronger bounded C-bend and damps its
carrier. Correct-sign observed yaw releases most of that redirect authority
back toward the propulsive rhythm, while a residual bend remains until the
direction error shrinks. Joint state still supplies gait phase; distance,
target direction, and recent yaw response are the only mode coordinates.

Expected signature: retain the coherent far-field wake and initial progress,
begin a stronger smooth turn before the target reaches the body abeam plane,
cross the `0.75L` capture radius or make a substantially tighter return arc,
and keep command-limit residence below the saturated aligned parents. Falsify
the mechanism if it repeats a `1.7L` or wider first miss and roughly `6L`
loop, loses far-field propulsion or wake coherence, exits high without a
closer re-approach, or restores persistent command/joint-limit residence.

bookshelf_consulted: true
source_domain: biological C-start redirect and robotic-fish closed-loop direction tracking
source_mechanism: large observed direction error evokes a bounded C-bend, then correct heading response releases the swimmer back toward a posterior propulsive beat
transferable_invariant: trade rhythmic drive for stronger mean curvature only while body-frame target error is large and the correct-sign yaw response remains inadequate
nontransferable_details: species-specific C-start stages, published bend angles and gains, dimensional cadence, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: use normalized distance and full signed `target_body_L` direction to gate a stronger aligned two-joint equilibrium; use recent yaw projected onto the requested turn sign to release the extra bend and restore the joint-state carrier continuously
falsification: reject if the first-pass miss and broad-loop topology persist, the target does not move toward the nose before the abeam crossing, propulsion or wake coherence collapses, or actuator-limit residence returns to the saturated-parent level
