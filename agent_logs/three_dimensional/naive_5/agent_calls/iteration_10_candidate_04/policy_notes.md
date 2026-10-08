# Projected-miss approach-braking candidate

## Visual and trace diagnosis before the edit

- All sampled and inherited evaluations are contract-valid direct-uniform
  still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm). In
  both rows of the combined sheets, each fish translates against the still
  background and sheds a body-attached alternating wake; the top-down
  vorticity and oblique Lambda2 views therefore identify self-propulsion, not
  advection or moving-window motion.
- The assigned parent, `solver_b3b6be8f076f`, globally qualifies redirect
  release with projected interception and closing speed. Its wake remains
  coherent, but the fish holds the high corridor, settles near a same-sign
  bend, reaches only `4.278496L`, and turns into the upper boundary at
  `27.066T`. At closest approach its projected miss is about `4.277L` and its
  two joint speeds are nearly zero. This is an evidenced far-field static-bend
  latch, so the global qualification must not be retained.
- The best sampled semantic trajectory, `solver_8097d423c0eb`, instead uses
  measured yaw or two-joint bend attainment to release the redirect. Its
  top-down path makes the broad downward turn and its oblique row preserves a
  coherent three-dimensional wake to `40.029T`; it avoids angle contact and
  keeps peak planar force/yaw moment near `0.0214/0.0098`. It misses capture by
  only `0.079828L`, then overshoots and exits left.
- The inherited completed terminal variants bound another same-sign redirect
  edit. A frequency increase reaches `0.870123L`; predictive projected-miss
  entry reaches `0.926872L`; and a directionally phased posterior recovery
  pulse reaches `0.895724L`. The release veto itself changes the earlier
  `0.8307L` minimum by less than `0.001L`. All preserve coherent wakes but
  remain `left_domain`, so redirect retention, response speed, predictive
  entry, and an added counterstroke have not converted the trajectory.
- A different common signature survives those tests: approach speed remains
  about `0.64--0.68L/T`. In the best sampled rollout it is `0.643L/T` at
  `1.50L`, `0.651L/T` at `1.00L`, and `0.659L/T` at the `0.829828L` minimum;
  projected miss is still `0.807L` and the course is almost perpendicular to
  the target vector at closest approach. None of the completed terminal edits
  materially reduced this translational energy before the target station.

## Policy hypothesis

Recover the sampled yaw/bend-response-released two-joint redirect, including
its established carrier, posterior lag, steering side, and static-latch
release. Add one new continuous mechanism: while the fish is closing through
the middle approach and its body-frame velocity/target projection still misses
the capture corridor, add bounded damping only to posterior joint velocity.
The posterior joint is the primary thrust channel, so this removes approach
energy without adding another directional pulse or suppressing anterior
steering. Distance, projected miss, closing speed, and translation gates make
the damping vanish at range, on a safe intercept, at zero speed, and after the
closest approach.

Expected evidence is the same coherent broad downward path with measurably
lower speed before the head crosses the target's `x` station, allowing the
existing correct-sign yaw response to cross inside `0.75L`. Falsify the
mechanism if it does not beat `0.829828L`, does not reduce middle/terminal
approach speed, shifts the crossing farther from the target, recreates a
static-bend latch, disrupts the alternating wake, touches the angle boundary,
or materially increases actuator-limit residence or the sampled redirect load
scale.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion combined with sensor-modulated robotic-fish targeting and terminal capture scheduling
source_mechanism: posterior kinematics supply much of the reactive thrust, while a distinct sensed near-target regime may reduce excess drive without discarding target-directed steering
transferable_invariant: when stable propulsion and correct-sign turning still produce a high-speed near miss, conditionally dissipate the posterior thrust rhythm while preserving the anterior steering channel and response-based maneuver release
nontransferable_details: published gains, species-specific amplitude envelopes, dimensional beat frequencies, full-body curvature, robot linkage geometry, exact vortex phases, target route, and world coordinates
policy_translation: form smooth gates from normalized body-frame target distance, velocity-projected miss, closing speed, and translation confidence, then add bounded posterior joint-velocity damping only to the cruise branch of the two-joint state-feedback redirect
falsification: reject if approach speed does not fall before target-station crossing, closest approach does not beat 0.829828L, or wake coherence, broad trajectory, angle clearance, load scale, or actuator-limit residence worsens

## Non-CFD implementation audit

On the frozen `solver_8097d423c0eb` observations, the candidate is exactly
identical to the same response-released policy with braking disabled whenever
distance is at least `4L`. The new posterior damping is active on `1024` of
`7278` samples, changes one command by `2.42 rad/T^2` on average while active
and at most `9.56 rad/T^2`, and does not increase frozen-state acceleration-
clamp incidence (`2680` samples in both cases). Direct zero-speed evaluation is
finite, and mirrored joint, target, velocity, bearing, and yaw states negate
both commands exactly. These checks establish locality, material activation,
boundedness, and reflection symmetry only; they do not predict the unevaluated
CFD speed or trajectory.
