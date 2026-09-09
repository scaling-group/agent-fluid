# Step 35 target-policy diagnosis

## Evidence read before candidate selection

- All four sampled solver runs satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and capture at
  `0.7492--0.7499L` after `18.4525--18.7495T`. Their top-down rows show an
  alternating signed-vorticity street from the released swimmer, and their
  oblique rows show bilateral Lambda2 structures with continuing body
  undulation through capture. Motion is therefore self-propelled rather than
  advection, and none of the sampled successes depends on terminal coasting.
- The strongest relevant sample is the exact
  `dogfish3d_outer_unsupported_bearing_v1` repeat. It captures at `0.74986L`
  and `18.6560T` with terminal speed `0.8369L/T`, head/tail action clipping of
  `68.75%/70.70%`, speed-limit residence of `10.32%/11.29%`, and peak planar
  force/yaw-moment magnitudes of `0.03143/0.01648`. Its coherent top-down and
  oblique wakes and actuator/load envelope match the repeat-backed carrier.
  Together with the inherited exact-policy capture at `0.74975L` and
  `18.3205T`, this narrowly gated target-bearing mechanism is now `2/2`.
- The assigned parent's exact speed-reserve replay is the informative active-
  wake failure. It retains the alternating street and bilateral 3D structures,
  but passes below at `1.4107L`, continues self-propelling at about `0.82L/T`,
  and exits the lower boundary. Unchanged baseline replay is therefore useful
  but not reliable first-pass interception.
- The assigned parent's response-released recovery bend is a distinct failure.
  It reaches `1.1790L` at `18.8375T`, remains stable at `0.8330L/T`, but never
  makes a second approach and exits below at `10.2248L` final distance. After
  `20T` it reduces mean absolute joint-speed sum from about `5.16` in the
  failed baseline replay to `2.26 rad/T` and lowers action clipping to roughly
  `45--46%`; the late top-down sheet correspondingly shows much less newly
  shed alternating structure. Reduced actuator burden and a detectable lost
  pass do not validate a same-signed two-joint recovery bend when the route
  topology remains unchanged.

## Candidate hypothesis

Keep exactly the prefilled `dogfish3d_outer_unsupported_bearing_v1` bytes. This
is a third reliability trial of the only recent target-geometry addition with
two exact-policy captures, not scalar tuning or a new stacked residual. The
controller preserves raw achieved-course feedback, the posteriorly lagged
traveling carrier, the inner intercept guard, additive steering allocation,
and sparse outward-only carrier reserve. Its only extra cue is reflection-
equivariant body-frame target bearing, admitted in the outer terminal annulus
only while course error is nearly zero; it is inactive in the far field,
whenever achieved-course feedback is informative, and inside the intercept
corridor.

Expected result: repeat capture while retaining both coherent wake views and
the sampled actuator/load envelope. Falsify the mechanism as a robust repair
if this exact repeat misses, follows the lower branch, changes far-field
closure, weakens the traveling wake, or moves clipping, speed residence,
force, or moment outside the repeat-backed range. Do not respond to a failed
repeat by widening or gain-tuning its bearing gate.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking over a rhythmic CPG carrier
source_mechanism: target-vector feedback modulates direction while an independently sustained traveling rhythm remains the propulsive carrier
transferable_invariant: retain a bounded target-side cue only when achieved-course feedback is momentarily uninformative without replacing or suppressing the posterior traveling bend
nontransferable_details: published gains, dimensional cadence, CPG phase equations, robot morphology, species kinematics, exact vortex phases, terminal timing, and task-specific routes
policy_translation: exactly repeat the normalized body-frame unsupported-bearing qualifier in the outer terminal annulus while preserving the two-joint carrier, allocation, speed reserve, raw course feedback, and inner intercept guard
falsification: reject robustness if the exact repeat misses, retains the lower branch, weakens either wake view, changes far-field closure, or leaves the repeat-backed actuator and load envelope
