# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and finite
  `left_domain` termination.  Motion in the keyframes is therefore
  self-propulsion rather than ambient advection.
- The transferred seed forms a coherent alternating wake in both the
  top-down vorticity and oblique Lambda2 rows and closes from `12.3277 L` to
  `4.7800 L` at `17.853 T`, but then keeps turning below the target and exits
  the lower boundary.  Its speed is `0.806 L/T` at closest approach while
  local flow is only about `0.020 L/T`, confirming a steering-topology failure
  rather than passive transport or thrust loss.
- The response-gated redirect is the only sampled semantic improvement.  Its
  coherent posterior wake persists through a visibly different, shallower
  trajectory; closest approach improves to `2.4625 L` at `24.228 T`.  It then
  passes above and left of the target and exits the left boundary.  At closest
  approach it is still moving at `0.941 L/T`; about `95.7%` of raw action rows
  exceed the acceleration envelope before evaluator clipping and a joint is
  at the speed bound in about `21.2%` of rows.  Local flow remains only about
  `0.021 L/T`, with `|F| <= 0.035` and `|Mz| <= 0.019`, so the upper miss is
  not a visible wake breakdown or numerical instability.
- The assigned velocity-lead parent does not preserve that improvement: it
  reaches only `7.3276 L`, rebounds to `15.0240 L`, and exits below.  The
  shared-mean-curvature sample nearly stalls (`12.2813 L` minimum and exit at
  `7.711 T`), while the inherited distributed-bend/drive-relief log reports a
  `12.2472 L` minimum.  Those results rule out adopting global carrier relief,
  shared curvature, or the parent's confounded lead/old-curvature combination
  as the next mechanism.

## Policy hypothesis

Use the response-gated redirect sample as the carrier and steering parent,
without changing its drive, curvature magnitude, or route gains.  Its redirect
currently releases as soon as recent yaw has the requested sign, even while
the body-frame target angle remains in the large-error band.  A tail-beat yaw
excursion can therefore masquerade as completion and repeatedly remove the
mean bend before the macroscopic target error has contracted.

Make the burst release completion-gated: retain the existing observed-yaw
response gate, but multiply its release authority by the complement of the
large-error gate.  Large target angle then holds the bounded distributed bend;
as normalized body-frame angle contracts into the activation band, correct-
sign yaw progressively releases the redirect back to the unchanged posterior-
lag carrier.  This is one state-feedback gating change, not a scalar gain
increase, clocked maneuver, or memorized route.

Expected result: preserve the coherent early approach of the response-gated
sample, sustain correct-sign curvature through its `16--24 T` upper-miss
segment, and improve on `2.4625 L` or the `left_domain` termination class.
Falsify the mechanism if the early wake or closing collapses, the path returns
to the seed's lower exit, the stronger persistence produces a tight turn away
from the target, or closest approach and termination do not improve.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG steering
source_mechanism: a large observed direction error sustains bounded curvature, followed by response-based release into the propulsive rhythm
transferable_invariant: release of a burst turn should represent contraction of macroscopic target-relative error, not merely an instantaneous correct-sign yaw excursion within an oscillatory gait
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat timing, robot geometry, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame target angle to withhold yaw-response release while the redirect error gate is large, then continuously restore release authority as that geometric error contracts within the existing two-joint posterior-lag controller
falsification: reject if early propulsion degrades, curvature turns away from the target, actuator saturation becomes materially worse, or the `2.4625 L` upper-left near-miss and `left_domain` class fail to improve
