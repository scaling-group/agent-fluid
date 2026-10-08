# Capture-corridor steering-release candidate

## Evidence-led diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen direct-uniform contract:
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm, and inertial
  zero velocity in newly exposed moving-window cells. All four terminate in
  capture, so the useful evidence is route quality and mechanical cost rather
  than a success/failure scalar ranking.
- I inspected the strongest replicated candidate and the informative weaker
  bidirectional allocator in their combined sheets from release through
  capture. In both the top-down row shows continuous target-directed
  translation and a coherent alternating red/blue street, while the oblique
  row shows compact three-dimensional Lambda2 structures following the caudal
  region into the capture sphere. Neither sheet shows passive advection,
  held-joint coasting, wake collapse, collision, or a boundary exit. The
  traces agree: the replicated candidate reaches `1.391U` while sampled local
  flow stays below `0.0327U`.
- Three byte-identical samples reproduce the assigned parent policy and full
  trajectory: capture at `16.93205T`, score `-0.20004481`, mean distance
  `2.08513L`, sublimit joint-speed peaks of `4.5192/4.5239 rad/T`, posterior
  angle magnitude `0.59921 rad`, and force/yaw-moment peaks
  `0.03693/0.01835`. This is strong evidence to preserve the zero-centered
  carrier, body-frame velocity-course steering, soft acceleration envelope,
  narrow positive-power speed guards, signed adverse-yaw work allocation, and
  stopping-risk projection.
- The fourth sample adds target-signed adverse-yaw suppression to the opposite
  anterior-to-posterior transfer direction. It still captures slightly sooner
  at `16.92618T`, but worsens score to `-0.20096611`, mean distance to
  `2.08585L`, and final crossing distance to `0.74483L`, while posterior angle
  remains `0.59922 rad`. Thus making both transfer directions obey the same
  signed-load arbitration does not produce a semantic benefit and should not
  be compounded in the next candidate.
- The replicated trace instead exposes a distinct terminal condition. Once
  distance is below `2L`, the current velocity ray repeatedly has positive
  closing speed and a projected lateral miss below `0.5L`, safely inside the
  `0.75L` capture radius, yet instantaneous course feedback continues to
  request large alternating corrections; terminal yaw-rate magnitude reaches
  `4.44 rad/T`. At `1.327L`, for example, closing speed is about `1.33U` and
  projected miss is about `0.225L`, but turn request is still about `-0.69`.
  The controller needs a geometric approach-hold condition, not another
  carrier gain or symmetric load gate.

## Single-candidate policy hypothesis

Add one bounded capture-corridor steering-release mechanism to the replicated
parent. Compute the straight-line projected miss from normalized body-frame
target position and body velocity, and require the measured normalized range
rate to confirm closing. Only while the fish is near the target, closing, and
the velocity ray lies continuously inside a conservative `0.5L` corridor,
reduce the posterior mean-steering component toward a nonzero floor. Preserve
the carrier, propulsion, acceleration reserve, all mechanical guards, and the
target-signed work-allocation request unchanged. If the projected intercept
deteriorates or the fish stops closing, full steering returns without a stage
counter or memorized route.

This is a state-dependent approach-hold primitive rather than distance-only
relief or scalar gain tuning. It should remove unnecessary terminal steering
without reintroducing the earlier `0.857L` tangent miss, because a miss outside
the conservative corridor receives the full inherited authority. Expect
capture and both coherent wake views with equal or lower terminal yaw/load and
no joint contact; seek an improvement over `-0.200045/2.08513L` without
arrival later than `16.932T`. Falsify the mechanism if the corridor gate causes
a near miss, later arrival, a changed broad route, loss of alternating
shedding, any joint contact, or increased posterior excursion, force, or yaw
moment.

```text
bookshelf_consulted: true
source_domain: biological terminal approach and sensor-modulated robotic-fish CPG control
source_mechanism: retain the propulsive rhythm while near-target closing geometry schedules only excess steering authority
transferable_invariant: once measured velocity predicts a safely closing intercept, withdraw bounded corrective steering continuously and restore it immediately when the intercept degrades
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, exact capture radius, prescribed approach stages, vortex phases, and task-specific routes
policy_translation: form projected miss from normalized body-frame target and velocity and confirm approach with normalized measured range rate; inside a conservative near-target corridor, taper only posterior mean steering toward a nonzero floor while leaving the two-joint carrier and safety layers intact
falsification: reject if capture, broad-route equivalence, or alternating 3D shedding is lost; if arrival or mean distance worsens; or if joint use and terminal yaw/load do not decrease
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Projecting the new observation gate over the 3,079 recorded parent states
activates it in 132 samples, only from `15.954T` to capture and only after
distance falls below `1.979L`. It reaches full authority on states with
positive measured closing speed and projected miss well inside the corridor;
at the final recorded state its value is `0.569`. By construction it changes
only the posterior mean-steering term, never joint 1 or the traveling carrier.
This confirms that the candidate is neither behaviorally inert nor a
broad-route edit. The projection does not evolve the body or fluid and is not
evidence that capture, load, or score will improve.
