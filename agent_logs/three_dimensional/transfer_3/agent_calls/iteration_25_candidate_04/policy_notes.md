# Route-confirmed phase-selective amplitude-relief candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and `capture` termination. The combined sheets for the strongest
  finite sample `solver_0288c0d51d57` and assigned-parent sample
  `solver_bc1eb6c855a8` were inspected from release through capture. In both
  top-down rows, body-led translation leaves a coherent alternating vorticity
  street; both oblique rows show compact body-attached and shed Lambda2
  structures following the fish through the capture arc. Neither view shows
  passive advection, wake collapse, collision, looping, boundary exit, or
  instability. This is consistent with local-flow RMS of only
  `0.01808--0.01816U` and confirms self-propelled route control.
- The current physical-response ablation separates actuator roles. Releasing
  posterior phase near yaw-error closure captures at `18.7715T`, score
  `-0.13713`, with `40.96%/75.39%` anterior/posterior acceleration-limit
  occupancy and `0.01335/0.00695` force/moment RMS. Relieving only posterior
  half-cycle amplitude preserves phase and captures at `18.6560T`, score
  `-0.13321`, with `40.74%/75.74%` occupancy and `0.01328/0.00691` loads.
  Direct helpful-moment phase release in the inherited logs is also slower at
  `18.7880T`. Measured moment is therefore useful as an allocation signal but
  not as permission to suppress the phase actuator.
- The amplitude result is promising but not yet a resolved timing improvement.
  Two exact-hash actuator-consistent phase evaluations capture at `18.6725T`
  and `18.7385T`, a `0.0660T` replication spread that contains the amplitude
  candidate's `0.0165T` edge over the faster repeat. Their score, occupancy,
  and load spread likewise overlaps the amplitude result. The defensible
  result is semantic: amplitude relief retains capture and the coherent wake,
  whereas both phase-release semantics are slower.
- The evaluated amplitude gate uses the sign of fast yaw error both to select
  half-cycle authority and to classify helpful moment. Near response closure
  that sign crosses zero, and multiplying the whole asymmetry term also fills
  in the deliberately attenuated half-cycle. Replay on all four sampled traces
  shows the existing error-aligned release above `0.1` in only
  `12.9--13.8%` of samples. A route-aligned moment gate confirmed by measured
  route-direction yaw response would be active in `28.0--29.7%`; applying it
  only to the strengthened half-cycle makes this a phase-selective test rather
  than a global authority handoff.

## Policy hypothesis recorded before editing

Start from `dogfish3d_helpful_moment_amplitude_relief_v1`. Preserve its
normalized body-frame bearing and LOS-rate request, recoil-conditioned yaw
response, distributed C-bend, traveling-wave carrier, persistent same-side
phase recruitment, coefficient-norm-preserving posterior phase rotation, and
componentwise acceleration projection.

Replace symmetric fast-error amplitude release with one route-confirmed,
phase-selective allocation. The slow bounded `target_yaw_rate` sets the sign
used to classify normalized yaw moment, while recoil-conditioned measured yaw
must already move in that route direction and yaw error must be near closure.
Under those conditions, reduce only positive half-cycle amplification; retain
the attenuated half-cycle exactly. This separates slow route ownership from
fast physical response and cannot suppress the carrier or posterior phase
actuator. Route request, measured yaw response, moment, and wave target all
reverse under reflection, so the gates are invariant and the final two-joint
command remains odd.

Support requires capture with the coherent alternating wake intact and either
arrival outside the `18.6725--18.7385T` exact-hash baseline spread or a clear
load/limit reduction without arrival later than the replicated half-cycle
bound near `18.931T`. Falsify the mechanism if capture is lost, the attenuated
half-cycle is effectively filled, arrival exceeds `18.931T`, or force/moment
RMS exceeds the actuator-consistent `0.01350/0.00703` bound. Current evidence
contains only self-generated low-flow wakes, so disturbance robustness is not
claimed.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful fluid-induced motion by modulating the smallest redundant rhythmic contribution while slow target geometry retains route ownership
transferable_invariant: separate slow route demand from fast hydrodynamic response, confirm that the body is already responding along the route, and relieve only the redundant strengthened beat contribution without cancelling the carrier
nontransferable_details: organized-wake phase, species and robot kinematics, published gains, dimensional frequencies, exact vortex timing, and source-task routes
policy_translation: use normalized body-frame LOS feedback for `target_yaw_rate`; require route-aligned normalized yaw moment, route-aligned recoil-conditioned yaw response, and near-closed yaw error before reducing only positive posterior half-cycle amplification while preserving phase recruitment and the attenuated half-cycle
falsification: reject if capture or wake coherence is lost, arrival exceeds 18.931T, force/moment RMS exceeds 0.01350/0.00703, or the allocation fails to separate from the slower phase-release topology

The current candidate's CFD result is not claimed here; it becomes evidence
only after this worker exits.
