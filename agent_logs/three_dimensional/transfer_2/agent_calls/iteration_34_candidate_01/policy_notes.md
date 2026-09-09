# Progress-confirmed far-carrier release candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, stable finite
  moving-window transport, and capture. Because this cohort contains no failed
  termination, the informative failure is a mechanism regression in trajectory
  and actuator semantics rather than loss of capture.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows from
  release through capture for the strongest finite sample
  `solver_1d05d22ea1fe` and the lowest-score byte-identical all-distance-release
  repeat `solver_0e82a9e35a2a`. Both fish start in blank quiescent water,
  self-propel on a continuous shallow arc, and leave compact alternating
  mid-plane vortices plus coherent three-dimensional caudal structures. Neither
  view shows advection, collision, domain exit, unproductive flailing, wake
  collapse, or instability. The gait, target sign, and course redirect should
  therefore be preserved.
- Metrics distinguish the similar sheets. The prefilled range-specific carrier
  handoff captured at `15.939T`, with distance integral `1.82008L`, head path
  `13.107L`, and force/moment peaks `0.03477/0.01715`. Two byte-identical
  all-distance carrier-release samples captured at `16.071--16.088T`, with
  integrals `1.82203--1.82366L` and paths `13.129--13.166L`. The range-specific
  handoff retained their early progress while restoring the coupled carrier
  through the normalized 6--4L approach, so the evidence supports preserving
  that approach boundary rather than tuning its distance or gains.
- Completed inherited repeats show that the prefilled policy itself spans
  `15.939--16.170T`, `1.82008--1.82951L`, and `13.107--13.142L`; this stochastic
  spread prevents treating a single score ordering as a new mechanism. The
  inherited response-gated half-cycle child captured at `16.022T` but had
  `1.82375L` integral and `13.144L` path. More importantly, it left anterior
  mean command at `16.65 rad/T^2`, residence above 90/99% of the rate limit at
  `17.71/12.15%`, and posterior rate residence at `8.07/1.27%`, all inside the
  unmodified handoff ranges. Scaling steering asymmetry from yaw response did
  not deliver its claimed actuator-cost reduction; further scalar authority
  edits to that same half-cycle gate are not supported.

## One-candidate policy hypothesis

Keep the prefilled corrected-sign body-frame target vector, distance/closing
drive relief, velocity-course redirect, half-cycle steering, posterior
allocation, phase-preserving carrier governor, 6--4L approach restoration,
bounds, and public two-joint contract. Change only the far-field release of
negative-work carrier reversal: retain its measured same-sign yaw condition,
but also require positive target closure normalized by current planar speed.
This progress confirmation is continuous and body-frame invariant; it passes
the release during useful target-directed motion but lets the existing common
carrier guard retain phase-coupled redirect priority when yaw response is not
actually producing closure. It adds no route stage, clock, or coordinate.

Expected signature: preserve the sampled early milestones and coherent
two-view wake while avoiding nonproductive far-field release, then reproduce
the range-specific `4L`-to-capture class because progress confirmation is
withdrawn with the existing approach handoff. Falsify if capture is lost; any
milestone, timing, or integral regresses beyond the completed repeat range
without a material path/load/rate benefit; or path, terminal yaw/slip, command,
joint margin, force/moment, finite action, or either wake view deteriorates.
The candidate's CFD result is not available to this worker and is not claimed
as evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-interaction control
source_mechanism: release a bounded directional maneuver into rhythmic propulsion only when observed body response produces useful task-relative motion
transferable_invariant: measured yaw response alone does not establish useful locomotion; retain response-conditioned rhythmic release only while normalized target closure confirms progress
nontransferable_details: published gains, oscillator frequencies, robot or species kinematics, duty ratios, exact vortex phases, world-frame routes, and task coordinates
policy_translation: multiply the existing far-field same-sign-yaw reversal release by bounded positive closing speed normalized by current planar speed, while leaving target steering, two-joint carrier phase, actuator bounds, and the normalized approach handoff unchanged
falsification: reject if early progress or the sampled approach class is lost, or if timing, distance integral, path, rate residence, command, load, joint margin, terminal course, finite action, or coherent top-down and oblique wakes regress
