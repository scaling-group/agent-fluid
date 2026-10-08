# Boundary-layer joint-speed viability candidate

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract and
  terminate in capture. `solver_bb2a1c7cb2a0` and
  `solver_ba8bbe9216df` are byte-identical high-knee soft-envelope policies;
  they are one physical result, not two independent mechanisms. They provide
  the strongest finite reference: capture at `16.943T`, mean distance
  `2.08985L`, peak fish speed `1.39290U`, peak local flow `0.03249U`, and
  force/moment peaks `0.03609/0.01766`. The very small local-flow/fish-speed
  ratio confirms self-propulsion rather than still-water advection.
- The assigned-parent global stopping-risk controller
  (`solver_8a4031ae8f39`) also captures, but later at `18.276T` with mean
  distance `2.13496L`; its requested accelerations reach
  `59.87/88.41 rad/T^2` and exact joint-speed-limit occupancy is about
  `4.81/2.68%`. The high-knee shoulder removes acceleration exceedance while
  retaining the route and improves the arrival and load evidence.
- The sampled broad joint-speed viability controller
  (`solver_ad0be852cd7b`) proves that speed protection can preserve capture and
  remove exact speed-limit contact: maximum joint speeds fall to
  `4.3968/4.4189 rad/T`, below the `4.5379 rad/T` limit. It is not a free
  improvement. Peak fish speed falls to `1.32766U`, arrival regresses to
  `17.435T`, and mean distance rises to `2.11127L`. Its linear admissible-
  acceleration ceiling constrains requests well below the nominal `0.98`
  speed buffer, so it perturbs the useful carrier through a broad part of each
  beat.
- In the combined visual sheets, the best high-knee capture retains a clean
  alternating top-down vorticity street and compact paired oblique Lambda2
  structures from release through capture. The broad speed-barrier sample
  remains coherent and self-propelled but takes a visibly different terminal
  arc, consistent with the quantitative loss of route speed rather than a wake
  failure. No sampled rollout is a failure termination; the slower assigned
  parent is therefore the informative inferior comparison.

## Policy hypothesis

Start from the demonstrated high-knee soft-envelope controller. Add a
directional, C1 joint-speed viability projection only inside a normalized thin
shell next to the speed boundary. Acceleration is unchanged below the shell;
inside it, the admissible outward request blends to mild inward braking at the
hard limit without ever weakening an existing reversal. This is a
feedback-structure change, not scalar drive tuning. It should preserve the
low-command identity region, course-error steering, posterior reserve
allocation, global angle viability,
alternating wake, and capture while reducing exact speed-limit occupancy with
less route distortion than the sampled broad linear barrier.

bookshelf_consulted: true
source_domain: robotic-fish CPG/residual control and wake-interaction control
source_mechanism: preserve a rhythmic propulsion carrier and apply the smallest bounded sensor-feedback residual needed, rather than damping all lateral motion
transferable_invariant: constraint correction should be state-triggered, directional, normalized, and inactive through the demonstrated useful carrier regime
nontransferable_details: published CPG gains, robot-specific duty ratios, species kinematics, exact vortex phase, dimensional speed bands, and task routes
policy_translation: use normalized absolute joint speed to gate a C1 outward-acceleration projection near the owned speed limit without weakening inward acceleration, while retaining the two-joint state-feedback oscillator
falsification: reject if capture, the 16.943T route, alternating 3D shedding, or the 0.0361/0.0177 load ceiling is lost, or if exact speed-limit occupancy is not materially reduced without shifting motion toward angle or acceleration limits

## Evaluation boundary

Formal CFD is deferred to EvE after this worker exits. This candidate may claim
only the prior evidence and the falsifiable mechanism above, not a new rollout
outcome.
