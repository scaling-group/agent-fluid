# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled solver rollouts and the assigned parent use valid direct
  uniform still-water initialization (`U_infinity=(0,0,0)`), no cylinders,
  and finite moving-window shifts. Their motion and wakes are self-generated,
  not ambient advection or prewarm artifacts.
- The strongest finite sampled policy, `solver_b6bb94d9cdaf`, forms a coherent
  alternating top-down wake and organized oblique Lambda2 structures. It
  self-propels for `21.79T` and reaches `5.3570L`, but its path rises above the
  target and exits at `y=15.2024L`. The closest sampled pass,
  `solver_e450df1efa49`, retains an even longer coherent wake and reaches
  `4.1281L`, but passes left above the target and requests accelerations beyond
  the physical envelope on most trajectory rows. These runs support retaining
  the joint-state traveling wave, but not their route actuation details.
- The inherited 2D champion `solver_e699ec5c28f1` visibly curls downward past
  the target, reaches `6.1797L`, then exits the lower boundary. Together these
  three useful wakes bracket the missing capability as bounded signed course
  correction rather than propulsion creation or wake rejection.
- The assigned course-error parent `solver_eb0b548f8cbc` is the decisive
  failure. Both visual rows show only a weak starting wake before a tight upper
  turn; it reaches just `11.4841L` and exits at `9.746T`. Two inherited sibling
  course/mean-curvature evaluations fail almost identically (`11.4698L` and
  `11.4731L`). They all send a positive posterior mean tangent together with
  an opposite anterior acceleration. That is an S-shaped steering deformation,
  not the common C-bend used by the repository's signed 3D turn sanity, and its
  repeated failure is structural rather than evidence for another gain edit.
- The sampled target/course half-cycle actuator is also rejected: its short
  curved wake, `0.237L/T` mean speed, and `0.3345L` closest-distance improvement
  show that merely changing the phase-side strength does not preserve the
  propulsive scaffold in its tested response range.

## Policy hypothesis

Preserve the compact bounded joint-state oscillator and posterior lag, but
replace the failed posterior/opposite-anterior S-bend with one common-bias CPG
mechanism. A bounded normalized body-frame bearing sets a shared equilibrium
for both joints. Joint 1 oscillates about that equilibrium; joint 2 retains the
same equilibrium while following the observed anterior state with posterior
lag. The documented 3D sign calibration maps positive common bias to negative
yaw, matching the initial positive-bearing correction without a world-frame
heading, yaw-rate servo, hidden phase, or route.

Because the bias recenters rather than adds to the traveling wave, it should
retain coherent self-propulsion while providing a cycle-mean steering sign.
Falsify the mechanism if closest distance does not beat the assigned parent's
`11.4841L`, if it repeats the weak-wake tight upper curl, if left/right response
does not follow the calibrated common-bias sign, or if joint/command-limit
residence and loads worsen. A useful result should ultimately preserve the
strong samples' wake while changing their above-target exit topology; no
terminal schedule is justified until a policy enters the `0.75L` capture
region.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and the repository's signed 3D common-bias turn sanity
source_mechanism: superpose a bounded common joint offset on a propulsive rhythm so direction changes without replacing the traveling wave
transferable_invariant: persistent normalized target error may recenter the rhythmic joint attractor, while posterior lag and oscillatory state feedback remain responsible for propulsion
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional cadence, the turn-sanity bias magnitude, and prescribed routes
policy_translation: map bounded body-frame bearing to one shared two-joint equilibrium; run the anterior state-feedback oscillator and lagged posterior target around that equilibrium with controller-owned soft acceleration limits
falsification: reject if the common-bias sign fails, the wake collapses into turn-in-place motion, closest progress fails to beat the assigned parent, or actuator and load histories worsen
