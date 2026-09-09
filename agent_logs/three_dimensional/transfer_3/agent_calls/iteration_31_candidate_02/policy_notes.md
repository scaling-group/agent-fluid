# Candidate diagnosis and hypothesis

## Evidence read before editing

All four assigned samples are valid direct-uniform still-water runs: their
diagnostics report `U_infinity=(0,0,0)`, direct quiescent initialization, no
prewarm snapshot, and zero cylinders. All terminate by capture, so this sample
has no failed termination to use as a visual contrast. The informative contrast
is the best-score capture against the prefilled demodulated-residual capture.

- `solver_0288c0d51d57` captures at `18.6560T`, score `-0.133208`, and mean
  distance `2.02115L`. Its action RMS is `24.71/28.77 rad/T^2`, acceleration-
  limit occupancy is `40.74%/75.77%`, and force/moment RMS is
  `0.013277/0.006912`.
- `solver_8c5ed84c4bcd` captures at `18.6725T`, score `-0.133625`, and mean
  distance `2.02129L`; it has the highest sampled posterior occupancy
  (`76.14%`) and force/moment RMS (`0.013499/0.007028`).
- `solver_bdf6dd947707` captures at `18.7440T`, score `-0.133635`, and mean
  distance `2.02198L`; stress-gating a raw moment response therefore supplies
  neither the fastest route nor the lowest loads.
- The prefilled `solver_e85ca9b86253` bidirectional carrier-demodulated
  residual captures at `18.7165T`, score `-0.135253`, and the worst sampled
  mean distance, `2.02337L`, while giving the lowest force/moment RMS
  (`0.013093/0.006816`), posterior acceleration occupancy (`74.17%`), and
  posterior action RMS (`28.56 rad/T^2`). Local-flow RMS is tightly grouped at
  `0.01807--0.01815U` across all four, so these differences are allocation and
  route effects rather than passive advection.

The top-down sheets show body-led translation from a wake-free release, a
coherent alternating street by `4T`, continuous range closure, and compact
paired vortices through the `18T` capture approach. The oblique sheets show
organized three-dimensional Lambda2 structures shed behind the tail without
visible wake breakup or a detached disturbance carrying the fish. The four
trajectories and wake topologies are nearly identical; the useful carrier and
LOS C-bend should therefore be preserved. Inherited optimizer logs are not
present in this workspace, so the parent `guidance/control_experience.md` is
the available distilled inherited record. It specifically asks for a
replication of one-sided opposing-response recruitment before this mechanism
is changed.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-feedback modulation of rhythmic robotic-fish control
source_mechanism: separate slow route demand from fast hydrodynamic disturbance response, and avoid spending actuation to cancel helpful wake-induced motion
transferable_invariant: preserve the propulsive traveling bend and recruit a bounded redundant steering channel only when observed fluid response opposes the current route response
nontransferable_details: published gains, species kinematics, full-body waveforms, dimensional frequencies, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: retain normalized body-frame LOS-rate guidance and actuator-consistent tail-phase steering; subtract the joint-phase carrier from normalized yaw moment, form a reflection-invariant response-opposition product, and use only its positive part to recruit bounded posterior phase
falsification: reject the transfer if capture is lost, arrival leaves the inherited `18.6725--19.0080T` band, either wake view loses coherence, posterior acceleration occupancy exceeds `74.44%`, force/moment RMS exceeds `0.013105/0.006822`, or posterior velocity-limit occupancy reaches `8.10%`

## Candidate hypothesis

Change exactly one response semantic in the prefilled controller: clamp the
carrier-demodulated opposition signal to `[0,1]` before it scales phase
recruitment. An opposing residual may add up to the existing bounded phase
fraction, while a helping residual leaves the actuator-consistent baseline
unchanged instead of withdrawing phase. All carrier, LOS, C-bend, persistent
same-side stress, phase-gradient, and feasibility-limit logic remains intact.

This tests whether the prefilled bidirectional allocator's small route penalty
comes from suppressing useful phase during helpful fluid response while
retaining the inherited one-sided load benefit. The new CFD result is not
available in this worker and is not claimed as evidence; later workers should
evaluate it against the explicit capture, timing, wake, saturation, load, and
velocity boundaries above.
