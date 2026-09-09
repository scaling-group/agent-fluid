# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The common prewarm sheet shows the held fish near the upper-right boundary
  after four interacting cylinder streets have filled the diagonal target
  corridor. Its byte-identical copies are shared initial-condition evidence,
  not evidence of candidate-specific wake phase or robustness.
- All four sampled solver policies and released sheets are byte-identical. The
  fish immediately establishes a zero-centered traveling wake, swims diagonally
  down-left through the merged streets without cylinder contact, and reaches
  the target at `44.121`. Mean body-x velocity is `-0.2470` while mean local
  flow is `-0.1848`, and head displacement is `-10.910/-4.263L`, so the route
  is actively propelled rather than passively advected. The final frames show
  a useful wake entry followed by a downward excursion and corrective hook into
  the capture circle; lateral motion is productive overall but leaves a narrow
  terminal opportunity for less corrective actuation.
- The deterministic reference has `1.70618/0.748931L` mean/minimum distance,
  mean command energy `1036.49`, and `389/3909` force/moment RMS. Both joint
  rates reach the `4.538` hard cap and both acceleration commands approach the
  candidate soft limit (`28.79/28.39`), so the route is successful without
  demonstrating spare steering authority or low actuator use.
- No sampled or inherited visual rollout is a semantic failure. The assigned
  parent's sine-compressed course residual is the strongest available negative
  control: it retains the diagonal capture but deepens/delays the terminal path,
  arriving at `46.074` with `1.73655L` mean distance, `407/4002` RMS loads, and
  the same joint-rate caps. Other inherited mechanism changes agree with that
  boundary: time-to-go onset reaches at `45.975/1.73033L`, prioritizing course
  over an opposing heading forecast reaches at `45.331/1.72584L`, and unsigned
  crossflow/yaw coincidence gating reaches at `45.150/1.71930L` while raising
  loads to `460/4421`. Do not make another scalar, representation, scheduler,
  cue-arbitration, or magnitude-only wake-gate edit around the proven terminal
  course residual.

## Policy hypothesis

Add exactly one actuator-side state-feedback mechanism: retain full optional
half-cycle steering while a joint has oscillator-normalized rate headroom, then
smoothly release only that joint's steering residual toward a nonzero floor as
its observed rate is consumed. Apply the gates independently to the anterior
and posterior half-cycle residuals. The zero-centered oscillator, base posterior
lag, progress allocator, time-to-go-capped heading forecast, fixed-distance
angular course damper, yaw-magnitude gate, steering signs, and acceleration
limiter remain unchanged.

This tests whether the visible terminal correction and cap-dominated joint
motion can be made less wasteful without weakening upstream propulsion. Later
CFD should retain first-crossing capture and the same broad diagonal wake-entry
topology while lowering force/moment load, command effort, rate-cap residence,
or the depth of the terminal hook. Reject the mechanism if capture is lost, the
route turns late or passes below the circle, arrival/mean distance regress
without a material load or effort benefit, or cap contact and hydrodynamic load
increase. The fixed prewarm snapshot cannot establish robustness to changed
wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: biological burst-redirect swimming and closed-loop robotic-fish CPG steering
source_mechanism: release a bounded steering residual as observed actuator response develops while preserving the underlying rhythmic propulsive wave
transferable_invariant: keep propulsion intact and condition only the optional two-joint steering residual on normalized joint-state headroom with a nonzero authority floor
nontransferable_details: published gains, dimensional rate thresholds, species-specific burst kinematics, exact vortex phases, cylinder or target coordinates, capture geometry, and task-specific routes
policy_translation: gate each existing half-cycle acceleration residual by its own joint-rate usage relative to the candidate-owned oscillator scale, leaving the base two-joint traveling bend and route signals unchanged
falsification: reject if capture or diagonal topology is lost, terminal excursion deepens, arrival or mean distance regresses without material load or effort relief, or joint cap contact and force or moment loads worsen
