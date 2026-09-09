# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets.  Those streets merge around the
  target corridor before release, and the sampled sheets share this initial
  condition; their particular vortex phase is therefore evidence context, not
  a transferable clock or route.
- Every current sampled solver is a finite `target_reached` success.  The
  fastest (`solver_f54bbab0ba47`) visibly makes a decisive early redirect,
  keeps an alternating posterior-lagged bend through the merged wakes, and
  reaches the target after `123.018` released units with `3.594L` mean
  distance.  Its `-11.041L` upstream head displacement against only `-0.0630`
  mean local streamwise flow confirms active self-propulsion rather than
  passive advection.
- That policy qualifies the previous-action response at both joints by the
  normalized signed power added by command lag.  Against unqualified
  two-joint response, it improves arrival from `130.729` to `123.018`, mean
  distance from `3.754L` to `3.594L`, total command energy from `115750` to
  `95084`, and RMS crossflow/force/moment from
  `0.1543/18.30/359.97` to `0.1429/17.03/334.45`.  The anterior acceleration
  still reaches its cap, and the direct-action course policy remains smoother
  and lower-load (`91401` energy and `0.1336/14.91/306.50` loads), so the
  signed-power guard is an evidenced route/effort compromise rather than a
  complete load solution.
- The inherited completed branches supply two negative controls.  Releasing
  anterior action history broadly from bearing and closing progress delays
  capture to `177.260`, raises mean distance to `4.869L`, and costs `121791`
  energy; its sheet shows repeated course reversals before entering the target.
  Stacking the course-alignment residual on persistent anterior response also
  delays capture to `162.222`, raises mean distance to `4.433L`, costs
  `136964` energy, and raises RMS crossflow to `0.1577`.  Thus neither broad
  route gating nor combining separately useful route residuals is supported
  on the action-response scaffold.

## Policy hypothesis

Materialize the sampled signed-power-qualified two-joint continuity controller
as the single candidate.  Preserve instantaneous body-frame bearing as route
owner, progress-qualified bearing-rate damping, the bounded normalized moment
residual, zero-mean half-cycle steering, and the posterior-lagged traveling
bend.  Use observed previous action and actual observation interval for command
continuity, but smoothly remove only the portion of lag that would add positive
normalized joint power relative to the current oscillator command.

This selection should reproduce the evidenced fast targetward trajectory while
avoiding the energy and load inflation of unqualified filtering.  Reject the
mechanism if it loses capture, upstream translation, or the alternating bend;
if arrival or mean distance regresses beyond `123.018/3.594L`; or if effort and
crossflow/force/moment return toward `115750` and
`0.1543/18.30/359.97`.  The same-snapshot result does not establish robustness
to held-out wake phase, inflow, target geometry, or resolution.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body traveling-wave propulsion
source_mechanism: preserve a coherent posterior-lagged rhythm while sensor feedback modulates actuator-command continuity instead of replacing the propulsive wave
transferable_invariant: command history may shape route and phase, but it should lose authority when its lag would add joint kinetic energy against the current state-feedback request
nontransferable_details: published gains, hardware servo constants, species-specific envelopes, dimensional beat settings, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: retain normalized body-frame target and moment feedback plus the two-joint traveling bend, then weight each observed previous-action residual by a soft guard on normalized positive signed lag power
falsification: reject if capture, upstream translation, or alternating propulsion is lost, or if arrival, mean distance, effort, and wake loads fail to reproduce the sampled advantage over unqualified two-joint response
