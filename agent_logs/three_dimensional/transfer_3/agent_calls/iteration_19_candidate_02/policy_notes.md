# Saturation-gated posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders, finite dynamics,
  and capture termination. The best and assigned-parent combined sheets both
  show body-led self-propulsion. Their top-down rows retain coherent alternating
  posterior vortex streets from release through capture, and their oblique rows
  retain compact paired three-dimensional Lambda2 structures. Neither visible
  view shows advection, wake collapse, collision, or numerical instability.
- The response-reversing half-cycle policy is replicated rather than supported
  by a single scalar: the same policy hash captures at `18.9310T` and
  `19.0520T`, with mean distance `2.0418--2.0486L`. Across those runs its action
  RMS is `24.85--25.22/28.75--28.86 rad/T^2`, force/moment RMS is
  `0.01330--0.01357/0.00692--0.00707`, and local-flow RMS is
  `0.01825--0.01843U`. It is already ahead of the parent by `16T` and preserves
  the coherent carrier, so its half-cycle response path is the baseline to
  retain.
- The sampled always-active fixed-norm phase rotation also captures, at
  `18.9970T` with mean distance `2.0480L`, but lies inside rather than improves
  the half-cycle replication band. It modestly lowers action RMS to
  `24.55/28.59`, force/moment RMS to `0.01317/0.00685`, and posterior
  acceleration-limit occupancy to `74.1%`, versus `75.0--76.1%` for the two
  half-cycle runs. Thus phase timing remains physically useful, but applying it
  throughout the response is not an evidenced semantic improvement.
- The assigned parent reallocates compatible posterior mean curvature to the
  anterior joint while conserving total slow bend. It captures more slowly at
  `19.2390T`, raises mean distance to `2.0610L`, and trails at `16T`
  (`3.100L` versus `2.839--2.889L` for the half-cycle replications), even though
  its action/load and limit occupancy are lower. Together with the inherited
  high-pass miss and delayed near-range allocation logs, this rules out more
  curvature allocation, range gating, or scalar authority as the next test.
- The remaining concentrated defect is actuator realization: the proven
  half-cycle carrier spends `75.0--76.1%` of posterior samples at the physical
  acceleration bound. The always-active phase variant reduces that occupancy
  slightly without wake or capture loss, providing evidence to test phase
  timing only when the observed actuator history says the posterior waveform
  is being clipped.

## Policy hypothesis recorded before editing

Start from the replicated response-reversing half-cycle policy, preserving its
normalized body-frame bearing and LOS-rate route request, recoil-conditioned yaw
response, continuous two-joint C-bend, traveling-wave carrier, and explicit
physical output projection. Add one mechanism: a bounded coefficient-norm-
conserving posterior phase rotation whose smooth activation is formed from the
absolute previous posterior action normalized by the owned acceleration limit.
The rotation direction remains the reflection-invariant product of yaw-response
error and observed joint-phase gradient. Below the clipping neighborhood the
policy is exactly the replicated half-cycle baseline; near the bound it changes
wave timing rather than mean curvature, coefficient norm, or the actuator
limit. `previous_action` supplies one-step actuator state without a clock,
mutable memory, fixed route, or exact vortex phase.

The candidate is supported only if it retains capture and either arrives before
`18.931T` or stays within the `18.931--19.052T` replication band while reducing
posterior limit occupancy or load beyond ordinary replicate spread. Falsify it
if capture is lost, arrival exceeds `19.052T` without a material load benefit,
the alternating wake weakens, posterior occupancy exceeds `76.4%`, or
force/moment RMS exceeds the inherited failed branch's `0.01574/0.00810`.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and phase-lag turning
source_mechanism: sensor-conditioned posterior phase modulation that preserves a propulsive traveling rhythm
transferable_invariant: adjust bounded oscillator timing from observed directional response while preserving the carrier, and release the adjustment when the state no longer calls for it
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: rotate the two posterior wave coefficients at fixed norm using normalized body-frame LOS demand, recoil-conditioned yaw error, joint-state phase, and a smooth gate from previous posterior action divided by the owned physical acceleration limit
falsification: reject if capture is lost, arrival exceeds the replicated half-cycle band without a material occupancy or load reduction, wake coherence degrades, posterior occupancy exceeds 76.4%, or force/moment RMS exceeds 0.01574/0.00810

The new CFD outcome is intentionally not claimed here; it becomes evidence only
after this worker exits.
