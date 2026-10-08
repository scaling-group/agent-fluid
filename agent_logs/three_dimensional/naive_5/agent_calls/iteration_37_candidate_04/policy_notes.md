# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
  inertial moving-window transport. All terminate in capture with zero angle,
  speed, or applied-acceleration contacts. This iteration therefore compares
  route response, arrival, wake organization, and loads rather than success
  class alone.
- I inspected every combined sheet in both the top-down vorticity/body row and
  the oblique body/Lambda2 row, including the highest-score force-qualified
  sample (`solver_64a9b2cc44b2`), the assigned moment-qualified parent
  (`solver_aadb9456cac4`), and the weakest-score but still successful
  posterior-recovery sample (`solver_2515fae158ed`). Each fish visibly
  self-propels from rest, sheds an orderly alternating wake, retains compact
  three-dimensional vortices, and reaches the target through the same shallow
  late hook. None shows passive advection, a broad wasteful curl, wake breakup,
  boundary interaction, numerical instability, or moving-window-induced body
  rotation. There is no sampled termination failure; the weakest within-cluster
  capture is the available informative mechanism-failure comparison.
- The inherited logs proposed velocity-normal force as a distinct fast
  course-response gate after posterior phase, sideslip, and yaw-moment
  corrections repeatedly retained the same path. That test is now completed.
  Relative to the assigned parent, the force-qualified policy improves arrival
  from `25.8885T` to `25.8115T`, mean distance from `2.496543L` to
  `2.496011L`, and score from `-0.594366` to `-0.594050`, but crosses at only
  `0.748308L` versus `0.748000L`. Both traces are identical through `18T`; at
  `20/22/24T` their projected misses remain approximately
  `2.897/2.084/1.010L` and `2.893/2.113/0.996L`. The combined visual sheets
  retain the same middle path and late hook. This is a finite fixed-pose
  tie-break, not the hypothesized integrated course or semantic improvement.
- The other response allocations confirm the cluster. The combined posterior
  half-cycle plus moment residual reaches `25.8280T/2.496475L`, and the direct
  posterior half-cycle reaches `25.9105T/2.497000L`; all four share peak joint
  angle/rate/action near `0.7635 rad`, `4.5150 rad/T`, and
  `29.6581 rad/T^2`, peak planar force/yaw moment within
  `0.01891--0.01910/0.01009--0.01014`, zero actuator contacts, and one visible
  route family. Therefore another additive-force gain, load threshold,
  posterior phase, or terminal-clearance retune is unsupported.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, course/miss-
triggered response-released redirect, target-line response, upstream posterior
vectoring, terminal tail modulation, coordinated acceleration projection, and
angle/rate viability guards. Replace only the inconclusive additive
yaw-moment residual with one response-selective yielding mechanism. Body-frame
target and velocity geometry continue to own the route side. In the closing
middle corridor, phase-rejected persistent course error qualifies the need for
correction, while adverse velocity-normal force is only a fast response
selector. On those adverse response phases, smoothly reduce both joint
commands by the same bounded factor; helpful force and all unqualified states
pass through exactly. Common-mode yielding preserves the anterior/posterior
command ratio while changing the fraction of each beat spent reinforcing an
adverse course impulse, rather than adding another competing steering pulse.

The falsifiable expectation is an integrated reduction in projected miss or a
visibly different useful middle route, while retaining capture, coherent wakes,
zero actuator contacts, and no increase over the sampled
`0.01910/0.01014` planar-force/yaw-moment regime. Reject the mechanism if it
merely reproduces the shallow milliscale cluster, reduces target progress by
weakening thrust, distorts the traveling bend, cancels helpful force, loses
capture, or increases load or limit exposure.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG duty-ratio control and wake-interaction swimming
source_mechanism: redistribute actuation exposure across response-qualified parts of a propulsive cycle while preserving the traveling-wave carrier and useful wake motion
transferable_invariant: geometry owns route direction, while a bounded fast response signal may make the coordinated carrier yield on only the cycle portions that reinforce adverse motion
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, clock phase, exact vortex phase, source wake geometry, and prescribed routes
policy_translation: normalized body-frame target/course geometry and closing distance qualify correction; adverse velocity-normal force smoothly scales both two-joint commands together inside the middle corridor, with joint-state feedback retaining the carrier
falsification: reject on unchanged integrated course response, slower or lost capture, loss of wake coherence, helpful-response cancellation, actuator contact, or peak force and yaw moment above the sampled regime

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 62-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the deterministic schema comparison finds neither a
  missing nor an inactive controller parameter.
- A deterministic 50,000-state grid spanning lateral reflections, far/near and
  fore/aft target geometry, adverse/helpful/zero force, negative/zero/positive
  closing response, and beyond-limit joint angles and rates remains finite and
  inside the `30 rad/T^2` policy envelope. Paired lateral reflections have zero
  numerical command error.
- Re-evaluating the assigned parent and candidate on 4,707 reconstructed parent
  trajectory states changes 470 post-guard command pairs, including 225 by
  more than `0.05 rad/T^2`; the maximum separation is
  `2.64381 rad/T^2`. Activation is confined to `19.063--24.734T` and
  `4.408--1.309L`, while far travel and the inner capture approach pass through.
  This establishes a material, bounded middle-response mechanism test, not CFD
  evidence of improvement.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account. Its three
  prescribed checks were run directly: material guidance/notes, the lightweight
  Julia public contract, and the solver editable boundary all pass. The first
  guidance run exposed two copied-parent markers in the rendered `README.md`;
  retaining exactly one marker repaired the ambiguity without changing the
  assigned parent or evidence. No formal CFD was run.
