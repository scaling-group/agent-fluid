# Steering-headroom-qualified posterior reserve

## Evidence reviewed before editing

- I read the assigned parent guidance, all four sampled scores, observations,
  diagnostics, trajectories, metrics, and policies, plus the inherited
  step-10 through step-12 optimizer notes and evaluations. Every sampled run
  satisfies direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and capture.
  Three sampled policies are byte-identical error-qualified route controllers
  with identical `17.7265T` trajectories; they are deterministic replication
  evidence, not three distinct mechanisms.
- I inspected both the top-down vorticity and oblique Lambda2 rows of the
  combined keyframe sheets for the strongest scalar result
  (`solver_aa78a1c20ec5`) and the replicated error-qualified baseline
  (`solver_c668b8e0b865`). Both self-propel from rest, establish a coherent
  alternating wake, retain compact three-dimensional posterior structures,
  and cross the capture boundary without wake breakup, collision, passive
  advection, or out-of-plane instability. The evidence therefore supports
  preserving the traveling-wave carrier, route observer, and approach law.
- Relative to the replicated baseline, the sampled low-energy posterior
  reserve increases mean speed over the first `3T` from `0.2395U` to
  `0.2523U`, reduces distance at `3T` from `11.9445L` to `11.9005L`, lowers
  mean score-distance from `1.967391L` to `1.960279L`, and improves score from
  `-0.081395` to `-0.073952`. Its extra posterior motion does not create a new
  acceleration/load class: acceleration-ceiling residence changes from
  `69.69/64.82%` to `69.34/65.94%`, with nearly unchanged force and moment RMS.
- The same reserve changes the route rather than simply improving it. Center
  path grows from `12.8468L` to `13.0672L`, maximum head cross-track from
  `0.5120L` to `0.6630L`, and cross-track at the `2.10L` approach boundary
  from `0.0183L` to `0.3766L`. Mean approach course alignment falls from
  `0.8993` to `0.7403`; capture alignment falls from `0.6010` to `0.1320`,
  final yaw rate changes from `-0.9008` to `-2.1456 rad/T`, and capture is
  delayed from `17.7265T` to `17.9740T`. Reconstructed state feedback shows
  the energy reserve is concentrated in the first `3T` and overlaps an
  average normalized turn load of about `0.29`; its mature-gait and approach
  activity is negligible. The defect is therefore early posterior-thrust and
  steering competition, not a need for terminal injection.
- The inherited step-12 closure-qualified approach cadence preserved capture
  time but regressed score/mean distance from `-0.081395/1.967391L` to
  `-0.081819/1.967732L`. Together with earlier terminal-course and posterior
  relief regressions, that result argues against stacking another approach
  cadence, terminal steering, or scalar carrier-gain edit onto this candidate.

## One policy hypothesis

Preserve the sampled low-energy posterior reserve and every established
carrier, guidance, approach, steering, and rate-governor term. Add one bounded
actuator-allocation mechanism: multiply only the *extra* posterior reserve by
the remaining steering headroom `1 - abs(turn_request)/turn_request_limit`.
The signal is already a bounded, normalized consequence of body-frame target
geometry and state feedback. The reserve therefore remains mostly available
during low-energy, modest-turn startup, but releases continuously if route
correction consumes the two-joint controller's turn authority. Base posterior
emphasis and full steering/reversal authority remain unchanged.

Expected evidence is retention of the reserve's early speed and distance gain,
the coherent two-view wake, and the better mean-distance score, while route
cross-track, approach alignment, terminal yaw, and arrival move back toward or
beyond the replicated baseline. Falsify the mechanism if it erases the first
`3T` closure gain, leaves the reserve trajectory's late positive cross-track
and poor approach alignment unchanged, worsens capture/score/load class, or
causes posterior wake coherence to regress. If falsified, later workers should
revert to the error-qualified baseline rather than tune the reserve gain.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve a posteriorly emphasized traveling wave while allocating auxiliary propulsion from the actuator authority left after target-directed steering demand
transferable_invariant: an extra posterior thrust reserve should withdraw smoothly as normalized body-frame turn demand consumes shared two-joint authority, without weakening the base carrier or reversal command
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, clock phase, duty ratios, exact vortex phases, target coordinates, and task-specific routes
policy_translation: multiply the existing low-carrier-energy posterior reserve by one minus the bounded turn-request fraction, using only current body-frame target and joint-state feedback while leaving the base posterior wave and steering paths unchanged
falsification: reject if early closure, capture, mean distance, path, cross-track, approach alignment, actuator/load class, reflection behavior, or either wake view regresses relative to the sampled reserve and replicated baseline boundaries
