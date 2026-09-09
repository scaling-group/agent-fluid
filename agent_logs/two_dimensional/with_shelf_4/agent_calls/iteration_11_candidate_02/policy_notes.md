# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets.  It is common initial-condition
  evidence; it supplies neither a candidate-specific wake phase nor a route.
- All four sampled solver sheets reproduce the strongest finite trajectory:
  an immediate target-directed redirect, a zero-mean posterior-lagged bend,
  self-propelled upstream wake entry, and capture after `137.357` released
  units.  Their matching metrics are `4.18356L` mean distance, `-10.9139L`
  upstream displacement, `90228.38` total command energy, `0.12955` RMS
  relative crossflow, and `14.75/303.02` RMS lateral force/yaw moment.  The
  two sampled file hashes differ only in comments, so the identical rollouts
  do not constitute distinct mechanism evidence or changed-wake robustness.
- The best sheet turns toward the target without losing propulsion, but after
  the initial redirect its corridor still contains several alternating course
  kinks.  The anterior demand already reaches `30.846 rad/time^2` against the
  `31.416` cap, so more oscillator drive or larger steering amplitude is not a
  credible repair.
- The assigned parent's latest one-change test relieved half of the direct
  yaw-moment residual during positive target-distance progress.  Its released
  sheet widens the redirect before entering the same corridor, and evaluation
  regresses to `152.526` units, `4.65798L` mean distance, `99467.04` effort,
  `0.13097` RMS crossflow, and `15.62/309.29` force/moment.  Full moment
  rejection during progress is therefore part of the useful baseline, not an
  indiscriminate correction to remove.
- The preceding posterior half-cycle sharing test widens the route still more
  and arrives at `172.095` units with `5.81638L` mean distance, `111777.57`
  effort, and `16.39/322.27` force/moment.  A separate inherited posterior
  steering multiplier reaches only at `279.439` units.  Together with the
  inherited regressions from posterior-lag relief, circular bearing history,
  lateral-target addition, and direct relative-crossflow rejection, this
  rules out another posterior reallocation, observation filter, or additive
  route/flow residual on the present evidence.

## Policy hypothesis

Make exactly one mechanism change from the reproduced baseline: preserve its
positive-progress qualification of `bearing_window_rate`, but add a smooth
alignment-dependent increment to that same response damping.  At large
instantaneous body-frame bearing the increment vanishes, leaving the evidenced
firm redirect unchanged.  As alignment returns, the increment rises
continuously, so bearing convergence damps the visible corridor reversals
before they become another overshoot.  Instantaneous bearing remains the route
owner; the full direct moment residual, anterior half-cycle asymmetry,
zero-mean oscillator, and posterior traveling bend remain unchanged.

This is an observed-geometry redirect-to-tracking transition, not bearing
history, a wake-phase estimate, an additive flow signal, or scalar-only gait
tuning.  The formal test should retain capture and upstream translation while
reducing the post-redirect kinks, arrival time, and mean distance without
raising load, effort, or actuator-cap contact.  Falsify it if the initial
redirect is blunted, capture is delayed beyond `137.357`, the route widens,
loads rise, the traveling bend weakens, or a loop or boundary exit returns.
The new CFD evaluation occurs only after this worker exits, so these are
expectations rather than results.

bookshelf_consulted: true
source_domain: nonsteady fish redirect control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain strong target-error steering during a large-error redirect, then release continuously into more strongly damped directional tracking as observed alignment returns
transferable_invariant: normalized body-frame target geometry can schedule the transition between redirect and tracking while joint-state phase preserves the zero-mean propulsive rhythm
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the evidenced two-joint half-cycle traveling bend, progress-qualified bearing-rate loop, and full `moment_z_L2` residual; add a bounded even gate of normalized instantaneous bearing that increases only the existing response-damping coefficient near alignment
falsification: reject if alignment scheduling blunts the initial redirect, loses or slows capture, weakens upstream translation, raises distance integral, effort, load, or cap contact, destroys posterior lag, or recreates a loop or boundary exit
