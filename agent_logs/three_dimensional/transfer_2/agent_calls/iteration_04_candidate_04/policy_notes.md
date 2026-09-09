# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=0`) and terminate by leaving the virtual domain; none enters the
  `0.75L` capture region.
- In both the top-down and oblique rows, the compact bounded
  bearing/curvature sample (`solver_b6bb94d9cdaf`) establishes a coherent,
  persistent three-dimensional wake and self-propels for `21.79T`. It improves
  distance from `12.3277L` to `5.3570L`, but then travels above the target and
  exits at center `y=15.2024L`. Its trajectory remains smoothly bounded below
  `31 rad/T^2`, while instantaneous heading-rate braking repeatedly competes
  with target bearing.
- The sign-flipped 2D transfer (`solver_e450df1efa49`) retains the strongest
  translation and reaches the sampled-best `4.1281L`, but its top-down path is
  nearly flat above the target, then continues past it to a left exit. Raw
  acceleration exceeds `31 rad/T^2` on about `71.3%/68.4%` of rows, so its
  complex steering branch is not a reusable bounded response.
- The bearing-rate release sample (`solver_59bc4ebdddec`) is bounded and forms
  a wake, but reaches only `7.5311L` before an upper exit. The course
  half-cycle sample (`solver_b43b85a4f60c`) shows the informative opposite
  failure in both views: little early translation, a short curved wake, and a
  turn-in-place upper exit after `8.59T`, with only `0.3345L` closest-distance
  improvement. Thus half-cycle asymmetry alone does not preserve the useful
  traveling-bend thrust in this response range.
- The assigned parent and inherited optimizer log identify the same scale
  separation problem more strongly: `turn_rate_recent` is instantaneous in
  this evaluator, reaches roughly `2--3 rad/T`, reverses posterior bend on the
  beat scale, and yields only `0.1020L` closest progress before an `8.646T`
  exit. The useful evidence instead supports persistent body-frame
  target/course geometry.

## Policy hypothesis

Preserve the bounded joint-state oscillator and posterior lag from the compact
self-propelled sample. Replace instantaneous yaw-rate feedback and half-cycle
amplitude steering with one course-error mean-curvature mechanism:

1. Compute normalized target direction and observed swimming course in the
   body frame.
2. Gate course feedback smoothly from zero while forward speed is undefined.
3. Let target-minus-course error own the sign of a bounded posterior mean
   tangent. Large route error redirects; course alignment continuously releases
   curvature back into the centered traveling-wave gait.

This should retain the coherent wake and bounded command envelope while
contracting the above-target lateral route error that remains after `12--20T`
in the strongest finite samples. Falsify it if closest distance does not beat
`4.1281L`, if the trajectory still exits through the upper boundary without a
material route change, or if propulsion collapses toward the course
half-cycle sample's turn-in-place topology. Also reject it if either direct
policy command can exceed its controller-owned `31 rad/T^2` soft limit.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: sensor-gated modulation of a propulsive rhythm, with strong redirection released by observed directional response
transferable_invariant: separate the persistent route error that owns steering sign from the observed course response that releases steering magnitude while preserving the propulsive wave
nontransferable_details: published gains, clocked CPG phase, species-specific burst kinematics, dimensional speeds, and prescribed routes
policy_translation: map normalized body-frame target-minus-course angle through a bounded mean tail tangent on the two-joint state-feedback oscillator, with a forward-speed gate where course is undefined
falsification: reject if it loses coherent self-propulsion, repeats an upper exit without better closest approach, fails to reduce target-minus-course error, or increases command/joint-limit residence
