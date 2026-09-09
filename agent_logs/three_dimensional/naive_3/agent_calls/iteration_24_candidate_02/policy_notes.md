# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  and finite dynamics. I inspected both rows of every combined keyframe sheet,
  comparing the strongest finite horizon example (`solver_101212af2a5e`) with
  the closest sampled phase-lag run (`solver_0620d96874f3`) and the assigned
  parent's moment-residual failure (`solver_b4f7ad49610a`). The top-down rows
  show alternating vorticity streets generated from quiescent release, and the
  oblique rows retain compact three-dimensional Lambda2 structures. All motion
  is self-propelled; wake collapse, passive advection, collision, and numerical
  instability do not explain the misses.
- The inherited yaw-moment residual is now a completed negative result. It
  retained the powered lower exit at `31.416T`, worsened minimum distance from
  the phase scaffold's `2.326L` to `2.539L`, and left final distance at
  `9.189L`. Together with the inherited duty, equilibrium, phase-gate, and
  phase-half-cycle failures, this closes another fast residual or rhythmic
  reallocation as the immediate next test.
- The geometry-released same-curvature C-turn is the first semantic
  improvement in this branch. It preserves the coherent inbound wake, reaches
  `2.346L`, eliminates the lower exit, survives the full `100T` horizon, and
  improves scored mean/final distance to `4.714/3.902L`; anterior/posterior
  acceleration clamp residence is about `0.718/0.104`, so the new topology is
  not purchased with more posterior saturation. After its target-behind
  selector engages, however, it never improves beyond `2.427L`. It continues
  at roughly `0.6--0.7U` around broad `3--5.8L` loops while target-ray/course
  error remains roughly `1.1--2.2 rad`. The visual path and trace therefore
  show a productive but oversized powered orbit, not a failed redirect or
  insufficient cruise thrust.

## Policy hypothesis

Start from the completed horizon C-turn and preserve its state-feedback
oscillator, inbound bearing curvature, response-selected posterior brake,
proximity-localized phase lag, full-direction recovery selector, same-sign
two-joint redirect, and command reserve. Add one continuous recovery-response
mechanism: only while the target is behind, inside the evidenced orbit radius,
and normalized closing speed is poor, contract the nonzero traveling-wave
carrier further while retaining the redirect equilibrium. Restore the sampled
recovery carrier continuously as closing response becomes positive or the
target returns ahead. This creates a bounded turn-in-place opportunity rather
than demanding still more saturated curvature, and it leaves release and the
first pass unchanged because the full-direction recovery selector is off.

Support requires preservation of the coherent first pass plus capture, a
closer return leg, or a materially smaller stable orbit with improved mean or
final distance and no increased limit/load residence. Reject the mechanism if
it changes inbound progress, stalls in a static bend, collapses or strongly
one-sides the wake, increases saturation/load residence, or merely preserves
the same `3--5.8L` orbit through the horizon. Formal coupled CFD runs only
after this worker exits; trace replay and controller probes can establish only
selector locality, symmetry, bounds, and schema ownership.

```text
bookshelf_consulted: true
source_domain: fish terminal-approach control and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve broad propulsive pursuit, then use measured closing response to contract rhythmic drive while retaining bounded turn authority near a miss
transferable_invariant: separate productive cruise from a response-selected near-target redirect; when continued propulsion sustains a nonclosing orbit, reduce the carrier without removing the curvature that can realign the body
nontransferable_details: published CPG gains, dimensional beat frequency, species-specific approach stages, prescribed waveforms, exact vortex phases, capture radius, target coordinates, and task-specific routes
policy_translation: normalized body-frame target projection, distance, translational speed, and closing speed gate a reflection-equivariant contraction of the joint-state traveling-wave envelope while the existing two-joint redirect equilibrium remains active
falsification: reject if the first pass changes, the fish stalls or loses wake coherence, clamp/load residence rises, or no closer return leg, smaller orbit, capture, or useful distance improvement appears
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. Non-CFD replay and contract
checks performed after the edit will be recorded here without presenting them
as hydrodynamic validation.

## Implemented candidate and non-CFD probes

The candidate starts from the completed horizon C-turn and adds six owned
recovery-response parameters. Normalized instantaneous closing speed is divided
by measured translational speed plus a finite low-speed scale; target-behind
geometry and a bounded distance envelope then select an additional carrier
contraction. The resulting traveling-wave scale has a nonzero `0.16` floor,
while the sampled redirect equilibrium is unchanged. The policy introduces no
clock, step count, mutable state, world coordinate, target identity, route, or
file access.

Replaying only the selector on the completed horizon trace leaves release
exactly unchanged through `2T`. At the sampled `2.3456L` minimum, redirect and
contraction weights are only `0.000723/0.000483`, and wave scale changes from
about `0.9996` to `0.9992`. Immediately after the target passes behind at
`18.7T`, the nonclosing contraction is `0.947` and reduces the sampled
recovery scale from `0.474` to `0.177`. Across later nonclosing states its mean
contraction and wave scale are `0.639/0.271`; across closing states they are
`0.130/0.473`, so positive response restores most of the sampled carrier.
These counterfactual selector values establish locality and material authority,
not a coupled-flow trajectory prediction.

All `39` controller parameters are returned by `target_policy_params()`.
Representative mirrored recovery states return exactly negated actions with
zero floating-point residual; zero and large finite states remain finite, and
commands respect the declared `+/-28 rad/T^2` reserve. The mandated material
guidance/notes check, lightweight Julia policy contract, parameter-schema
guard, and solver editable-boundary check pass. No formal CFD was run.
