# Candidate wake-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations are valid direct-uniform still-water runs:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and 252 moving-window
  shifts. All terminate by capture, so the assigned-parent/prefill capture is
  the least-effective finite comparison rather than a true failure; the
  inherited upper-boundary exits remain the informative failure topology.
- In both the top-down vorticity row and oblique body/Lambda2 row, the parent
  and strongest sample are self-propelled rather than advected. They grow an
  organized alternating wake, retain compact three-dimensional tail
  structures, and execute the same shallow late hook toward the target. There
  is no visible wake breakup, thrust collapse, collision, or instability
  preceding capture. The strong and weak finite sheets differ in detail but
  not in useful trajectory topology.
- Metrics agree with that reading. The parent captures at `0.749266L` and
  `25.9710T` with mean distance `2.498175L`. The phase-rejected posterior
  half-cycle sample is the best scalar/clearance result at `0.748269L`,
  `25.9105T`, and mean `2.497000L`; the moment-qualified sample is fastest at
  `25.8335T` and has mean distance `2.496768L`. All four sampled traces have
  zero angle, rate, and policy-acceleration contacts, with common maxima near
  `0.76352 rad`, `4.51496 rad/T`, and `29.65805 rad/T^2`. Their peak planar
  force and yaw moment remain in the narrow `0.01885--0.01902` and
  `0.01003--0.01016` bands.
- The phase-rejected sample improves projected miss over the parent at `24T`
  from about `0.998L` to `0.916L`; the moment-qualified sample reaches about
  `0.901L` and advances capture by `0.1375T`. These are finite improvements,
  not a semantic success: every sample remains the same coherent shallow-hook
  capture class. Instantaneous body-normal velocity is strongly beat-phase
  contaminated, so another slip threshold or scalar posterior gain is not
  supported.

## Policy hypothesis

Use the strongest sampled phase-rejected course observer and its
opposite-tail-motion posterior half-cycle as the slow geometric correction.
Within the same closing middle-distance regime, treat a normalized yaw moment
opposing that geometry-owned turn side as a fast response deficit and gate a
small same-sign two-joint half-cycle residual. The moment cannot choose the
route, cannot act in the upstream carrier or capture corridor, and cannot
cancel an adequate response. The downstream coupled acceleration envelope and
angle/rate viability guards remain unchanged.

Expected signature: retain the organized top-down and oblique wakes and zero
actuator contacts, match the phase-rejected sample's lower `24T` projected
miss, and approach the moment-qualified sample's earlier arrival without
raising peak force/moment outside the sampled band. Falsify the combination if
it loses capture or wake coherence, produces the same milliscale-only shallow
hook, restores any actuator contact, fails to lower full-beat middle-course
error, or materially exceeds the sampled load regime.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and adaptive wake-response control
source_mechanism: sensory feedback modulates a rhythmic controller with a bounded residual while a slower task signal retains directional authority
transferable_invariant: separate slow body-frame target geometry from fast normalized hydrodynamic response, and apply correction only on a useful joint-state half-cycle
nontransferable_details: published CPG gains, species-specific kinematics, cylinder-wake timing, exact vortex phase, and task-specific routes
policy_translation: phase-reject the carrier component of normalized course error, let target geometry set turn side, and let only adverse normalized yaw moment gate a small two-joint half-cycle residual inside the evidenced middle approach
falsification: reject if capture or coherent propulsion is lost, actuator or load exposure rises, full-beat course error does not fall, or the result remains in the visually identical milliscale capture cluster
