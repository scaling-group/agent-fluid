# Bidirectional steering-residual allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  Two
  independently written v29 posterior-recovery policies reproduce the same
  strongest rollout at `19.3105 T`, score `-0.21057567`, and distance integral
  `2.09959 L`.  The two reproduced v28 gait-frame policies capture at
  `20.5315 T`, score `-0.29557888`, and integral `2.18697 L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  from release through termination for the stronger v29 rollout and the
  slower v28 capture.  Both fish visibly self-propel from quiescent water:
  compact startup structures grow into coherent alternating three-dimensional
  posterior packets, with no imposed-flow advection or visible instability.
  Both follow a smooth target-signed arc, but v29 is progressively farther
  along it; its distances are `11.7665/9.4269/6.5005/3.2320/0.9882 L` at
  `4/8/12/16/19 T`, versus v28's
  `11.8164/9.6219/7.0177/4.2245/1.9071 L`.  The final top-down and oblique
  frames show capture during continued coherent swimming rather than a coast
  or an accidental swept crossing.
- Numeric diagnostics agree with that visual reading.  V29 raises mean/max
  speed from v28's `0.6281/0.8944` to `0.6649/0.9312 L/T`, while peak
  normalized planar force remains `0.03056` and peak yaw moment changes only
  from `0.01525` to `0.01541`.  Approximate limit residence falls from
  `36.1/10.5/46.4%` to `34.3/8.3/42.4%` for head/tail/any joint, so the faster
  capture is not explained by more pervasive bang-bang action.  The sampled
  v28 capture is the informative weaker trajectory in this generation; the
  inherited uncentered projection remains the semantic failure boundary
  because it missed by `0.0506 L`, reversed its route, and exited left.
- The completed v29 trajectory exposes a remaining allocation asymmetry.
  Replaying the policy on recorded states (mean command reconstruction error
  about `0.0083 rad/T^2`) finds posterior steering overflow on `8.18%` of
  sampled steps, with mean/max signed residual magnitude
  `0.974/2.408 rad/T^2`.  On those fixed states, every residual fits in the
  anterior command's remaining same-sign headroom.  This supports a reciprocal
  allocation pass; it does not support increasing carrier or steering gains.

## One-candidate policy hypothesis

Preserve v29's state-feedback traveling wave, centered gait-frame geometry,
raw completion-gated redirect, progress-gated posterior lag, half-cycle
steering, anterior-to-posterior spillover, and componentwise physical bounds.
After the existing posterior command is projected, measure only the signed
target-steering residual rejected at that posterior bound and offer it once to
the already projected anterior command.  The second pass is dormant whenever
posterior steering is feasible and cannot expand either joint's acceleration
envelope; it completes the same route-residual allocation mechanism rather
than changing its scalar authority.

The expected outcome is to retain capture and the v29 wake/route while making
the remaining posterior-clipped steering effective on observed phases with
anterior headroom, lowering capture time or distance integral without raising
limit residence or loads.  Falsify the mechanism if capture is lost or later
than `19.3105 T`, the integral exceeds `2.09959 L`, the coherent target-signed
arc changes into the inherited near-miss/reversal, limit residence grows
without compensating closure, or max speed and normalized force/moment
materially exceed `0.9312`, `0.03056`, and `0.01541`.

bookshelf_consulted: true
source_domain: residual CPG control and sensor-modulated robotic-fish turning
source_mechanism: preserve the rhythmic carrier while target-dependent turning uses observed phase and the authority available across coupled joints
transferable_invariant: route-scale feedback should remain separate from propulsion and place only an unrealized bounded steering residual on another actuator with same-sign headroom
nontransferable_details: published gains, dimensional cadence, linkage leverage, species-specific kinematics, clocked phase, exact vortex phase, task coordinates, and any assumed equality of joint torque effectiveness
policy_translation: keep normalized body-frame v29 guidance unchanged; after head-to-tail spillover and posterior projection, transfer only the remaining signed posterior steering overflow once into bounded anterior headroom
falsification: reject if reciprocal recovery delays or loses capture, disrupts the alternating wake, recreates route reversal, or raises speed, saturation, force, or moment without better closure

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer logs.  The reciprocal allocation pass is an unevaluated
candidate; formal CFD after worker exit must determine whether the frozen-state
headroom result survives closed-loop trajectory change.
