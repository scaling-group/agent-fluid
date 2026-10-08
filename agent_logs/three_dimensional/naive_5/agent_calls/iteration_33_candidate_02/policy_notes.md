# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial
  moving-window transport. All capture, so arrival, distance integral,
  actuator/load exposure, trajectory topology, and wake coherence distinguish
  them more usefully than termination or first-crossing distance alone.
- Both rows of all four combined keyframe sheets were inspected from release to
  capture. Their top-down views show genuine self-propulsion, a regular
  alternating traveling wake, and the same shallow late hook into the target.
  Their oblique Lambda2 views show a compact coherent three-dimensional wake
  through capture. None shows passive advection, wake breakup, boundary
  interaction, instability, or moving-window-induced rotation. The images do
  not support a new carrier, stronger gait, or another terminal waveform.
- The sampled posterior course-slip policy is the strongest scalar result: it
  captures at `0.748361L` and `26.1635T`, scores `-0.607211`, and has mean
  distance `2.509866L`. Relative to the translation-consistent comparison, its
  distance improves from `10.4619/6.2320/1.8911L` to
  `10.4512/6.1888/1.8102L` at `8/16/24T`. This supports retaining its bounded
  upstream posterior wave-shape allocation.
- The assigned route-priority parent preserves that upstream result, suppresses
  an opposing anterior target-line residual during middle approach, and
  captures `0.0440T` earlier at `0.748769L`. It improves the sampled
  posterior policy's distance at `22/24T` from `2.89287/1.81024L` to
  `2.88851/1.80642L`, but mean distance changes by only `0.000003L` and score
  is slightly worse (`-0.607378`). Its top-down and oblique sheets retain the
  same route/wake family. Withdrawing the conflicting anterior request has a
  favorable finite arrival signal but no semantic improvement by itself.
- Instantaneous force commutation is the informative failure. Modulating the
  same upstream posterior vectoring from velocity-cross-force response arrives
  at `26.0920T`, but worsens mean distance to `2.512198L`, worsens score to
  `-0.609997`, and crosses only `0.0000815L` inside capture. All samples remain
  below the angle/rate/action envelopes and the force-gated sheet shows no new
  useful topology. Thus the new candidate must not retune the force scale or
  use instantaneous load to choose a beat phase.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, large-bearing
redirect, line-of-sight positive-deficit response, upstream course-slip tail
vectoring, route-priority conflict gate, capture-scale posterior term, common
acceleration projection, and angle/rate viability guards. Add one compact
middle-approach actuator-allocation mechanism: when the existing normalized
geometry and response gates withdraw an anterior target-line half-cycle because
it opposes the direct route request, redirect a bounded fraction of that
conflict into the already evidenced route-side posterior wave shape. This
bridges the upstream posterior vectoring to the middle approach without force
phase sensing, a carrier-gain increase, or a coordinate/time route. Agreement,
far travel, adequate response, non-closing motion, and redirect-dominated
states pass through exactly; the established approach gate also withdraws the
transfer before the capture neighborhood.

The falsifiable expectation is a coherent, limit-free capture with a real
middle-route separation: improve arrival or mean distance beyond the assigned
parent while keeping peak planar force/yaw moment within its sampled
`0.01944/0.00987` envelope. Reject the mechanism if capture is lost, the
alternating wake degrades, actuator contacts return, loads rise, or the result
again stays in the milliscale-equivalent shallow-hook cluster. A rejection
would argue against transferring opposed anterior authority into the posterior
joint on this carrier; later workers should then seek a genuinely slower
course-response observation rather than tune this allocation fraction.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and elongated-body reactive propulsion
source_mechanism: sensory feedback reallocates steering across a persistent rhythmic carrier while posterior wave shape supplies reactive course authority
transferable_invariant: when a measured steering response conflicts with target-directed course geometry, preserve propulsion and move bounded authority to the actuator channel already shown to improve translational course
nontransferable_details: published gains, robot linkage geometry, species envelopes, clock phase, dimensional frequencies, exact vortex phases, and prescribed routes
policy_translation: normalized body-frame distance, closing speed, course observability, target-line response deficit, and request-side conflict transfer a bounded route-side command from the anterior half-cycle to posterior joint-state-phased wave shape
falsification: reject on lost capture or coherent three-dimensional propulsion, no meaningful middle-route separation, any actuator contact, or force and yaw moment above the sampled parent envelope

## Non-CFD implementation audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 51-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the guidance semantic check and solver editable-boundary
  check pass.
- In a deterministic 20,000-state stress grid, 829 states exercise the new
  allocation, all commands remain finite and within `30 rad/T^2`, and paired
  lateral reflections have zero numerical command error. Synthetic far,
  target-line/route agreement, and `0.8L` terminal states exactly reproduce the
  assigned parent; an active middle-conflict state changes only joint 2.
- Reconstructing body-frame inputs over all 4,749 rows of the assigned-parent
  trace changes 540 post-guard command pairs, including 312 by more than
  `0.01 rad/T^2`. Activation is confined to about `19.971--25.339T` and
  `3.992--1.101L`, the largest command separation is `0.41954 rad/T^2`, and
  the reconstructed peak command remains the parent's `29.72437 rad/T^2`.
  This verifies bounded, material middle-route activation and capture-neighborhood
  pass-through; it is not CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Its three configured checks were run directly
  and pass. No formal CFD was run.
