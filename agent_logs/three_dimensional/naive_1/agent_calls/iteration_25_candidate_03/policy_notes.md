# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts are finite captures from the required direct
  uniform still-water initialization: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm snapshot, and no reported instability. Three independently
  materialized copies of the prefilled course-plus-posterior-recovery policy
  reproduce exactly the `23.331013T` capture, `0.749672L` crossing,
  `2.135772L` score-metric mean distance, and `-0.239045` score. This closes
  the assigned parent's compatibility question with deterministic fixed-pose
  evidence rather than held-out robustness.
- The composition improves on the complete course-only control at every
  inspected checkpoint from `2T` through `22T`: distance is already
  `12.156286L` rather than `12.198925L` at `2T`, is `5.214322L` rather than
  `5.295370L` at `14T`, and is `1.191649L` rather than `1.219455L` at `22T`.
  It also advances capture from `23.369514T` and lowers mean distance from
  `2.152884L`. The gain is therefore distributed progress from a distinct
  actuator allocation, not a first-crossing artifact or scalar-only course
  tuning.
- The complete `solver_8d6cd2d6a3b7` sheet shows self-propelled translation
  along the inherited S-shaped route, with an attached alternating red/blue
  mid-plane street and discrete three-dimensional Lambda2 structures from
  wake formation through capture. The complete course-only
  `solver_220a1177a646` sheet has the same useful wake class and a slightly
  slower route. The `solver_ce62814ff884` and `solver_e36dfe604591` top-down
  rows reproduce the winning trajectory, but their black oblique rows are
  render artifacts and provide no additional 3D-wake evidence.
- The improvement has a bounded but real allocation cost. Relative to the
  course-only control, mean action rises from `58.179` to `59.044`, mean
  action through `5T` rises from `77.675` to `79.968`, anterior/posterior
  rate-cap occupancy rises from about `11.16/6.10%` to `11.34/6.27%`, and
  peak normalized force/moment rise from `0.029468/0.015365` to
  `0.030861/0.016213`. Near-target mean action instead falls slightly from
  `44.396` to `44.015`, consistent with the added posterior term being an
  early locomotor intervention rather than a terminal steering change.
- A trace replay, used only to bound the proposed intervention, finds the
  through-water recovery gate active on 609 samples through `4.125T`. During
  that window the posterior angle is at or below the anterior carrier
  amplitude on about `75.4%` of samples and reaches about `1.40` times that
  amplitude. Keeping full posterior recovery through the nominal envelope and
  smoothly releasing it between `1.0` and `1.3` amplitudes would retain about
  `87%` of the gate-weighted recovery on the recorded trace while removing
  reinforcement at its largest excursions. This offline calculation is not a
  CFD result and does not predict the closed-loop score.

## One candidate hypothesis

Preserve the reproduced through-water course loop, anterior speed-deficit
oscillator recovery, posterior lag, target geometry, phase-selective steering,
reactive-rudder sign, and terminal stroke-qualified relief. Change only the
added posterior locomotor-recovery allocation: combine its existing normalized
through-water speed-deficit gate with a smooth joint-state amplitude envelope.
The added `1.12` posterior carrier scale remains fully available while
`abs(q2) <= 1.0 * oscillator_amplitude`, fades continuously to the inherited
carrier by `1.3` amplitudes, and does not modify the carrier, rudder, route, or
terminal paths outside that added recovery term. This tests whether the early
progress can be retained without reinforcing already-large posterior
excursions or introducing a clock, coordinate, route memory, vortex phase, or
new disturbance residual.

Falsify the amplitude-qualified allocation if capture is lost or later than
`23.331013T`, scored mean distance exceeds `2.135772L`, the `12.156286L`
distance-at-`2T` boundary regresses, or the complete alternating wake and
S-route degrade. Also reject it if the current `59.044/79.968` mean/early
action, `11.34/6.27%` rate-cap occupancy, or `0.030861/0.016213` peak
force/moment envelope worsens; a lower effort or load without preserved route
progress is not sufficient. A positive direct-still-water result would show
envelope compatibility only, not robustness to a changed pose or imposed
wake.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG amplitude regulation
source_mechanism: retain posterior-emphasized traveling-wave thrust while using observed oscillator amplitude to stop recovery from reinforcing an already-established tail envelope
transferable_invariant: locomotor deficit may recruit the lagged posterior carrier, but the added recovery should release smoothly when normalized posterior joint state shows that the rhythmic amplitude is already established
nontransferable_details: published gains, dimensional frequencies and speed thresholds, distributed species-specific envelopes, robot sensor calibration, exact vortex phases, cylinder geometry, fixed coordinates, and task-specific routes
policy_translation: multiply only the existing posterior speed-deficit recovery share by a smooth envelope that is full through one normalized carrier amplitude and zero by 1.3 amplitudes, while preserving all route, carrier, rudder, and terminal feedback
falsification: reject if capture is later than 23.331013T or lost, mean distance exceeds 2.135772L, early progress regresses, or route, complete wake, action, saturation, force, or moment envelopes worsen
