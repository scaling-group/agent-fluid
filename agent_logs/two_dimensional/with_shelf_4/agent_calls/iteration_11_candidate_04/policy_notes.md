# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the common release condition,
  not evidence for an exact wake phase, cylinder-specific route, or timed
  controller stage.
- All four sampled solver results reproduce the same successful policy and
  metrics: target capture after `137.357` released units, `4.18356L` mean
  distance, `-10.9139L` upstream head displacement, `90228.38` total command
  energy, and `0.12955/14.75/303.02` RMS relative crossflow, lateral force,
  and yaw moment. Their released sheets show active upstream propulsion, an
  alternating posterior-lagged bend, and a targetward wake crossing rather
  than passive downstream advection. Exact repetition under one certified
  prewarm snapshot establishes a stable baseline, not held-out robustness.
- The assigned parent's bearing-dependent posterior-lag relief remains a
  semantic success but delays capture to `158.147`, increases mean distance to
  `4.69192L`, total command energy to `103628.53`, and RMS crossflow/force/
  moment to `0.13199/15.66/311.93`. Its inherited step-10 policy therefore
  correctly restores the complete posterior lag and the `137.357` baseline.
- Other inherited one-change additions also regress: an opposing relative-
  crossflow residual reaches at `154.110` with essentially unchanged RMS
  crossflow, while a lateral-target residual reaches at `159.302`. These
  results reject another unconditioned observation added to the route request.
- The most informative mechanism failure is the inherited same-sign posterior
  half-cycle multiplier. Its released sheet preserves the alternating wave and
  eventually captures, but makes repeated broad loops above and below the wake
  corridor. Arrival nearly doubles to `279.439`, mean distance rises to
  `6.98171L`, total energy to `182835.90`, mean upstream body speed falls from
  `-0.0791` to `-0.0389`, and RMS crossflow/moment rise to `0.13554/316.29`.
  Joint-2 angle and acceleration remain below the hard caps even though their
  maxima rise from `0.346/25.55` to `0.387/28.29`; spare actuator headroom did
  not imply useful route authority.
- The best keyframes still show several targetward course kinks on the final
  approach, while joint 1 already reaches `30.846 rad/time^2` against its
  `31.416` cap. A smaller response-conditioned use of existing anterior route
  authority is therefore better supported than stronger steering, posterior
  recruitment, scalar gait tuning, or another wake residual.

## Policy hypothesis

Make exactly one controller-mechanism change from the sampled policy: add a
smooth terminal-approach relief to the existing target-route component. The
relief becomes material only when normalized body-frame distance is small and
positive windowed closing speed confirms useful translation. It leaves the
direct yaw-moment residual unchanged. If closing stops or reverses, the relief
vanishes continuously and full bearing authority returns, so proximity alone
cannot make the fish coast through a miss.

Preserve instantaneous bearing as route owner, progress-qualified bearing-rate
damping, zero-mean state-inferred anterior half-cycle steering, the direct
moment residual, oscillator gait, and unmodulated posterior lag. The formal
test is retained capture and upstream translation with a less kinked final
approach, lower mean distance or effort/load, and no additional cap contact.
Falsify the candidate if it delays or loses capture, increases final-approach
hunting, weakens upstream displacement, suppresses alternating propulsion, or
worsens distance, energy, crossflow, force, moment, or saturation relative to
the reproduced `137.357` baseline. CFD evaluation occurs only after this
worker exits, so these are expectations rather than same-worker results.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady fish target approach
source_mechanism: preserve rhythmic propulsion while scheduling route authority continuously from observed approach regime and useful translational response
transferable_invariant: near-target steering relief should require both normalized body-frame proximity and measured target-distance closure, and full route authority should return when closure is lost
nontransferable_details: published gains, dimensional frequencies, species-specific maneuvers, robot linkage geometry, exact vortex phases, cylinder layout, capture route, and timed approach stages
policy_translation: retain the evidenced two-joint half-cycle traveling bend and yaw-load loop, then smoothly reduce only the bearing-owned turn component by a bounded function of `distance_L` and positive `window_closing_speed_L`
falsification: reject if capture is lost or delayed, a near-target miss is not corrected when closure stops, upstream translation or the alternating bend weakens, or distance, effort, load, or actuator-cap contact worsens
