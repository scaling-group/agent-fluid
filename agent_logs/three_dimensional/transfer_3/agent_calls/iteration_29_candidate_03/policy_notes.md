# Controlled replication of one-sided carrier-demodulated phase recruitment

## Evidence diagnosis recorded before the policy edit

- All four sampled solver examples and the assigned-parent rollout satisfy the
  frozen contract: direct `uniform_direct` initialization with zero background
  flow, no prewarm, no cylinders, finite dynamics, and capture. The sampled
  cohort arrives at `18.6560--18.7825T`; the assigned parent arrives at
  `18.8980T`. Thus the parent is an informative route/effort tradeoff, not a
  termination failure.
- I inspected every sampled combined keyframe sheet and the assigned-parent
  sheet from release through capture. In both the top-down vorticity rows and
  oblique Lambda2 rows, the body advances toward the target while shedding a
  compact alternating caudal wake. The wake remains body-led and coherent,
  turning remains continuous, and no sheet shows passive advection, wake
  collapse, growing wasteful sway, boundary approach, or instability before
  capture. Local-flow RMS remains `0.01796--0.01809U`, consistent with
  self-propelled still-water motion rather than environmental transport.
- The prefilled actuator-consistent policy captures at `18.6725T`, score
  `-0.13362`, mean distance `2.02129L`, with anterior/posterior acceleration-
  limit occupancy `42.24%/76.14%`, action RMS `24.95/28.85 rad/T^2`, and
  lateral-force/moment RMS `0.01256/0.00703`. Helpful raw-moment amplitude
  relief is the best sampled score (`-0.13321` at `18.6560T`) but still uses
  `75.77%` posterior limit occupancy and `0.01235/0.00691` loads; its route
  lead is below inherited same-hash timing spread and is not a robust raw-
  moment result.
- The assigned parent's one-sided carrier-demodulated residual captures at
  `18.8980T`, score `-0.14813`, mean distance `2.03633L`. It lowers action RMS
  to `24.42/28.63 rad/T^2`, posterior acceleration-limit occupancy to `74.24%`,
  and lateral-force/moment RMS to `0.01213/0.00680`, improving every effort
  quantity relative to the prefill and the current raw-moment controls while
  retaining the same coherent trajectory topology. Posterior velocity-limit
  occupancy rises modestly to `7.68%` from the prefill's `7.51%`, so the
  mechanism is not evidence of velocity headroom.
- Inherited completed controls explain why this should be replicated without
  another allocator change: bidirectional carrier-demodulated phase response
  already replicated an effort benefit, whereas stress-gated raw-moment
  relief delayed capture to `18.7825T`, and instantaneous outward-phase
  withdrawal delayed capture to `18.8100T` while increasing posterior
  velocity-limit occupancy to `8.10%`. The new one-sided result is compatible
  with the load trend but has only one completed evaluation.

## Policy hypothesis recorded before editing

Replicate the assigned-parent policy exactly. Preserve normalized body-frame
bearing and LOS-rate guidance, recoil-conditioned yaw error, the distributed
C-bend, state-feedback traveling carrier, response-reversing half-cycle path,
persistent same-side stress gate, coefficient-norm-preserving posterior phase
rotation, sampled carrier-moment subtraction, and componentwise acceleration
projection. The only fluid-response allocation remains one-sided: an opposing
carrier-demodulated residual may increase existing posterior phase recruitment
by a bounded fraction, while a helpful residual cannot withdraw the proven
route actuator.

Replication is supported if capture remains within the inherited successful
`18.6725--19.0080T` band, both wake views remain coherent, posterior
acceleration-limit occupancy stays below the raw-moment cohort's `75.77%`, and
lateral-force/moment RMS stays below `0.01235/0.00691`. A second run near the
parent's `74.24%` and `0.01213/0.00680` would establish a reusable effort
benefit despite slower route cost. Falsify it if capture is lost, arrival
leaves the band, wake coherence degrades, effort returns to the raw-moment
band, or velocity-limit occupancy reaches the inherited `8.10%` negative
control; later workers should then retain the replicated bidirectional
demodulated allocator and test beat-history rather than another instantaneous
moment gate.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish CPG control
source_mechanism: preserve useful fluid-induced motion while a bounded residual channel rejects only response opposing the slow route correction
transferable_invariant: retain the productive traveling wave and normalized route loop, subtract self-generated carrier response from the physical cue, and recruit only small residual authority against opposing response
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, organized-wake synchronization, and source-task routes
policy_translation: keep body-frame LOS guidance and observed two-joint phase primary; use the reflection-even alignment of carrier-demodulated moment and requested yaw response only to increase bounded posterior phase recruitment against opposition
falsification: reject if replication loses capture, leaves 18.6725--19.0080T, weakens either wake view, exceeds 75.77% posterior acceleration occupancy or 0.01235/0.00691 lateral-force/moment RMS, or reaches 8.10% posterior velocity occupancy

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
