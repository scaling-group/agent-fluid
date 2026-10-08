# Candidate diagnosis and hypothesis

## Evidence diagnosis before policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations
  with `U_infinity=(0,0,0)`, capture at `19.684490 T`, score
  `-0.261384287`, mean/final distance `2.151092787 L`/`0.748302400 L`, path
  length `12.951133 L`, and `243` moving-window shifts. Their trajectory CSVs
  and combined keyframe sheets are byte-identical. Three policies are the
  identical v40 law; v41 adds a source-level course/yaw selector whose output
  is dormant under the existing terminal allocation floor. This is one
  deterministically reproduced physical behavior, not four demonstrations of
  the v41 mechanism.
- In the top-down row, release grows into a compact, self-propelled approach
  with a regular alternating wake. The fish turns toward and then translates
  directly into the capture circle; there is no passive advection, collision,
  exit, loop, diffuse standing wiggle, or late wake collapse. The oblique row
  shows finite localized Lambda2 structures from the caudal region through
  capture rather than a volume-filling instability. Metrics agree: distance
  falls from `12.327720 L` to capture, joint excursions remain finite at about
  `0.661505/0.530948 rad`, and terminal force/moment maxima are about
  `0.027533/0.015673`.
- The remaining defect is actuator feasibility during the useful traveling
  gait, not missing propulsion or target direction. The reproduced parent has
  `1368/1973` anterior/posterior stored commands above `30 rad/T^2`, including
  `229/302` below `4 L`. Inherited evidence already rejects changing terminal
  posture, startup energy, cadence, mean curvature, or posterior lag: terminal
  response gates regress distance, energy injection bends the route into a
  late sweep, cadence relief delays every mature crossing, and lag shortening
  produces a large loop with paired vorticity bands.

## Policy hypothesis

Test one phase-preserving posterior-follower mechanism. Preserve the sampled
oscillator frequency, amplitude, mean curvature, derivative-defined lag
target, residual allocator, and full terminal handoff. Outside `4 L`, after
positive target closure and established body-frame translation speed, require
raw drive overload, independent-clipping direction distortion, normalized
posterior tracking error, posterior velocity that is already closing the
unchanged target, and a same-direction stiffness request. Only then release a
bounded share of the posterior stiffness term; retain its damping term. This
is an upstream response-conditioned follower handoff, not a gain-only cadence
edit or a posterior phase rewrite.

Expected test: the gate must be independently active in the mature outer gait,
reduce redundant saturated posterior correction, and preserve or advance the
`8/4/2 L` crossings and `19.684490 T` capture without changing the compact
route, alternating top-down wake, finite oblique structures, or terminal
commands. Falsify it if it is dormant, slows any mature crossing, increases
excursion/clipping/load, changes the outer topology, introduces a loop or joint
stop, loses capture, or degrades either wake view.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG follower modulation, interpreted through traveling-wave and elongated-body propulsion
source_mechanism: sensor-conditioned response of a posterior oscillator that follows an anterior bend with phase lag
transferable_invariant: preserve a directed posterior-lagged traveling bend, while conditioning follower effort on measured phase-target error and whether the follower is already moving to close it
nontransferable_details: published CPG gains, clock phase, species kinematics, full-body amplitude envelopes, exact Strouhal values, and task-specific routes
policy_translation: use normalized joint error and joint velocity plus body-frame range closure; release only the posterior stiffness contribution under simultaneous outer overload and clipping-direction distortion, without changing the lag target, cadence, mean bend, or terminal controller
falsification: reject dormant activity or any slower mature crossing, worse distance integral, changed compact route, renewed joint-stop or load growth, loop, lost capture, or degradation of the alternating top-down and localized oblique wakes
```
