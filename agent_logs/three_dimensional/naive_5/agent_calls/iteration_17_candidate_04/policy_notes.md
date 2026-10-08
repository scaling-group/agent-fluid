# Capture-preserving joint-envelope candidate

## Visual and trace diagnosis before the edit

- All four sampled solver IDs are byte-identical evaluations of the assigned
  parent and satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  Their combined sheet is
  likewise identical.  In its top-down mid-plane row the fish translates left
  with a regular alternating wake, then continues a late downward path rotation
  through the target circle.  The oblique body/Lambda2 row shows the same
  body-attached, organized three-dimensional wake through capture.  The
  `12.3277L` to `0.749769L` progress at `27.6045T`, terminal speed near
  `0.642L/T`, and 260 lossless moving-window shifts confirm controlled
  self-propulsion rather than storage-window advection.
- The closest inherited visual failure available in this workspace is the
  anterior counter-sweep rollout at `0.828153L`.  Its top-down row follows the
  same broad corridor but passes the circle and continues to a left-domain
  exit; its oblique row retains an organized wake.  Together with the inherited
  `0.828--0.831L` terminal-pulse cluster, that comparison shows why the sampled
  inertial line-of-sight response is semantic progress: it changes the late
  route while retaining the productive carrier, whereas more terminal wave,
  recoil, damping, or redirect-threshold edits did not capture.
- The success is narrow and carries a distinct actuator-envelope defect.  Its
  trace reaches exactly `45 deg` on joint 2 for three samples near `16.92T` and
  `6.22L` target range; joint speed reaches the `260 deg/T` cap for 1183 of
  10038 joint samples (about `11.8%`), and acceleration commands reach the
  policy's `30 rad/T^2` clamp for 1878 joint samples.  Peak planar force and yaw
  moment (`0.03397/0.01548`) remain well below the inherited high-load failure
  class, but the capture margin is only `0.000231L`.  This supports a compact
  envelope intervention, not more line-of-sight gain or another terminal pulse.

## Policy hypothesis

Keep the capture-proven traveling-bend carrier, body-frame target/course
selector, same-sign redirect, terminal miss veto, and inertial line-of-sight
positive-response-deficit branch unchanged.  Add one two-joint reference guard
after their commands are combined.  For a joint moving farther from neutral,
estimate normalized stopping excursion from its observed angle and angular
speed under the owned acceleration envelope.  As that excursion crosses a soft
angle boundary, smoothly blend only toward maximum inward braking; when the
joint is moving inward, leave the evaluated command untouched.  Using absolute
angle/speed for the gate and signed velocity only for the braking direction
preserves reflection equivariance and cannot inject an outward pulse.

The falsifiable expectation is repeat capture with the same broad and late
target-directed visual path, no `45 deg` contact, and lower joint-speed or
acceleration-limit residence without materially increasing force or moment.
Reject the guard if capture becomes `left_domain`, the minimum distance worsens
beyond `0.75L`, the coherent wake or late line-of-sight turn changes materially,
the guard produces switching near neutral, or angle/load/limit exposure does
not improve.  Because this worker cannot run CFD, these remain downstream tests
rather than claims about the unevaluated candidate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control with bounded state-feedback residuals
source_mechanism: preserve a productive rhythmic carrier while observed state gates only the smallest corrective intervention still required
transferable_invariant: constraint feedback should leave the traveling-wave controller intact away from the observed defect and add bounded correction only as measured headroom vanishes
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional beat timing, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized two-joint angle and angular-speed stopping excursion gates a smooth blend toward signed inward braking under the owned acceleration limit; all target steering and carrier commands remain unchanged outside the guard
falsification: reject if capture does not repeat, the late target-directed route or coherent wake changes materially, exact angle contact remains, or speed-cap, acceleration-cap, force, or moment exposure worsens

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three commands were therefore run
  directly and separately.  The guidance semantic-delta check, finite
  two-joint Julia contract, and solver editable-boundary check all pass.  The
  rendered `README.md` initially duplicated the same assigned-parent marker;
  removing only that duplicate allowed the prescribed guidance check to
  resolve the unchanged parent identity.
- All 39 direct `params.FIELD` references are owned by
  `target_policy_params()`, and exactly one non-empty candidate policy exists
  under `solver/`.  A reflected synthetic state negates both commands to
  floating-point tolerance.  On the sampled successful trace, applying the
  guard algebra to the recorded commands changes 192 joint-1 and 278 joint-2
  samples, with maximum inward changes of about `9.66` and `6.55 rad/T^2`; no
  change strengthens acceleration in the direction of outward joint motion.
  This establishes material activation, schema coverage, boundedness, and the
  intended symmetry/direction contract only.  The candidate itself remains
  unevaluated by CFD.
