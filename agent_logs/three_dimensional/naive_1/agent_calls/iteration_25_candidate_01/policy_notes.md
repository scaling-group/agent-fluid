# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three comment-different but
  executable-identical assigned-parent candidates reproduce exactly the same
  `23.331013T` capture, `0.749672L` crossing, score-metric mean distance
  `2.135772L`, and `-0.239045` score. The matched course-only control captures
  at `23.369514T`, crosses at `0.748821L`, has mean distance `2.152884L`, and
  scores `-0.255909`. The parent's added `0.12` posterior share of the
  through-water speed-deficit carrier recovery therefore improves both
  arrival and the distance integral; this is a reproducible compatibility
  result, not a cosmetic policy difference or a crossing-radius artifact.
- The complete assigned-parent and course-only combined sheets both show
  continuous target-directed self-propulsion along the established S-route.
  With zero imposed flow, the coincident translation and attached alternating
  red/blue mid-plane street rule out passive advection. Discrete oblique
  Lambda2 structures remain behind the posterior body from wake formation
  through capture, with no visible collision, domain exit, wake collapse, or
  instability. The other two identical-parent oblique rows are blank render
  artifacts, so they support numerical determinism and the top-down wake but
  are not independent 3D-wake confirmations.
- The positive posterior allocation is not free: relative to the course-only
  control, mean action rises from about `58.179` to `59.044`, anterior and
  posterior rate-cap occupancy rise from about `11.16/6.10%` to
  `11.34/6.27%`, and peak normalized force/moment rise from
  `0.029468/0.015365` to `0.030861/0.016213`. Those increases remain finite
  and the complete two-view wake is preserved, but they bound another direct
  thrust or load increase. The inherited logs also show that a second
  posterior adverse-moment residual was non-additive, regressing three
  repeated compositions to `23.853519T/2.194872L`; it should not be retried.
- A route-level observation defect remains. In the reproduced parent, the
  head travels about `14.035L` for `12.768L` displacement and bows as much as
  `2.238L` from the initial target line. The instantaneous through-water
  course angle has about `0.381 rad` standard deviation and is strongly
  carrier-locked: its correlation with normalized anterior joint rate is
  approximately `-0.90` over the rollout and remains below `-0.88` in every
  post-startup interval. A linear replay of lateral body-water motion gives a
  carrier-rate slope near `-0.38U` overall (`-0.50U` early and about
  `-0.30U` late). Thus the slow route loop is responding partly to
  self-generated beat sway rather than only to mean through-water course.

## One candidate hypothesis

Preserve the reproduced assigned-parent traveling carrier, anterior and
posterior speed-deficit recovery, full target geometry, anterior redirect,
phase-selective posterior carrier, target-gated reactive rudder, and
response-plus-anterior-stroke terminal relief. Change only the slow course
observation: subtract the joint-state-predicted carrier sway from normalized
lateral body-water motion before forming the bounded `atan` course angle. Use
the already bounded anterior joint-rate phase and a conservative `0.35U`
coefficient inside the observed `0.30--0.50U` slope range. On the completed
trace this reduces course-angle standard deviation from about `0.381` to
`0.174 rad` and reduces target-opposing route commands from about `12.2%` to
`6.2%`. This is a carrier-aware observation separation, not a scalar change
to the evidenced course gain; it adds no time, world coordinate, route memory,
load residual, prescribed vortex phase, or extra propulsion.

Falsify the translation if capture is lost or later than the reproduced
`23.331013T` parent, scored mean distance exceeds `2.135772L`, or the
preterminal S-route is not shortened or straightened. Also reject it if the
alternating top-down street or discrete oblique wake degrades, mean/near-target
action materially exceed `59.044/44.015`, anterior/posterior rate-cap
occupancy leaves the approximately `11.34/6.27%` class, or peak normalized
force/moment materially exceed `0.030861/0.016213`. A fixed-pose still-water
win would establish compatibility only; changed pose or hydrodynamic evidence
would still be required for robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: preserve a traveling rhythmic carrier while separating its self-generated lateral oscillation from the slower course signal used for target steering
transferable_invariant: a slow body-frame route loop should not treat carrier-synchronous sway as persistent course error when joint state supplies an equivariant estimate of that rhythmic component
nontransferable_details: published gains, dimensional frequencies and speeds, robot sensor calibration, species-specific kinematics, distributed-body envelopes, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the evidenced course controller and all actuation paths, but form its lateral observation from measured through-water sideslip plus a bounded anterior joint-rate compensation before the existing normalized `atan`
falsification: reject if capture is lost or later than 23.331013T, mean distance exceeds 2.135772L, the route is not shortened, or two-view wake, action, saturation, force, or moment envelopes worsen
