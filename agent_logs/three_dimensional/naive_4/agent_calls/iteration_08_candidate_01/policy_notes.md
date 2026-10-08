# Wake-policy candidate notes

## Evidence diagnosis

The assigned parent is `solver_57f7c1352c72` (score `-0.066284`, capture at
`16.258T`, final distance `0.748L`). All four sampled evaluations are finite
captures from direct uniform still water with no cylinders. In the combined
keyframes, the best sampled result (`solver_a5dc27216aa2`, `-0.066121`) and the
weakest sampled result (`solver_3b1e268859f6`, `-0.066867`) are visually close:
both self-propel from rest, establish a coherent alternating top-down wake by
`4-8T`, retain compact three-dimensional Lambda2 structures behind the caudal
region, execute a smooth broad target redirect, and cross the capture circle
without a collision, exit, or instability. There is no sampled semantic
failure; the weaker score is an informative terminal-control comparison rather
than a different trajectory topology.

The numeric histories separate the policies near the target. Below `1.75L`,
the assigned parent remains at the acceleration envelope for about `65.9%` of
anterior and `50.8%` of posterior samples and ends at speed `1.120U`. The
zero-bend hold ends at `1.024U` and lowers those fractions to `30.9/37.7%`, but
arrives `0.011T` later. Selective closing-gated wave relief preserves mean
steering, ties the earliest `16.258T` capture, ends at `1.047U`, and has the
best sampled score. Thus the established route and coherent carrier should be
preserved; the remaining opportunity is role-selective terminal unloading, not
more curvature, a shifted anterior equilibrium, or beat-scale yaw feedback.

## Candidate hypothesis

Keep the assigned parent's speed-reliable target-versus-course redirect and
mean-priority posterior acceleration allocation intact. Add one continuous
approach mechanism: use normalized body-frame target distance and target-aligned
body velocity to gate damping of the anterior oscillation and attenuation of
the posterior wave, while leaving posterior mean curvature intact. This should
leave the far-field wake and route unchanged, retain capture, and reduce
terminal carrier effort without the zero-bend hold's loss of directional bend.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological terminal approach
source_mechanism: feedback-conditioned modulation of rhythmic drive while preserving a separate directional command
transferable_invariant: unload the oscillatory carrier only when proximity and positive closing agree, while retaining the slow steering channel
nontransferable_details: published gains, species-specific envelopes and braking kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: gate joint-state damping and posterior-wave attenuation with normalized body-frame target distance and target-aligned velocity; retain the parent's posterior mean curvature and redirect allocation
falsification: reject if pre-approach motion changes, capture is lost or delayed materially, mean steering is weakened, joint/load relief disappears, or loss of closing fails to restore the full carrier

