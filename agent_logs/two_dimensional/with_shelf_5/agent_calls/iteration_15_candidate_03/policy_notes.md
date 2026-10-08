# Multi-wake candidate diagnosis

## Evidence read before the edit

- The shared prewarm sheet shows the common held fish at the upper-right and
  four developed, mutually interacting cylinder wakes crossing the target
  neighborhood. This is initial-condition evidence shared by every policy,
  not evidence for a controller-specific route.
- The reproduced parent policy (`solver_5049b3347a65`, byte-identical to the
  prefill) visibly turns from the upper-right toward the target, self-propels
  leftward through the developed wake, and reaches the `0.75L` capture circle
  without a collision or boundary excursion. Metrics confirm a direct finite
  capture at `43.9505`, mean distance `2.1391L`, mean velocity
  `(-0.2471,-0.1020)` versus mean local flow `(-0.1342,-0.1556)`, and positive
  mean relative streamwise motion `0.1129`; the displacement is therefore not
  passive advection alone. Both joint-rate and acceleration caps are reached,
  with RMS force/moment `49.44/701.26`.
- The strongest sampled result (`solver_881c1f236d0d`) circularly averages the
  short bearing history and blends it into the route command. Its sheet shows
  the same useful early redirect and wake entry but a tighter target approach;
  metrics improve capture to `41.5030` and mean distance to `2.0216L`. The
  improvement costs larger realized joint excursions (`0.579/0.527` versus
  `0.525/0.452` rad), command mean (`1296.36` versus `1207.78`), relative
  crossflow (`0.2246` versus `0.2111`), and RMS force/moment
  (`61.80/862.48`), while the same rate and acceleration caps remain active.
- The most informative lower-load contrast (`solver_b7b629a6b402`) visibly
  preserves the parent's route topology and capture. Its alignment-conditioned
  outward-rate projection leaves capture effectively unchanged at `43.9505`
  while lowering RMS force/moment to `44.47/657.47`. Inherited logs corroborate
  that the related phase-indiscriminate projection repeatedly captured at
  `44.0220` with `44.86/663.89`, whereas approach localization, extra phase
  selectors, and an alignment-conditioned `0.90` oscillator envelope did not
  create a better useful trajectory.
- No sampled solver in this workspace supplies a released failure keyframe;
  all four terminate at the target. The inherited naive-seed domain exit is
  retained only as metric-backed context and is not assigned an unseen visual
  diagnosis.

## Candidate hypothesis

The history-filtered sample demonstrates that persistent body-frame target
geometry improves the route, but feeding that same persisted command to both
mean curvature and posterior half-cycle authority couples its arrival benefit
to higher excursions and loads. Test one two-timescale steering mechanism:
use the blended circular-mean bearing only for the anterior mean-curvature
route command, and use current body-frame bearing for the posterior half-cycle
asymmetry. Early history padding keeps full redirect authority at release;
after alignment, the posterior steering can respond immediately instead of
holding the filtered request. Keep the carrier, approach envelope, lag, and
all numerical parameters otherwise unchanged so this split is the single
causal change.

Expected evidence is a target-reaching trajectory faster and lower in mean
distance than the `43.9505`/`2.1391L` parent, with RMS force/moment lower than
the fully history-driven `61.80/862.48`. Reject the mechanism if it loses the
direct route or target success, fails to improve arrival/mean distance over
the parent, or retains the history-driven load/excursion increase. The new CFD
outcome is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-feedback robotic-fish direction tracking
source_mechanism: separate slow persistent target geometry from fast corrective steering instead of driving every actuator role from one instantaneous or one filtered signal
transferable_invariant: distinct observed timescales should have distinct bounded control roles while preserving the propulsive carrier
nontransferable_details: recurrent-network architecture, published gains, species kinematics, single-cylinder vortex phase, dimensional frequencies, and task-specific routes
policy_translation: circularly averaged normalized body-frame bearing drives anterior mean curvature; current body-frame bearing drives the target-favored posterior half-cycle under the existing two-joint state-feedback contract
falsification: reject if target success or the direct route is lost, arrival and mean distance do not beat the parent, or force, moment, and realized excursion remain at the fully history-driven sample's elevated levels
