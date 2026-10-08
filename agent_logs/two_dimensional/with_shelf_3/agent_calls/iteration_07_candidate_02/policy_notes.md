# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets; it is a common initial condition, not
  candidate-specific evidence. All four sampled released sheets end in direct
  first capture, and no sampled failure sheet is available. The useful visual
  comparison is therefore the strongest finite rollout against the distinct
  slower successes, while inherited logs supply the failure boundary.
- The assigned parent (`solver_32a951081f95`) preserves the `0.55`-period,
  `28 deg` posterior-lagged traveling bend, filtered body-frame bearing, bounded
  `12 deg` total mean curvature, and bearing-conditioned `40/60 -> 35/65`
  allocation. Its keyframes show an immediate targetward rotation, active
  body-generated wake, and compact diagonal crossing; metrics confirm capture
  at `35.0625`, `1.73388L` mean distance, and `50,174.96` total command energy.
- The strongest distinct sample (`solver_98f1bdc8648a`) leaves that scaffold
  intact and adds a small bearing-gated gain only to the posterior wave
  half-cycle whose sign helps the requested turn. Its sheet retains the direct
  topology and reaches at `32.4720`, with `1.64761L` mean distance and
  `46,287.66` total command energy: improvements of `7.39%`, `4.98%`, and
  `7.75%` relative to the parent. Mean command energy falls only `0.39%`, so
  lower total effort is chiefly a shorter-episode consequence.
- Placement of the asymmetry matters. The alternative sample
  (`solver_743ad303451c`) modulates the anterior/posterior mean-curvature split
  by half-cycle instead of the posterior propulsive wave. It still captures,
  but regresses to `35.4310` arrival, `1.75151L` mean distance, and `50,815.23`
  total command energy. Its force and moment RMS are lower (`50.01`, `741.22`),
  whereas the faster posterior-wave candidate raises them to `68.70` and
  `931.60`, `21.43%` and `17.37%` above the parent. Both alternatives touch the
  joint velocity and acceleration envelopes, so the winning result establishes
  faster navigation at this wake phase, not actuator headroom or robustness.
- The informative inherited failure remains the bearing-window-rate child:
  its documented rollout never sustains the traveling bend, moves downstream,
  exits the domain after `16.956`, and approaches no closer than `12.424L`.
  This candidate therefore does not add route-rate, force, moment, or crossflow
  feedback to the oscillator center.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric flapping and elongated-body reactive propulsion
source_mechanism: preserve a posteriorly lagged traveling wave while strengthening only the target-helping posterior half-cycle under persistent direction error
transferable_invariant: slow body-frame target geometry should set bounded mean curvature, while observed joint state may gate a small sign-symmetric posterior propulsive asymmetry without introducing an external clock or replacing the traveling wave
nontransferable_details: published gains, duty ratios, dimensional frequencies, species-specific kinematics, exact vortex phases, actuator limits, and source-task routes
policy_translation: retain the sampled filtered bearing, total-curvature allocation, oscillator, and posterior lag; infer posterior wave side from anterior joint angle and velocity, then apply the already evaluated bounded gain only on the bearing-congruent posterior half-cycle and recover the symmetric wave at alignment
falsification: reject or retreat from the mechanism if held-out wake phase or target geometry loses capture or the direct topology, if arrival and mean distance cease improving over the scheduled-allocation parent, or if its higher force and moment RMS produce instability or no navigation benefit

## Candidate hypothesis

Promote the strongest completed posterior half-cycle policy exactly, rather
than extrapolating another gain or combining it with an unevidenced residual.
Persistent filtered bearing continues to set the bounded mean-curvature request
and its bearing-conditioned allocation. Current anterior joint state implies the
posterior wave phase; only the target-helping half-cycle receives at most an
`8%` bearing-gated gain, and the evaluated symmetric traveling wave is recovered
continuously as alignment is reached.

The expected downstream evaluation is reproduction of direct target capture
near `32.472` released time and `1.648L` mean distance. The completed sample is
the reason for the exact parameters. Higher force and moment RMS remain an
explicit tradeoff and robustness falsifier; no new CFD benefit is claimed by
this worker.
