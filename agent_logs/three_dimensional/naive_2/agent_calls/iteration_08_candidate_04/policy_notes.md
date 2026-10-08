# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled rollouts satisfy the Phase 2 contract: direct uniform
initialization in still water, zero background velocity, no cylinders, and a
finite `left_domain` termination. The combined sheets were inspected in both
views. Their top-down rows show sustained leftward self-propulsion and coherent
alternating mid-plane vortex streets; the oblique rows confirm tail-connected
three-dimensional Lambda2 structures rather than passive advection or a
collapsed gait. Every visible path instead passes above the target and exits
the upper virtual boundary, so the missing capability is terminal route
recovery rather than wake production.

The most informative sampled comparison is the undamped `4 deg` transient
course redistribution (`solver_6d90d1984e81`). It reaches `3.161L` at
`18.227T` with speed about `0.846U`, but radial closure has fallen to roughly
zero; by `20T` closure is negative and the fish recedes to `8.569L` before its
`27.572T` exit. Its coherent wake persists throughout, while maximum joint
speed reaches `4.538 rad/T`, maximum acceleration reaches the soft
`31.4 rad/T^2` envelope, and peak force and moment coefficients are about
`0.034` and `0.0175`. The `3 deg` comparison reaches `4.419L` and recedes to
`6.383L`. Distance-only amplitude relief reaches only `5.126L`, while
distance-times-course-error damping reaches only `6.397L`; both alter a still
productive approach and therefore do not support proximity or absolute course
error as sufficient braking triggers.

The assigned-parent logs sharpen that negative result. Its full-amplitude,
approach-aware redistribution reaches `3.135L` and then recedes to `10.210L`.
The completed closure-aware amplitude-hold child (`solver_bc0a63178377`)
reduces final recession to `7.891L`, but worsens the minimum to `3.926L` and
still exits. A sibling predicted-miss redistribution
(`solver_cac759c37551`) reaches `3.448L` and recedes to `9.596L`, also without
changing termination. Thus measured closure is a useful terminal discriminator,
but neither an early projected-miss lever nor a large reduction of the
oscillator's equilibrium amplitude has yet produced capture.

## Single candidate hypothesis

Retain the assigned parent's full-amplitude joint-state oscillator, posterior
lag, body-frame bearing and relative-crossflow feedback, speed-gated course
brake, approach-aware `4 deg` anterior course redistribution, recent-yaw term,
bounded posterior mean, and smooth action envelope. Replace amplitude relief
with one response-localized mechanism: add dissipative damping to the anterior
oscillator only when normalized target proximity coincides with weak or
negative body-frame radial closure. The closure gate is centered near zero,
rather than the inherited `0.30U` reference, so decisive targetward motion
retains the exact carrier even at large course error. Once closure stalls or
reverses, damping sheds beat energy while the posterior mean-steering request
remains available; if the redirect restores closure, the state-feedback
oscillator continuously recovers without a stage flag.

The intended semantic change is to preserve the inherited `3.135L` approach
more faithfully than amplitude hold while reducing post-minimum recession,
upper drift, and near-limit action residence. Falsify it if the early path or
alternating wake differs materially, minimum distance worsens beyond the
closure-amplitude child's `3.926L`, closure does not recover after the damping
gate engages, final recession is not better than `7.891L`, `left_domain`
persists without a useful trajectory change, or peak joint/load excursions
exceed the inherited references.

bookshelf_consulted: true
source_domain: fish terminal capture and closed-loop robotic-fish CPG modulation
source_mechanism: continuously preserve rhythmic propulsion during productive approach, then dissipate carrier energy when observed target closure stalls while keeping steering authority
transferable_invariant: terminal drive relief should be gated by normalized proximity and measured loss of radial closure, and should release when targetward motion recovers
nontransferable_details: published gains, dimensional capture distances and speeds, species or robot kinematics, oscillator clocks, exact vortex phases, and task-specific routes
policy_translation: compute radial closure from `target_body_L` and `velocity_body_U`; use a smooth proximity-times-closure-deficit gate only on anterior velocity damping while retaining the full oscillator amplitude, actual-state posterior lag, and bounded steering terms
falsification: reject if productive far-field closure or the coherent wake changes, closest approach degrades, recession and upper exit do not improve, propulsion fails to recover, or actuator and hydrodynamic loads grow

## Non-CFD gate audit

Replaying only the new algebraic gate on the undamped `4 deg` observation
history gives mean added damping ratio `0.000215` at distances of at least
`8L`, and at most `0.000019` whenever radial closure is at least `0.5U`.
Inside `5L` the mean is `0.0589`; inside `3.3L` it is `0.0853`, with a bounded
maximum of `0.1599` near `18.106T` as closure becomes negative. This establishes
locality and boundedness only. It does not claim the new hydrodynamic result,
which remains for post-worker CFD evaluation.
