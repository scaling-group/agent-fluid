# Low-speed posterior-wave recovery candidate

## Evidence diagnosis before the policy edit

- The assigned parent and two additional current examples are source-identical
  captures. Each uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, forms a coherent wake, reaches the target at
  `16.054371T` after 2,919 steps and 239 moving-window shifts, crosses at
  `0.745845616L`, integrates `1.929839552L` distance, and scores
  `-0.046899933`. Repetition establishes determinism, not a new trajectory.
- I inspected the combined sheets for the assigned parent, the strongest
  finite current sample, and the inherited yaw-separated response regression.
  Their top-down rows show the initially quiescent release growing into an
  alternating, reverse-street-like wake while the fish self-propels along a
  smooth target-directed arc. Their oblique body/Lambda2 rows show compact,
  organized three-dimensional caudal structures advecting behind that arc.
  None shows wake collapse, collision, virtual-boundary approach, or
  out-of-plane instability. No failed-termination keyframe sheet is available
  in this workspace; the yaw-separated sample is the informative failed
  improvement, preserving the wake and capture but regressing to
  `0.745862067L`, distance integral `1.929853434L`, and score `-0.046917101`.
- The only non-clone current solver changes feasible action at route scale. It
  smoothly adds at most 25% to the posterior traveling-wave target below
  `0.35U` measured body-frame forward speed and is inactive in the established
  approach. It preserves capture and the coherent two-view wake while
  improving arrival to `15.977511T`, the crossing to `0.744402707L`, distance
  integral to `1.928580797L`, score to `-0.045506315`, and shifts to 238.
- That result does not validate a simple faster-launch story. Its `8L` and
  `6L` milestones are slightly later (`9.0915/11.0550T` versus
  `9.0750/11.0440T`), the `4L` and `2L` milestones are unchanged at trace
  resolution, and the improvement appears at `1.25L` and capture. Mean
  posterior command rises from `24.5845` to `25.4727 rad/T^2`, posterior
  acceleration-limit residence from `21.79%` to `22.58%`, and peak lateral
  force from `0.03239` to `0.03334`; posterior excursion falls from `36.43`
  to `33.12 deg`, peak axial force falls from `0.02485` to `0.02328`, and peak
  yaw moment is effectively unchanged. The mechanism is therefore supported
  as a bounded low-speed route perturbation with a better terminal state, not
  as evidence that arbitrary amplitude or frequency gain improves thrust.
- The inherited route-wide line-rate residual remains the decisive negative
  boundary: it kept a visually coherent wake but missed capture at
  `0.785816L`, curled away, and exited at `29.293T` with final distance
  `9.122L`. The current yaw-separated terminal response likewise changes only
  terminal-scale action and slightly regresses. Preserve the established
  steering, redirect, approach, and terminal response instead of widening or
  retuning those branches.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: preserve the anterior rhythmic carrier while allocating bounded posterior traveling-wave emphasis from measured locomotor response
transferable_invariant: a two-joint swimmer can change route-scale hydrodynamic response by emphasizing the lagged posterior wave without replacing the anterior rhythm or target-directed mean bend, and feedback should release that emphasis when measured forward response recovers
nontransferable_details: published reactive-force gains, species-specific amplitude envelopes, dimensional frequencies, exact Strouhal values, clock-defined burst durations, exact vortex phase, and task-specific trajectories
policy_translation: retain the evaluated anterior oscillator and every steering, redirect, wave-relief, approach, terminal, allocation, and actuator-projection role; outside approach only, use normalized body-frame forward speed to smoothly scale the posterior traveling-wave target above unity at weak response and return exactly to the parent carrier by the evidenced recovery speed
falsification: reject the transfer if the coherent alternating wake or capture is lost, the parent steering topology changes adversely, the crossing and distance integral do not reproduce their benefit, or the added posterior effort and lateral load persist without a better finite route; do not infer generic propulsion benefit unless earlier speed and distance milestones also improve

## One candidate hypothesis

Adopt exactly one controller mechanism from the strongest sampled solver: a
bounded, continuous posterior-wave recovery gate. At valid normalized
body-frame forward speed at or below `0.10U`, the posterior traveling-wave
target receives at most 25% extra amplitude; the increment fades smoothly to
zero by `0.35U` and is suppressed continuously by approach proximity. Because
the gate is state feedback, it can reopen after genuine locomotor-response
loss without using time, step count, target identity, a world-frame route, or
external vortex phase. The anterior carrier, target-directed mean curvature,
response-gated redirect, one-sided wave relief, approach settling, terminal
line-of-sight response, mean-first posterior allocation, and exact
velocity-boundary projection remain byte-for-byte unchanged.

This is a controlled exploitation and reproducibility test of the sole
evaluated route-scale positive in the current sample, not a new gain sweep.
The falsifiable expectation is the same coherent two-view wake and capture
topology with a materially different route from the assigned parent and a
reproduced improvement in capture time, crossing, and distance integral.
Earlier distance milestones and posterior effort remain explicit countermetrics:
failure to improve them means the mechanism should continue to be described as
route shaping rather than faster propulsion. The new CFD outcome is not
available to this worker and is not claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `f915d466444cf8efad27707431c558749510254354be3998c294348dbb001f25`,
  byte-identical to the strongest evaluated current sample and distinct from
  the assigned parent's `650a2d0d...b2e6e2`. This confirms that the intended
  controlled adoption, rather than an accidental recombination, is staged.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  checks were therefore executed directly and separately: guidance
  materiality, the lightweight Julia policy contract/schema, and the solver
  editable-boundary check all pass. The Julia contract returns two finite
  accelerations for the full smoke observation; no CFD was run.
- The candidate contains 51 unique direct `params.FIELD` references, including
  all three recovery fields returned by `target_policy_params()`. The candidate
  remained non-empty throughout the edit and no solver file outside the
  permitted target-policy path was changed.
