# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform, quiescent-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in
  capture. Three byte-identical policy evaluations reproduce the assigned
  angle-stopping-guard parent at `0.749992L` and `27.7695T`; they establish
  deterministic fixed-pose behavior, not trajectory diversity or geometric
  robustness.
- In both the top-down vorticity and oblique body/Lambda2 views, the assigned
  parent and the non-duplicate rate-guard sample self-propel from rest, shed an
  organized alternating three-dimensional wake, maintain the same broad
  target-directed path, and make a late correct-sign hook into the capture
  circle. The wake trails the body through hundreds of inertial window shifts,
  so the translation is not moving-window advection. No sampled failure sheet
  is present; inherited logs instead supply the informative failures, where
  terminal wave, recoil, damping, deeper-curvature, and instantaneous
  projected-intercept variants retained coherent wakes but passed at
  `0.828--1.096L` and exited left.
- The assigned parent has zero angle contacts and peak planar force/yaw moment
  coefficients near `0.02212/0.01041`, but still records `1124/10098` joint
  samples at the `260 deg/T` speed cap and `1700/10098` actions at the policy
  acceleration clamp. The sampled symmetric joint-rate guard eliminates all
  exact speed-cap samples, retains zero angle contacts, lowers acceleration
  clamp exposure to `1686/10028`, and leaves peak force/yaw moment essentially
  unchanged at `0.02218/0.01034`. It also captures earlier and slightly deeper
  (`0.749366L` at `27.5770T`, score `-0.707508`) than the assigned parent
  (`0.749992L` at `27.7695T`, score `-0.709920`). Thus the useful evidence is a
  distinct velocity-envelope correction with capture preserved, not a claim
  that the tiny fixed-pose clearance difference is robust.
- The inherited rate-guard audit established reflection equivariance,
  boundedness, exact sub-band pass-through, and intervention only when the
  combined command would accelerate a near-limit joint farther in its current
  direction. The completed CFD sample now supplies the previously missing
  closed-loop confirmation that this local filter removes rate saturation
  without changing the useful wake topology.

## Policy hypothesis

Promote the sampled rate-viability guard onto the assigned angle-guard parent
without changing the traveling-bend carrier, posterior allocation, body-frame
target/course selector, large-error redirect, terminal miss veto, or positive
line-of-sight response-deficit branch. For either joint, normalized observed
speed in a soft band below the hard rate limit activates a smooth bounded
opposite acceleration only when the current command would increase speed;
speed-reducing commands and all sub-band states pass through. Applying the
same signed construction to both joints preserves lateral reflection
equivariance.

The formal candidate evaluation should replicate capture with the coherent
route, zero angle contacts, and no exact speed-cap residence. Reject the
mechanism if capture is lost, ordinary sub-band gait changes, speed saturation
returns or becomes soft-boundary chatter, or angle contact, acceleration-clamp
residence, force, or yaw moment rises materially. The sampled result supports
this hypothesis; the new candidate's CFD evaluation still occurs only after
this worker exits.

bookshelf_consulted: true
source_domain: sensor-modulated rhythmic robotic-fish control and finite-envelope swimming efficiency
source_mechanism: preserve an effective traveling-wave carrier while bounded observed-state feedback intervenes only at a physical viability boundary
transferable_invariant: constraint feedback should be reflection-equivariant, inactive during viable rhythmic motion, and oppose only the command component that worsens measured loss of actuator headroom
nontransferable_details: published gains, dimensional frequencies, species-specific joint rates and envelopes, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain the body-frame line-of-sight controller and two-joint angle stopping guard, then apply the same smooth normalized near-rate-limit gate to each joint so only speed-increasing acceleration is replaced by bounded braking
falsification: reject if repeat capture or the coherent wake is lost, sub-band or speed-reducing phases change, exact rate-cap residence returns, or angle contact, command clipping, force, or yaw moment increases materially

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were then run
  directly and separately: the guidance semantic-delta/schema check, finite
  two-joint Julia policy contract, and solver editable-boundary check all pass.
- The executable candidate matches the completed sampled rate-guard policy;
  its only textual difference is a more explicit comment on the inherited
  angle guard. Exactly one non-empty candidate exists under `solver/`, and all
  41 direct `params.FIELD` references are owned by `target_policy_params()`.
- A synthetic near-rate-limit state and its lateral reflection produce finite,
  bounded commands that negate to floating-point tolerance. This establishes
  contract, boundedness, and reflection behavior only; no CFD was run in this
  workspace.
