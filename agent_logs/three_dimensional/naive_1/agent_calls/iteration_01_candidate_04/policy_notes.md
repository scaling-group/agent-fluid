# Wake-policy candidate notes

## Evidence diagnosis

- The assigned parent guidance is the unchanged fresh-lineage contract; no
  inherited optimizer log is present in this workspace. The only sampled
  solver is therefore both the best finite example and the informative
  failure available for this first architecture proposal.
- `solver_0718f4efab03` is a valid direct-uniform still-water rollout
  (`U_infinity=(0,0,0)`, no prewarm, no cylinders). It terminates
  `left_domain` at `8.613 T`: distance changes from `12.328 L` to a best
  `12.064 L` and then to `12.351 L`, so the apparent motion gives only
  `0.264 L` best progress and negative net progress.
- In the top-down row, the initially compact wake develops into a coherent
  alternating street, but the entire street bends into an upward arc. The
  fish passes the target-aligned direction near `4 T` and continues rotating
  until it points and translates toward the top boundary. The oblique
  Lambda2 row confirms self-propulsion and a three-dimensional caudal wake;
  there is no visible ambient advection to explain the exit.
- The trajectory cross-check agrees: body heading changes from `0.506` to
  `-0.739 rad`; reconstructed body-frame bearing changes from `0.155` to
  about `-1.14 rad`; final world velocity is approximately
  `(-0.213, 0.466) U`. Raw requested joint accelerations exceed the
  `1800 deg/T^2` envelope on about `32.8%` and `33.5%` of samples, although
  joint angles remain below their hard limit. Thus the carrier makes a wake,
  but it neither observes nor corrects accumulated turn and its coherent wake
  is not evidence of target control.

## Policy hypothesis

Keep the seed's state-feedback oscillator and posterior lag as the propulsion
carrier. Add one bounded mean-curvature mechanism to the posterior target:
body-frame bearing requests the turn, and normalized recent yaw rate opposes
overshoot. The sign follows the repository's FSI calibration that positive
joint curvature produces negative yaw. This should arrest the seed's
one-sided startup turn near target alignment while retaining the traveling
bend. The new CFD result is not available in this worker; reject the
hypothesis if it retains `left_domain`, fails to improve minimum/net distance,
reverses the requested turn, destroys the coherent posterior wake, or makes
limit-clipped actuation more persistent.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and classical fish mean-curvature turning
source_mechanism: sensor-modulated rhythmic gait with a bounded average bend for turning
transferable_invariant: preserve the propulsive rhythm while a signed target error sets bounded mean curvature and measured yaw rate damps overshoot
nontransferable_details: published gains, species-specific joint envelopes, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: map normalized body-frame bearing and recent yaw rate to a saturated posterior mean-curvature target within the two-joint state-feedback oscillator
falsification: reject if turn sign is wrong, target progress or termination does not improve, the posterior wake loses coherence, or actuator clipping becomes more persistent
