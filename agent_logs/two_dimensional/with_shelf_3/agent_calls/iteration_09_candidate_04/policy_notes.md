# Wake-policy candidate diagnosis

## Evidence read before the edit

- The four sampled solver rollouts have identical released and prewarm
  keyframe hashes and exactly the same target capture at `32.472` release time,
  `1.64761L` mean distance, and `0.747485L` final/minimum distance. Their source
  files differ only cosmetically, so these are fixed-snapshot reproducibility
  evidence for one controller, not four independent wake-phase tests.
- The shared prewarm sheet shows the held fish upstream/right of four fully
  developed, interacting vortex streets. The released sheet shows an immediate
  correct-sign redirect, a persistent posterior-traveling bend, a compact
  diagonal approach, and entry into the developed wake before first-crossing
  capture. The fish is self-propelled rather than merely advected: head
  displacement is `(-10.912,-4.332)L`, while mean velocity is
  `(-0.334,-0.140)` and mean local flow is `(-0.197,-0.189)`.
- The visual success is consistent with `0.939835` progress and monotone
  terminal closest approach, but it is not low-load evidence. Both joints hit
  the `260 deg/time` velocity and `1800 deg/time^2` acceleration ceilings;
  lateral force/moment RMS are `68.70/931.60`, versus `56.57/793.76` for the
  slower `35.063` capture that preceded the posterior half-cycle residual.
- Inherited step-8 scores bracket a useful tradeoff without exposing enough
  controller provenance for a causal claim: one capture at `32.730` retained
  nearly the incumbent distance integral while lowering force/moment RMS to
  `56.29/800.58`; another at `32.824` raised them to `70.97/945.05` and also
  worsened mean distance. This argues for an isolated structural headroom gate,
  not another scalar increase in half-cycle authority.
- No sampled failure keyframe is present in this workspace. The available
  negative boundary is inherited guidance: unrestricted bearing-trend feedback
  collapsed the traveling bend and exited downstream, while anterior-heavy
  recentering also lost propulsion. Those failures rule out changing the base
  oscillator or its proven distributed curvature scaffold in this candidate.

## Candidate hypothesis

Keep the incumbent bearing filter, `40/60 -> 35/65` total-curvature allocation,
state-only anterior oscillator, and lagged posterior target exactly intact.
Add one smooth state-feedback mechanism: gate only the incremental target-helping
posterior half-cycle gain by the minimum normalized headroom in posterior joint
velocity and the previously realized posterior acceleration. The base posterior
wave has unit gain even when the gate closes, so saturation awareness cannot
coast the fish or erase the traveling bend. Expected evidence is the same
compact direct capture with less velocity/acceleration saturation residence and
lower force/moment load; reject the mechanism if capture is lost, trajectory
topology changes, arrival/distance integral regress without a meaningful load
or saturation reduction, or the load history is unchanged.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and residual gait control
source_mechanism: sensor feedback modulates a bounded residual around a persistent low-dimensional propulsive rhythm
transferable_invariant: preserve the traveling base gait and yield only incremental steering authority when observed actuator-state headroom is depleted
nontransferable_details: published CPG gains, robot morphology, species kinematics, dimensional frequencies, exact actuator ratings, vortex phase, and source-task routes
policy_translation: smoothly gate only the target-helping posterior half-cycle residual with normalized posterior velocity and previous-acceleration usage; leave oscillator centers and the unit-gain lagged posterior wave unchanged
falsification: reject if direct target capture or the compact diagonal route is lost, or if arrival and distance integral worsen without reduced load or saturation residence
