# Multi-wake candidate diagnosis

## Evidence read before the edit

- The common held-fish prewarm sheet shows the same mature, interacting four-cylinder vortex streets for every policy, so it is an initial-condition control rather than evidence for a candidate-specific wake phase.
- In the target-blind seed sheet, the fish makes limited upstream progress, folds into a tight downward curl, and exits below the domain. The metrics agree: `left_domain` at `50.127`, displacement `(-3.545,-13.300)L`, only `0.024` progress, and minimum target range `8.615L`.
- The bounded-bearing carrier takes a broad, mostly monotone diagonal route through the developed wake and visibly reaches the capture circle. It terminates `target_reached` at `93.032`, with `0.940` progress and `4.033L` mean distance, but also reaches both joint-rate and acceleration caps and carries RMS lateral force/moment near `95.50/1146.61`.
- The sampled terminal amplitude-envelope policy (`2.5L` onset, `0.75` amplitude floor) reproduces the ungated success almost exactly: identical termination and release time; command-energy mean `972.51450` versus `972.51483`; power mean `66.86842` versus `66.86890`; and slightly higher, not lower, RMS force/moment. This is evidence that changing only the Van der Pol amplitude does not materially change the dominant restoring acceleration or its clipping in this regime.
- Inherited failures reinforce the boundary: globally slowing/narrowing the carrier exited right in `17.457`, a larger static bias exited right in `16.791`, and slow/narrow propulsion plus uncalibrated heading-rate damping became unstable in `14.508`. The far and middle successful route therefore remains unchanged.

## Candidate hypothesis

Start from the sampled successful `0.55`/`28 deg` carrier and `8 deg` body-frame bearing bias. Replace the ineffective oscillator-amplitude schedule with a terminal, state-gated soft acceleration limiter. A smooth normalized-distance gate is exactly zero at and beyond `2.5L`; a bounded `window_closing_speed_L` gate prevents relief while stalled or receding. Only where both gates are active, blend each raw carrier acceleration toward a smooth `tanh` limit below the environment hard cap. This changes command authority directly without introducing a clock, route, cylinder coordinate, global heading, or wake-phase estimate.

Expected result: the pre-approach trajectory and turn remain identical, capture is retained, and cap occupancy plus terminal effort/load fall enough to distinguish the mechanism from the prior inert amplitude schedule. Reject the mechanism if the far/middle path changes, target crossing is delayed or lost, or command/load metrics remain materially unchanged in spite of terminal gating.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and cross-domain terminal capture control
source_mechanism: sensor-gated modulation of a rhythmic carrier, with drive relief confined to the final approach
transferable_invariant: preserve the proven propulsive and steering rhythm away from the target, and reduce excessive drive only when normalized range is small and observed closing progress is positive
nontransferable_details: published gains, dimensional beat frequencies, species-specific joint envelopes, exact vortex phases, and task-specific routes
policy_translation: multiply a normalized distance gate by a bounded body-frame window-closing-speed gate, then use that product to blend both raw two-joint acceleration commands toward a smooth parameter-owned soft limit
falsification: reject if capture is delayed or lost, any trajectory change appears outside the terminal range, or acceleration saturation, command effort, and terminal loads do not decrease
