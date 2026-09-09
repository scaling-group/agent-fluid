# Response-gated half-cycle steering-release candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled episodes satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite moving-
  window transport, stable dynamics, and `capture` termination. Their combined
  sheets were inspected from release through capture. The top-down rows show
  self-propulsion from quiescent water and a coherent alternating posterior
  vortex street; the oblique rows show compact three-dimensional Lambda2
  structures following the caudal region. No sampled run is an informative
  termination failure, so the weaker course-response capture is used for the
  visual comparison and the inherited exposed-course-redirect domain exit is
  retained only as a hard architectural boundary.
- The assigned response-aware handoff exact repeat is the strongest sampled
  result at `19.162T`, distance integral `2.06924L`, score `-0.18047`, and head
  path `12.309L`. Together with its first run at
  `19.338T/2.07622L/-0.18691/12.304L`, it is consistently ahead of the two
  distance-only handoff runs at `19.354--19.613T`,
  `2.07892--2.09432L`, and `12.416--12.554L`. The response condition therefore
  survives exact replication as a useful allocation mechanism on this release,
  rather than merely perturbing one scalar score.
- The exact response-aware pair keeps peak planar force/yaw moment near
  `0.02535--0.02537/0.01335--0.01356` and mean anterior command near
  `18.45--18.46 rad/T^2`, but about `35.7--36.0%` of anterior actions remain
  above 90% of the smooth command bound and both runs touch the joint-rate
  limit. Their `2--4L` lateral-speed/course-error values also vary from
  `0.196U/0.289 rad` to `0.204U/0.318 rad`. The wake is healthy; the remaining
  falsifiable opportunity is to release turn-biased half-cycle effort after a
  corrective yaw response appears, not to add propulsion, mean curvature, or
  another terminal residual.
- The sheets retain a pronounced continuous hook between roughly `16T` and
  capture. The slower course-response candidate has the same wake and capture
  topology (`19.398T`, `2.08187L`, `12.341L`), while inherited evidence shows
  that exposing velocity-course curvature outside the validated approach
  region instead caused a domain exit at `8.750T` after reaching only
  `11.895L`. The new mechanism must therefore be unable to act beyond `6L` and
  may only remove part of an existing steering allocation.

## One-candidate policy hypothesis

Preserve the assigned response-aware posterior wave handoff exactly, including
the corrected 3D turn sign, fore/aft-aware target vector, distance/closing drive
relief, bounded terminal velocity-course redirect, joint-state oscillator, and
far-amplitude/near-lag endpoints. Add one response-release mechanism to the
  existing half-cycle steering primitive: during the already validated `6--4L`
approach transition, when normalized recent yaw has the same sign as the
body-frame turn request, use the existing bounded response-handoff weight to
remove at most a fixed fraction of useful/return-stroke asymmetry. Opposed or
absent yaw and all distances beyond `6L` recover the assigned controller
exactly. This changes no mean route command, oscillator carrier, clock, task
coordinates, or terminal course gain.

Expected signature: preserve the response-aware pair's early milestones,
capture class, coherent two-view wake, and approximately `0.0254/0.0136` load
envelope while reducing the late-hook path, middle/near lateral motion, and
anterior near-bound command residence. Support requires a meaningfully useful
trajectory or actuator improvement beyond exact-repeat variation without worse
arrival/integral, joint/rate margin, loads, or wake coherence. Falsify if the
release loses capture or early progress, widens the hook, raises command/load
cost, or only shifts score inside repeat spread; then retain the evaluated
response-aware handoff and do not tune the release fraction.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release asymmetric useful-stroke steering continuously once the requested yaw response is established
transferable_invariant: preserve a posterior traveling bend while using observed turn-demand/yaw agreement to withdraw excess half-cycle steering after it has produced the needed response
nontransferable_details: published gains, dimensional burst timing, species-specific kinematics, robot-specific joint envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: inside the normalized body-frame `6--4L` wave handoff, reuse the bounded positive product of turn request and recent yaw to reduce only a bounded fraction of joint-state half-cycle asymmetry under the two-joint acceleration contract
falsification: reject if capture, early progress, path, lateral motion, command residence, joint margin, load class, or coherent top-down and oblique wakes fail to improve without regression
