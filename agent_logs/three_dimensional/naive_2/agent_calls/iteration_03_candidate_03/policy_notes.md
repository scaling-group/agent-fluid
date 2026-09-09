# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no cylinders, and no prewarm. All terminate by leaving
  the upper virtual boundary in `8.79--9.25T`; none captures the target.
- In both visual rows, `solver_77089a0404da` preserves a coherent alternating
  mid-plane/3D tail wake and visibly self-propels. Relative to the sampled
  posterior mean-curvature failure `solver_4b909c5b2efc`, its shared half-cycle
  acceleration asymmetry increases leftward center travel from `1.056L` to
  `2.041L` and improves minimum distance from `12.056L` to `11.347L`, while
  keeping requested accelerations below `30 rad/T^2` instead of exceeding
  `100 rad/T^2` posteriorly.
- The semantic failure remains directional. The best rollout's reconstructed
  normalized body-frame bearing changes from about `+0.118` to negative by
  `3--5T`, reaches about `-0.62`, and ends at `-0.617`; center y nevertheless
  rises from `14.0L` to `15.202L` before upper-boundary exit. The oblique row
  confirms a self-generated vortex chain rather than passive advection. Both
  joint rates still touch the `260 deg/T` limit. Thus stronger carrier gains or
  more static curvature would not address the observed centerline overshoot.
- The inherited parent lesson correctly rejects more static-mean-curvature and
  scalar-gain variants. The newly sampled best result supports its proposed
  half-cycle mechanism, but falsifies the candidate's lateral-velocity-only
  release as sufficient: a useful wake and better x progress coexist with the
  same upper-exit topology.

## Policy hypothesis

Retain the evidenced joint-state traveling carrier and shared, posterior-heavy
half-cycle acceleration asymmetry. Replace the failed lateral-slip release with
a bounded lead term from `bearing_window_rate`: when bearing is sweeping toward
zero, the lead reduces and then reverses half-cycle authority before the body
crosses deeply; when error grows, proportional bearing restores authority. This
is a feedback-structure change, not carrier gain tuning, and uses only normalized
body-frame/task observations and joint state. The next CFD evaluation should
retain the alternating wake, reduce bearing overshoot and rate-limit contact,
delay or avoid upper-boundary exit, and improve both minimum and final distance.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: sensor feedback modulates half-cycle amplitude or duty asymmetry while preserving the locomotor rhythm, then releases steering as the directional response develops
transferable_invariant: separate the propulsive carrier from bounded state-feedback steering and use measured error trend to brake an established turn before overshoot
nontransferable_details: published gains, dimensional frequencies, clocked oscillator phase, robot hardware, species kinematics, exact vortex phase, and task-specific paths
policy_translation: retain the joint-state traveling bend; use bounded body-frame bearing plus its short-window trend to select shared posterior-heavy half-cycle acceleration asymmetry under smooth acceleration limits
falsification: reject the transfer if the alternating 3D wake weakens, joint-limit occupancy rises, bearing still grows after centerline crossing, or neither closest approach nor termination topology improves over solver_77089a0404da
