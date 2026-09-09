# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver rollouts satisfy the frozen evidence contract:
  direct uniform still-water initialization at `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. I
  inspected both rows of the combined sheets. The top-down views show a
  target-directed alternating street and the oblique views retain compact
  caudal Lambda2 structures from release to first crossing, so translation is
  self-propulsion rather than initialization advection.
- Three geometry-only executables are replications apart from comments. They
  capture at `18.6505--18.7550T` with score-metric mean distance
  `2.09340--2.09542L`; the sampled response-coupled envelope schedule captures
  at `18.6615T` and `2.09362L`, inside that wider repeat band. Geometry is the
  supported gait-schedule observation, but the extra response coupling is not
  distinguishable. The terminal range/velocity compound is weaker at
  `19.0520T` and `2.09874L` and visibly takes a larger lateral excursion.
- The geometry-only carrier still contacts the joint-rate envelope on roughly
  `11%/15%` of anterior/posterior rows and the acceleration envelope on about
  `61%/73%`. This candidate is therefore a route-allocation test, not an
  actuator-relief claim. It keeps the exact final acceleration projection and
  avoids the failed pointwise rate barriers.
- The assigned-parent logs provide two informative coherent-wake failures.
  Releasing posterior redirect curvature separately passes high, approaches
  only `4.5218L`, and exits left at `24.8215T`. A shared low-speed cadence
  boost produces an initially energetic street but progressively turns down,
  approaches only `3.1735L`, and exits left at `29.0895T`, ending `9.1868L`
  away. Lower rate contact in either trace is not relief because capture and
  the compact target-directed route are lost. These results rule out another
  cadence change or joint-role split around this carrier.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological rapid-turn transitions and sensor-modulated robotic-fish CPG turning
source_mechanism: trade rhythmic excursion for bounded mean-curvature asymmetry during redirect, then return continuously to a propulsive cruise beat
transferable_invariant: persistent normalized body-frame target misalignment may allocate a shared bend budget between oscillatory envelope and target-signed mean curvature while preserving the coupled traveling bend and recovering the cruise carrier at alignment
nontransferable_details: species-specific C-start timing and curvature, published CPG offsets or gains, dimensional tail-beat settings, full-body waveforms, exact vortex phases, and any world-frame route
policy_translation: retain geometry-only amplitude relief and reallocate a bounded fraction of the relieved anterior excursion to both mean-curvature shares through one common scale, preserving their evidenced ratio, common response gate, displacement phase, posterior lag, and acceleration projection
falsification: reject if capture is lost, either wake row loses coherence, arrival or mean distance remains inside the replicated geometry-only band, the route leaves its compact target-directed family, or load and saturation histories worsen materially

## Single-candidate policy hypothesis

The successful schedule reduces rhythmic amplitude when the target has a large
body-lateral component but leaves redirect curvature unchanged. The candidate
turns that one-way reduction into a bounded allocation: a policy-owned
fraction of relieved anterior excursion increases both target-signed curvature
limits through the same multiplier. At alignment the allocation is exactly
zero and the evidenced cruise carrier is recovered; during redirect it keeps
the `4:10` anterior/posterior ratio and cannot invert the geometry-owned turn
sign. The expectation is a more direct redirect and capture outside the
`18.6505--18.7550T` / `2.09340--2.09542L` replication band without the phase
change of cadence modulation or the route loss of posterior-specific release.
New CFD evidence is deferred to the downstream evaluator.
