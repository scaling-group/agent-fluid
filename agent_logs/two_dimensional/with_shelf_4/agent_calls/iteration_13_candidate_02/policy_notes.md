# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common prewarm sheet shows the fish held in the upper-right while four
  developed, staggered cylinder streets merge around the target. This fixes a
  common initial condition; it does not identify a transferable vortex phase
  or justify a memorized route.
- All four sampled solver results are deterministic replications of one
  finite success. Their released sheets are byte-identical and show an active
  redirect, an alternating posterior-lagged bend, a broad wake crossing, and
  entry into the target from the right after `137.357` released units. The
  matching diagnostics are `4.18356L` mean distance, `-10.9139L` upstream
  head displacement, `90228.38` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. Mean streamwise
  body velocity is `-0.07905`, larger in magnitude than mean local-flow x
  `-0.05420`, so the trajectory is self-propelled rather than passive
  advection. Joint-1 acceleration reaches `30.846 rad/time^2` against the
  `31.416` hard limit, ruling out another unconditioned authority increase.
- The latest inherited one-change candidates all preserve capture but regress
  the same useful scaffold. Opposite posterior half-cycle redistribution
  visibly widens the midcourse path and delays arrival to `150.210`, with
  `4.617L` mean distance and `99669` energy. Route asymmetry applied only to
  the lag component produces repeated folds before capture at `196.317`, with
  `5.718L` mean distance and `131294` energy. Composing route and moment
  residual inside one smooth envelope produces the broadest excursions and
  captures at `223.746`, with `6.429L` mean distance, `144686` energy, and
  `16.79/324.37` RMS force/moment. Their mean upstream velocities fall to
  `-0.07404`, `-0.05601`, and `-0.04851`, respectively. These results reject
  further posterior redistribution or route/load arbitration on this
  snapshot; they do not reject the baseline's direct moment residual.
- The route currently consumes `state.bearing`, whose testbed definition uses
  the absolute forward target offset in its denominator. It therefore gives
  the same small error for a target equally far ahead or behind at the same
  lateral offset. That semantic ambiguity is dormant while the target remains
  ahead, but the inherited loop/fold sheets make it a concrete recovery
  boundary: once wake-induced rotation carries the target behind the fish,
  the route owner can request too little turn even though actuation remains
  available.

## Policy hypothesis

Make exactly one observation-semantic change from the replicated baseline:
derive the route bearing as `atan(target_body_L_y, -target_body_L_x)`. The
body's forward direction is negative body x in this testbed, so this signed
two-argument angle equals the existing bearing throughout ordinary forward
targeting but retains the quadrant when the target moves abreast or behind.
Keep progress-qualified bearing-rate damping, the direct normalized yaw-moment
residual and hard arbitration, joint-state half-cycle steering, oscillator
regulation, and the posterior traveling bend exactly as sampled.

The formal expectation is unchanged baseline propulsion with fewer wake-driven
folds and no delayed recovery if the target crosses behind. Falsify the
mechanism if it changes the initial correct-sign redirect, loses or delays
capture beyond `137.357`, creates a turn-direction discontinuity, increases
distance, energy, crossflow, load, or cap contact, weakens upstream velocity,
or destroys the alternating wave. The new CFD outcome is unavailable until
after this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and target-vector turning
source_mechanism: persistent body-frame target geometry modulates bounded rhythmic steering while joint-state phase preserves propulsion
transferable_invariant: the route owner must preserve the signed target quadrant so wake-induced body rotation cannot make a target behind appear equivalent to one ahead
nontransferable_details: published gains, robot linkage geometry, dimensional frequencies, species-specific envelopes, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: compute a full signed bearing from normalized `target_body_L` and feed it through the existing progress-qualified two-joint half-cycle controller without changing gait, load rejection, or posterior lag
falsification: reject if capture or upstream translation is lost or delayed, the ordinary ahead-target path changes adversely, a turn-sign discontinuity appears, or distance, effort, loads, saturation, or alternating propulsion regress from the replicated baseline
