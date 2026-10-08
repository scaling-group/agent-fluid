# Dogfish L64 Second-Row Wake-Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 40-iteration lineage with no solver or optimizer population
  import. The same guidance is used by matched 2-, 3-, and 4-worker runs.
- The fixed task is `L64`, target `(9,9.5)L`, first-crossing radius `0.75L`,
  inflow `0.18`, held-fish prewarm `200`, released horizon `300`, and actuator
  envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect shared prewarm and released keyframe sheets before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination.
- For the common target-blind seed, the released keyframes and diagnostics show
  a specific architecture failure: it exits the bottom boundary after `50.13`
  time units with `-13.30L` cross-stream displacement but only `-3.55L`
  upstream displacement, and its best distance (`8.61L`) regresses to
  `12.12L`.  Both joint velocities and accelerations reach their hard limits,
  so increasing oscillator gains is not a credible first repair.  On this
  failure topology, add bounded body-frame target-bearing control to the mean
  curvature of a realizable state-feedback traveling bend before introducing
  wake-phase or flow rejection.  This lesson is falsified if that curvature
  feedback turns with the wrong sign, preserves the bottom-exit topology, or
  removes the seed's upstream progress; only after target-directed motion is
  established should repeated wake-synchronous yaw reversals motivate a
  separate disturbance residual.
- Completed descendants sharpen that lesson: putting bearing error into a
  static oscillator center is not enough.  An amplitude-regulated version
  improves `left_domain` to a full `300`-unit horizon and halves RMS yaw moment
  (`541.70` to `270.96`), but keyframes show a far-right loop with only `1.19L`
  upstream displacement and a `10.28L` closest approach.  Two simpler centered
  biases instead leave the downstream boundary within `16.63`--`19.87` units,
  each moving about `+2.2L` downstream.  Therefore neither horizon survival
  nor large joint motion validates route control; avoid scalar-only tuning of
  this static-bias architecture when the loop/advection topology persists.
- Phase-dependent half-cycle steering is now a replicated positive mechanism,
  not merely a proposal.  Two independently completed zero-mean variants both
  reach the target after the static-bias failures: one arrives in `179.22`
  units with `5.04L` mean distance and `-10.93L` upstream displacement, while
  the other arrives in `268.49` units with `8.04L` mean distance and `-10.92L`
  upstream displacement.  Their keyframes retain alternating bends throughout
  broad targetward arcs into the interacting wakes.  Preserve state-encoded
  phase, zero crossings, and posterior lag when extending this controller;
  falsify an extension if it loses capture, upstream translation, or the
  alternating wave.  The faster variant also raises RMS moment from `273.01`
  to `338.91` and command-energy mean from `351.62` to `653.20`, and the two
  policies differ in several gait and tail parameters, so this comparison does
  not identify a causal scalar gain.  Treat bounded load/yaw rejection as a
  separately falsifiable extension and require it to preserve arrival, rather
  than inferring that lower effort alone is an improvement.
- Once the alternating half-cycle scaffold reaches the target, qualify slow
  route-response damping with measured translation instead of treating body
  rotation as progress. Two duplicated rate-only policies capture after
  `149.605` units with `4.358L` mean distance, whereas two otherwise identical
  policies gate `bearing_window_rate` damping by positive normalized closing
  speed and capture after `137.357` units with `4.184L` mean distance; total
  command energy falls from `96933` to `90228`, and RMS crossflow, force, and
  moment fall from `0.1321/15.49/308.48` to `0.1296/14.75/303.02`. Preserve
  instantaneous body-frame bearing as the route owner on this scaffold: an
  inherited one-change circular average of its short history still captures
  but regresses to `149.853` units, `4.423L` mean distance, `100638` total
  command energy, and higher crossflow and load. Apply progress qualification
  when bearing convergence can be yaw without approach. An inherited
  one-change attempt to relieve posterior phase lag whenever absolute bearing
  is large also keeps capture but widens the lower midcourse excursion and
  regresses to `158.147` units, `4.692L` mean distance, `103629` total command
  energy, and `0.13199/15.66/311.93` RMS crossflow/force/moment. Thus do not
  infer from large target misalignment alone that posterior traveling-wave
  thrust should be reduced during a redirect; test any future actuator
  coordination with measured response or phase while preserving full-wave
  recovery. Falsify these boundaries if capture, upstream translation, or the
  alternating bend is lost, or if held-out wakes do not reproduce the arrival,
  distance, and load advantages. Avoid bearing-history smoothing until a
  slower observation window or phase-conditioned filter is tested without
  blunting the initial redirect.
- Three completed response-conditioning and actuator-sharing extensions now
  establish a reusable negative boundary around the `137.357`-unit scaffold.
  Gating direct yaw-moment rejection by growth of absolute bearing delays
  capture to `149.490` units and raises mean distance/energy from
  `4.184L/90228` to `4.428L/97418`; putting route-driven half-cycle asymmetry
  into the posterior wave delays capture to `196.317` with
  `5.718L/131294`; and attenuating moment rejection when moment opposes body
  yaw rate delays capture to `205.519` with `6.209L/134893`. Their keyframes
  retain alternating propulsion but show deeper or longer midcourse detours,
  and their RMS force/moment all exceed the direct-residual baseline. Thus
  slow bearing divergence, instantaneous yaw-power sign, and unused posterior
  acceleration headroom do not establish when to withdraw disturbance
  rejection or move route authority into the tail. Restore the direct moment
  residual and unmodified posterior traveling wave after this topology; avoid
  another attenuation or actuator-sharing heuristic unless a calibrated
  phase or target-relative translational signature predicts when it should
  act. This boundary is limited to the common wake snapshot and is falsified
  only by a one-change mechanism that preserves the baseline capture topology
  while improving distance and effort/load together.
- On the `137.357`-unit progress-qualified scaffold, appending another bounded
  observation directly to the turn request has now failed in two distinct
  ways. An oppositely signed relative-crossflow residual preserves capture but
  delays it to `154.110` units, worsens mean distance from `4.184L` to
  `4.687L`, raises total energy from `90228` to `99457` and RMS force/moment
  from `14.75/303.02` to `15.85/310.83`, yet barely changes RMS crossflow
  (`0.12955` to `0.13005`). A bounded lateral-target residual likewise delays
  capture to `159.302` units with `4.722L` mean distance. Treat measured
  crossflow as neither automatically harmful nor a route command, and avoid
  further unconditioned additive route/flow residuals when capture already
  works. A later disturbance term should first show an adverse, phase- or
  response-conditioned signature; otherwise test coordination between the
  existing steering and propulsive actuators. This boundary is falsified only
  if a one-change residual preserves the `137.357` capture topology while
  improving distance and load/effort together under the same wake snapshot.
- Treat previous-action response as a phase/amplitude mechanism, not as an
  effort smoother. Relative to the replicated direct-action scaffold, a short
  response on both joints advances capture from `137.357` to `130.729` and
  improves mean distance from `4.184L` to `3.754L`, but raises total command
  energy from `90228` to `115750`, RMS crossflow/force/moment from
  `0.1296/14.75/303.02` to `0.1543/18.30/359.97`, and anterior acceleration to
  its cap. Restricting response to the anterior joint gives the best sampled
  mean distance (`3.685L`) and lowers energy to `110448`, yet capture is later
  (`135.019`) and RMS force/moment remain `18.53/362.61`; removing response and
  adding closing-qualified course alignment instead retains the lower-load
  topology but captures at `137.247` with `4.077L` mean distance. Thus action
  history and its joint placement reshape the traveling wave and route, while
  neither filtered result supports a load-reduction claim. Keep posterior and
  anterior placement separately falsifiable, and condition any further
  actuator response on observed phase or signed joint energy rather than
  stacking another route residual. This boundary is falsified only if the same
  wake snapshot preserves the filtered distance/arrival advantage while bend
  peaks, cap contact, effort, and force/moment improve together.
- Prefer normalized body-frame feedback. Wake phase, inflow, cylinder layout,
  and target position are intended held-out axes; coordinate memorization is
  not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
