# Phase-consistent velocity-course candidate

## Evidence-led diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and zero inertial velocity
  in newly exposed moving-window cells. All capture, so the useful comparison
  is trajectory quality, actuator viability, and mechanism isolation rather
  than success versus failure.
- I inspected both rows of the combined keyframe sheets for the replicated
  winner (`solver_db2418f56ce7`) and the informative mirrored-allocation
  regression (`solver_292735cefd5b`) from release through capture. Both
  top-down rows show continuous target-directed self-propulsion and a coherent
  alternating red/blue street. Both oblique rows retain compact
  three-dimensional caudal Lambda2 structures through the target crossing.
  Neither shows passive advection, held-joint coasting, wake collapse,
  collision, or boundary exit. The winner's `1.391U` peak body speed versus
  only `0.0327U` peak sampled local flow corroborates the visual diagnosis.
- Three sampled policies reproduce the same hash, complete trajectory,
  `16.93205T` capture, `-0.20004481` score, `2.08513L` mean distance, and
  `0.74389L` crossing distance. They remain below the joint-speed stops at
  `258.93/259.20 deg/T` and peak near `0.03693/0.01835` in force/yaw moment.
  Preserve their zero-centered carrier, posterior lag, acceleration reserve,
  soft envelope, phase-local speed guards, actuator-specific signed transfer,
  and posterior stopping-risk projection.
- The mirrored anterior-to-posterior load arbitration still captures a little
  earlier at `16.92618T`, but regresses to `-0.20096611`, `2.08585L` mean
  distance, and `0.74483L` crossing distance without reducing the posterior
  excursion. The indistinguishable wake sheets do not rescue that symmetric
  work rule, so this candidate returns to the replicated directional
  allocator.
- Completed inherited logs resolve two proposed terminal fixes negatively.
  Capture-corridor steering release regressed to `-0.20433673`; the assigned
  parent's continuous collision-cone relief also regressed to `-0.20294088`
  and `0.74668L` despite retaining capture. A separate terminal windowed
  bearing-rate residual worsened further to `-0.20453523` and `0.74825L`.
  The replicated trace explains the common weakness: below `2L`, projected
  miss swings from roughly `0.18L` to `0.89L` within one beat while range
  keeps closing. Instantaneous intercept and seven-state rate gates therefore
  remain contaminated by the propulsive cycle; do not repeat terminal
  steering withdrawal or add another terminal derivative residual.
- A different observation defect is visible over the broad route. From `5T`
  to capture, target-cross velocity-course error correlates `-0.973` with the
  measured body heading rate. It alternates around a much slower signed route
  bias and drives mean absolute course error to `0.346 rad`. Projecting a
  short, bounded body-frame de-yaw correction onto the recorded states reduces
  that value to `0.238 rad` while retaining essentially the same mean signed
  error (`-0.0835` versus `-0.0824 rad`). This supports changing how course is
  observed, not adding a steering command proportional to yaw rate.

## Single-candidate policy hypothesis

Preserve the replicated controller and add one phase-consistent course
observation mechanism. Before forming course bearing, subtract the normalized
lateral velocity induced at a short virtual reference arm by measured body yaw
rate. Bound that correction in velocity units, then feed the resulting
de-yawed course through the established speed blend and target-course
steering. The operation is body-frame and reflection equivariant: lateral
velocity, heading rate, target bearing, and the resulting correction all
reverse together. It introduces no time, route, target identity, external
phase, or carrier-gain change.

This is not the previously failed instantaneous-yaw steering feedback. Yaw
rate cannot directly add acceleration, reverse the target request, or gate
terminal authority; it only places the translational course observation at a
short virtual body point before the existing bounded controller acts. Expect
less carrier-synchronous steering allocation while retaining the slow route
bias, capture, coherent two-view wake, and all mechanical margins. Falsify the
mechanism if the broad route changes in the wrong direction, capture or
alternating shedding is lost, score/mean distance does not beat
`-0.200045/2.08513L`, a hard stop returns, posterior excursion exceeds
`0.5993 rad`, or force/yaw-moment peaks exceed `0.0370/0.0184` without a
semantic improvement.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual path following over rhythmic locomotion
source_mechanism: preserve the coupled propulsive rhythm while guidance feedback acts on a direction signal separated from fast locomotor oscillation
transferable_invariant: do not treat carrier-synchronous body yaw as a slow route error; condition direction feedback on a phase-consistent body-frame motion observation while leaving the traveling wave intact
nontransferable_details: published CPG gains, robot or species kinematics, dimensional reference-point offsets, exact beat phases, capture radii, and task-specific routes
policy_translation: use normalized measured heading rate and a bounded parameter-owned virtual arm to de-yaw lateral `velocity_body_U` before computing target-relative course error; preserve the two-joint carrier and all allocation and safety layers
falsification: reject if the de-yawed observation loses capture or the coherent top-down/3D wake, worsens route score or mean distance, restores any hard stop, or raises posterior angle and hydrodynamic loads beyond the replicated winner without a new semantic benefit

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.
