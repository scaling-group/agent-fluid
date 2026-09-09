# Sign-persistent posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. In every combined sheet, the top-down row shows
  body-led motion with a coherent alternating posterior vortex street from
  release to capture, while the oblique row shows compact paired three-
  dimensional Lambda2 structures following the fish. There is no passive
  advection, wake collapse, loop, collision, boundary exit, or instability.
- The actuator-consistent phase gate is the strongest sampled route. It
  captures at `18.6725T`, scores `-0.13362`, and lowers mean distance to
  `2.0213L`. At `14T/18T` it is already at `4.215/1.205L`, versus
  `4.289/1.301L` for the demand-lead candidate and `4.304/1.311L` for the
  current-demand gate. The visual sheets remain coherent, so this is useful
  target-directed self-propulsion rather than a scalar-only anomaly.
- That faster route does not validate the actuator-consistent gate's original
  load-relief claim. Its action RMS is `24.95/28.85 rad/T^2`, posterior limit
  occupancy is `76.11%`, and force/moment RMS is `0.01350/0.00703`, close to
  the phase-free half-cycle's `25.22/28.86`, `76.09%`, and
  `0.01357/0.00707`. By contrast, current-demand phase recruitment captures at
  `18.7990T` with `73.96%` posterior occupancy and `0.01315/0.00684` loads.
  This identifies a timing/load trade: releasing phase at beat reversal helps
  the route, but multiplying phase authority by the raw same-side stress
  magnitude attenuates the load-saving rotation even after persistence is
  established.
- The inherited demand-lead rollout is a concrete negative result. It captures
  at `18.7880T`, only `0.011T` ahead of current-demand recruitment and well
  inside the roughly `0.12T` same-policy timing spread, while posterior
  occupancy rises to `75.38%` and force/moment RMS to `0.01333/0.00694`.
  Its own falsification required a resolved timing improvement without that
  degradation; more scalar tuning of the one-step lead is therefore not the
  next test.
- Local-flow RMS is only `0.01808--0.01843U` across the four captures. No wake-
  rejection term, range schedule, curvature reallocation, carrier gain, or
  task-specific route is supported by these still-water samples.

## Policy hypothesis recorded before editing

Start from the sampled actuator-consistent policy, preserving normalized body-
frame bearing and LOS-rate guidance, recoil-conditioned yaw response,
continuous two-joint C-bend closure, response-reversing half-cycle authority,
the traveling-wave carrier, and explicit physical output projection.

Change one actuator-state mechanism. Keep the smooth current-demand headroom
gate, and keep phase rotation off when current raw posterior demand and the
observed previous feasible action disagree in sign at a beat reversal. When
they agree, pass their normalized signed product through a bounded saturating
map before multiplying phase authority. Thus sign persistence is evidence that
the same actuator flank continues, not a second amplitude command: phase
authority can approach full recruitment during sustained clipping instead of
being linearly attenuated by stress magnitude. The expected outcome is a
Pareto interpolation between the fast actuator-consistent route and the lower-
load current-demand route without clock phase, mutable memory, or scalar-only
carrier tuning.

Support requires capture no later than `18.799T` with posterior occupancy below
the actuator-consistent candidate's `76.11%` and force/moment RMS below
`0.01350/0.00703`; stronger support is arrival near `18.6725T` or load near the
current-demand candidate's `73.96%` and `0.01315/0.00684`. Falsify the transfer
if capture is lost, arrival exceeds the phase-free `18.931T` baseline, the
alternating wake weakens, posterior occupancy exceeds `76.4%`, or force/moment
RMS exceeds `0.01574/0.00810`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and phase-lag turning
source_mechanism: sensory state recruits bounded posterior timing changes while preserving a propulsive traveling rhythm
transferable_invariant: retain the carrier, release timing correction when actuator response reverses, and use persistent same-side response to restore bounded phase authority
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: multiply normalized body-frame current-demand phase recruitment by a saturating positive signed product of raw posterior demand and observed previous feasible posterior action
falsification: reject if capture is lost or later than 18.931T, wake coherence degrades, posterior occupancy exceeds 76.4%, or force/moment RMS exceeds 0.01574/0.00810

The new CFD outcome is intentionally not claimed here; it becomes evidence only
after this worker exits.
