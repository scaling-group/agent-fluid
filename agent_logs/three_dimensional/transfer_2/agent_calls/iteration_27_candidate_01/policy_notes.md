# Positive-work-only carrier governor candidate

## Evidence diagnosis written before the policy edit

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  moving-window transport, and `capture` termination. There is no semantic
  failure sample in this batch; the informative negative comparison is failure
  to protect actuator headroom and loads while preserving the useful route.
- Both rows of all four combined keyframe sheets were inspected. From blank
  still water, each fish develops an alternating top-down caudal wake and
  compact three-dimensional Lambda2 structures behind the body, turns toward
  the target, and remains self-propelled through capture. None shows passive
  advection, wake breakup, collision, exit, or instability. The visual evidence
  therefore supports preserving the response-aware target scaffold and the
  coupled traveling carrier rather than adding another route or terminal gate.
- The uncancelled-positive-work governor is the strongest finite trajectory:
  it crosses `10/8/6/2L` at `6.496/8.938/11.220/16.027T`, captures at
  `17.688T`, and improves the distance integral to `1.96419L`. The signed-sum,
  dominant-joint, and independently guarded carrier variants capture at
  `17.990--18.111T` with `1.98918--2.00209L` integrals. This matched contrast
  supports aggregation of uncancelled positive carrier work as a useful
  trigger, beyond the earlier repeat spread recorded by the assigned parent.
- That trigger is not yet a successful actuator protector. Relative to the
  dominant-joint and independent guards, it raises anterior residence above
  99% of the `260 deg/T` rate envelope to `12.13%` from `8.44/8.17%`, raises
  peak planar force/yaw-moment coefficients to `0.03198/0.01651` from at most
  `0.02909/0.01498`, and lengthens head path to `12.330L` from
  `12.170/12.281L`. Its current common scale attenuates both full carrier
  commands when either joint performs positive work. Thus positive work at one
  joint can suppress the other joint's negative-work reversal exactly while a
  measured rate is near the envelope, a concrete mechanism consistent with the
  coexistence of faster progress and worse rate residence/load.
- Inherited optimizer notes show the complementary boundary: independently
  guarding each complete joint carrier gave the best rate/load metrics here,
  but previously distorted the traveling relation and now has the slowest
  `18.111T/2.00209L` result with `0.373 rad/T` sub-`2L` yaw. The next test
  should therefore change the energy-setting component of the aggregate
  governor, not tune its scalar threshold or independently clip joint phase.

## One-candidate mechanism and falsification

Start from the evaluated uncancelled-positive-work policy. Retain its normalized
maximum-rate gate and one aggregate positive-work alignment signal. Decompose
each carrier acceleration by the sign of its product with measured joint rate:
apply the single bounded aggregate scale only to positive-work carrier
components, while passing negative-work reversal components and both exact
target-conditioned steering residuals unchanged. When both carriers inject
energy they retain the same scale; when one reverses, the controller no longer
weakens that braking action because the other joint is outward. This is an
energy-direction mechanism, not a gain change, distance stage, or new steering
term.

Expected signature: preserve the coherent wake, early milestone and capture
class of the uncancelled-work parent while reducing anterior/posterior
near-bound residence, outward impulse, and the elevated load/path class.
Falsify it if capture exceeds the guarded `18.111T/2.00209L` envelope without
a material actuator/load benefit, if path exceeds `12.33L`, if joint margin or
terminal yaw regresses, if positive-work residence does not fall, or if either
wake view loses its compact alternating traveling structure. A later repeat is
required before attributing small differences to the decomposition.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and Lighthill-style reactive traveling-wave propulsion
source_mechanism: regulate rhythmic energy from measured actuator response while retaining the posterior-lag traveling bend and independent directional feedback
transferable_invariant: withdraw only observed positive rhythmic work near a normalized actuator boundary; preserve negative-work reversal, the coupled carrier relation when both joints drive, and target-conditioned steering
nontransferable_details: published gains, dimensional beat frequencies, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, actuator models, and task-specific routes
policy_translation: use normalized joint rates plus carrier acceleration-times-rate in the two-joint state; one aggregate uncancelled-work signal scales only each positive-work carrier component, and the existing body-frame steering residuals pass unchanged
falsification: reject if rate residence, outward impulse, load, or path do not improve while early milestones, capture, joint margin, terminal yaw, and coherent top-down and oblique wakes remain in the sampled useful class

## Post-edit non-CFD validation

- The mandated check-runner passes the material-guidance comparison, including
  this note and the reusable lesson distilled into `control_experience.md`.
- The Julia contract check passes with a finite two-acceleration return, and a
  static audit finds every direct `params.FIELD` reference in the returned
  parameter schema.
- The editable-boundary check passes: only the permitted 3D target-policy file
  differs under `solver/`, and no sibling 3D candidate was created. No CFD was
  run; the mechanism and its falsification remain claims for later evaluation.
