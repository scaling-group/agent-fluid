# Posterior velocity-headroom phase-allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7385T`. There is no sampled
  termination failure in this workspace, so the informative comparison is the
  best finite capture against the slowest assigned-parent-hash replicate,
  supplemented by the assigned parent's completed step-26 replication and the
  inherited high-pass/left-exit failures.
- I inspected the combined sheets for the best sample
  `solver_0288c0d51d57` and the slowest sample
  `solver_e6174a15bb9d` from release through termination. Their top-down rows
  show body-led translation and a coherent alternating caudal vortex street;
  their oblique rows show bounded three-dimensional Lambda2 structures shed
  behind the body. Neither rollout is passively advected, develops growing
  wasteful sway, loses its turn toward the target, collides, exits, or becomes
  unstable. Distance decreases to capture and local-flow RMS remains
  `0.01806--0.01815U`, consistent with the visual diagnosis.
- The sampled actuator-consistent phase parent captures at `18.6725T` and
  `18.7385T`, with posterior acceleration-limit occupancy
  `75.58--76.14%`, force/moment RMS `0.01327--0.01350/0.00691--0.00703`,
  and posterior velocity-limit occupancy `7.43--7.51%`. Helpful raw-moment
  amplitude relief captures at `18.6560T`, but its `0.0165T` lead is far
  inside the inherited identical-hash `0.3355T` timing spread and it retains
  `75.77%` posterior acceleration occupancy.
- Carrier-demodulated moment allocation is a reproducible effort result, not
  a route-speed result. The sampled rollout captures at `18.7165T` with
  action RMS `24.461/28.558 rad/T^2`, posterior acceleration occupancy
  `74.17%`, and force/moment RMS `0.013093/0.006816`; the assigned parent's
  completed replication captures at `18.7605T` with corresponding values
  `24.494/28.595`, `74.44%`, and `0.013105/0.006822`. Both remain inside the
  parent arrival spread, but posterior velocity-limit occupancy rises to
  `7.73--7.83%`, and the controller still commands outward acceleration while
  posterior velocity exceeds `95%` of its limit during about `9.3%` of
  samples. This is the remaining
  actuator-state mismatch targeted here.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized body-frame bearing/LOS-rate route,
recoil-conditioned yaw response, continuous distributed C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side stress gate, and carrier-demodulated moment-residual
phase allocator. Add one bounded anti-windup semantic: calculate the
incremental acceleration requested by posterior phase rotation relative to
the already successful half-cycle path, and smoothly withdraw only that phase
increment when it would accelerate an already near-velocity-limit posterior
joint farther outward. Phase authority that brakes the joint is retained.
The product of posterior velocity and incremental phase acceleration is even
under reflection, so the gate does not encode a turn side, time, range stage,
world direction, or memorized route.

Support requires capture with both wake views coherent, arrival inside the
replicated `18.6725--19.0080T` band, posterior velocity-limit occupancy below
`7.5%`, posterior acceleration occupancy below `75.0%`, and force/moment RMS
no greater than `0.01320/0.00690`. Falsify the mechanism if capture is lost,
arrival or distance-integral score worsens outside replicate spread, the
velocity occupancy does not decrease, load relief disappears, or either wake
view loses coherence. Do not infer disturbed-flow robustness from this
direct still-water test.

bookshelf_consulted: true
source_domain: sensor-feedback modulation of rhythmic robotic-fish control and phase-lag steering
source_mechanism: preserve the propulsive rhythm while observed actuator response continuously modulates a bounded steering phase contribution
transferable_invariant: retain useful traveling-wave and route feedback, but withdraw only rhythmic authority that drives an actuator farther into a measured physical constraint while preserving authority that restores headroom
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, organized-wake synchronization, and task-specific routes
policy_translation: use normalized posterior joint velocity and the reflection-even product with incremental phase acceleration to gate only carrier-demodulated posterior phase rotation within the two-joint state-feedback contract
falsification: reject if capture leaves 18.6725--19.0080T, posterior velocity occupancy is not below 7.5%, posterior acceleration occupancy is at least 75.0%, force/moment RMS exceeds 0.01320/0.00690, or either wake view degrades

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
