# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=[0,0,0]`; there is no prewarm or ambient advection to explain
  their motion.
- The scalar-best phase-compensated run (`solver_5c5f9d80447b`) retained a
  coherent alternating wake in both the top-down vorticity and oblique Lambda2
  rows, but passed above the target at `3.0031L` and continued to the left-domain
  exit. Its clipped acceleration envelope was active on about `91%` of logged
  rows, so its longer survival is not evidence of a better terminal actuator.
- The inherited terminal half-cycle reallocation
  (`solver_a8af0d71b0de`) produced the most useful sampled trajectory: coherent
  self-propulsion and a target-directed turn brought the head to `1.2669L` at
  `18.69T`. The combined keyframes then show a near-vertical below-target path,
  fading Lambda2 structures, and a lower-boundary exit at `30.12T`; the metrics
  agree (`final_distance=9.6564L`, not captured, finite dynamics).
- The inherited failure is not merely a scalar steering miss. Its two joint
  excursions fall from about `52/52 deg` peak-to-peak during `16--17T` to
  `25/26 deg` at `18T`, `9/8 deg` at `19T`, and only a few degrees thereafter.
  Normalized head/tail oscillator energy falls from about `0.84` before the
  terminal reallocation to `0.40/0.31` at `18T` and below `0.2` after `19T`.
  The policy continues coasting toward the lower boundary while a saturated
  body-frame course request cannot rebuild the traveling bend.
- The compatible half-cycle candidate (`solver_9cc71cad0aa3`) retained roughly
  `55--61 deg` joint excursion and a coherent wake through termination without
  acceleration clipping, but only reached `2.7390L`. This contrast supports
  preserving the inherited close-pass steering topology while preventing its
  one-sided carrier attenuation from extinguishing the rhythm.

## Policy hypothesis

Add one state-feedback mechanism: estimate normalized carrier energy from each
joint's angle and velocity relative to the commanded oscillator amplitude and
frequency, and smoothly release only the terminal opposing-half-cycle relief
when either joint falls below a propulsion reserve. Keep the achieved-course
outer loop, direct bounded steering, far-field cadence, and traveling-bend
scaffold unchanged. The expected signature is the inherited early trajectory
and first close approach together with recovered joint excursion and coherent
wake after `17--18T`, giving the course request authority to turn back toward
the capture disk instead of coasting out the lower boundary. This candidate's
CFD outcome is not available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst-redirect behavior
source_mechanism: preserve rhythmic propulsion while bounded steering is released when the observed gait response approaches a failure boundary
transferable_invariant: steering modulation must yield to observed locomotor-state feedback before it extinguishes the propulsive rhythm
nontransferable_details: published CPG gains, robot or species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use only normalized joint angle and velocity energy in the existing body-frame course servo to gate terminal half-cycle carrier attenuation; retain the two-joint state-feedback contract
falsification: reject if the first approach degrades materially, joint excursion still collapses, coherent wake is not restored, acceleration or speed saturation worsens, or the lower-exit termination topology is unchanged
