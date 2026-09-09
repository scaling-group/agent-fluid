# LOS-response anterior-release candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7825T`. There is no sampled
  termination failure, so the informative relative failure is the weakest
  route/effort allocator against the best finite capture, supplemented by the
  assigned parent and inherited completed controls.
- I inspected the combined top-down and oblique sheets for the best-score
  helpful-moment sample and the weakest-score stress-gated sample from release
  to capture. Both top-down rows show body-led translation and a coherent
  alternating red/blue posterior vorticity street; both oblique rows show
  compact paired three-dimensional Lambda2 structures shed behind the body
  through target closure. Neither shows passive advection, growing wasteful
  sway, collision, boundary approach, wake collapse, or instability. Their
  direct-zero initialization and local-flow RMS of `0.01796--0.01808U` agree
  with self-propulsion, so the nearly indistinguishable sheets do not justify
  ranking these close allocators visually.
- The sampled actuator-consistent no-moment baseline captures at `18.6725T`,
  mean distance `2.02129L`, with anterior/posterior acceleration-limit
  occupancy `42.24%/76.14%` and force/moment RMS `0.01350/0.00703`. Raw
  helpful-moment amplitude relief is fastest at `18.6560T` and lowers those
  quantities to `40.74%/75.77%` and `0.01328/0.00691`, but its `0.0165T`
  timing edge is smaller than the inherited same-hash arrival spread and is
  not a replicated route improvement. Stress-gated moment relief is slower at
  `18.7825T`, while stress-confirmed moment residual allocation captures at
  `18.7440T`; both retain the same wake topology.
- The assigned parent's carrier-demodulated moment replication captures, but
  falsifies its own claimed separation: `18.8650T`, mean distance `2.03488L`,
  `74.69%` posterior occupancy, and `0.01325/0.00689` loads all miss its stated
  `2.02337L`, `74.3%`, and `0.01317/0.00685` route/load bounds. Inherited
  demodulated-amplitude variants are slower still at `18.9750T` and
  `19.1070T` with mean distances `2.04497L` and `2.05106L`; the one-sided
  opposing-moment residual captures at `18.8980T` without a route gain. The
  reusable conclusion is to stop giving moment another allocator role in this
  low-flow lane, not to tune another moment scale.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized bearing-plus-LOS-rate route,
recoil-conditioned yaw response, distributed C-bend, state-feedback traveling
carrier, response-reversing half-cycle steering, persistent same-side actuator
gate, coefficient-norm-preserving posterior phase rotation, and componentwise
feasibility projection. Remove hydrodynamic yaw moment from the prefilled
allocator.

Test one new release mechanism: when the observed LOS-rate response opposes
the bearing-derived yaw request, interpret their bounded normalized alignment
as evidence that the broad redirect is already producing route rotation.
Continuously release at most half of the anterior mean-curvature recruitment
while leaving posterior mean curvature, half-cycle steering, phase
recruitment, and the propulsion carrier intact. At startup, when LOS response
is absent, and whenever LOS motion reinforces rather than counters bearing
demand, the candidate exactly retains full anterior recruitment. This is an
architecture-level response gate, not scalar tuning of the established route.

Support requires capture within the inherited `18.6725--19.0080T` replicated
route band, mean distance no greater than `2.02337L`, coherent wakes in both
views, anterior limit occupancy below the sampled `40.4%` floor without
posterior occupancy exceeding `76.11%`, and force/moment RMS no greater than
the best finite sample's `0.01328/0.00691`. Falsify the mechanism if it loses
capture, slows or bends the approach outside those bounds, weakens either
wake, or merely transfers clipping to the posterior joint. This still-water
test does not establish disturbance rejection.

bookshelf_consulted: true
source_domain: biological burst-redirect turning and sensor-modulated robotic-fish rhythmic control
source_mechanism: recruit strong curvature for a large route error, then release the redirect when measured route response appears while preserving the propulsive rhythm
transferable_invariant: slow body-frame route error should recruit bounded turning authority, observed counter-response should release redundant anterior curvature continuously, and the posterior traveling carrier should remain intact
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body C-start shapes, exact vortex phases, world-frame routes, and task-specific timing
policy_translation: use normalized body-frame bearing and LOS rate to form a reflection-invariant counter-response fraction; reduce only anterior mean-curvature recruitment while preserving the two-joint posterior mean, half-cycle, and phase paths
falsification: reject if capture leaves 18.6725--19.0080T, mean distance exceeds 2.02337L, either wake loses coherence, anterior occupancy does not fall below 40.4%, posterior occupancy exceeds 76.11%, or force/moment RMS exceeds 0.01328/0.00691

## Post-edit signal audit (not CFD evidence)

Replaying only the bounded LOS-release expression on the sampled no-moment
trajectory activates it on `41.03%` of logged states. Anterior authority has
mean/minimum/maximum `0.8866/0.5000/1.0000`, with early mean `0.9471` and late
mean `0.8636`. Thus the candidate retains nearly full redirect during startup,
releases more authority as observed route response develops, and is neither a
no-op nor a global drive reduction. This open-loop expression audit does not
predict the new closed-loop trajectory or claim the current candidate's CFD
outcome.

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
