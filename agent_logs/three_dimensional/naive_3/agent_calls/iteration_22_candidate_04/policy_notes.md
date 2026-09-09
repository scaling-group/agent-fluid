# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts and both inherited step-21 rollouts satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `left_domain` termination. I inspected both
  rows of the combined keyframe sheets for the sampled `2.326L` posterior
  phase-lag result, the prefilled `2.385L` response-selected brake, the sampled
  `2.469L` differential-equilibrium failure, and the inherited `2.738L`
  half-cycle-authority failure. Each fish self-propels along the same broad
  diagonal approach, sheds a long alternating planar wake with compact
  three-dimensional Lambda2 structures, misses laterally, and remains powered
  on a steep lower-boundary exit near `31T`. There is no passive advection,
  wake collapse, collision, or numerical instability to repair.
- The sampled posterior phase-lag action remains the best current scaffold:
  relative to the brake it improves minimum/mean distance from
  `2.385/8.436L` to `2.326/8.424L` while retaining the coherent wake. At its
  minimum (`17.908T`), speed is about `0.687U`, the body-frame target is about
  `(-0.492,2.274)L`, and target-ray-to-course error is `1.088 rad`; the miss is
  therefore a persistent lateral course error under active propulsion, not
  inadequate speed or ambient-flow transport.
- Two completed descendants falsify further refinement of when or on which
  beat phase that lag action is applied. The assigned parent's attenuation of
  the same-sign posterior half-cycle regressed to `2.738/8.473L`; inherited
  forming-miss gating regressed to `2.684/8.474L`. Both preserved the coherent
  powered lower exit. The sampled shared anterior/opposite-posterior
  equilibrium action also reached only `2.469/8.439L`. In contrast, the durable
  inherited evidence records that a simpler opposite-sign posterior
  counterbend previously improved `2.443L` to `2.187L`, but its instantaneous
  lateral-velocity gate repeatedly released while lateral target fraction
  remained `0.7--1.0`. The unisolated test is therefore a posterior-only mean
  counterbend selected and released by persistent normalized lateral target
  geometry, without another anterior redirect or phase-authority change.

## Policy hypothesis

Retain the sampled `2.326L` phase-lag carrier, including its bounded
bearing/yaw anterior curvature, alignment envelope, response-selected brake,
posterior lag modulation, and command reserve. Add one posterior-only mean
action. Inside the approach envelope, normalized lateral target fraction
selects an opposite-sign posterior counterbend; speed continuously suppresses
the undefined release-from-rest limit. The anterior equilibrium is unchanged,
the posterior traveling wave is neither amplified nor attenuated, and the
counterbend persists through gait-scale yaw oscillations until lateral target
geometry actually corrects. The request is realized only through posterior
command reserve, so it cannot create new clamp residence on the replayed base
state. This isolates the actuator allocation suggested by the earlier
`2.187L` result from the sampled differential controller's simultaneous
anterior redirect.

Support requires capture, a visible return leg, a new useful termination
class, or a material improvement below `2.326L` without worse mean distance,
wake coherence, or actuator/load residence. The mechanism is falsified by a
changed far-field release, a short-wake tight curl, increased posterior clamp
or load residence, or the same powered lower exit without material closest-
approach improvement. Formal coupled CFD occurs only after this worker exits;
controller replay can establish only locality, symmetry, schema, and bounds.

```text
bookshelf_consulted: true
source_domain: robotic-fish mean-bias turning and classical posteriorly emphasized traveling-wave swimming
source_mechanism: sensor-selected bend asymmetry steers a productive rhythm while posterior kinematics retain their propulsive traveling-wave role
transferable_invariant: apply a bounded posterior steering bias from persistent signed route geometry while preserving the anterior oscillator, wave direction, phase lag, and oscillatory posterior authority
nontransferable_details: published gains, robot offsets, dimensional beat frequencies, species-specific envelopes, exact tail kinematics, vortex phases, capture radius, and task-specific route
policy_translation: normalized body-frame lateral target fraction and speed gate a reflection-equivariant opposite-sign posterior mean counterbend within the two-joint acceleration contract; geometry, not a clock or instantaneous yaw phase, releases it
falsification: reject if far-field progress changes, wake coherence degrades, a tight curl or higher posterior limit/load residence appears, or minimum distance and the powered lower-exit class remain materially unchanged
```

## Evaluation boundary

The candidate receives formal CFD only after this worker exits. Non-CFD
selector replay and contract checks will be appended after implementation.

## Implemented candidate and non-CFD probes

The candidate starts from the sampled fixed-proximity phase-lag policy and adds
only the hypothesized posterior geometric counterbend plus its command-reserve
realization. It introduces no time, world coordinate, route, mutable state,
flow-file access, or command-limit increase. Replaying the selector on the
completed `2.326L` trace gives mean/max absolute weight
`0.0000021/0.0000174` through `2T`. Inside `3L`, the requested counterbend
averages `5.20 deg`; at closest approach it requests `5.68 deg`. On the same
frozen states, the posterior command differs from the base by
`10.69 rad/T^2` on average inside `3L`, while posterior clamp fraction falls
slightly from `0.3552` to `0.3533` because the new request may use reserve or
move a command off a clamp but cannot push it onto one. These are selector and
counterfactual command diagnostics, not a coupled-flow prediction.

Representative approach and mirrored states produce exactly negated commands
with zero floating-point residual. Zero-speed and extreme finite states remain
finite, and extreme commands respect the declared `+/-28 rad/T^2` reserve. All
`32` direct controller parameters are owned by `target_policy_params()`.
Formal contract, schema, guidance-difference, and editable-boundary checks are
run separately; no CFD rollout is run in this workspace.
