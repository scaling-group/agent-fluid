# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts report direct uniform initialization at
  `U_infinity=(0,0,0)`, no cylinders, finite dynamics, and self-propelled
  `left_domain` termination. No visible translation is ambient advection or a
  prewarm artifact.
- The phase-compensated bearing and bearing/course rate-loop samples
  (`solver_5c5f9d80447b` and `solver_95d1e880b3e5`) keep coherent alternating
  top-down vortex streets and compact oblique Lambda2 structures, but pass
  above the target at `3.0031L` and `3.1135L`. They keep swimming to the left
  boundary rather than suffering a numerical or wake instability.
- The useful terminal samples (`solver_a8af0d71b0de` and
  `solver_213717a6b100`) turn below the target and reach `1.2669L` and
  `1.5454L`. Both visual rows show coherent broad-approach propulsion. The
  half-cycle attenuation case then lays down little substantial new terminal
  wake and coasts at about `0.78--0.85L/T`; the posterior-mean-curvature case
  preserves more wake but retains the same lower exit. Together with the
  inherited cadence-relief and energy-guard failures, this rejects deeper
  carrier suppression or another terminal route-gain edit as the next test.
- The achieved-course signal itself is beat-contaminated. Beat-centered
  regression over `4--22T` shows body-frame lateral velocity is predicted by
  the two observed joint velocities with `R^2=0.903--0.986` across the four
  sampled policies; the corresponding longitudinal fits are only
  `R^2=0.018--0.179`. The lateral coefficients also keep the same signs and
  comparable scales across the upper-pass and lower-pass families. In the
  closest sampled route, the instantaneous course residual changes from
  `+0.195 rad` at `4L` to `-0.127 rad` at `3L`, then back to `+0.260 rad` at
  `2L`, while the fish ultimately crosses below the target. Feeding those
  within-beat reversals directly to the slow steering actuator is not a
  reliable terminal slip estimate.

## One candidate mechanism

Restore the evidenced achieved-course servo's intact traveling-bend carrier
and bounded shared-acceleration steering, without cadence relief, opposing-half
attenuation, or terminal mean-curvature blending. Before computing course
angle, subtract only the joint-velocity-predicted lateral beat component from
`velocity_body_U[2]`; leave longitudinal velocity unchanged. Gate this
correction continuously by normalized joint phase-plane energy so the policy
falls back to raw velocity before an informative carrier exists. The resulting
target-versus-compensated-course residual remains normalized, body-frame,
reflection equivariant, state feedback, and owned entirely by policy
parameters.

Expected test: preserve far-field wake coherence and distance closure while
removing beat-scale steering sign reversals, start the required terminal
course correction before the raw residual saturates, and cross the `0.75L`
capture circle without extinguishing the carrier.

Falsification: reject if early distance closure or the alternating wake
weakens, the compensated lateral velocity develops a persistent wrong sign,
joint saturation or load spikes grow, closest approach does not beat the
`1.0435L` inherited course-servo miss, or the same upper/lower
`left_domain` topology remains. A later worker should then test a genuinely
longer-window course estimator or bounded yaw/slip response feedback rather
than tune these phase coefficients or suppress the carrier again.

## Bookshelf transfer record

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and rhythmic-locomotion feedback separation
source_mechanism: preserve a propulsive rhythm while a slow direction loop rejects fast phase-correlated body motion instead of treating it as route error
transferable_invariant: separate the observed fast rhythmic component from the persistent body-frame course signal before applying bounded steering feedback
nontransferable_details: published CPG gains, dimensional cadence, robot or species kinematics, prescribed phases, exact vortex timing, and task-specific routes
policy_translation: estimate only the lateral beat component from the two observed joint velocities, subtract it from normalized body-frame velocity under a joint-energy gate, and feed target-versus-compensated-course error to the two-joint bounded steering law
falsification: reject if wake coherence or early closure degrades, corrected course has a persistent wrong sign, actuation saturation grows, or neither closest approach nor termination class improves

## Non-CFD verification

- The configured synthetic-state contract returns two finite accelerations
  inside the owned `1800 deg/T^2` bound. Static schema inspection found no
  `params.FIELD` reference missing from `target_policy_params()`, and mirrored
  target, velocity, joint-angle, and joint-velocity states produced exactly
  sign-reversed actions.
- Replaying sampled states through the new observation equation changed the
  closest lower-pass trace's raw course residuals at `4L/3L/2L` from
  `+0.195/-0.127/+0.260 rad` to `+0.410/+0.209/+0.413 rad`. In the preserved-
  carrier mean-curvature trace they changed from `-0.052/+0.060/+0.352 rad`
  to `+0.325/+0.210/+0.658 rad`. The energy gate stayed within `0.872--0.966`
  at those sampled approach states. This verifies the intended phase removal
  and sign stabilization only; it is not CFD evidence of capture or a better
  trajectory.
- The required guidance-change, policy-contract, and solver-boundary checks
  all pass. Formal CFD remains deferred to EvE after this worker exits.
