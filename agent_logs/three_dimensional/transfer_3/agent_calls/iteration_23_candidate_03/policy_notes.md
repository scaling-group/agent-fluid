# Hydrodynamic counter-moment phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. There is no current-cohort failure sheet, so the
  visual contrast uses the best-score actuator-consistent capture and the
  least favorable complementary-handoff capture; inherited logs supply the
  earlier high-pass miss and loop/exit failure boundaries.
- Both combined sheets show body-led self-propulsion rather than advection.
  Their top-down rows grow a coherent alternating posterior vortex street from
  quiescent release through capture, and their oblique rows show compact paired
  three-dimensional Lambda2 structures following the fish. Lateral motion is
  a productive tail beat on a smooth target-directed route; neither view shows
  wake collapse, collision, boundary departure, a terminal loop, or numerical
  instability. Sparse keyframes do not resolve the small timing differences.
- The sampled actuator-consistent policy has the best single score
  (`-0.13362`), mean score distance (`2.02129L`), and arrival (`18.6725T`),
  but its same-hash inherited repeat arrives at `19.0080T`. That `0.3355T`
  spread is larger than the complete current variant band: complementary
  amplitude handoff arrives at `18.7495T`, while demand lead and helpful-moment
  release both arrive at `18.7880T`. Sub-replication timing deltas therefore
  cannot establish a reusable ranking.
- Physical metrics do distinguish the sampled mechanisms. Relative to the
  actuator-consistent run's `76.41%` posterior acceleration-limit occupancy
  and `0.01350/0.00703` force/moment RMS, complementary handoff reaches
  `74.48%` and `0.01336/0.00696`, while helpful-moment release is best in the
  current cohort at `74.41%` and `0.01306/0.00679`. All retain nearly identical
  local-flow RMS (`0.01798--0.01809U`) and coherent wakes. The inherited
  sign-persistent phase gate is a negative control: stronger phase exposure
  under same-side stress slows capture to `18.8650T` without beating the
  helpful-moment release loads. The evidence supports response-selective phase
  allocation, not more phase, carrier effort, scalar authority, or near-range
  coasting.

## Policy hypothesis recorded before editing

Start from the sampled helpful-moment-release controller. Preserve normalized
body-frame bearing and LOS-rate guidance, recoil-conditioned yaw response,
continuous distributed C-bend, response-reversing half-cycle steering, the
traveling-wave carrier, the same-side actuator-consistency gate, fixed-norm
posterior phase rotation, and componentwise physical projection.

Replace the one-sided release with a symmetric hydrodynamic counter-moment
gate. Form the reflection-invariant alignment between the requested signed yaw
response and observed normalized hydrodynamic yaw moment. A smooth bounded map
recruits phase toward one only as the fluid moment becomes adverse, gives half
authority at neutral alignment, and releases toward zero as the moment helps.
This separates the slow target-route request from a measured fast physical
response and prevents neutral low-load intervals from receiving full phase
authority. It adds no gain-only carrier change, time, external phase, mutable
state, fixed coordinate, range stage, or memorized route.

Support requires capture with both wake views coherent and either posterior
limit occupancy below `74.41%` or force/moment RMS below `0.01306/0.00679`,
without exceeding the robust half-cycle arrival boundary near `19.052T`.
Falsify the mechanism if capture is lost, arrival exceeds that boundary, load
or occupancy rises above the actuator-consistent `0.01350/0.00703` and
`76.41%` values, or the result only adds switching without a resolved physical
benefit. Since sampled local flow is only about `0.018U`, no stronger-
disturbance robustness is claimed.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: separate persistent route demand from a bounded phase correction recruited only against adverse measured fluid response
transferable_invariant: preserve a stable traveling-wave carrier and use the smallest response-conditioned correction that opposes adverse yaw without cancelling helpful fluid motion
nontransferable_details: published gains, clock phase, robot or species kinematics, dimensional frequencies, exact vortex phases, source-task disturbances, and routes
policy_translation: multiply the existing normalized two-joint same-side phase gate by a smooth reflection-invariant selector from signed yaw-response demand and observed normalized yaw moment
falsification: reject if capture or wake coherence is lost, arrival exceeds 19.052T, or posterior occupancy and force or moment loads fail to improve without crossing the actuator-consistent bounds

The candidate's CFD result is not claimed here; it becomes evidence only after
this worker exits.
