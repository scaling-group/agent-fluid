# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned parent's inherited evaluation
  satisfy the frozen experiment contract: direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
  inspected the combined sheets for the strongest sampled finite policy, the
  weakest sampled near-miss, the assigned solver parent, and the inherited
  whole-wave hold. In every top-down row the fish self-propels down-left behind
  a sustained alternating vorticity street; the oblique rows confirm compact
  three-dimensional Lambda2 structures through the approach. Every trajectory
  then passes laterally by the target, rotates toward a nearly vertical course,
  and exits the lower boundary. The defect is active momentum redirection, not
  advection, collision, wake collapse, weak cruise propulsion, or instability.
- The assigned solver parent is the yaw-selected posterior half-cycle brake:
  it reaches `2.385L` and exits low at `31.21T`. The sampled state-phased
  posterior-lag policy is the strongest current inbound scaffold, improving
  the minimum to `2.326L` and the recorded trajectory mean from `6.772L` to
  `6.725L` while preserving the coherent wake and roughly `0.75/0.36`
  anterior/posterior command-clamp residence. It still moves at about `0.69U`
  at the miss, crosses to target-behind near `18.65T`, recedes to `4.78L` by
  `24T`, and exits low at `31.74T`.
- Sampled and inherited results falsify selector retuning and passive recovery.
  Moving the useful phase modulation earlier with a closure-cone selector
  regressed to `2.390L` with the same `left_domain` class. A target-behind
  differential curvature burst reached only `2.499L`. Most directly, the
  assigned parent's whole-wave damping hold drove both measured joint rates
  near zero by `21T`, yet the fish continued down from `3.47L` at `21T` to
  `5.52L` at `24T`; closest approach regressed to `2.484L` and exit advanced
  to `29.21T`. Removing rhythmic input therefore left the miss momentum
  essentially unopposed. More damping, another static curvature split, or a
  proximity/closure threshold edit is not supported.

## Policy hypothesis

Start from the sampled `2.326L` phase-lag carrier and preserve its oscillator,
target-curvature steering, alignment envelope, response-selected posterior
brake, inbound phase shaping, and command reserve. Add one post-overshoot
mechanism: active reversal of posterior phase order. Normalized longitudinal
target geometry, measured closing speed, and local distance must agree that
the target is behind and receding. That continuous gate changes the sign of
the posterior lag while retaining the measured anterior rhythm and its mean
steering curvature. The resulting reverse-traveling bend is intended to
oppose the established translational momentum instead of merely coasting;
bringing the target ahead or resuming closure restores the original posterior
lag continuously. No clock, hidden stage, world coordinate, or route is used.

Support requires unchanged inbound progress and coherent wake followed by a
measurable speed/closing reversal, a returning second pass, capture, or a new
useful termination class. Falsify the mechanism if the inbound minimum moves
materially outward, the phase transition causes a one-sided wake or load/clamp
increase, the fish fails to slow and return, or the same lower exit persists.
A small scalar minimum-distance change without momentum reversal is not
support.

```text
bookshelf_consulted: true
source_domain: classical traveling-wave reactive propulsion and sensor-modulated robotic-fish rhythm control
source_mechanism: posterior phase order determines traveling-wave thrust direction while body geometry and tail motion dominate the reactive impulse
transferable_invariant: when a geometrically confirmed overshoot retains substantial momentum, apply a bounded opposed traveling-wave impulse rather than removing the complete rhythm
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, prescribed reversal durations, capture radii, and task-specific routes
policy_translation: normalized body-frame longitudinal target fraction, normalized distance, and measured closing speed continuously reverse only the posterior lag of the existing joint-state traveling bend; target-directed mean steering and the inbound carrier remain intact
falsification: reject if inbound progress or wake coherence changes, command/load residence rises, the reversed wave does not reduce recession or create a return, or the powered lower-exit topology persists
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Replay and contract
checks can establish inbound locality, continuous gating, reflection
equivariance, finite bounds, and parameter-schema consistency; they cannot
establish hydrodynamic counterthrust or improvement.

## Controller-only activation audit

Replaying candidate and sampled phase-lag algebra on the completed `2.326L`
trajectory changes the maximum joint command by only `5.3e-10 rad/T^2` on
average before minimum distance; reversal weight remains below `4.0e-8` over
that interval. On the stored states it is `0.0033` at the `18.65T`
target-behind crossing, reaches `0.994` by `21T`, and remains `0.861` at
`24T`. The bounded lag multiplier therefore moves from approximately `+1`
inbound to `-0.49` at `21T` and `-0.29` at `24T`; this verifies selector and
phase-order semantics only.

On the same stored states, replayed anterior clamp residence is unchanged at
`0.7477`; posterior residence is `0.3549` versus `0.3552` for the sampled
baseline. A mirrored overshoot probe negates both commands with zero
floating-point residual, and all returned commands remain within the common
`+/-28 rad/T^2` reserve. These checks do not predict the coupled wake or
translational response.
