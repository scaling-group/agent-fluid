# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, and finite dynamics.  The
  top-down and oblique rows of the combined keyframe sheets therefore show
  self-propulsion rather than imposed advection.
- The transferred seed (`solver_e1a03f18d808`) and the prefilled
  response-release child (`solver_dc5e319e8345`) both sustain a coherent
  alternating mid-plane wake and compact three-dimensional Lambda2
  structures.  They reduce distance from `12.3277L` to respectively
  `4.7800L` and `4.6597L`, but both curl below the target and exit the lower
  virtual boundary at about `27.5T` and `28.4T`.  The child's small numerical
  gains (`0.1203L` in minimum distance and `0.1046L` in final distance) do not
  constitute a new trajectory or termination class: releasing only the old
  geometry-driven acceleration bias leaves the inherited route failure.
- The assigned parent's tail-only line-of-sight mean-curvature candidate
  (`solver_dc5bdf69e4ab`) is the most informative failure.  Its top-down row
  shows an immediate tight upward turn instead of target progress, and its
  oblique row shows that propulsion and vortex shedding still exist during
  that turn.  It reaches only `12.2065L` before the upper-boundary exit at
  `7.887T`.  Thus a continuously applied `12 deg` tail-tangent bound has far
  more yaw authority than the parent inferred from the seed's correlation;
  the result falsifies that magnitude/persistence, not the traveling-wave
  carrier.
- Two inherited sibling results reinforce the boundary.  Centering both
  joint cycles on an `8 deg` mean bend also exits the upper boundary with only
  `12.2614L` closest approach, while the slower progress-loss redirect
  (`solver_a1d9e06dfe8a`) preserves a clean wake but still over-redirects to
  the upper boundary and never gets closer than `8.7524L`.  Static curvature
  placement and delayed progress gating are therefore poor next repetitions.
- Reconstructing target and velocity in the body frame exposes a cleaner
  release signal.  On the useful seed segment at `8--16T`, target-versus-body
  bearing grows from about `+0.26` to `+1.03 rad`, but the angle from measured
  swimming velocity to the target is already consistently negative, about
  `-0.52` to `-0.68 rad`: translation is aimed too far downward before the
  body-bearing error becomes extreme.  In the over-redirected parent, this
  course error has already reversed to about `+1.26 rad` by `2T`, whereas the
  body bearing is still only `+0.07 rad`.  Course alignment can therefore
  release/reverse steering earlier than either a persistent body-axis error
  or a progress-loss gate.

## Policy hypothesis

Preserve the seed's anterior joint-state oscillator, posterior lag, cadence,
and amplitude because those are the only sampled elements that repeatedly
produce strong target progress and a coherent 3D wake.  Replace the inherited
multi-branch steering stack with one tail-only course-alignment primitive.
At low speed it uses signed body-frame bearing to initiate the small needed
redirect; as speed develops it smoothly switches to the signed angle from the
measured body-frame velocity vector to the target vector.  Feed that bounded
error into a deliberately small posterior mean-tangent target.  The command
then releases automatically when actual translation aligns, rather than
remaining active until body yaw or distance progress catches up.

Falsification: reject this translation if it destroys the coherent traveling
wake or early distance decrease, repeats either the upper-boundary
over-redirect or lower-boundary under-correction, fails to improve on the
`4.6597L` sampled minimum without a better termination class, or makes raw
acceleration saturation materially worse.  Offline replay can only verify
sign, boundedness, and response release; it is not new CFD evidence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and biological burst redirect, layered on classical traveling-wave propulsion
source_mechanism: preserve the posterior-lagged propulsive rhythm while a bounded route correction releases when the observed swimming response aligns
transferable_invariant: steering should be driven by normalized target error and withdrawn on measured course response, rather than maintained as a static curvature bias
nontransferable_details: published gains, motor dynamics, species-specific envelopes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: blend low-speed body-frame bearing with target-versus-velocity course angle and apply one bounded tail-only mean tangent inside the existing joint-state oscillator
falsification: the mechanism fails if course alignment does not prevent both observed over-redirect and under-correction topologies, or if it sacrifices the coherent wake and early progress

## Pre-evaluation checks

- Algebraic replay on the recorded seed states requests about `-1.25 deg` of
  tail tangent at `8T` and `-1.15 deg` at `12T`, when measured translation is
  aimed below the target.  On the parent's over-redirected states it has
  already released and reversed to about `+0.25 deg` by `2T` and `+1.28 deg`
  by `4T`.  The command remains below its `2 deg` bound on all sampled states.
- Replaying the complete seed trace gives `72.1%` raw acceleration-envelope
  exposure versus about `74.0%` for the evaluated seed action.  This does not
  establish improved actuation, but it confirms that the new steering term
  does not algebraically increase the inherited clipping burden on those
  states.  The policy contract and semantic guidance checks pass; formal CFD
  remains deferred to the evaluator.
