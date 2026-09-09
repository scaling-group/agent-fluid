# Wake-policy candidate notes

## Evidence diagnosis before policy edit

- The assigned parent is the common naive state-feedback oscillator. The sole sampled solver is therefore both the best finite example and the most informative failure available; no inherited `logs/optimize/` evidence is present to support a finer comparison.
- The direct-uniform initialization contract holds: diagnostics report `U_infinity=(0,0,0)`, `uniform_direct`, no prewarm, and no cylinders. Motion and wake production are therefore self-generated rather than background advection.
- In the top-down sheet, a compact alternating wake appears by 2--3 T and grows into a coherent but sharply curved wake by 8 T. The fish makes only a small target-directed displacement before curling upward; the target remains far to its lower-left as the swimmer approaches the upper boundary.
- The oblique Lambda2 sheet confirms a three-dimensional alternating wake behind the caudal region at 4--8 T. It does not show passive translation through a pre-existing flow; it shows a propulsive gait coupled to a large planar yaw excursion.
- Metrics agree with the visual diagnosis: distance improves from 12.3277 L to only 12.0694 L, then worsens to 12.3647 L; center x advances 0.9405 L toward the target while center y drifts 1.2011 L away, ending in `left_domain` at 8.5965 T through the upper virtual boundary. Heading spans -1.186 to 0.602 rad, and the 260 deg/T joint-rate limit is reached on both joints (17 and 30 samples), so the failure is not absent actuation.
- The initial normalized body-frame target is approximately `(-12.18, 1.90)L`, or a bearing of +0.155 rad (8.9 deg). The seed never reads that observable. The evidence supports adding target-directed mean curvature before attempting wake rejection; local-flow and load feedback lack a comparative scale in this one-rollout sample.

## Candidate hypothesis

Preserve the demonstrated state-only Van der Pol drive and lagged posterior target, but add one bounded mean-curvature mechanism: map normalized body-frame bearing through a smooth saturation to a joint-acceleration bias, with a smaller posterior share. This should turn the mean gait toward the target while retaining the traveling bend and avoiding a route, clock, or fixed world direction. It is falsified if the fish retains the same upper-boundary exit topology, gains no material closest-distance improvement, loses coherent propulsion, or increases sustained joint-limit contact.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and mean tail-beat bias
source_mechanism: sensor-driven bounded average curvature superposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error may modulate mean curvature while the oscillatory traveling bend remains the propulsion carrier
nontransferable_details: published gains, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: smoothly saturate normalized body-frame bearing into one acceleration bias shared across the two joints while preserving the seed oscillator and posterior lag
falsification: reject if distance progress and termination topology do not improve, or if wake coherence, horizon, or joint-limit occupancy deteriorates
```

## Dry validation (not rollout evidence)

The mandated policy contract and editable-boundary checks pass. Reflected
joint state and bearing produce exactly reflected accelerations for sampled
bearings from -1 to +1, and all outputs are finite. A 10 T joint-only probe at
fixed initial bearing +0.155 rad shifts late mean curvature in the requested
direction and does not expose a new limiter problem: compared with the same
probe at zero bearing, acceleration-clamp events fall from 1387 to 1083 and
rate-clamp events from 91 to 50. This probe contains no hydrodynamics and is
only a controller sanity check; the post-worker CFD must decide the stated
distance, termination, wake-coherence, and saturation falsifiers.
