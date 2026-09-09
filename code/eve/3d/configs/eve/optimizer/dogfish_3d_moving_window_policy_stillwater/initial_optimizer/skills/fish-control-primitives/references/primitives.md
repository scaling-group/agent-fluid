# Fish-Swimming and Wake-Control Reference for Dogfish Policy

This is a cross-domain reference for mechanism-level reasoning. It preserves
the classical control primitives used by the earlier dogfish target-policy
program and adds a wake-specific translation. It is not a recipe: identify the
source-domain mechanism, separate its transferable invariant from
source-specific details, and test the translated hypothesis against current
evidence.

The L64 wake lane controls two bending joints through state feedback. It must
not copy an open-loop sine wave, full-body spline, known vortex phase, or
precomputed route. Translate useful ideas into observed joint state,
body-frame target geometry, normalized velocity and flow, force, and moment.

## Classical propulsion ideas

Taylor's swimming sheet gives the simplest warning: reciprocal standing motion
is a weak propulsion idea, while a traveling lateral wave can create net
swimming. The qualitative translation is:

```text
do not merely wiggle both joints together
produce a bend with direction, lag, and posterior emphasis
```

Lighthill elongated-body theory treats a slender swimmer as accelerating water
laterally and receiving reactive thrust, with tail-end kinematics playing a
large role. For a two-joint policy:

```text
anterior joint: sustain and steer the body wave
posterior joint: lag and emphasize the wave to generate thrust
```

Carangiform and subcarangiform swimming are useful qualitative gait families
for a dogfish-like swimmer. Anguilliform motion uses more of the body than this
model has, while a thunniform interpretation is too tail-fin dominated. The
practical prior is modest anterior bend, stronger posterior motion, and a
posterior phase lag.

Strouhal-number results are guardrails only. Efficient animals and flapping
foils often occupy moderate frequency-amplitude regimes, but a paper value is
not a hard constraint for this two-dimensional, two-joint wake problem. Do not
solve reaching by unbounded frequency, amplitude, or acceleration.

## Classical turning ideas

Fish and robotic fish commonly turn by adding controlled asymmetry to a
propulsive rhythm. Every option below must be driven by observed body-frame
target geometry rather than a fixed world direction.

Mean-curvature or tail-beat bias:

```text
turn_cmd from target geometry
add a bounded average bend to one or both joint accelerations
```

This is the most direct two-joint primitive. Excessive static curvature can
destroy the traveling wave and thrust.

Half-cycle amplitude asymmetry:

```text
infer beat side from phi and phi_dot
make the useful half-cycle slightly stronger for the requested turn
```

This is a state-feedback translation of asymmetric flapping or duty-ratio
control. It is useful when a static offset turns too weakly or suppresses the
propulsive rhythm.

Phase-lag or wave-shape modulation:

```text
change posterior lag or tail target as a bounded function of turn_cmd
```

This can preserve a fish-like wave, but with only two joints it is an indirect
steering knob and may need a clearer target-vector-to-curvature mapping.

C-start or burst redirect:

```text
large observed heading error -> strong bounded curvature
heading response appears -> release into stronger posterior beat
small error -> return continuously toward cruise or approach
```

This biological mode is nonsteady and easy to over-apply. Gate it by observed
geometry, joint state, and response—not elapsed time or a hidden stage counter.

## Wake-interaction ideas

A cylinder wake introduces alternating crossflow and yaw disturbances that
should not be confused with persistent target error. Use different observable
signatures for the two roles:

```text
slow/persistent target geometry -> route and mean-turn request
fast alternating crossflow, lateral force, or yaw moment -> bounded rejection
```

Candidate signals include `local_flow_velocity_body_U`,
`relative_flow_velocity_body_U`, `force_body_L`, `moment_z_L2`, bearing rate,
heading rate, recent turn rate, joint state, and previous action. Calibrate
their sign and scale from the actual rollout before using them. Instantaneous
vortex phase is not a world-frame route command.

Kármán-gait and wake-exploitation studies show that a swimmer may synchronize
with or extract useful motion from an organized vortex street. For this lane,
that is a hypothesis, not a target behavior. Do not force phase locking when
the objective is transient target reaching through interacting four-cylinder
wakes. First distinguish useful passive advection from loss of target control.

Wake rejection also need not mean cancelling every lateral motion. A controller
that damps all crossflow can waste actuation or erase helpful vortex-induced
motion. Prefer the smallest feedback that improves target progress, clearance,
and load histories without destroying propulsion.

## Terminal capture ideas

The `0.75L` capture radius makes final approach a separate diagnostic regime.
A useful continuous structure is:

```text
far: preserve propulsion and broad target-directed steering
middle: correct accumulated wake displacement
near: reduce excess drive if needed and damp yaw/slip without coasting too soon
```

Distance scheduling is appropriate only after broad target-directed motion
works. A near miss can reflect insufficient authority, excessive speed,
oversteer, wrong wake response, or loss of thrust; keyframes and histories must
separate these explanations.

## Compatibility with the current wake lane

Compatible, if translated carefully:

- A state-feedback oscillator built from joint angle and velocity.
- Posterior lag and posterior amplitude emphasis.
- Target-vector-to-curvature feedback from bearing and `target_body_L`.
- Mean-curvature bias, half-cycle asymmetry, and phase-lag modulation.
- Soft feedback from normalized local/relative flow, force, or moment after
  sign and scale are evidenced.
- Continuous distance-conditioned approach or hold behavior.

Only loosely compatible:

- Full-body spline waveforms from CFD papers; they have more degrees of
  freedom than the two-joint policy.
- Exact Strouhal targets, species-specific amplitude ranges, or published CPG
  gains; treat them as qualitative priors.
- Clock-driven robotic-fish CPGs; translate them into observable joint-state
  phase or a state-feedback oscillator.
- Steady single-cylinder Kármán gait conclusions; this task is transient and
  contains interacting wakes from four cylinders.

Not compatible:

- Hidden time, step counters, random numbers, file I/O, or mutable global
  oscillators.
- Fixed yaw bias independent of current target geometry.
- Cylinder coordinates, known release phase, target identity, case index, or a
  fixed world-frame route.
- Persistent bang-bang control justified only by a scalar score.
- Reading raw VTK or long trajectories as default optimizer evidence.

## Evidence-to-reference map

Use this table only after reading current keyframes and metrics.

| Evidence diagnosis | Background idea worth considering |
| --- | --- |
| Weak propulsion or reciprocal standing wiggle | traveling bend, posterior lag, amplitude envelope |
| Stable propulsion but wrong or negligible target turn | target-vector feedback to bounded mean curvature |
| Correct turn sign but thrust collapses | half-cycle asymmetry or mild phase-lag modulation |
| Target-directed motion works outside strong wake events but yaw repeatedly reverses | separate slow target request from bounded fast disturbance rejection |
| Large crossflow exists but passive advection improves the route | preserve useful wake motion; avoid indiscriminate cancellation |
| Good closest approach followed by loss near `0.75L` | approach scheduling, drive relief, yaw/slip damping |
| Repeated scalar edits preserve the same failure topology | change one actuator or feedback primitive rather than another gain |

## Compact primitive sketches

These sketches are not commands. Fit at most one to the current diagnostics.

### Propulsive traveling-bend scaffold

```text
drive joint 1 from observed joint state toward a bounded rhythm
set joint 2 target from a lagged function of joint 1 state
track the posterior target with damping
```

### Target geometry to turn command

```text
lateral_target = target_body_L_y / max(distance_L, scale)
turn_cmd = bounded function(bearing, lateral_target, body-frame slip)
```

### Mean-curvature bias

```text
joint1_accel += head_share * bounded(turn_cmd)
joint2_accel += tail_share * bounded(turn_cmd)
```

### Half-cycle steering

```text
beat_side = function(phi, phi_dot)
steer = turn_cmd * bounded half-cycle asymmetry
```

### Phase-lag modulation

```text
tail_target = lagged_head(phi1, phi_dot1, base_lag + k * turn_cmd)
```

### Wake-disturbance residual

```text
route_turn = slow target-geometry request
disturbance_turn = soft bounded function(relative crossflow, force, moment)
command = propulsive wave + route_turn + small disturbance_turn
```

### Approach hold

```text
distance and closing behavior schedule drive and steering authority
near target, damp measured yaw/slip without removing necessary propulsion
```

## How to use this reference in notes

A compact clean-variant note can remain evidence-led:

```text
trigger_evidence: visible correct-sign turn is lost during two large crossflow events
primitive_selected: bounded wake-disturbance residual
policy_translation: preserve target steering; add one soft relative-crossflow term
falsification: reject if thrust drops, load spikes, or the same yaw reversals remain
```

The structured worker entrypoint may require a fuller source-domain and
transferability record. In both variants, literature is not authority for the
edit; rollout evidence remains the reason for accepting or rejecting the
translated controller.
