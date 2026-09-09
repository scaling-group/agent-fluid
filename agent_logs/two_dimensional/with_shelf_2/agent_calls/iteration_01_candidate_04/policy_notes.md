# Multi-Wake Candidate Notes

## Inherited evidence

- The only sampled solver is the common naive seed (`score=-14.294201`,
  `termination=left_domain`); no inherited optimizer notes or evaluated
  non-seed candidates are present in this first-generation workspace.
- The shared prewarm sheet shows the common held fish at the upper-right
  release point and a fully developed, interacting four-cylinder wake before
  release. This is initial-condition evidence, not candidate-specific credit.
- In the released sheet the fish begins approximately aligned with the
  diagonal target direction, but its track curls into a near-vertical descent.
  It crosses the outer downstream wake instead of advancing into the target
  neighborhood and exits through the lower boundary after only `50.1269` time
  units. The active gait and its shed vortices are visible, but the available
  evidence has no passive counterfactual, so it does not isolate active thrust
  from wake advection.
- The trajectory metrics confirm the visual topology: head displacement is
  `(-3.545L, -13.300L)`, minimum distance is only `8.615L`, and final distance
  rebounds to `12.123L`. Both joints reach the acceleration cap
  (`31.416 rad/time^2`) and velocity cap (`4.538 rad/time`), while moment RMS is
  `541.704` and command-energy mean is `1496.247`. Thus a weak acceleration
  correction layered on the seed would have little usable authority.

## Policy hypothesis

The first missing semantic capability is target-locked turning. Preserve the
seed's state-feedback traveling-bend structure, but express body-frame bearing
as a bounded mean-curvature equilibrium for both joints. Moderate the
propulsive rhythm so the joint controller has headroom to move that equilibrium
instead of spending the rollout at the velocity and acceleration limits. This
is one mechanism-level change: target-vector feedback to mean curvature; the
gait rescaling only makes that mechanism executable under the fixed envelope.

Expected evidence is an initially modest corrective bend, sustained diagonal
leftward progress, less extreme vertical displacement, later or non-domain-exit
termination, and reduced cap occupancy/load. Falsify the candidate if the same
downward-exit topology remains, target progress or propulsion collapses, the
turn sign is wrong, or joint acceleration/velocity stays persistently capped.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and fish turning by asymmetric mean body curvature
source_mechanism: modulate a rhythmic locomotor scaffold with a bounded target-error-dependent mean bend
transferable_invariant: persistent body-frame target angular error can shift the mean curvature while the oscillatory traveling bend continues to supply propulsion
nontransferable_details: published gains, robot or species geometry, dimensional beat settings, prescribed CPG phase, exact vortex phase, and task-specific routes
policy_translation: clamp normalized body-frame bearing, map it smoothly to bounded head and tail joint equilibria, and run the existing state-feedback head oscillator and lagged tail follower about those equilibria
falsification: reject if steering has the wrong sign, diagonal target progress does not improve, propulsion collapses, load or cap occupancy remains excessive, or the same lower-boundary exit recurs
