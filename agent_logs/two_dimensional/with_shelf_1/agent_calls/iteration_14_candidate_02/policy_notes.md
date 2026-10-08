# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting cylinder streets. The release state and target
  marker are common across the sampled candidates.
- Every sampled released sheet reaches the target with the same visible control
  topology: a sharp targetward redirect, a coherent posterior trail during a
  sustained leftward traverse, and direct entry into the `0.75L` capture
  circle. Head displacement near `-10.92L` in x despite mean local x flow near
  `-0.20U` corroborates active upstream propulsion rather than passive
  advection. The best and prefilled sheets are visually indistinguishable at
  five-frame resolution, so their metric differences, not vortex appearance,
  decide this edit.
- No sampled failure sheet exists. The informative inherited boundaries are
  therefore textual: putting bearing trend into persistent route steering
  exited after `18.304` with negative progress, while replacing the carrier
  wholesale with a slower/smaller curvature-equilibrium gait became unstable
  with force/moment RMS `16749.8/290421`. The carrier, raw-bearing route
  ownership, and response localization should remain intact.
- The prefilled per-joint speed release reaches in `34.8590`, with `1.62681L`
  mean distance, `47176.8` total command energy, `0.24086` RMS relative
  crossflow, and `74.24/1105.81` force/moment RMS. Restricting moment credit to
  one targetward joint phase reaches in `34.8535` but worsens force/moment RMS
  to `82.35/1231.74`.
- Two independently sampled copies of the strongest controller use the maximum
  normalized speed of either joint as a single coupled-carrier pressure signal
  and apply one resulting asymmetry to both joint residuals. Both reproduce
  `34.7105` arrival, `1.62283L` mean distance, `46985.9` total command energy,
  `0.24023` RMS relative crossflow, and `68.96/1036.40` force/moment RMS. This
  dominates the prefilled local release on every listed finite metric except
  mean command energy (`1353.65` versus `1353.36`), while both retain capture.

## Policy hypothesis

Promote the sampled coherent two-joint burst release as the single candidate
change. Treat speed pressure anywhere in the coupled traveling bend as a reason
to withdraw the same bounded share of only the optional response burst from
both joints. Preserve the state-feedback carrier, posterior lag, raw-bearing
mean steering and reserve, course-slip correction, signed assisting-moment
credit, and base half-cycle asymmetry. This is a coordination mechanism for a
coupled body wave, not a scalar gait or gain retune.

Expected evidence is deterministic reproduction of target reach and the
sampled compact upstream route, with arrival, distance integral, total effort,
crossflow, and load close to the two strongest copies. Falsify this candidate
if capture is lost or the sampled joint improvement fails to reproduce. Even a
successful replication remains bounded to the shared prewarm; changed wake
phase or layout is required before claiming robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and organized-wake adaptive swimming
source_mechanism: modulate optional asymmetric turning feedback coherently around a coupled rhythmic propulsive carrier
transferable_invariant: preserve the traveling-wave carrier and persistent route controller, while one normalized whole-carrier response signal releases only surplus maneuver authority across the coupled joints
nontransferable_details: published CPG gains, clocked phase, robot or species kinematics, exact vortex phase, dimensional frequencies, cylinder coordinates, and task-specific routes
policy_translation: normalize the maximum observed two-joint speed by the endogenous carrier scale and use it to attenuate one shared response-gated half-cycle asymmetry; retain normalized body-frame bearing, course, and signed moment feedback
falsification: reject if target reach or coherent upstream propulsion is lost, if the sampled arrival-distance-effort-load advantage does not reproduce, or if a changed-wake test shows coherent release damages capture
