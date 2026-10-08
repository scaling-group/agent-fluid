# Approach-relieved redirect-allocation candidate

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the Phase 2 evidence contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite dynamics, and inertial moving-window
  transport. Their motion is self-propelled rather than imposed advection.
- I compared both rows of the combined sheets for the best-scoring capture,
  `solver_a5dc27216aa2`, with the inherited non-capture
  `solver_c0ba6ee601b1`. Both top-down rows develop an alternating red/blue
  caudal wake and both oblique rows show persistent three-dimensional Lambda2
  structures. The failure preserves that wake but curls upward, passes its
  `5.086L` closest point, and exits at `19.201T`; the sampled captures instead
  follow a sustained down-left course and cross the `0.75L` target boundary
  near `16.26T`. The semantic improvement is response-gated steering, not
  advection or a replacement propulsion gait.
- The four sampled descendants isolate two compatible improvements around the
  same captured response-gated carrier. Closing-gated partial drive relief has
  the best score (`-0.066121`) and captures at `16.258T`, but it only lowers
  whole-rollout anterior/posterior acceleration-limit residence to
  `48.2%/59.3%` from the unrelieved capture's `49.4%/60.4%`; inside `1.75L`,
  posterior residence is still `64.7%`. Full terminal joint hold reduces
  near-field residence further but slightly delays capture and regresses the
  score to `-0.066867`, so replacing the terminal wave is not supported.
- Redirect-priority posterior allocation independently retains capture at
  `16.258T`, improves score over the unrelieved parent from `-0.067427` to
  `-0.066284`, and cuts whole-rollout posterior limit residence from `60.4%`
  to `22.5%` (near-field `81.6%` to `48.0%`). Its top-down and oblique wake
  remain coherent. This establishes useful action headroom without evidence
  that terminal drive should remain unrelieved.

## Policy hypothesis

Compose the two sibling mechanisms without altering either observation or the
captured response logic: use redirect-priority posterior allocation throughout
the response gate, and retain the best-scoring proximity-and-closing-gated
anterior damping plus posterior-wave relief. The posterior law first tracks
and damps the bounded mean bend, then admits only oscillatory acceleration that
fits the redirect reserve or unloads the mean request. The near-target gate
continues to dissipate excess beat energy without removing mean steering.

This is a small mechanism combination rather than scalar-only gain tuning. It
should retain the alternating three-dimensional wake and capture no later than
about `16.29T`, while moving posterior limit residence toward the sampled
allocation result and avoiding the full-hold score regression. Falsify the
combination if capture is lost, score or arrival materially regresses from the
two parent mechanisms, posterior residence returns near `60%`, the coherent
wake weakens, or force peaks exceed the sampled finite range near `0.039`.

bookshelf_consulted: true
source_domain: biological burst redirection, terminal capture, and sensor-modulated robotic-fish CPG control
source_mechanism: observed response error temporarily prioritizes bounded curvature over the oscillatory wave, while reliable near-target closing continuously relieves excess drive
transferable_invariant: preserve the established traveling bend in cruise, allocate finite actuation to corrective mean curvature when response error is large, and reduce rather than remove propulsion only after proximity and closing agree
nontransferable_details: species-specific maneuvers, published gains and duty ratios, dimensional gait settings, clocked phases, exact vortex timing, morphology-specific torque, and task-specific routes
policy_translation: use normalized body-frame target bearing, body-frame course, target distance, target-aligned velocity, and joint state to gate posterior mean-first acceleration allocation plus bounded approach damping and wave attenuation under the two-joint contract
falsification: reject if coherent self-propulsion or capture disappears, arrival exceeds about 16.29T materially, posterior hard-limit residence remains near 60 percent, sampled force bounds are exceeded, or the full-hold score regression reappears

The candidate has no same-worker CFD result. Only the downstream evaluator can
test the closed-loop combination; local checks are limited to the policy
contract, parameter schema, symmetry, boundedness, and fixed-trace separation.

## Non-CFD verification

- The prescribed guidance-provenance, lightweight Julia policy-contract,
  deterministic parameter-schema, and solver-boundary checks pass.
- A `6,561`-state sweep spanning target distance and bearing, body-frame
  velocity, both joint angles, and both joint rates returns finite bounded
  accelerations and exact sign reversal under lateral reflection.
- On the sampled `solver_a5dc27216aa2` trace, the composed law leaves anterior
  commands unchanged and reduces counterfactual posterior hard-limit residence
  from `59.3%` to `22.5%` overall and from `64.7%` to `30.6%` inside `1.75L`.
  This verifies actuator-role separation on fixed states only; it does not
  predict the downstream closed-loop path or establish capture retention.
- No formal CFD rollout was run in this workspace.
