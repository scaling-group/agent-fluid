# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled diagnostics confirm the required direct uniform still-water
  initialization (`U_infinity=[0,0,0]`), no cylinders, finite dynamics, and
  capture. There is no sampled failure keyframe sheet in this workspace, so the
  informative comparison is the fastest finite sample against the weaker
  replicate of the assigned-parent hash, supplemented by the inherited
  high-pass failure described in `guidance/control_experience.md`.
- In both combined visual rows, the fish is self-propelled rather than advected:
  the top-down sheets grow a coherent alternating reverse-vortex street from
  the caudal region while distance falls from `12.328L` to capture, and the
  oblique sheets show bounded three-dimensional Lambda2 loops following the
  body without collision, wake collapse, or instability. The four sheets have
  the same useful trajectory and wake topology to visual resolution.
- The exact actuator-consistent parent hash captures at `18.6725T` and
  `18.7385T` in the current sample (`-0.13362` and `-0.13693`). The best scalar
  sample, helpful-moment amplitude relief, captures at `18.6560T` and
  `-0.13321`; its `0.0165T` lead over the fastest parent is far below the
  inherited same-hash `0.3355T` spread. Error-conditioned raw-moment phase
  release is slower at `18.7715T` and `-0.13713`.
- The current traces reinforce that these moment selectors are not materially
  separated. Helpful-moment amplitude relief has action RMS
  `24.710/28.766 rad/T^2`, limit occupancy `40.7%/75.7%`, and force/moment RMS
  `0.013277/0.006912`; the two parent replicates span
  `24.658--24.955/28.781--28.847`, `40.5--42.2%/75.6--76.1%`, and
  `0.013270--0.013499/0.006908--0.007028`. Local-flow RMS remains
  `0.01806--0.01816U` across all four.
- Raw yaw moment is carrier dominated: across the four sampled traces its
  correlation with anterior angle is about `0.842`. A reflection-odd linear
  carrier estimate from `(q1,q2,qd1/omega,qd2/omega)` is stable across samples
  near coefficients `(0.0169,0.0029,0.0077,-0.0055)` and reduces moment RMS
  from about `0.0069--0.0070` to a residual near `0.0024`. The residual still
  has the correct positive next-sample yaw-acceleration sign, but only about
  `0.234--0.237` correlation; it therefore supports a small allocator, not a
  replacement yaw command.

## Policy hypothesis

Preserve the evaluated normalized LOS route, recoil-conditioned yaw error,
response-reversing half-cycle asymmetry, traveling-bend carrier, and
persistent same-side actuator-consistent phase gate exactly. Add one new
mechanism: subtract the joint-phase carrier estimate from observed normalized
hydrodynamic yaw moment, then let the bounded residual increase posterior phase
recruitment slightly when it opposes the requested yaw response and decrease
it slightly when it helps. At zero residual or zero yaw demand the evaluated
parent path is recovered. Because response direction and moment residual both
reverse under reflection, their product is an invariant scalar gate.

Falsify this candidate if it loses capture, leaves the inherited
`18.67--19.01T` parent band without a material load reduction, exceeds `76.1%`
posterior limit occupancy or `0.01350/0.00703` force/moment RMS, or disrupts
either coherent wake view. A useful outcome is an earlier capture outside run
spread or a material clipping/load reduction while arrival stays in band.

bookshelf_consulted: true
source_domain: Wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish control.
source_mechanism: Separate the slow target-directed command from a small bounded fast disturbance residual instead of cancelling all lateral fluid response.
transferable_invariant: Preserve the propulsive rhythm and route loop; condition only residual authority on whether observed fluid response helps or opposes the requested correction.
nontransferable_details: Published gains, species kinematics, exact vortex phase, cylinder-wake synchronization, dimensional frequencies, and source-task routes.
policy_translation: Use normalized body-frame moment and observed two-joint phase to remove the carrier-correlated moment, then apply a bounded reflection-equivariant residual multiplier only to posterior phase recruitment.
falsification: Reject if capture robustness, arrival band, load/occupancy bounds, or coherent top-down and oblique wakes degrade; do not infer disturbed-flow robustness from this still-water test.
