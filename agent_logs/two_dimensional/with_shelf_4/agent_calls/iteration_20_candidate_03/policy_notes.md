# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The common prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting cylinder streets. Their merged release pattern
  is shared initial-condition evidence, not a transferable vortex phase,
  cylinder-aware route, or timed control cue.
- No sampled termination failure is available: all four current solver
  examples reach the target, and three reproduce the `123.018`-unit
  per-joint signed-power result. The strongest sampled rollout instead uses
  one shared signed-power response gate. Its sheet retains the alternating
  posterior-lagged bend, completes the initial redirect, crosses upstream
  through the interacting wakes, makes a compact lower-midcourse fold, and
  enters the capture circle from the right after `118.024` released units.
  Its `-10.915L` upstream head displacement despite `-0.0686` mean local
  streamwise flow supports active propulsion rather than passive advection.
- Relative to the replicated per-joint gate, the shared gate improves arrival
  (`123.018` to `118.024`), mean distance (`3.594L` to `3.560L`), command
  energy (`95084` to `89079`), and RMS relative crossflow/force/moment
  (`0.1429/17.03/334.45` to `0.1383/16.74/329.67`). It also preserves bounded
  joint angles (`0.427/0.380 rad`) and the posterior acceleration below its
  cap, although anterior acceleration still reaches `31.416 rad/time^2`.
  This coherent improvement is evidence for coupling the actuator-history
  decision across the traveling-wave pair; it is not evidence for increasing
  oscillator gains.
- The informative inherited mechanism regressions retain capture but worsen
  trajectory semantics. Course-alignment feedback takes `137.247` units and
  raises energy/load above its direct-action parent; the sampled large-bearing
  burst redirect takes `130.053` units with `3.758L` mean distance and `99377`
  energy, and its sheet shows a wider midcourse S-fold than the best shared-
  gate path. Together with earlier failures of crossflow, lateral-target,
  bearing-history, posterior route-sharing, and lag-relief residuals, this
  argues against another route term, burst envelope, posterior target edit,
  or scalar gait increase.

## Policy hypothesis

Use the completed shared signed-power gate as the parent mechanism and make
one further actuator-coordination change. Decompose the short previous-action
lag into components parallel and orthogonal to the current raw two-joint
acceleration vector. Retain only the smoothly regularized parallel component,
then apply the evidenced shared positive-power guard to it. This lets history
smooth the magnitude of the current state-feedback command pair without
rotating its anterior/posterior direction; near a vanishing raw pair, the
regularization continuously restores the raw command. Route bearing, closing-
qualified bearing-rate damping, moment rejection, half-cycle steering,
oscillator regulation, and posterior target equations remain unchanged.

The formal expectation is preserved target capture, approximately `-11L`
upstream translation, and an alternating posterior-lagged bend, with less
phase-distorting action history, a no-wider lower fold, and no regression from
the `118.024`-unit shared-gate result in mean distance, energy, crossflow,
force, moment, or actuator-cap contact. Falsify the mechanism if capture is
lost or delayed, propulsion weakens, the trajectory fold grows, posterior lag
is visibly erased, command switching increases, or distance and load/effort
do not improve together. The candidate will be evaluated only after this
worker exits, so these are testable expectations rather than outcome claims.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve the interjoint direction and posterior lag of a low-dimensional traveling-wave command while actuator history smooths its magnitude
transferable_invariant: previous-action continuity should not rotate the current anterior/posterior state-feedback command away from its propulsive traveling-wave relationship
nontransferable_details: published gains, servo constants, linkage geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: project normalized two-joint response lag onto the current raw acceleration pair with a bounded near-zero regularizer, then apply one shared signed-added-power gate before returning both accelerations
falsification: reject if capture, upstream translation, or alternating posterior lag is lost, or if arrival, mean distance, effort, load, actuator-cap contact, switching, and trajectory folding fail to improve coherently relative to the sampled shared-gate result
