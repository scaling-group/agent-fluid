# Multi-Wake Target-Policy Candidate Notes

## Inherited visual and metric diagnosis

- The assigned parent introduced positive-bearing to positive-mean-curvature
  steering around the seed's state-feedback traveling bend. Its evaluated
  rollout (`solver_fcd2b160ff34`) did not retain the seed's useful upstream
  motion: the released sheet shows the fish remain at the upper-right edge and
  leave through the right boundary after only `17.039` time units. The metrics
  agree: head displacement is `(+2.172L,-0.887L)`, minimum distance never
  improves beyond the common initial `12.424L`, progress is `-0.1465`, and mean
  body speed (`+0.129` in x) nearly matches mean local flow (`+0.145` in x).
  This is predominantly downstream advection, not target-directed propulsion.
- Two independently parameterized sibling policies used the same bearing-sign
  convention and have the same topology. `solver_0a0fa18e3872` exits after
  `17.116` with `+2.196L` head-x displacement, while
  `solver_6e0df568da11` exits after `18.106` with `+2.172L`; neither improves
  distance below `12.424L`. Their lower command energy and sub-cap joint
  extrema show that recovering actuator headroom alone did not create useful
  steering or propulsion.
- The naive seed is the best finite comparison despite its later failure. It
  visibly produces a traveling wake and advances `-3.545L` upstream, reaches
  `8.615L` from the target, and survives `50.127` time units before an
  uncontrolled near-vertical descent exits the lower boundary. Its high cap
  occupancy and `541.704` moment RMS remain liabilities, but its upstream
  trajectory is a behavior to preserve rather than erase.
- The shared prewarm sheet confirms an identical held-fish release pose and
  developed four-cylinder wake for every candidate. Thus the three immediate
  right exits are policy-dependent evidence, not different initial wakes.

## Policy hypothesis recorded before the edit

Test the falsification explicitly named by the parent logs: retain the assigned
parent's bounded mean-curvature architecture and the seed's exact propulsive
parameters, but reverse the semantic map from body-frame target bearing to
joint curvature. All sampled steering variants mapped a positive initial
bearing to a positive equilibrium shift; that shift moved the initial positive
joint-1 bend toward its equilibrium and coincided with loss of the oscillator's
upstream motion. A negative equilibrium shift both tests the opposite physical
turn sign and leaves a larger initial displacement from the state-feedback
oscillator's center. No gain, wake-force, phase, route, or approach mechanism
is added, so the next CFD rollout can attribute any trajectory change to this
single sign-semantic correction.

Expected evidence is restored negative head-x displacement, distance below the
common `12.424L` release value, survival beyond the `17--18` right-exit cluster,
and a track that begins rotating toward the target rather than being advected
outward. Falsify the translation if it still exits right, repeats the seed's
lower-boundary descent without reducing bearing, fails to recover upstream
motion, or recovers motion only through the seed's persistent hard clipping.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological turning by tail-beat mean-curvature bias
source_mechanism: bounded target-error modulation of mean bend around a state-phased propulsive traveling wave
transferable_invariant: persistent body-frame direction error should create a bounded left-right gait asymmetry without replacing the propulsive rhythm
nontransferable_details: published gains, robot or species geometry, dimensional beat frequency, prescribed CPG phase, exact vortex phase, and task-specific routes
policy_translation: preserve the two-joint state-feedback oscillator and posterior lag, but map normalized body-frame bearing to the opposite signed bounded joint-equilibrium shift identified by the sampled rollouts
falsification: reject if upstream propulsion is not restored, target distance never falls below the release value, the same immediate right exit remains, or the opposite sign merely restores the seed's saturated lower exit
