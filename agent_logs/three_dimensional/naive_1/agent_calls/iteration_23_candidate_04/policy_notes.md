# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four assigned solver examples are finite captures from the required
  direct uniform still-water initialization: `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, and no reported instability. The two
  comment-only through-water axial-recovery variants reproduce capture at
  exactly `23.424515T`, `0.749902L`, score-metric mean distance `2.184349L`,
  and score `-0.287480`. The two matched inertial-axial controls reproduce the
  slower `23.864521T`, `0.749310L`, `2.192138L`, and `-0.294271` outcome.
  Thus local-water-relative axial sensing is a completed semantic improvement,
  not merely a hoped-for robustness property or evidence for more drive gain.
- In the strongest combined sheet, the top-down row shows continuous
  self-propelled translation along the inherited S-shaped route with an
  attached alternating red/blue caudal street from release through capture.
  The matched slower control has the same useful visible route and wake class.
  Every assigned oblique Lambda2 row is black, including the strongest
  sample's, so these examples add no independent three-dimensional wake claim;
  the earlier complete speed-recovery sheet remains the inherited 3D bound.
- The assigned parent's trajectory leaves a route-level opportunity: its head
  travels about `13.81L` for `12.58L` net displacement and bows about `2.24L`
  from the initial head-to-target line before returning to capture. Its raw
  water-relative lateral-speed correction is mixed directly with an angular
  target bearing even though normalized through-water forward speed varies
  from startup to cruise. The sampled success of both axial and lateral
  body-water sensing supports using those two components together as a bounded
  course observation; it does not support changing steering gain alone.
- The newest inherited optimizer logs provide the informative failure. Three
  independently authored but executable-identical policies add the sampled
  adverse-yaw-moment posterior residual to the through-water parent and all
  reproduce `23.853519T`, mean distance `2.194872L`, and score `-0.297049`.
  Their top-down route and alternating street remain coherent and the rollout
  stays finite, but they give back the parent's arrival and distance gains.
  The failure is non-additivity between feedback paths, not loss of capture;
  do not reintroduce that load residual or infer compatibility from each
  mechanism's independent success.

## One candidate hypothesis

Preserve the reproduced assigned-parent carrier, through-water axial recovery,
full target geometry, anterior redirect, phase-selective posterior carrier,
reactive-rudder sign, and response-plus-anterior-stroke terminal relief. Change
only the slow route observation: form a body-water course angle from lateral
sideslip and sign-correct forward through-water speed, with a positive speed
floor so startup and reversal remain bounded, then subtract a dimensionless
fraction of that angle from target bearing. The sampled parent mean
through-water speed (`0.541U`) times its previous lateral coefficient (`1.2`)
sets a conservative `0.65` course-angle fraction, preserving approximately the
same small-sideslip authority at the evidenced operating point while changing
the semantics from an unmatched velocity term to course feedback. This is one
observation/feedback-structure test; it adds no clock, coordinate, route memory,
load residual, drive increase, or exact vortex-phase command.

Falsify the translation if capture is lost or later than the reproduced
`23.424515T` parent, score-metric mean distance exceeds `2.184349L`, the
preterminal S-route or attached alternating wake degrades, or mean/near-target
action, about `11.74/6.65%` anterior/posterior rate-cap occupancy,
`0.029780` peak normalized force, or `0.015287` peak normalized moment
materially worsen. A fixed-pose still-water improvement would establish
course-feedback compatibility only; changed-flow or pose evidence and a valid
oblique render are still required for multi-wake or 3D-wake robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: preserve the traveling rhythmic carrier while steering its slow mean route from target geometry relative to measured body-water course
transferable_invariant: compare normalized body-frame target bearing with a bounded through-water course angle so inertial advection and speed-dependent lateral motion are not mistaken for the same route error
nontransferable_details: published gains, dimensional speeds and frequencies, robot sensors, species-specific kinematics, exact vortex phases, cylinder geometry, prescribed timing, fixed coordinates, and task-specific routes
policy_translation: retain the reproduced carrier and allocation, but replace the raw lateral-speed term in the slow route request with `atan` course feedback built from both components of `relative_flow_velocity_body_U` and a positive speed floor
falsification: reject if capture is lost or later than 23.424515T, mean distance exceeds 2.184349L, or route, wake, action, saturation, force, or moment envelopes worsen
