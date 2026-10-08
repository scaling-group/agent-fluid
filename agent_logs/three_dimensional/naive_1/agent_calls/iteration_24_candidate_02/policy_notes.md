# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- The assigned parent and two sampled comment-only repeats are deterministic
  direct-uniform still-water captures at `23.424515T`, with scored mean
  distance `2.184349L`, crossing distance `0.749902L`, and score `-0.287480`.
  They retain the inherited water-relative axial recovery and raw lateral-slip
  route correction. Their top-down sheets show self-propelled motion on the
  established broad S-route and a continuous alternating caudal street, but
  their oblique rows are blank render artifacts and add no three-dimensional
  wake evidence.
- The strongest sampled result changes only the slow route observation from a
  dimensional lateral-speed residual to a bounded through-water course angle.
  It captures at `23.369514T`, reduces scored mean distance to `2.152884L`,
  improves score to `-0.255909`, and slightly lowers sampled mean action
  (`58.179` versus `58.289`), anterior/posterior rate-cap occupancy
  (`11.32/6.12%` versus `11.83/6.69%`), and peak normalized force
  (`0.02947` versus `0.02978`) at nearly unchanged peak moment. Its top-down
  row preserves the same useful route and alternating street while already
  being visibly closer at `14T` and `18T`. Unlike the repeats, its complete
  oblique row shows discrete three-dimensional Lambda2 structures behind the
  posterior body through capture, so it is the current wake-preservation
  reference rather than merely a scalar winner.
- A distinct inherited rollout adds a `0.12` share of the same smooth
  through-water speed-deficit response to the lagged posterior carrier. It
  captures earliest at `23.347515T`, lowers scored mean distance to
  `2.161137L`, and improves score to `-0.263925`, with mean action `57.822`,
  rate-cap occupancy `11.71/6.12%`, and peak normalized force/moment
  `0.02983/0.01552`. Its top-down sheet preserves the route and attached
  street; its black oblique row is a render failure, so the positive evidence
  is arrival, distance, effort/load, and top-down wake evidence only.
- The informative negative control is the inherited adverse-yaw-moment
  residual: three executable-identical compositions regress to
  `23.853519T`, mean distance `2.194872L`, and score `-0.297049` despite finite
  capture and the same top-down wake class. Its inspected oblique row is also
  blank. This falsifies generic additivity and specifically warns against a
  second posterior steering residual; it does not falsify a speed-deficit
  carrier allocation that turns off after early recovery.

## One candidate hypothesis

Use the sampled course-angle controller as the base because it has the best
completed score, mean-distance integral, complete two-view wake evidence, and
lower effort/saturation class. Add only the independently positive, bounded
posterior carrier-recovery allocation: during the existing normalized
through-water speed deficit, multiply the lagged traveling carrier by
`1 + 0.12 * propulsion_recovery_gate`, while leaving course feedback,
joint-state phase, anterior oscillator recovery, target-gated reactive rudder,
and terminal relief untouched. This is one small composition of a slow route
observation and an early locomotor allocation, not scalar-only gain tuning or
another load/steering residual. Both components are body-frame, normalized,
memoryless state feedback; no time, coordinates, route, target identity, or
vortex phase is introduced.

Falsify the composition if it loses capture, arrives later than the best
`23.347515T` component, or raises scored mean distance above the best
`2.152884L` component. Also reject it if the preterminal S-route or alternating
top-down/oblique wake degrades, mean action materially exceeds `58.179`,
anterior/posterior rate-cap occupancy leaves the approximately `11.7/6.1%`
class, or peak normalized force/moment materially exceed `0.02983/0.01552`.
A fixed-pose still-water win would establish compatibility only; it would not
establish imposed-wake, pose, or hydrodynamic robustness.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a traveling rhythmic carrier, steer its slow mean route from target-relative through-water course, and place bounded locomotor recovery toward the posterior actuator during measured speed deficit
transferable_invariant: separate slow body-frame course correction from carrier production, and recruit posterior traveling-bend authority only when normalized through-water motion shows a locomotor deficit
nontransferable_details: published gains, dimensional speeds and frequencies, distributed-body envelopes, species-specific kinematics, robot sensors, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: retain the sampled bounded `atan` course observation and all established steering laws, while multiplying only the lagged posterior carrier by the existing smooth speed-deficit gate with the independently tested `0.12` bounded share
falsification: reject if capture is lost or later than 23.347515T, scored mean distance exceeds 2.152884L, or route, complete two-view wake, action, saturation, force, or moment envelopes worsen
