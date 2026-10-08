# Candidate diagnosis and hypothesis

## Evidence reviewed before the edit

- The assigned parent is the prefilled `dogfish_3d_target_normal_power_relief_v24`
  policy. No inherited `logs/optimize/` files were exposed in this rendered
  workspace, so the inherited experiments are taken from the parent
  `guidance/control_experience.md` and the sampled optimizer guidance.
- All four sampled evaluations are valid direct-uniform still-water releases:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  capture termination, and no instability. Thus the motion is self-propelled,
  not ambient advection or a prewarm artifact.
- I inspected the combined top-down/oblique keyframe sheets for all four
  samples, comparing the best-score v20 capture (`-0.0640276`) with the
  prefilled v24 result (`-0.0644074`) and both v25 mechanisms. From release to
  capture, every top-down row develops a coherent, alternating posterior wake;
  the oblique rows show persistent linked 3D vortex structures rather than a
  collapsing or visibly unstable wake. The sheets are nearly
  indistinguishable at their sampling cadence, so scalar differences must be
  interpreted through the trajectory and actuator histories.
- v24 target-normal-power suppression of the whole lagged posterior target
  captured at `17.9960T`, shortened center path to `13.1921L`, and reduced near
  posterior acceleration-ceiling residence to `72.38%`, but ended at only
  `0.0975` course alignment and `1.2697 rad/T` absolute yaw. The v20 yaw-power
  selector scored best but still ended at `0.1092/0.9840 rad/T` alignment/yaw.
  These are not propulsion failures; both retain the coherent two-view wake.
- The v25 positive-work governor preserved the posterior target and reduced
  near posterior acceleration-ceiling residence further to `62.28%`, with
  final absolute yaw `0.8980 rad/T`, but widened the route to `13.2426L`,
  delayed capture to `18.0180T`, and regressed score to `-0.0643357`.
  Posterior positive-work withdrawal therefore changes the load class but is
  too costly as the next route-control mechanism.
- The v25 target-normal-power mean-bend allocation preserved the posterior
  wave and used the load signal only to move a conserved share of the existing
  signed mean tangent forward. Relative to v24 it improved score/mean distance
  to `-0.0640349/1.950361L`, reduced head cross-track from `0.7269L` to
  `0.7189L`, and reduced absolute final yaw from `1.2697` to
  `1.1215 rad/T`, without changing the coherent wake class. However final
  alignment was still only `0.1036`. The load-power selector alone does not
  ensure that forward allocation is acting against the current cross-course
  motion.
- Sampled optimizer guidance reports the complementary boundary: a
  course-consensus allocation improved final alignment/yaw to approximately
  `0.195/0.276 rad/T` but slightly delayed capture and regressed the distance
  integral. This motivates intersecting course consensus with the already
  selective load-power event instead of adding turn magnitude, changing the
  carrier, or sweeping allocation share.

## Policy hypothesis

Start from the sampled v25 target-normal-power mean-bend allocation. Preserve
its evaluated far/middle route, odd target-request-to-curvature map, full
posterior traveling-wave target, state-feedback oscillator, acceleration/rate
envelope, and fixed `35%` maximum anterior share. During approach, shift that
conserved mean tangent forward only when all of the following are observed:

1. the fish is moving but not aligned with the target corridor;
2. target-normal hydrodynamic force is adding kinetic energy to the measured
   cross-course velocity; and
3. the odd, pre-recovery geometric turn request opposes that normalized
   cross-course velocity.

The third condition is a continuous, reflection-invariant course-consensus
gate. Using the pre-recovery geometric request prevents the inherited
direction-specific recovery magnitudes from leaking into this selector. The
gate cannot add mean curvature: the anterior increment is subtracted from the
posterior mean, and it cannot alter the lagged oscillatory posterior wave. The
candidate introduces no clock, stage counter, route coordinate, or scalar gain
sweep.

Expected result: retain capture, the v25 mean-distance/score class, the
coherent two-view wake, and exactly inactive pre-approach behavior, while
improving final alignment and absolute yaw over the load-only v25 allocation.
An offline, no-CFD replay of the sampled v25 observation trace confirms that
the new selector is not inert: it is active on the same 152 qualified near
rows while reducing mean anterior-allocation authority from `0.0832` to
`0.0664` (maximum new authority `0.5507`). A synthetic reflected-observation
check gives identical allocation authority, and the candidate action is
exactly equal to sampled v25 outside the `2.10L` approach region.
Reject the mechanism if capture or the distance integral regresses materially,
if path/cross-track or terminal alignment/yaw fail to improve together, if
actuator pressure migrates forward, if reflection does not produce a reflected
course response, or if either visual wake view degrades.

bookshelf_consulted: true
source_domain: robotic-fish and closed-loop CPG turning by bounded mean-curvature bias while retaining a propulsive rhythm
source_mechanism: target-feedback-qualified redistribution of mean curvature rather than suppression of the traveling posterior wave
transferable_invariant: preserve the propulsive traveling bend and change only the bounded mean-bend allocation when observed target error and directional response agree
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, actuator geometry, exact vortex phase, and prescribed routes
policy_translation: use normalized body-frame target-normal velocity, force, speed, distance, and the odd pre-recovery geometric turn request to gate a conserved anterior/posterior mean-tangent transfer; leave the two-joint state-feedback carrier and posterior lag unchanged
falsification: reject if transit changes, capture or distance integral regresses, yaw and course alignment do not improve together, load migrates to the anterior joint, reflection fails, or the coherent top-down or oblique wake is lost
