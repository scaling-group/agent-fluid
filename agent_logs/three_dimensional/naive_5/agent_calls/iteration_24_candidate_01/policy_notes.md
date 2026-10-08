# Capture-corridor response-closure promotion

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture, so there is no sampled termination failure. Three
  are behavior-identical executions of the assigned coordinated-envelope
  parent; their repeated trajectory establishes fixed-condition determinism,
  not robustness to initial geometry or flow.
- In the assigned parent's combined sheet, the top-down row shows genuine
  self-propulsion from rest, a coherent alternating wake, monotone target
  approach, and a late correct-sign hook into the capture disk. The oblique
  row shows a connected three-dimensional Lambda2 wake throughout the same
  route. The distinct capture-corridor sample has the same visible topology in
  both rows. The wake trails the body, so neither motion nor yaw is a
  moving-window artifact.
- The assigned parent captures at `0.7492417097L` and `26.2955208T`, with zero
  angle, speed, and acceleration contacts, maximum joint angle/speed
  `0.772361 rad`/`4.512809 rad/T`, and peak planar force/yaw moment
  `0.0188344/0.00978884`. This confirms that the inherited common acceleration
  envelope fixed the older component-clipping defect without sacrificing the
  productive carrier.
- The one distinct sampled descendant adds an approach-and-projected-miss
  gated, course-side yaw-response residual through the anterior half-cycle
  channel. It first changes the action at `24.2990T` and `1.74669L`, changes
  the aligned head path by at most about `0.0025L`, and retains identical
  force/moment peaks and zero limit contacts. It captures one integration step
  later at `0.7490895391L`; mean score distance improves from `2.51998063L` to
  `2.51987524L`, and score improves from `-0.6172379350` to `-0.6170911112`.
  The visual sheets remain indistinguishable at their sampling scale.
- The inherited logs reject terminal damping, reverse-wave braking, recoil,
  deeper-curvature scalars, and a binary one-beat projected-intercept hold.
  They identify response-based target-line feedback as the first successful
  semantic mechanism. The sampled corridor residual is therefore a narrow
  extension of that evidenced structure, not justification for another drive,
  braking, threshold, or waveform gain sweep.

## Policy hypothesis

Promote the sampled capture-corridor response closure without changing the
carrier, line-of-sight residual, posterior allocation, coordinated command
envelope, or angle/rate viability guards. Inside the already normalized
approach-and-miss corridor, compare the calibrated course-correction side with
phase-rejected measured yaw. Add anterior half-cycle authority only for a
positive yaw-response deficit. This preserves adequate turns and all
far-field commands while supplying a distinct body-frame response objective
when a line-of-sight-rate intercept remains tangential near the capture disk.

The formal expectation is repeat capture with the sampled slightly lower
terminal distance, unchanged coherent top-down and oblique wakes, zero joint
contacts, and no load increase. Treat the result as falsified if capture is
lost, the carrier or wake changes outside the corridor, any actuator contact
returns, arrival/load cost worsens materially, or the terminal path fails to
move. Even a repeat of the `0.74909L` result would establish deterministic
fixed-condition transfer only; require a materially larger margin or varied
initial conditions before calling the mechanism robust. The new CFD result is
produced only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and terminal target capture
source_mechanism: modulate a coordinated rhythmic carrier with bounded observed response error, while using a separate near-target objective only after broad target-directed motion works
transferable_invariant: add steering authority only when normalized target geometry requests a turn and measured body response remains inadequate, leaving an already adequate carrier response unchanged
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex phases, full-body waveforms, fixed routes, and source-task switching schedules
policy_translation: retain the body-frame traveling bend and line-of-sight response; within the existing distance-and-projected-miss corridor, add a bounded positive course-side yaw-response deficit through the anterior half-cycle channel
falsification: reject if repeat capture, wake coherence, actuator viability, or load exposure worsens, or if the terminal trajectory does not move enough to distinguish response closure from numerical crossing noise

## Non-CFD implementation audit

- The candidate byte-matches the distinct sampled corridor-response policy
  (`ee81312adf0e6edae39e428467356269d7966cad85c546f4c3ac48fa964d2877`),
  so the mechanism and cited rollout evidence have exact provenance. The three
  new direct parameter references are all owned by `target_policy_params()`.
- The mandated check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable for this account. Its three prescribed commands were therefore
  run directly and separately: the guidance semantic/schema check, finite
  two-joint Julia contract, and solver editable-boundary check all pass. The
  duplicated assigned-parent marker in the rendered workspace README was
  removed to make its parent identity unambiguous.
- A deterministic grid of `2187` finite state pairs confirms bounded output
  and exact lateral reflection equivariance; maximum output is the existing
  `30 rad/T^2` limit and maximum reflection error is zero. This is a contract
  audit, not a new CFD result. No CFD was run in this workspace.
