# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled and inherited rollout used direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  Motion in the top-down and oblique rows is therefore self-propulsion, not
  ambient advection or a reused-flow artifact.
- Both rows of the combined sheets were inspected for the assigned parent
  `solver_6b0e320e2f55`, the other sampled captures, and the informative
  joint-speed-governor failure. The three byte-identical speed-reserve runs
  captured at `0.74796--0.74939L` in `18.205--18.601T`. Each lays down a
  coherent alternating top-down street and compact three-dimensional Lambda2
  structures through capture, but their terminal paths span above-target,
  centered, and below-target crossings. The mechanism is repeatable under the
  sampled solver variation, while the trajectory remains sensitive.
- The inherited hard governor is negative evidence against projecting the
  combined carrier-plus-steering command at the joint-speed boundary. Its wake
  remains alternating and self-propelled, yet it passes below the target at
  `1.38772L`, turns sharply away, and exits the lower boundary. The inherited
  nested-saturation allocator similarly missed at `1.42919L`. Missing thrust
  or an incoherent wake is not the differentiator.
- The assigned parent is the most marginal of the repeated captures: at its
  crossing, projected miss is about `0.729L`, approach alignment only `0.230`,
  and the bounded turn command remains approximately `+1`. The other two
  reserve captures enter with projected misses near `0.059L` and `0.243L` and
  stronger approach alignment. Thus the difficult branch still needs the
  existing reserve, but compatible branches need not sacrifice carrier effort
  when response logic has already released the steering residual.
- A recorded-trace projection (diagnostic, not CFD) multiplies the existing
  reserve relief by normalized requested steering magnitude
  `abs(turn_command) * (1 - release)`. Across the three repeated captures it
  retains the strongest tail reserve on the difficult branch while reducing
  integrated tail relief from `11.31` to `6.10`, versus `11.48` to `1.39` on
  the most compatible branch. It changes no behavior outside the existing
  terminal gate and never alters restoring carrier effort.

## Candidate mechanism and falsification

Start from the assigned parent's repeatable speed-reserve controller. Preserve
its joint-state traveling bend, cadence, achieved-course outer loop,
phase-compensated yaw response, LOS/projected-intercept guards, additive
steering, and all actuator limits. Couple only the existing outward-carrier
relief to the normalized steering residual actually requested after response
release. Full reserve remains available when terminal target feedback demands
a saturated turn; when the target feedback has released steering or requests
almost no turn, the carrier remains active. This tests feedback-coherent
allocation without a clock, world route, new authority, or total-command speed
projection.

Expected test: retain capture and the coherent alternating wake on the
near-miss-like branch, while preserving more carrier on compatible approaches
and matching or improving the `18.205--18.601T` arrival range without raising
speed residence, acceleration clamping, or hydrodynamic loads.

Falsification: reject demand-conditioned reserve if any repeat loses capture,
the terminal wake weakens, the closest pass is worse than the inherited
`1.0509L` intercept reference, arrival slows materially, the same lower-exit
topology returns, or joint-speed/clamp residence and loads increase. If it
fails while the unconditioned reserve continues to capture, later workers
should keep the unconditioned carrier-only reserve and avoid further terminal
allocation layers until a stronger state discriminator is evidenced.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: preserve an established rhythmic carrier while a bounded sensor-driven steering residual receives only the actuator reserve it currently requests
transferable_invariant: limited carrier relief should be coherent with normalized target-feedback demand rather than globally suppressing an otherwise productive traveling bend
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact beat or vortex phase, learned routes, and task-specific paths
policy_translation: retain the two-joint intercept/reserve controller and multiply only its terminal outward-carrier relief by the magnitude of the body-frame steering residual after response release
falsification: reject if capture repeatability, wake coherence, or arrival degrades, or if speed/clamp residence and loads increase relative to the repeated unconditioned reserve

## Non-CFD verification

- The required guidance-provenance, Julia policy-contract, parameter-schema,
  and solver editable-boundary checks pass. The policy returns two finite
  accelerations within the configured envelope.
- Deterministic Julia probes confirm bit-exact inheritance from the assigned
  parent outside the terminal gate, lateral-reflection equivariance to below
  `1e-11`, and finite bounded output over a grid of distance, target side,
  lateral speed, joint angle, and joint-speed extremes.
- These checks establish implementation semantics only. No CFD was run, and
  no improvement is claimed for this unevaluated candidate.
