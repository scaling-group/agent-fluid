# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no prewarm) and terminate in capture. Three
  executable-equivalent predictive-half-cycle policies reproduce the exact
  `22.154001T` arrival, `2.105583L` mean distance, `0.748384L` crossing, and
  `-0.210952` score. The complete sampled sheet shows the self-propelled
  S-route with an attached alternating mid-plane street and discrete oblique
  three-dimensional Lambda2 structures through capture. Mean action is about
  `59.932`, anterior/posterior exact-rate-cap occupancy is `11.49/6.41%`, and
  peak normalized force/moment are `0.030897/0.015839`.
- The informative sampled parent without predictive posterior half-cycle
  allocation is slightly weaker at `22.159500T`, `2.105808L`, and
  `-0.211168`, while preserving the same visible route and coherent two-view
  wake. The improvement from previewing the half-cycle envelope is therefore
  small but repeatable and actuator-path specific; previewing posterior
  recovery was trajectory-inert in the sampled comparison.
- Three inherited optimizer evaluations of the same anterior-redirect preview
  candidate reproduce a concrete negative result not yet distilled into the
  assigned guidance: capture is delayed to `22.258499T`, mean distance rises
  to `2.107164L`, and score falls to `-0.212304`. The top-down sheet retains
  the S-route and alternating wake, but its oblique row is blank and cannot
  establish independent 3D-wake preservation. Peak force/moment remain at the
  parent bound, while mean action falls to about `59.738` and anterior rate-cap
  occupancy rises to about `11.79%`; moving preview onto the anterior burst is
  thus a route/phase-allocation regression, not a load instability or a useful
  efficiency result.
- Reconstructing the parent in normalized body coordinates identifies a
  narrower observation opportunity. The current seven-step folded-bearing
  derivative, after subtracting recent body turn, and the instantaneous
  full-vector kinematic target-line rate agree through most of the approach,
  but the historical signal lags when the path curls most sharply: near `21T`
  it is about `0.206 rad/T` versus `0.393 rad/T` from target position and
  inertial velocity. With the inherited cap and lead, that changes only the
  posterior half-cycle envelope from about `0.492` to `0.661`; both versions
  saturate again by `22T`. No scalar authority increase is indicated.

## Visual diagnosis

The parent is actively swimming rather than being advected: still water at
release develops a persistent alternating street behind a continuously
beating fish, and compact three-dimensional wake structures remain visible at
capture. Its target-directed S-route is stable, so the candidate should not
replace the carrier, anterior curvature, rudder, recovery, or terminal-relief
laws. The useful contrast is phase timing on the late curl, not wake strength.
The inherited anterior-preview sheet's blank oblique row is a render failure,
not evidence of wake collapse.

## Policy hypothesis

Preserve the sampled controller and its history-based de-yawed line-of-sight
rate on the course, recovery-allocation, and reactive-rudder paths. For only
the already-positive posterior half-cycle envelope, compute target-line
translation rate directly from normalized `target_body_L` and inertial
`velocity_body_U`, with the inherited rate cap. This full-vector kinematic
signal has no folded rear-axis branch and no short-window delay, while target
side and stroke phase remain selected by instantaneous target geometry and
anterior joint velocity. It adds no authority, changes nothing outside the
existing proximity gate, and should move a bounded share of posterior carrier
effort onto the useful stroke during the late curl. Reject it if it does not
beat `22.154001T/2.105583L`, changes the launch or preterminal S-route, loses a
complete coherent two-view wake, or worsens the sampled action, saturation,
force, or moment envelopes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: allocate a continuing propulsive rhythm between turn-helping and return half-cycles using measured directional state
transferable_invariant: preserve the traveling carrier and bounded authority while target-relative motion selects when an existing joint-state phase asymmetry is useful
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target position and inertial velocity to form a capped full-vector target-line translation rate for only the posterior half-cycle envelope; retain instantaneous target side, anterior joint-rate phase, and every established ceiling
falsification: reject if capture is later than 22.154001T, mean distance exceeds 2.105583L, launch or route changes adversely, or the complete wake, action, rate-cap occupancy, normalized force, or moment exceeds the assigned-parent bounds
