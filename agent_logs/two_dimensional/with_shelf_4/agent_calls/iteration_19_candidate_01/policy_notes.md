# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting cylinder streets. Vortices already fill the target
  corridor at release; their exact phase is a common initial condition, not a
  transferable timing signal or route.
- All four sampled solver artifacts have the same executable policy logic
  (their source differences are comments or layout), identical released
  keyframe hashes, and identical physical metrics. They therefore provide one
  repeated materialization of the signed-power-gated response, not four
  independent controller tests or evidence of robustness across wake phases.
  No sampled termination failure is available.
- That completed mechanism is nevertheless a real positive result relative to
  the assigned parent's inherited comparisons. It reaches the target in
  123.018 released units with 3.5936L mean distance, 95084 command energy, and
  0.1429/17.03/334.45 RMS relative crossflow/force/moment. The unguarded
  both-joint response needed 130.729 units and 3.754L, expended 115750, and
  produced 0.1543/18.30/359.97; the anterior-only response needed 135.019
  units and 3.685L, expended 110448, and produced 0.1535/18.53/362.61. Thus
  bypassing action lag when it adds positive normalized joint power improves
  route, effort, and load together, although it still exceeds the smoother
  direct-action contrast's load and effort.
- The current released sheet retains the alternating posterior-lagged wave,
  redirects downward earlier, and follows a shorter broad fold into the
  interacting wake corridor. The inherited 162.222-unit course-alignment
  branch instead swims shallowly upstream for longer and then makes repeated
  midcourse yaw reversals before capture, consistent with its worse 4.4325L
  mean distance and 136964 energy. Current head displacement is -11.0406L
  upstream despite mean local streamwise flow of only -0.0630, confirming
  active propulsion rather than passive advection.
- The remaining visible opportunity is the initial near-reversal: the target
  begins far behind the body heading, and the fish spends an early portion of
  the trajectory establishing the correct targetward course. Because static
  curvature, posterior route sharing, lag relief at large bearing, and
  additive course/crossflow residuals already regressed inherited rollouts,
  the next test leaves those channels untouched.

## Policy hypothesis

Retain the completed body-frame bearing route loop, closing-qualified bearing-
rate damping, direct bounded moment residual, state-inferred half-cycle
steering, regulated oscillator, posterior lag, and per-joint signed-power
response guard. Add one bounded response-qualified redirect mechanism to the
existing anterior half-cycle envelope: when normalized absolute bearing is
large, temporarily increase half-cycle asymmetry, then continuously remove
the extra authority as either bearing moves in the correcting direction or
positive normalized closing speed confirms useful translation.

This is a state-triggered C-start analogue rather than a time stage or a new
mean-curvature command. It should tighten the initial redirect while allowing
the validated cruise wave to recover automatically. The formal expectation is
preserved capture, roughly -11L upstream translation, and alternating
propulsion, with arrival earlier than 123.018 or mean distance below 3.5936L
without materially exceeding 95084 energy or 17.03/334.45 RMS force/moment.
Falsify it if the extra envelope causes a deeper initial fold, sustained
joint-cap contact, weaker upstream translation, loss or delay of capture, no
route improvement, or disproportionate effort and load. Formal CFD occurs
only after this worker exits, so these are expectations rather than
same-worker result claims.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG asymmetric flapping
source_mechanism: strong bounded curvature for a large heading error followed by continuous release when observed heading or translational response appears
transferable_invariant: extra redirect authority should exist only while normalized body-frame target error is large and observed correction has not yet begun
nontransferable_details: published gains, C-start timing, servo constants, species-specific bend envelopes, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: add a bounded large-bearing half-cycle-asymmetry increment and suppress it continuously with correcting bearing rate or positive closing speed while retaining the two-joint state-feedback traveling wave
falsification: reject if capture, upstream translation, or alternating propulsion is lost, or if the initial route, arrival, mean distance, effort, load, and actuator-cap contact do not improve as a coherent tradeoff
