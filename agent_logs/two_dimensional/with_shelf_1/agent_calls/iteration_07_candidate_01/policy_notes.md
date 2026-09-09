# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet confirms the common held-fish initial condition:
  four developed, interacting streets surround the second-row target while the
  fish is still above and downstream. It does not distinguish controllers.
- The assigned-parent policy (`solver_17e11e11d29a`) is the strongest sampled
  finite result. Its released sheet shows a sharp initial clockwise redirect,
  a regular posterior wake during a self-propelled leftward/downward traverse,
  and direct entry into the target region after `45.727`. The metrics agree:
  head displacement is `(-10.922,-4.152)L`, mean distance is `2.0543L`, mean
  command energy is `1264.65`, and RMS force/moment are `49.36/799.31`.
- The raw-bearing scheduled sibling (`solver_107fd6f7f029`) follows the same
  useful topology but turns into a slightly lower route and arrives after
  `46.035`; it has lower mean effort (`1237.06`) and moment (`761.46`) but
  higher RMS force (`51.40`). The fully coupled slip/reservation parent child
  arrived after `46.761` with worse force/moment (`59.04/923.45`). Thus keeping
  raw bearing in charge of reservation while slip corrects only the residual
  produced a real route/arrival improvement, not universal effort relief.
- `solver_17e11e11d29a`, `solver_a3d960194765`, and
  `solver_c898f5873077` are syntactically distinct but semantically equivalent
  copies of that role-separated controller and produce identical trajectories
  and diagnostics. They are duplicate evidence, not three tested mechanisms.
- Every distinct sampled success touches the candidate's `30.0` acceleration
  envelope on both joints and the physical `260 deg/time` joint-speed limit.
  The keyframes show coherent propulsion rather than a repeated wake-induced
  yaw reversal, so uncalibrated crossflow rejection is not supported. No
  failed keyframe sheet is sampled in this workspace; the inherited log's
  slower/smaller curvature-carrier instability remains only a textual failure
  boundary (`121.517` elapsed, RMS force/moment `16749.8/290421`).

## Candidate hypothesis

Preserve the validated `0.55`-period joint-state carrier, posterior lag,
slip-corrected bearing residual, raw-bearing reservation, joint split, and
`30.0` envelope. Add one bounded half-cycle asymmetry to the existing residual:
for each joint, infer beat side from its normalized observed angular velocity,
give the residual modestly greater weight while that joint is already moving
in the requested turn direction, and give it modestly less weight on the
opposing half-cycle. The multiplier is continuous, state-only, and returns to
one with vanishing route error, so the mean-curvature interface and nominal
traveling bend remain intact.

This tests whether continuously applying the same residual wastes finite
authority by opposing the propulsive half-cycle. Expected evidence is preserved
capture and coherent upstream propulsion with an arrival no worse than the
`46.035` raw-scheduler result, plus lower mean effort, reduced limit contact, or
a more compact route than the `45.727` role-separated parent. Falsify the
mechanism if capture is lost, arrival exceeds `46.035` without a clear load or
effort benefit, force/moment exceed the fully coupled `59.04/923.45` boundary,
or the posterior traveling wake visibly loses coherence. The new candidate is
not evaluated until this worker exits.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping control
source_mechanism: sensor-conditioned half-cycle amplitude asymmetry around a rhythmic propulsive carrier
transferable_invariant: preserve the traveling carrier while redistributing a bounded turn residual toward the observed joint half-cycle already moving in the requested curvature direction
nontransferable_details: published gains, duty ratios, dimensional beat rates, robot geometry and hardware, clocked phase, species kinematics, exact vortex phases, and source-task routes
policy_translation: multiply each joint's existing body-frame route residual by a bounded function of signed steering request and normalized observed joint velocity, while leaving the carrier, posterior lag, raw-bearing reservation, and envelope unchanged
falsification: reject if semantic capture or coherent upstream propulsion is lost, arrival regresses without a load or effort benefit, limit contact worsens, or the traveling posterior wake loses coherence
