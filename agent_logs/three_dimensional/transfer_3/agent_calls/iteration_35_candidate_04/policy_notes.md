# Response-releasing anterior C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, zero cylinders, finite dynamics, and
  capture. Their arrival band is `18.6560--18.7330T`; three exact
  `dogfish3d_actuator_consistent_tail_phase_v1` instances span
  `18.6725--18.7330T`, scores `-0.13362-- -0.13142`, and mean distance
  `2.01959--2.02129L`. The helpful-moment allocator's `0.0165T` one-run edge
  remains smaller than exact-policy timing variation and is not replicated
  mechanism evidence.
- I inspected the best current finite sheet (`solver_0f8ee73693ab`) and the
  inherited odd-phase observer failure (`solver_0212ec86c755`) from release to
  capture in both the top-down vorticity and oblique Lambda2 views. The exact
  route forms a body-led alternating wake by `4T`, maintains a compact
  posterior 3D vortex street, and approaches the target smoothly without
  passive advection, collision, wake breakup, boundary contact, or numerical
  instability. Its local-flow RMS is only `0.01804U`, and its force/moment RMS
  is `0.01335/0.00695`.
- The failed phase observer also retains a coherent self-generated wake, but
  visible translation is weaker at `4T`, route closure is delayed, and a much
  larger late turn is needed. The diagnostics agree: capture moves to
  `22.0110T`, mean distance rises to `2.31828L`, and score falls to `-0.42356`.
  Lower posterior saturation and load therefore came from sacrificing useful
  early route/carrier coupling, not from a better causal response estimate.
  This rules out another fitted instantaneous recoil observer or a wholesale
  carrier/phase rewrite in the present low-flow lane.
- The recovered exact route still spends about `41%/75%` of samples at the
  anterior/posterior acceleration limits. The anterior redirect center is
  commanded from route demand alone even when its existing recoil-conditioned
  yaw estimate already points with that demand. An offline, noncausal-free
  audit of the recovered trace shows a bounded aligned-response factor would
  reduce the active redirect center by about `20%` on average and would be
  nontrivial during about two thirds of redirect samples. This audit chooses
  the feedback structure only; it does not claim the future CFD response.

## Policy hypothesis recorded before the policy edit

Preserve the evaluated normalized bearing-plus-LOS-rate route, the
posterior-lagged state-feedback carrier, response-reversing half-cycle scale,
persistent same-side phase recruitment, and componentwise feasible-action
projection exactly. Change only the anterior C-bend allocation: when the
existing recoil-conditioned yaw response has the same sign as the requested
yaw, continuously release at most `35%` of the anterior mean center. Opposite
or absent response retains full redirect authority. The response product is
reflection-invariant, normalized by the larger of squared route demand and
the existing yaw-error scale, and clipped to `[0,1]`; the translated command
therefore remains bounded, body-frame, and state-feedback-only.

This is a C-start-style response release, not a new response observer and not
scalar-only gain tuning. It should retain early propulsion and posterior route
closure while avoiding redundant anterior mean bend after helpful yaw has
appeared. Support requires capture inside the inherited
`18.6560--18.7935T` useful band with coherent wakes in both views and mean
distance no greater than `2.02129L`; an effort benefit additionally requires
anterior occupancy or force/moment load to separate below the exact-route
bands without raising posterior occupancy. Reject it on lost/delayed capture,
weaker early translation, a more curved late route, broken wake coherence, or
load/occupancy outside the recovered envelope.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish rhythmic control
source_mechanism: apply strong bounded curvature for large route error, then release it when the observed heading response appears while retaining the propulsive rhythm
transferable_invariant: route curvature should be response-releasing rather than persist after helpful yaw is already present, while a directed posterior-lagged traveling bend remains primary
nontransferable_details: species-specific C-start kinematics, published gains, dimensional frequencies, full-body waveforms, exact maneuver phases, vortex phases, and task-specific routes
policy_translation: multiply only the existing anterior mean-curvature center by a bounded reflection-invariant aligned-yaw-response release; preserve normalized LOS guidance, the two-joint carrier, posterior phase actuator, and hard limits
falsification: reject if capture leaves 18.6560--18.7935T, early translation or either wake weakens, mean distance exceeds 2.02129L, or occupancy/load fails to improve without a route penalty

The current candidate's CFD evaluation occurs only after this worker exits and
is not evidence in these notes.
