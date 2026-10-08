# Selected braking-reserve candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen evidence contract:
  direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
  cylinders or prewarm, finite dynamics, and inertial moving-window
  transport. Their policy and combined keyframe files are byte-identical, so
  they replicate one course-preview result rather than four mechanisms. That
  controller self-propels to capture at `24.5795T`, minimum/final distance
  `0.746968L`, and mean score distance `2.36044L`.
- Both visual rows were inspected for the replicated course-preview capture,
  the inherited active-brake failure, and the inherited braking-reserve
  capture. The successful top-down sheets show a coherent alternating wake
  along the long diagonal, a pre-passage redirect, and head crossing of the
  target circle near `24.6T`; their oblique sheets retain compact Lambda2
  structures through redirect and capture. This is self-propulsion from
  quiescent water, not advection, and neither wake breakup nor instability is
  the capability to repair.
- The active inward-brake negative control keeps an organized wake but misses
  at `0.91322L`, rotates onto a near-vertical departure, and exits the virtual
  domain at `36.872T` with final distance `6.522L`. Thus replacing the useful
  posterior carrier command with a route-gated, bounded position brake is not
  safe merely because its barrier is finite and mirror-equivariant.
- The behaviorally distinct predictive braking-reserve variant retains the
  successful route and captures at `24.6290T`, `0.748702L`, with mean score
  distance `2.36161L`. Relative to sampled course preview, it reduces
  posterior hard-stop occupancy from `23.38%` to zero and peak absolute
  body-frame force/yaw-moment coefficients from `0.269/0.178/0.143` to
  `0.024/0.030/0.015`. This physical improvement survives direct CFD evidence
  despite the small scalar-score change from `-0.46067` to `-0.46209`.
- The reserve does not solve rate saturation: any-joint rate-limit exposure is
  `15.16%`, and `12.10%` of the complete trace is already exposed before
  `18.5T`, where the terminal stroke filter is dormant. Do not claim a
  terminal barrier can fix that far-carrier issue or retune its threshold for
  that purpose.

## Policy hypothesis

Materialize the evaluated predictive braking-reserve controller as the one
candidate in this workspace. Preserve the state-feedback traveling-wave
carrier, body-frame course preview, geometric route requests, and predictive
priority guard. After posterior carrier/steering allocation, use observed
posterior angle and outward rate to calculate constant-deceleration stopping
stroke. When projected stroke consumes the existing soft reserve, replace
only insufficient outward/inward acceleration with the bounded inward
deceleration needed to stop; release the filter immediately during safe inward
motion. Unlike the failed active brake, do not multiply this actuator safety
filter by terminal route request and do not limit kinetic stopping authority
to the small position-guard relief fraction.

Expected evidence is reproduction of capture and the established far route,
zero posterior hard-stop occupancy, and the `0.024/0.030/0.015` peak-load
class. Falsify this selection if capture is lost, the far path changes, hard
stops return, or force/moment approaches the sampled course-preview class.
Treat unchanged rate-limit exposure as a separate future carrier problem, not
as a reason to change this terminal reserve.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and elongated-body posterior reactive swimming
source_mechanism: preserve a propulsive traveling wave while proprioceptive feedback protects finite posterior stroke needed for continued reactive thrust
transferable_invariant: intervene only when observed posterior position and outward rate predict a constraint conflict, while leaving unconstrained rhythmic motion and safe inward recovery unchanged
nontransferable_details: published gains, motor models, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized posterior joint state and the owned acceleration envelope to apply a mirror-equivariant stopping-stroke reserve after two-joint carrier and body-frame steering allocation
falsification: reject if capture or far-path dormancy is lost, posterior hard-stop occupancy returns, or peak load leaves the evaluated braking-reserve class

## Pre-evaluation validation

- The candidate is byte-identical to the inherited evaluated
  `dogfish_target_control_v32_predictive_braking_reserve` artifact, with
  SHA-256 `9fc91d274d3f711369ff4927dc92df91c1fcc8abffa685307778ac30dfe3052e`.
  This is selection of completed positive evidence, not a same-worker CFD
  claim.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The required public-contract state and
  a `900`-state grid return two finite accelerations; a separate `150`-probe
  reserve grid is mirror-equivariant to numerical tolerance.
- The reusable-guidance semantic check, exact Julia contract check, and solver
  editable-boundary audit pass. The configured check-runner was invoked, but
  its pinned `gpt-5.4-mini` model is unsupported on this account, so its three
  declared no-CFD commands were run directly and separately. No formal CFD
  was run.
