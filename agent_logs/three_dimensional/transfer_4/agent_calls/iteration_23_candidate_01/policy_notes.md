# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report direct uniform quiescent initialization,
  `U_infinity=(0,0,0)`, and capture. The duplicate v12 policies reproduce the
  same `18.0125T`, `-0.064599` trajectory, so they establish determinism rather
  than a second mechanism.
- I inspected both rows of the combined keyframe sheets for the current v16
  leader (`solver_f5d69a1ef633`) and the most informative semantic regression,
  the v17 direct target-course residual (`solver_476865f5b913`). In both the
  top-down row shows self-propelled target closure with a coherent alternating
  vorticity street rather than background advection, and the oblique row shows
  organized three-dimensional shed structures persisting through capture.
  Neither sheet shows a wake collapse, domain interaction, or a visually new
  route in v17. The remaining problem is terminal course regulation, not basic
  propulsion.
- Relative to v12, v16's alignment-qualified posterior-wave envelope remains
  inactive through transit and improves path/cross-track from
  `13.2330L/0.7417L` to `13.2111L/0.7232L`, near/final alignment from
  `0.6637/0.0678` to `0.6722/0.1818`, and near/final absolute yaw from
  `1.9970/1.0892` to `1.8883/0.4200 rad/T`. It retains the best sampled mean
  distance, `1.950801L`, but its normalized signed target/velocity course error
  is still `0.5951` on average below `2.10L` and `0.9833` at capture.
- Adding that course error directly to the turn request in v17 is a concrete
  negative result. Capture and the coherent wake survive, and path shortens by
  only `0.0005L`, but score/mean distance regress to
  `-0.064645/1.950875L`, final alignment falls to `0.1640`, final absolute yaw
  rises to `0.5884 rad/T`, and near posterior acceleration-ceiling residence
  rises from `72.47%` to `72.66%`. A direct curvature residual can continue
  demanding the correct turn side while measured yaw is already excessive.
- Inherited score-only results at `-0.064995` and `-0.065308` are consistent
  with no scalar gain opportunity, but lack sampled policy/trajectory evidence
  and are not assigned a mechanism here. Inherited optimizer guidance reports
  that instantaneous posterior half-cycle relief also regressed terminal yaw
  and alignment, so this candidate preserves the symmetric v16 envelope.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and biological terminal approach control
source_mechanism: preserve the propulsive oscillator while sensor feedback supplies a bounded, slower desired turning-rate reference that is closed around measured yaw
transferable_invariant: course error should set a bounded response rate, and feedback should withdraw corrective effort once the measured body turn rate reaches that response, without disturbing the traveling propulsion wave
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific envelopes, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: below the normalized `2.10L` approach boundary, blend from the existing body-frame geometric yaw-rate target toward an odd bounded target derived from the normalized body-frame target/velocity cross product; gate it by measured speed and close the existing rate loop around `turn_rate_recent`, while leaving the v16 posterior wave and envelope unchanged
falsification: reject if the pre-approach trajectory changes, capture or the `1.950801L` sampled-best mean distance is lost, terminal alignment/path/yaw fails to improve, acceleration or rate residence migrates without benefit, reflection equivariance fails, or either visual wake row loses coherence

## One-candidate policy hypothesis

The v17 residual failed because it bypassed yaw-rate feedback and therefore
could reinforce an already fast correct-side rotation before velocity aligned.
This candidate makes course error a terminal desired-yaw-rate reference instead
of a direct bend. A continuous distance/speed authority blends that reference
with the existing geometric target; the measured-rate error then determines
the actual correction. The mechanism is exactly inactive outside the approach,
keeps the v16 allocation and propulsion structure intact, and should preserve
capture while reducing excessive near yaw and signed course error.
