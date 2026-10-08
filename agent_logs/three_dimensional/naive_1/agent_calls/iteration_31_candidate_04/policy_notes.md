# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled evaluations are finite captures from the required direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and no reported instability. The assigned parent and
  two comment-only descendants have the same executable policy and reproduce
  the same trajectory byte for byte: capture at `22.500492T`, scored mean
  distance `2.120233L`, crossing distance `0.749267L`, and score `-0.225086`.
- Both visual rows were inspected. Every sampled top-down sheet shows
  self-propulsion rather than advection: an alternating red/blue street is
  attached to the caudal region by `4T`, stays coherent along the S-shaped
  approach, and remains rhythmic through capture. The
  `solver_4287e5faa0ad` oblique row is complete and shows discrete
  three-dimensional Lambda2 structures trailing the caudal region at `4T`,
  `12T`, `20T`, and capture. The other parent-equivalent oblique rows and the
  allocation-only row are black render artifacts, so they are not additional
  3D-wake evidence.
- The assigned parent's composition clears both boundaries set by its
  inherited hypothesis. Relative to the target-error allocation-only sample,
  line-of-sight-led rudder recruitment advances capture from `23.122009T` to
  `22.500492T`, lowers mean distance from `2.127679L` to `2.120233L`, and
  improves score from `-0.231273` to `-0.225086`. The traces are identical at
  `2T`, `4T`, and `9T`, then the composition is closer at `12/18/20T`
  (`6.201/3.056/1.999L` versus `6.203/3.114/2.101L`). This is compatible
  state-feedback composition, not evidence for more rudder or recovery gain.
- The improvement does not come from lower effort. Mean action rises from
  about `58.990` to `59.671`, while anterior/posterior exact rate-cap
  occupancy remains finite at about `11.78/6.40%` and peak normalized
  force/moment remain at `0.030527/0.015817`. The complete two-view sheet
  rules out wake collapse or inertial coasting as the explanation for the
  faster crossing.
- Inherited logs bound the next edit. Posterior half-cycle redistribution,
  angle-quadrature stacking, tail-rate unloading, instantaneous power
  qualification, and an unqualified yaw-moment residual all regressed capture
  or route quality. The positive parent instead separates a target-error
  allocation signal from a bounded target-line predictor, while keeping one
  fixed posterior recovery budget and an independently bounded rudder.

## One candidate hypothesis

Preserve the assigned parent's through-water course feedback, anterior
oscillator recovery, full target geometry, anterior redirect, phase-selective
carrier, line-of-sight-led reactive rudder, and response-plus-stroke terminal
relief. Change only the selector of the fixed `0.12` posterior recovery
budget: compute a separate smooth allocation gate from the already bounded
one-cycle `led_target_error`, and use that gate to crossfade between the
completed whole-carrier and anterior-velocity-quadrature recovery targets.
Keep the unpredicted `redirect_gate` in the anterior redirect and carrier
relief paths, so the edit does not broaden the predictor across the controller.

The hypothesis is that the parent's target-line residual can anticipate the
need for phase-oriented posterior recovery as well as rudder recruitment,
recovering more of the later route advantage without sacrificing the aligned
whole-carrier launch. This is a new observation-to-allocation path, not a gain
change: the carrier, recovery share, rudder sign and limit, thresholds, and
terminal law are unchanged. It uses only normalized body-frame target, water-
relative velocity, short-window response, and joint-state observations; it
adds no time, step, route memory, fixed coordinate, case identity, external
phase, or mutable state.

Falsify the mechanism if capture is lost or later than `22.500492T`, scored
mean distance exceeds `2.120233L`, score fails to exceed `-0.225086`, or the
parent-identical launch through about `8T` changes materially. Also reject it
if mean action exceeds about `59.671`, anterior/posterior exact rate-cap
occupancy exceeds `11.78/6.40%`, peak normalized force/moment exceed
`0.030527/0.015817`, or a valid two-view sheet does not retain the coherent
alternating 3D wake. Any improvement remains fixed-pose still-water evidence,
not robustness to changed pose, inflow, hydrodynamics, or external wakes.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a posterior-delayed traveling bend while bounded sensor feedback selects amplitude-like or phase-like allocation within one fixed locomotor budget
transferable_invariant: anticipated body-frame route demand may select between completed posterior quadratures without stacking authority or replacing the traveling carrier
nontransferable_details: published gains, dimensional frequency and speed, species-specific envelopes, distributed-body kinematics, robot calibration, source look-ahead horizons, exact vortex phases, fixed coordinates, and task-specific routes
policy_translation: use the existing bounded one-cycle led target error only to select the fixed 0.12 posterior recovery crossfade, while leaving the current-error redirect, carrier, and independently scheduled rudder unchanged
falsification: reject if capture is later than 22.500492T or lost, mean distance exceeds 2.120233L, the launch changes, or valid two-view wake, action, saturation, force, or moment envelopes worsen
