# Sampled speed-viability promotion

## Evidence read before editing

- The assigned parent guidance and inherited worker log leave the prefilled
  line-of-sight-response controller with its two-joint stopping-margin angle
  guard as the capture-preserving baseline. The log proposes a separate speed
  guard, and the sampled `solver_f269448a491b` evaluation supplies the completed
  CFD evidence needed to judge that proposal rather than treating it as an
  unevaluated hypothesis.
- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and moving-window transport
  that preserves inertial coordinates. Three byte-identical executions of the
  angle-guard parent capture at `0.749992L` and `27.7695T`; the sampled speed-
  guarded descendant captures at `0.749366L` and `27.5770T` with a slightly
  better mean distance (`2.612789L` versus `2.615460L`). Duplicate parent runs
  establish fixed-condition determinism but not trajectory diversity.
- Both unique combined keyframe sheets show self-propulsion from rest, an
  organized alternating top-down wake, coherent oblique Lambda2 structures,
  continuous target-directed translation, and the same late correct-sign turn
  into the capture circle. The wake trails the body as the storage window
  follows it; there is no visual sign of imposed-flow advection or a window
  artifact. No sampled failure sheet is present. The inherited failure digest
  therefore remains the available contrast: terminal waveform, recoil,
  damping, and instantaneous-intercept variants retained coherent wakes but
  missed at `0.828--1.096L` and exited left.
- The speed guard eliminates all exact `260 deg/T` contacts from the parent's
  `1124/10098` joint samples, preserves zero `45 deg` angle contacts, and trims
  acceleration-clamp exposure from `1700/10098` to `1686/10028`. Peak planar
  force changes only from `0.022123` to `0.022180`, while peak yaw moment falls
  from `0.010414` to `0.010343`. Maximum joint speeds become `259.63` and
  `258.03 deg/T`, so the result is genuine hard-envelope clearance rather than
  a relabeled cap contact. Its combined visual route stays coherent and capture
  occurs `0.1925T` earlier.
- A separately sampled stronger fixed-brake rate barrier is less useful: it
  leaves 34 exact speed contacts, increases acceleration-clamp samples to 1725,
  raises peak planar force/yaw moment to `0.02418/0.01124`, and scores worse at
  `-0.715374` despite capture. That negative comparison argues against scalar
  strengthening of the speed brake.

## Policy hypothesis

Promote exactly the sampled `solver_f269448a491b` speed-viability mechanism
onto the prefilled angle-guard controller. Preserve the traveling-bend carrier,
posterior allocation, body-frame target/course selector, same-sign redirect,
terminal miss veto, positive line-of-sight response-deficit branch, and angle
stopping guard without retuning. For either joint, only when observed angular
speed is inside the final `10 deg/T` of the hard envelope and the combined
command would accelerate still farther in the same direction, smoothly blend
that worsening component toward bounded opposite acceleration. Leave all
sub-band and speed-reducing commands unchanged, and use the same signed
construction on both joints to preserve lateral reflection equivariance.

The falsifiable expectation for reevaluation is deterministic repeat capture
with the coherent route, zero angle and speed contacts, and no increase in
acceleration clipping or load exposure. Reject the promotion if it loses
capture, changes ordinary sub-band motion, creates soft-boundary chatter, or
restores any joint/load defect. The current worker does not claim its later CFD
result; the evidence above belongs to the already completed sampled rollout.

bookshelf_consulted: true
source_domain: sensor-modulated rhythmic robotic-fish control and finite-envelope feedback for traveling-wave propulsion
source_mechanism: preserve a productive state-feedback rhythm while a bounded residual intervenes only when measured actuator motion consumes the remaining physical envelope
transferable_invariant: constraint feedback should be reflection-equivariant, inactive during viable traveling-bend motion, and oppose only the command component that worsens normalized measured headroom
nontransferable_details: published gains, dimensional frequencies, species-specific joint limits and kinematics, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the body-frame two-joint target-line controller and angle stopping guard, then apply the same smooth near-speed-limit command-direction gate to each observed joint so only speed-increasing acceleration is replaced by bounded braking
falsification: reject if repeat capture or coherent propulsion is lost, any sub-band or speed-reducing phase changes, exact speed contact returns, or angle contact, acceleration clipping, force, or yaw moment increases

## Non-CFD implementation audit

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then run
  directly and separately. After removing one duplicate rendered assigned-
  parent marker from the workspace `README.md`, the guidance semantic-delta
  and deterministic parameter-schema check passes, the Julia contract returns
  two finite accelerations, and the solver editable-boundary check passes.
- The final candidate SHA-256 is
  `630283dcc05309a84219b6a9d1f28aac4aa6a8b5cb201e13cabd6ac7c95009a2`,
  byte-identical to the completed sampled speed-guard rollout. This establishes
  faithful promotion only; the new formal CFD evaluation still occurs after
  this worker exits.
