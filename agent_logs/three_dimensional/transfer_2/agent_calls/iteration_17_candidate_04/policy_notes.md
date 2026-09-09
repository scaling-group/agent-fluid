# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled rollouts are valid direct-uniform still-water releases with
  `U_infinity=(0,0,0)`, no cylinders, and capture termination. Their scores span
  `-0.20789` to `-0.19989`, capture times span `19.360T` to `19.552T`, and mean
  distances span `2.08911L` to `2.09701L`; the candidate therefore must retain
  the established capture scaffold rather than solve a missing-success problem.
- In both the strongest `solver_1af6c62469a7` sheet and the relatively weakest
  prefill `solver_1fb0a88ab950` sheet, the fish visibly self-propels from
  quiescent water, turns toward the target, and leaves a coherent alternating
  top-down vortex street with compact three-dimensional Lambda2 structures.
  Neither view shows passive advection, wake breakup, collision, domain exit,
  or instability. Both trajectories finish with a curved approach while the
  final top-down wake becomes elongated paired shear layers as drive is
  relieved. Thus the useful difference is terminal allocation, not a new wake
  class.
- Trace diagnostics agree with the images. The sampled response-gated posterior
  bend is fastest at `19.360T`, has the best mean distance `2.08911L`, and lowers
  mean absolute yaw below `2L` to `0.285 rad/T`, versus `0.349--0.406 rad/T` for
  the two exact lag evaluations and posterior-amplitude variant. Its cost is
  mean absolute commands of `19.25/17.71 rad/T^2`, higher than the posterior-
  amplitude variant's `18.09/17.33 rad/T^2`; peak planar force and yaw moment
  remain in the common approximate `0.023/0.0134` coefficient envelope.
- The two byte-identical lag policies capture at `19.409T` and `19.508T`, while
  inherited parent logs also contain nearby captures with scores `-0.21272`,
  `-0.20571`, and `-0.20065`. Small scalar separations within this topology are
  not enough to establish improvement from one allocation.

## Candidate hypothesis

Use `solver_1af6c62469a7`'s response-gated posterior curvature as the strongest
sampled scaffold. Add one approach-allocation mechanism: as normalized
distance/closing feedback reduces anterior oscillator amplitude, retain a
small bounded fraction of the posterior carrier and lag terms. This should
preserve tail-generated propulsive authority through the visible final
shear-layer regime without changing far-field gait or adding static curvature.
The expected benefit is earlier capture or lower distance integral while
retaining the sampled low terminal-yaw response. Reject the mechanism if it
loses capture, strengthens the terminal hook, raises sub-`2L` yaw, worsens
command-bound residence or joint margin, increases the current force/moment
envelope, or disrupts the coherent top-down/oblique wake.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and classical carangiform body/caudal-fin allocation
source_mechanism: tail-end traveling-wave kinematics retain a disproportionate role in reactive thrust when anterior motion is moderated
transferable_invariant: preserve bounded posterior wave authority instead of relieving both joints identically during a controlled approach
nontransferable_details: published gains, dimensional beat frequencies, species envelopes, full-body waveforms, exact vortex phases, and route geometry
policy_translation: use existing normalized body-frame distance and closing feedback to gate a bounded posterior carrier/lag multiplier while retaining target-vector steering and the two-joint state-feedback oscillator
falsification: reject if capture timing or distance integral does not improve beyond repeat variation, or if terminal yaw/path, command headroom, joint margin, load coefficients, or either wake view regresses
