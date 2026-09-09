# Repeated terminal-interception promotion

## Evidence and visual diagnosis before editing

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  both the top-down vorticity and oblique Lambda2 rows. The motion is
  self-propelled: each rollout leaves body-connected alternating structures,
  so the useful distinction is trajectory control rather than advection or
  missing thrust.
- The full-circle pursuit failure remains strongly propulsive but follows a
  broad high-side route, gets no closer than `4.64998L`, and exits the left
  boundary at `20.03T`. Its late top-down row turns away from the target
  corridor while the oblique row still shows a generated wake. The trajectory
  cross-check finds `25.36%` posterior angle dwell beyond `40 deg` and peak
  normalized planar force/moment of `0.6204/0.2611`; longer survival does not
  make this a useful interception mechanism.
- The base predicted-miss controller captures at `16.0105T` and `0.74772L`,
  following a direct approach behind a compact alternating wake with zero
  sampled angle dwell beyond `40 deg` and peak force/moment
  `0.03465/0.01721`. Inherited logs nevertheless record byte-identical base
  repeats that passed below the disk at roughly `0.94--0.96L`, establishing a
  repeat-margin boundary rather than disproving its approach geometry.
- The exact response-gated posterior-pulse policy (SHA-256
  `c8459795cfc38bc3ebbebc4120c1427abe9622491e2bc3fae39385b55f1805ca`)
  is now sampled twice. Both executions capture, at `15.9830T/0.749982L` and
  `16.0435T/0.749337L`. Their two visual sheets retain the base controller's
  direct route and compact body-connected wake through capture; both have zero
  `>40 deg` angle dwell, similar `17%` near-rate-limit occupancy, and low peak
  force/moment (`0.03421--0.03436` and `0.01728--0.01743`). This is positive
  repeat evidence for the small terminal response/pulse composite, not for
  raising carrier or steering gains.

## Single candidate hypothesis

Promote the exact twice-captured response-gated posterior-pulse policy over the
prefilled base predictor, without scalar tuning or another feedback primitive.
Its joint-state traveling bend and body-frame constant-course miss predictor
remain the far-field propulsion/interception scaffold. Only inside the
terminal handoff, carrier-separated yaw delays release of rhythmic steering
until the body response is corrective, while normalized anterior-joint speed
gates a small target-signed posterior offset during active stroke. The two
channels are a compatible response/actuator pair and vanish outside the
intercept, preserving the evidenced carrier and route.

Support is another capture near `16T` with a compact alternating wake, zero
large-angle dwell, low `~0.034/0.017` normalized loads, and no material growth
in rate-limit occupancy. Falsify on a renewed lower-left miss, loss of the
far-field direct route, oscillatory response release, posterior pinning,
larger joint/load occupancy, or wake decoherence. Because the candidate is
evaluated only after this worker exits, the present note claims only the prior
two sampled captures.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish interception
source_mechanism: preserve a rhythmic propulsive carrier while measured directional response governs steering release and observed joint phase gates a brief posterior correction
transferable_invariant: separate propulsion from bounded target correction, release rhythmic steering only after corrective response, and recruit posterior authority only during an active observed stroke
nontransferable_details: published gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity for predicted miss, subtract the two-joint-rate carrier estimate from heading response, and gate a target-signed posterior lag offset by normalized anterior-joint speed
falsification: reject if repeated capture, useful trajectory class, wake coherence, joint reserve, and low normalized loads do not remain jointly favorable, or if future multi-wake crossflow is mistaken for persistent target response

## Dry validation only

The mandated independent runner passes guidance materiality/schema, the Julia
policy contract, and the editable boundary after removal of a duplicated
assigned-parent marker in the rendered workspace `README.md`. The installed
candidate is byte-identical to both sampled response/pulse captures. A
`233,280`-state body-frame grid spanning target geometry, velocity, both joint
states, yaw response, and distance produced finite commands strictly inside
the smooth `30 rad/T^2` envelope and exact left/right reflection (maximum
error `0.0`). These are provenance and algebraic checks, not new physical
evidence; no CFD was run in this workspace.
