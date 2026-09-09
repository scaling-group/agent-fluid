# Wake-policy candidate notes

## Evidence diagnosis before policy edit

All four sampled evaluations satisfy the direct-uniform still-water contract
and terminate in capture. The three geometry-only policies are executable-
identical despite comment hashes. Their combined sheets show the same useful
mechanism from release through capture: a target-directed alternating
top-down street remains attached to a traveling bend, while the oblique row
retains compact alternating caudal Lambda2 structures. The response-coupled
prefill has the same visual topology. There is no sampled termination failure
or wake collapse; `solver_6237b046a5e7` is therefore the informative weak
finite comparator rather than a failure image.

The geometry-only repeats capture at `18.6505--18.7550T`, score from
`-0.20743` to `-0.20578`, and mean distance `2.09340--2.09542L`; their joint-rate
contact is about `10.9--11.2%`/`14.8--15.1%` and acceleration contact about
`60.7--61.0%`/`73.1--73.2%`. The response-coupled prefill captures at
`18.6615T` with mean distance `2.09362L`, inside those repeat bands, so its
extra gait/response coupling is not attributable. The late route remains
forward aligned (`target_body_L` forward direction cosine at least about
`0.85`) but its lateral fraction still ranges to roughly `0.51--0.55` in some
runs. This supports preserving propulsion, route sign, displacement-only
phase, response release, and posterior lag while isolating a small near-field
geometry envelope. The inherited posterior-compensation and velocity-led
terminal failures rule out changing the posterior wave or adding velocity to
route curvature.

Trajectory cross-checks agree with the visual comparison: all four rollouts
have mean/max normalized planar force near `0.0131/0.0333`, mean/max yaw
moment near `0.0068/0.0175`, local-flow magnitude near `0.0174/0.0258`, and
relative-flow magnitude near `0.67/0.91`. Distance increases on only about
`2.6%` of logged steps. Thus neither the response-coupled prefill nor the weak
finite repeat reveals a distinct advection, load-spike, or crossflow mechanism
that should be promoted into route feedback.

No inherited optimizer log is present under `logs/`; the assigned parent
guidance and the three sampled guidance banks provide the inherited negative
and replication evidence used here.

## Policy hypothesis

Restore the replicated geometry-only amplitude schedule by removing the
unattributable response-gate multiplier. Add one continuous approach gate from
normalized `distance_L`; only when the target is both near and laterally
misaligned does it add a small whole-wave amplitude relief. Absolute
differential-curvature shares remain unchanged, so the mechanism increases
their authority relative to rhythm without changing their sign. Full gait is
preserved near the target when body-frame alignment is good.

Expected result: retain capture, the two-view coherent wake, and the
`2.0934--2.0954L` sampled route band while reducing late lateral excursion or
late rate/acceleration contact. Reject the mechanism if it loses capture,
distorts either wake row, shifts arrival/mean distance outside finite repeat
variation without a load benefit, or reproduces the slower velocity-led
terminal topology.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and path-following control
source_mechanism: continuous far-to-near gait-envelope transition after route control is established
transferable_invariant: near-field target geometry may rebalance propulsion and curvature without changing route sign or beat phase
nontransferable_details: published gains, species kinematics, exact vortex phases, task routes, and dimensional approach distances
policy_translation: preserve the evidenced two-joint carrier and add a bounded normalized-distance gate only to the existing body-lateral-error whole-wave relief
falsification: reject on lost capture or wake coherence, departure from the sampled route band without lower late demand, or a slower terminal trajectory like the inherited range-plus-velocity compound
