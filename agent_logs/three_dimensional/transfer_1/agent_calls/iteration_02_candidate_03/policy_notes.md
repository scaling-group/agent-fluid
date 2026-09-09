# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm snapshot. Every result is a finite controlled
  trajectory ending in `left_domain`, not a numerical instability.
- The strongest finite examples, `solver_6c46616730e6` and
  `solver_2ce3d25ef5a2`, visibly self-propel with compact alternating vorticity
  in the top-down row and paired three-dimensional Lambda2 structures in the
  oblique row. Their posterior-lag gait should be preserved: each closes from
  `12.328L` to about `6.1L` before sweeping below the target and exiting the
  lower boundary near `26T`. Local-flow components remain at only a few
  hundredths of `U`, so ambient wake rejection is not the first missing
  mechanism in these quiescent trials.
- Adding the speed-gated course residual in `solver_6c46616730e6` changed the
  score by only `+0.059`, closest approach by `0.060L`, and final distance by
  `0.049L` relative to `solver_2ce3d25ef5a2`; both retain the same long lower-
  boundary exit. The inherited falsification therefore fired: another scalar
  increase of course gain is not supported.
- The assigned-parent bearing-only posterior mean curvature
  (`solver_f0f4cd87e65f`) produces the needed initial clockwise yaw sign but
  does not release it soon enough. Bearing falls from about `+0.155` initially
  to `-0.45` near `4T`, while heading has already fallen from `0.506` to
  `-0.063` rad; inertial yaw then carries it to the upper boundary at `7.79T`
  after only `0.122L` of closest-distance improvement. The slower bounded
  target-curvature candidate `solver_b0e1dc12d96c` has the same upper-exit
  class by `9.09T` and reaches only `12.272L`; its two visual rows show a much
  shorter, weaker wake and a pivot with little useful translation rather than
  the long coherent propulsive street of the strong examples. The inherited same-sign
  two-joint mean-bias trial is worse still (`15.401L` final distance and a
  right-boundary exit). Reversing curvature sign or reducing carrier scale
  alone is therefore not enough.
- Instantaneous body yaw is dominated by the propulsive beat, so feeding raw
  heading rate directly into mean curvature would oppose useful oscillation.
  Across the two strong traces, a least-squares diagnostic gives approximately
  `heading_rate = offset - 0.66*phi_dot1 - 0.19*phi_dot2` with `R^2 > 0.99`;
  the bearing-only upper-exit trace gives coefficients `-0.57` and `-0.23`
  with `R^2 = 0.976`. A conservative joint-velocity compensation can thus
  expose the slower yaw response without a clock or mutable filter.

## Candidate hypothesis

Preserve the `0.55T`, `28 deg` state-feedback traveling bend from the strong
examples, but replace direct bearing-to-curvature steering with one bounded
closed-loop turn-rate primitive. Body-frame bearing sets a modest desired yaw
rate. Measured heading rate is compensated by the evidenced joint-velocity
component of beat-phase yaw, and the residual rate error sets the posterior
mean tangent. This keeps the correct initial redirection while commanding an
opposite braking tangent before the bearing-only controller accumulates the
upper-exit yaw. The final acceleration is explicitly clamped at the physical
envelope so evaluation does not depend on larger hidden policy commands.

Expected test: retain the coherent alternating wake and early leftward
translation, keep the initial clockwise response, then release or reverse the
mean tangent before heading crosses far below its target-aligned value. A
semantic improvement is avoiding both early upper exit and the inherited long
lower-boundary sweep, even before capture is achieved.

Falsification: reject the phase-compensated rate loop if it disrupts the
alternating wake, loses the strong examples' early closure, still exits the
upper boundary before `10T`, recreates the lower-boundary sweep, or shows that
the joint-velocity compensation changes sign or scale enough that residual
rate feedback becomes a beat-synchronous disturbance. In that case later
workers should test a clean half-cycle steering actuator rather than more
course gain or another static mean-curvature sign.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological burst redirect/release
source_mechanism: preserve a rhythmic propulsive wave while target error requests bounded curvature and observed heading response releases the redirect
transferable_invariant: persistent body-frame direction error should request a bounded turn response, but steering must relax or reverse once the measured response is sufficient so propulsive phase motion is not mistaken for route yaw
nontransferable_details: published CPG gains, robot geometry, species kinematics, dimensional frequencies, exact vortex phase, world-frame routes, and task-specific timing
policy_translation: map body-frame bearing to desired yaw rate, remove the rollout-evidenced joint-velocity component from measured yaw rate, and drive one bounded posterior mean tangent from the residual rate error while retaining the state-feedback lagged gait
falsification: reject if yaw compensation erases thrust, produces phase-locked steering chatter, fails to brake the early clockwise overshoot, or retains either sampled boundary-exit topology
