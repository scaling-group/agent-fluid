# Whole-wave crossflow-phase candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solvers contain the same v38 policy and byte-identical
  trajectory.  They reproduce finite capture at `18.232491 T`, score
  `-0.126500`, total/observed distance integrals `2.012983/1.399804 L`, and
  distances `11.6583/8.9925/5.8275/2.4288 L` near `4/8/12/16 T`.  The runs
  use direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm.  Mean/max speed is `0.7032/0.9519 L/T`, either-
  joint acceleration-limit residence is about `41.54%`, and peak normalized
  planar force/moment is `0.03068/0.01579`.
- I inspected the combined, top-down, and oblique sheets from release through
  capture.  The readable v38 examples show active self-propulsion on a smooth
  target-directed arc: compact startup structures become a coherent
  alternating mid-plane vortex street and paired posterior Lambda2 structures
  persist to capture.  There is no passive advection, collision, wake collapse,
  domain exit, or visible instability.  One older combined sheet has an
  entirely black oblique row while its top-down sheet and trajectory match the
  other runs exactly; that is a rendering artifact, not evidence about the 3D
  wake.  The current sample has no physical failure, so the inherited
  whole-wave route-rate projection remains the informative failure boundary:
  it retained an organized wake but turned with the wrong sign, exited at
  `8.4755 T`, reached only `12.2107 L`, and produced roughly tenfold force and
  moment peaks.
- Two completed step-23 attempts show that another hydrodynamic magnitude is
  not the missing mechanism.  The response-gated lateral-load confidence
  candidate captures but scores `-0.131892` with final distance `0.746988 L`,
  and the near-zero-crossflow dropout bridge captures but scores `-0.129781`
  with final distance `0.747506 L`.  Both trail reproduced v38 despite deeper
  terminal samples, after inherited reconstruction had already shown that load
  confidence is broadly active and tends to erase the crossflow band pass.
  This candidate therefore does not add force, moment, or another confidence
  channel.
- Frozen-trace reconstruction instead identifies a phase-estimation question
  inside the successful v38 mechanism.  Local body-frame crossflow correlates
  `0.603` with the existing de-meaned anterior phase and `0.646` with the
  de-meaned posterior tail-tangent phase.  A bounded equal blend of their
  normalized angles raises the correlation to `0.687`.  It remains close to
  the existing correction (`0.903` correlation), while reducing mean absolute
  crossflow pose correction from `0.01307` to `0.01163 rad`; the mean/max
  frozen-trace change is `0.00505/0.01556 rad`.  This is diagnostic evidence
  for a small whole-wave sensing test, not a closed-loop outcome.

## One-candidate policy hypothesis

Preserve v38's state-feedback traveling-wave carrier, posterior lag, raw
large-error redirect, geometry-released bearing-divergence recovery,
mean-preserving proportional pose rejection, head-only route-rate correction,
raw half-cycle steering, response-released cadence, approach scheduling,
carrier-first rejected-head-steering spillover, and componentwise acceleration
bounds.  Change one sensing mechanism only: phase the established band-pass
crossflow pose term from an equal bounded blend of the de-meaned anterior bend
and the de-meaned whole-wave tail tangent.  The latter already removes the
route and redirect means, so deliberate target curvature cannot masquerade as
carrier phase.  The fused signal stays out of redirect selection, rate
feedback, oscillator dynamics, and direct actuation.

The intended signature is capture no later than the reproduced `18.2325 T`
with route checkpoints and observed integral no worse than v38, the same
coherent two-view wake, and no material increase beyond the sampled
`0.952 L/T`, `41.6%`, `0.03068`, and `0.01579` speed/saturation/force/moment
envelope.  Falsify the mechanism if the head/posterior phase blend merely
weakens useful pose authority, regresses middle or terminal closure, changes
the target-signed arc or alternating wake, or expands that physical envelope.
Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish control
source_mechanism: posterior-emphasized traveling bends couple coordinated body-wave state to local hydrodynamic response while route feedback remains separate
transferable_invariant: a phase-bearing fluid-side correction should reference the coordinated traveling bend that produces the wake, not an isolated joint, while preserving deliberate mean curvature
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phase, full-body envelopes, and task-specific routes
policy_translation: blend normalized de-meaned anterior angle with normalized de-meaned two-joint tail tangent, bound the result, and use it only to phase the existing body-frame band-pass crossflow term in the two-joint state-feedback contract
falsification: reject if capture or v38 route checkpoints regress, the coherent two-view wake changes, or speed, saturation, normalized force, or yaw moment materially exceeds the reproduced envelope
```

## Evidence boundary

Completed outcome claims above come from the assigned parent, sampled solver
artifacts, and inherited optimizer logs.  Correlation and phase-delta values
come from frozen reconstruction of the reproduced trace and are not causal CFD
evidence.  The new candidate's evaluation belongs to a later worker.

## No-CFD implementation audit

- The sole candidate has SHA-256
  `62d2027db36a0a9e9e62703d9f2fad571bd44372e5aeae2c4058fb4e93f6497f`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its exact three prescribed commands were
  then run locally and separately: the material guidance/schema check,
  lightweight Julia policy contract, and solver editable-boundary check pass.
- Frozen replay algebra over all `3315` reproduced states returns finite,
  componentwise-bounded commands.  This checks implementation scale only; it
  is not closed-loop CFD.  No formal CFD was run in this workspace.
