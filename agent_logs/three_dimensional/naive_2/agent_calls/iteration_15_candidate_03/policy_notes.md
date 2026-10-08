# Candidate wake-policy notes

## Evidence diagnosis

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm. The moving-window views therefore
  show self-propulsion rather than background advection.
- In the assigned parent (`solver_929554cd32fb`), the top-down row shows an
  organized alternating wake through 17T, followed by an upward turn and exit;
  the oblique row likewise retains tail-connected three-dimensional vortices.
  The trace agrees: the fish reaches only `4.530L` at `17.25T`, already has
  velocity `(-0.562,+0.457)U`, and exits the upper boundary at `21.72T`.
  Coherent propulsion survived, but closure-gated posterior wave relief did
  not correct the route.
- The other sampled relief/scheduling policies repeat that topology, reaching
  only `4.743--5.126L` before an upper exit. Lower effort is not evidence of
  better targeting when the trajectory still peels away.
- In the strongest finite sample (`solver_a46c8c6241a4`), both views show the
  same alternating, tail-connected carrier while the target distance falls
  from `12.328L` to capture at `0.748L` and `16.64T`. Its joint-phase-
  demodulated yaw response is the material controller difference: repeatable
  beat-scale yaw is removed before the directional-response comparison, and
  extra authority is phase selective. The captured trajectory remains finite
  (`max |q|=0.560 rad`, peak planar force/moment about `0.0369/0.0186`), though
  its roughly `74%` near-limit acceleration residence is a robustness boundary.

## Policy hypothesis

Replace the assigned parent's proximity/closure wave shedding with the sampled
joint-phase-demodulated yaw-response mechanism. Preserve the full anterior
state-feedback oscillator, body-frame bearing/course geometry, posterior lag,
and bounded half-cycle steering. A joint-state estimate of carrier-induced yaw
should prevent beat phase from masquerading as route error; recruiting only a
small additional opposing-half-cycle relief when the compensated response is
short of the route request should preserve thrust while producing the sampled
capture trajectory. This candidate deliberately keeps the already completed
capturing implementation intact rather than tuning its scalar gains.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG steering and adaptive swimming response separation
source_mechanism: preserve a rhythmic propulsive carrier while using sensed response to apply bounded phase-selective turning asymmetry
transferable_invariant: separate slow body-frame route demand from repeatable joint-phase yaw before closing the directional-response loop
nontransferable_details: published CPG gains, species kinematics, dimensional beat settings, exact vortex phase, and task-specific routes
policy_translation: estimate carrier yaw from normalized joint angle and joint-rate state, subtract it from recent yaw, and gate a bounded posterior half-cycle correction by compensated response deficit
falsification: reject if capture is not reproduced, the compensated residual remains phase-correlated, the coherent carrier or approach is lost, joint limits are contacted, or force, moment, and near-limit acceleration materially worsen

The candidate's own CFD evaluation occurs after this worker exits; no outcome
for the new materialization is claimed here.
