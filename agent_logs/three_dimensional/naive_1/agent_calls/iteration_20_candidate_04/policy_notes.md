# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract and
  capture. Their combined sheets show self-propelled, coherent alternating
  top-down streets and compact caudal Lambda2 structures from release through
  approach; there is no prewarm or passive-advection signature.
- The assigned prefill captures at `18.7550T`, score `-0.20743`, and scored mean
  distance `2.09542L`. Two executable baseline repeats capture at
  `18.6505--18.6835T`, score `-0.20606-- -0.20578`, and mean distance
  `2.09340--2.09405L`. This bounds the observed baseline score spread at about
  `0.00165`.
- The only material sampled architecture change redistributes the parent's
  target-error amplitude relief between joint-displacement half-cycles. It
  retains capture and the same wake class, improves score to `-0.20041`, and
  lowers scored mean distance to `2.08855L`. Its `11.07%/14.93%` joint-rate
  contact and `60.85%/73.27%` acceleration contact remain in the baseline
  bands, so it is not evidence of demand relief. One rollout is insufficient
  to distinguish a repeatable route improvement from CFD variability.
- Inherited optimizer logs also contain severe `left_domain` results after
  architectural ablations, including minima of `3.426L` and `1.007L`; the
  parent guidance attributes the relevant failures to velocity-led phase and
  removal of the non-inverting response-release gate. Those components stay
  excluded.

## Policy hypothesis

Replicate the one evidenced half-cycle envelope-redistribution mechanism
exactly while preserving displacement-only phase, target-owned turn sign,
differential mean curvature, posterior lag, response release, and final hard
acceleration projection. If the mechanism is real, a second evaluation should
retain capture and the coherent two-view wake while keeping scored mean
distance below the baseline-repeat band. Reject the mechanism if capture is
lost, the route reverts to the baseline band, or wake/load/saturation evidence
worsens materially. No same-worker CFD outcome is claimed.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: half-cycle amplitude asymmetry redistributes rhythmic effort during a requested turn
transferable_invariant: use observed beat side to move bounded effort toward the useful half-cycle without changing the persistent target-owned turn sign
nontransferable_details: published gains, duty ratios, clock phase, species-specific kinematics, exact vortex phase, and task-specific routes
policy_translation: modulate normalized target-error amplitude relief with anterior-joint displacement phase while preserving cycle-mean relief and the two-joint curvature carrier
falsification: reject if capture or coherent propulsion is lost, scored mean distance does not remain outside the baseline-repeat band, or saturation and loads enter a worse class
