# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet confirms the common held-fish condition: four
  developed, interacting streets surround the second-row target while the fish
  waits above and downstream. It is initial-condition evidence, not a policy
  comparison.
- No sampled failure keyframe sheet exists in this workspace. The strongest
  distinct success (`solver_2b5646fbb020`) and the weaker prefill
  (`solver_107fd6f7f029`) both actively self-propel leftward through the wake;
  their coherent posterior wakes and roughly `-10.91L` head displacement rule
  out passive advection as the primary transport. The inherited wholesale
  slower/smaller carrier failure remains a textual boundary: instability after
  `121.517` with RMS force/moment `16749.8/290421`.
- The prefill makes a steep corrective turn and reaches after `46.035`, with
  mean distance `2.0695L`, total/mean command energy `56948/1237.1`, and RMS
  force/moment `51.40/761.46`. The half-cycle sibling aligns into the leftward
  corridor earlier, holds a shallower direct approach, and reaches after
  `36.471`, improving mean distance to `1.6860L` and total energy to `48700`.
  Its speed comes with higher mean effort `1335.3`, relative crossflow `0.2397`,
  and RMS force/moment `63.59/953.42`; both joints also touch speed and
  acceleration limits. Thus phase-selective steering is a validated fast-route
  mechanism, but its extra authority has an evidenced load/effort tradeoff.
- The other sampled role-separated controller arrives after `45.727` with
  force/moment `49.36/799.31`; its duplicate artifacts are not independent
  mechanism tests. Raw bearing should continue to own reservation, while
  course slip remains confined to the steering residual.

## Candidate hypothesis

Start from the evaluated half-cycle policy and add one continuous terminal
approach schedule. Preserve the `0.55`-period joint-state carrier, posterior
lag, slip-corrected mean steering, raw-bearing reservation, far-field
half-cycle asymmetry, joint split, and `30.0` envelope. Use normalized
`state.distance_L` to taper only the extra phase-selective asymmetry inside a
candidate-owned approach scale; mean target steering and propulsion remain
available all the way to capture.

This tests whether the fast policy's phase redistribution is most valuable for
the initial redirect but unnecessarily raises late corrective authority. Retain
the mechanism only if capture and the direct upstream route survive while
arrival remains near `36.471` and mean effort, force, moment, or limit contact
improves. Falsify it if capture is lost, arrival regresses toward `45.727`
without a material load benefit, or the posterior wake loses coherence. This
candidate receives CFD evaluation only after this worker exits.

bookshelf_consulted: true
source_domain: biological burst redirect and terminal capture control around rhythmic fish swimming
source_mechanism: geometry-gated release from strong redirect into a lower-excess approach while preserving the traveling propulsive carrier
transferable_invariant: large route error can justify phase-selective steering, but extra redirect authority should recede continuously as normalized target distance closes while baseline propulsion and target correction remain
nontransferable_details: published gains, dimensional distances and beat rates, species kinematics, clocked stages, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: preserve the sampled body-frame bearing/slip half-cycle controller and multiply only its added asymmetry by a bounded function of current normalized `distance_L`
falsification: reject if target reach or coherent propulsion is lost, arrival materially regresses without lower effort or loads, or late approach remains equally saturated
