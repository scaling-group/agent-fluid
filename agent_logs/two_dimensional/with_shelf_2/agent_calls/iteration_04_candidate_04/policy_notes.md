# Multi-wake policy candidate notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting cylinder streets. It is an initial-condition
  control, not candidate-specific evidence.
- The strongest finite sampled trajectory, `solver_a84fba8bf04f`, actively
  swims upstream from the upper right and enters the interacting wake rather
  than drifting with the inflow. It bends onto a much more useful approach
  than the inherited half-cycle parent, but after passing near the target its
  keyframes show a steep downward turn and lower-boundary escape. The metrics
  confirm a `1.646L` closest approach, then `-13.233L` lateral head displacement
  and `left_domain` at `75.09` release-time units. Its response-aware anterior
  half-cycle steering also raises force/moment RMS to `487.10/4680.10`, versus
  `314.32/3430.21` for `solver_928f830d4c45`.
- The assigned parent `solver_928f830d4c45` preserves useful upstream
  propulsion (`-9.726L` head x displacement and `4.621L` closest approach),
  but its sheet likewise ends in a nearly vertical lower-boundary escape with
  `-13.313L` lateral displacement. Increasing its half-cycle authority would
  reinforce the failure topology already identified in inherited guidance.
- The informative unstable example, `solver_c047d8bd6501`, visibly curls near
  the upper-right release region by its second and final keyframe. Its early
  `unstable_dynamics` termination, `1.212` RMS relative crossflow, and
  `23111/397906` force/moment RMS reject the opposite-sign equilibrium-shift
  design as a safe steering scaffold. The inherited `solver_78b1ea3edfcb`
  result also rejects equilibrium recentering on different grounds: it moved
  `+2.194L` downstream, made negative progress, and exited after `18.23` units.

## Candidate hypothesis

Keep the parent's zero-centered anterior oscillator and soft acceleration
limit unchanged so the test retains its evidenced upstream propulsion. Remove
half-cycle acceleration asymmetry from both joints. Instead, add one bounded
body-frame target-curvature term to the desired total tail tangent, realized
only through the posterior joint. Predict bearing with the observed windowed
bearing rate so a correct response releases steering and a growing error adds
correction. This separates a slow steering bias from the traveling bend and
should reduce the persistent lateral escape without recreating the startup
thrust loss of equilibrium-shift controllers.

Falsification: reject the mechanism if upstream head displacement falls
materially from the parent's `-9.726L`, if closest approach and lateral exit
topology do not improve together, or if joint saturation and force/moment
loads approach the unstable equilibrium-bias example. In those cases later
workers should test posterior-bias sign/authority or a soft wake-disturbance
residual, not increase anterior half-cycle authority.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and reactive-tail swimming
source_mechanism: modulate a propulsive rhythm with sensor-driven turning bias while preserving posterior wave emphasis
transferable_invariant: separate zero-mean rhythmic propulsion from bounded response-aware curvature, with the posterior joint realizing the total-tail bias
nontransferable_details: published gains, duty ratios, species envelopes, clock phase, exact vortex phase, and source-task routes
policy_translation: use body-frame bearing plus windowed bearing rate to bias the posterior total-tail target while leaving the anterior state-feedback oscillator zero-centered
falsification: reject if the separated posterior bias loses recovered upstream propulsion, preserves the same lower-boundary escape, or produces saturation and load growth
