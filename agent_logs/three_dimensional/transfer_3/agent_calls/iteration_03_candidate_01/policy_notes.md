# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm. Their motion and wakes are therefore
  self-generated, not advection artifacts.
- The strongest finite sample, `solver_19f251537923`, retains a coherent
  alternating top-down wake and compact three-dimensional Lambda2 structures
  while reducing range from `12.328L` to `6.138L`. The fish then continues a
  lower-going arc, range regresses to `10.460L`, and it exits at `26.147T`.
  Near closest approach the reconstructed body-frame bearing is still about
  `1.07 rad`, while the short-window yaw estimate oscillates with the beat;
  this is useful propulsion with failed route/turn arrest, not weak drive.
- The assigned parent, `solver_a8731015fd6e`, keeps the same `0.55T`, `28 deg`
  joint-state traveling-bend carrier but adds a persistent posterior mean bend
  of at most `4 deg`. Both visual rows show a developing propulsive wake, yet
  the fish corrects past alignment, climbs out of the upper boundary at
  `9.108T`, and improves range by only `0.450L` before regression. Its raw yaw
  signal changes sign over individual beats, so instantaneous rate feedback is
  not a clean slow-turn measurement.
- `solver_97bc3c03d55b` replaces the parent's geometry-only bias with a
  yaw-rate-to-mean-curvature loop. It makes monotonic range progress to
  `9.175L`, but its `12 deg` posterior bias and short-window rate signal produce
  a large upper-going arc and the same upper-boundary termination at `11.132T`.
- The informative weak-carrier failure, `solver_1b4176f9edeb`, applies
  yaw-response-gated half-cycle scaling to a `0.70T`, `12 deg` carrier. Its
  sparse wake, `0.162L` closest progress, subsequent regression, and upper exit
  show that phase-local steering does not compensate for removing the
  evidenced propulsive carrier.
- Inherited optimizer logs add two negative controls: a prior direct-yaw-arrest
  experiment scored `-18.303` with `final=16.264L`, and another weak response
  controller scored `-15.694` with `final=13.147L`. These results argue against
  another raw-rate residual or another reduced-drive controller.

## Policy hypothesis

Preserve the parent's proven joint-state oscillator and posterior phase lag
exactly. Remove the persistent posterior mean curvature. Instead, introduce a
small geometry-driven half-cycle modulation of the posterior traveling-wave
target, using the observed posterior-wave sign as phase and a continuous
alignment gate that removes steering authority as the normalized body-frame
line of sight approaches the centerline. This keeps zero mean curvature at
alignment and does not consume the anterior propulsion oscillator. Unlike the
weak-carrier half-cycle failure, the `0.55T`, `28 deg` carrier is unchanged.

Falsification: reject this mechanism if it loses the organized alternating
wake or fails to beat the parent's `11.878L` minimum distance; also reject it
as insufficient turn arrest if it retains either upper/lower boundary-exit arc
with growing range after crossing the target centerline. A useful outcome must
retain self-propulsion while delaying or removing the runaway-yaw topology.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: preserve a rhythmic locomotor carrier while applying bounded state-dependent half-cycle modulation for turning
transferable_invariant: separate the self-sustaining propulsive rhythm from a small feedback steering residual, and continuously withdraw the residual near directional alignment
nontransferable_details: published CPG gains, robot morphology, dimensional cadence, duty ratios, species kinematics, exact wake phase, and any task-specific route
policy_translation: use normalized body-frame target geometry for the steering request and observed two-joint wave state for phase; modulate only the posterior target around the unchanged state-feedback traveling bend
falsification: the transfer fails if wake coherence or distance progress falls below the assigned parent, or if centerline crossing still produces an unrecovered boundary-exit arc
