# Candidate diagnosis and hypothesis

## Assigned and sampled evidence

- The assigned parent is the acceleration-feasible, LOS-response-triggered
  distributed C-bend. Its sampled rollout captures at `19.283T` with score
  `-0.182182`, mean distance `2.071L`, and direct uniform initialization.
- All four sampled examples are finite captures (`19.283--19.888T`, scores
  `-0.182182-- -0.208236`). The two examples with identical unbounded
  response-triggered policy SHA capture at `19.585T` and `19.888T`; that
  `0.303T` spread is evidence that small single-run score differences are not
  a sound reason for scalar gain tuning. The slower informative contrast is
  the intercept-gated C-bend, which still captures at `19.784T`.
- The top-down sheets show self-propelled motion from the upper right and a
  coherent alternating vortex street in every rollout, rather than passive
  advection from the zero background flow. The oblique Lambda2 sheets show
  compact alternating three-dimensional loops through capture without a
  growing asymmetric wake or instability. Thus the carrier is useful and
  should not be retuned.
- The terminal trajectories differ despite the common carrier: the feasible
  parent reaches the capture circle from the east at head `(9.745, 9.435)L`,
  while the two identical unbounded-policy samples finish from the upper side
  at `(9.422, 10.119)L` and `(8.877, 10.237)L`. The intercept-gated sample also
  finishes high at `(9.242, 10.208)L`. Across the sampled traces, local-flow
  RMS is only `0.0181--0.0188U`, force RMS `0.0126--0.0138`, and moment RMS
  `0.0066--0.0072`; no wake disturbance justifies a new rejection loop.
- Reconstructed body-frame approach geometry shows the parent at `18T` has
  range `1.594L`, positive closing speed `0.753U`, and projected miss
  `0.208L`, yet its bounded route demand remains large and continues to
  recruit anterior redirect. This is a concrete response-defined opportunity
  to release the burst without weakening far/mid steering or the posterior
  traveling bend.

## Policy hypothesis

Add one continuous terminal-corridor release to the assigned parent. Preserve
the state-feedback carrier, LOS-rate route request, response-triggered anterior
recruitment, posterior mean curvature, and explicit acceleration feasibility.
Only attenuate the anterior mean C-bend when all three body-frame observations
agree that the fish is near, closing, and projected to pass inside a bounded
capture corridor. This should remove unnecessary late broad-body curvature
while leaving posterior steering and propulsion active. It is falsified if the
new rollout loses capture, increases arrival time/distance integral beyond the
sampled `19.28--19.89T` band, or visibly disrupts the alternating wake.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish rhythm modulation
source_mechanism: recruit bounded body curvature for a large route error, then release it into the propulsive rhythm when observed response establishes the turn
transferable_invariant: strong redirect authority should be response-gated and released continuously once measured approach geometry shows that the remaining correction is feasible
nontransferable_details: species-specific C-start kinematics, published CPG gains, exact beat or vortex phase, dimensional thresholds, and task-specific routes
policy_translation: preserve the joint-state carrier and posterior LOS response; use normalized body-frame range, closing velocity, and projected miss only to soften the anterior mean bend inside a terminal corridor
falsification: reject if capture is lost, time or distance integral worsens beyond sampled variability, acceleration feasibility is violated, or the coherent alternating wake breaks down

## Lightweight verification

- Replaying the four completed observation traces through the new guidance
  (without advancing CFD) gives a maximum release weight of only `0.0022`
  outside `3L`, so evaluated far/mid recruitment is materially unchanged.
- At `18T`, release is selective: `0.978` for the feasible parent's safe
  `0.208L` projected miss, `0.900` for the second safe `0.332L` pass, only
  `0.235` for the marginal `0.628L` pass, and `0.009` for the unsafe `0.896L`
  pass. The authority floor keeps at least `20%` of the recruited anterior bend.
- Synthetic far, safe-near, unsafe-near, and reflected states return finite
  accelerations within `1800 deg/T^2`; mirrored state/action pairs agree to
  `1e-12` while the safe-near case releases and the unsafe-near case does not.
