# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the experiment contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm snapshot,
  and no cylinders. Their motion and wakes are therefore self-generated rather
  than background advection.
- The naive carrier is numerically stable and genuinely propulsive. In its
  top-down row an alternating posterior wake lengthens as the body translates;
  the oblique Lambda2 row confirms a connected three-dimensional caudal wake.
  The carrier nevertheless turns into the upper boundary: distance improves
  from `12.3277L` to `12.0694L`, then ends at `12.3647L` and `8.5965T`, while
  reconstructed target bearing changes from `+8.9 deg` to `-72.4 deg`.
- The best finite sample applies bounded mean curvature only through the
  posterior lag target. Both visual rows retain the strongest alternating wake
  of the steering variants, and mean/final distance improve to `12.2089L` and
  `12.2073L`, with a `12.0564L` minimum. This is useful but not directional
  control: it still exits the upper boundary at `9.1465T`, reaches `-74.2 deg`
  target bearing, hits the `260 deg/T` rate limit, and requests as much as
  `111.7 rad/T^2` before the episode clamp.
- A direct acceleration bias shared by both joints is worse (`12.2349L`
  minimum, `13.3096L` final, upper exit at `8.7285T`). More decisively, the
  assigned parent's equal two-joint equilibrium bias damps the traveling bend
  into nearly static `-10 deg/-10 deg` curvature; the wake weakens while the
  body coasts through a broad wrong-way turn, reaching only `12.2972L` before
  ending at `13.4234L` and `10.8405T`. Its lower action/rate extrema are thus
  gait collapse rather than successful regulation.
- The sampled head-flow magnitude is at most `0.057U`, and no rollout changes
  the upper-boundary termination class. The present evidence supports changing
  the steering actuator, not adding uncalibrated flow/load rejection or making
  another scalar-only carrier edit.

The combined-sheet comparison therefore distinguishes a useful mechanism from
the common failure: posterior lag must remain the propulsion carrier, but a
persistent DC curvature bias either lacks enough timely authority or suppresses
the rhythm when spread across both joints. The next candidate should create
turning authority inside the beat without replacing that beat.

## Candidate policy hypothesis

Retain the naive anterior Van der Pol carrier and posterior state-derived lag.
Map body-frame target bearing plus measured yaw response into one bounded turn
request. Apply that request only on the anterior half-cycle opposed to the
requested turn: the phase gate weakens the wrong-side excursion, while the
unforced half-cycle and the lagged posterior target continue the traveling
bend. Smoothly bound both requested accelerations just inside the fixed episode
envelope so the new asymmetry cannot rely on unseen excess command or create a
controller-owned hard plateau.

This is a state-feedback half-cycle-asymmetry mechanism, not a clocked waveform
or a DC gain retune. It uses only normalized body-frame bearing, normalized yaw
rate, and joint state, and is reflection equivariant. Evaluation falsifies it
if the alternating wake collapses, the negative target-bearing sweep and upper
exit recur without a closest approach below `12.0564L`, or joint-rate contact
remains persistent despite bounded acceleration. A different termination or a
materially longer target-directed trajectory would be semantic progress even
before capture.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric tail-beat control
source_mechanism: sensor-driven half-cycle amplitude asymmetry superposed on a traveling propulsive rhythm
transferable_invariant: phase-selective weakening of the target-opposed stroke can create mean yaw without replacing the alternating traveling bend with static curvature
nontransferable_details: published gains, clock phase, prescribed joint waveforms, robot linkage geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: derive the beat side from anterior joint angle, bound a body-frame bearing and yaw-rate request, gate an anterior acceleration correction to the opposed half-cycle, and let the existing posterior state lag propagate the asymmetric bend
falsification: reject if propulsion weakens like the equal-bias parent, if target bearing again sweeps far negative into the upper boundary without beating `12.0564L`, or if acceleration bounding merely shifts saturation into sustained joint-rate contact

## Dry validation after the edit

The candidate passes finite-output, parameter-schema, and exact reflection
checks. A non-hydrodynamic `12T` joint-state probe keeps both joints oscillating
and avoids the `45 deg` angle limit. At fixed `+0.155 rad` bearing, the late
joint means are approximately `(+2.65,-1.03) deg`, the signed counterpart of
the negative-bearing response after accounting for the asymmetric initial
joint state; the neutral late means remain near zero. Smoothly bounded actions
stay below `30 rad/T^2`, and positive-bearing rate-limit samples fall from 109
in the neutral probe to 46. This is controller sanity evidence only: it contains
no fluid loads or rigid-body yaw, so it cannot validate turn authority, wake
preservation, distance progress, or termination.
