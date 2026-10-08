# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. This is the certified common initial
  condition, not candidate-specific wake selection or phase-robustness
  evidence.
- All four current samples reach the target on the same compact diagonal. The
  released sheets show an immediate targetward redirect, a sustained
  posterior-traveling body wake, no cylinder approach, and a nose-first entry
  into the `0.75L` circle. The trajectory-supervised sample's mean fish
  velocity `(-0.3362,-0.1404)` versus local flow `(-0.1961,-0.1918)` and its
  `(-10.9149,-4.2375)L` head displacement show active upstream propulsion,
  not passive advection. Its late oscillation remains a narrow productive wake
  as the fish enters the interacting cylinder-wake region.
- The two ungated samples reproduce capture at `32.472`, mean distance
  `1.64761L`, force/moment RMS `68.70/931.60`, and posterior excursion
  `0.58337 rad`. The assigned parent's trajectory-efficiency supervisor is a
  genuine semantic improvement: it preserves capture and route topology,
  arrives at `32.340`, improves mean distance to `1.63773L`, lowers force and
  moment to `65.12/888.56`, and reduces posterior excursion to `0.57530 rad`.
  Unchanged relative-crossflow scale (`0.24372` versus `0.24511`) shows that
  the load reduction did not come from avoiding the developed wake.
- The independent response-confirmed curvature release is faster still at
  `32.136`, has the best mean distance `1.63696L`, and lowers loads relative to
  ungated control to `67.22/907.46`. Its sheet preserves the same traveling
  bend and direct route. Both improved branches still touch both joint velocity
  and acceleration ceilings, so neither supports increasing actuation.
- No failed released keyframe exists in the current sample. The most
  informative adverse visual contrast is therefore the successful but
  higher-load ungated branch. Inherited textual failure boundaries still rule
  out unrestricted bearing-rate recentering, which erased the traveling bend
  and exited downstream, and blanket physical-limit damping, which delayed
  capture. Those unavailable sheets are not treated as new visual evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking combined with biological redirect-and-release turning
source_mechanism: preserve a persistent propulsive rhythm while observed target response supervises bounded mean-turn and posterior rhythmic residuals
transferable_invariant: slow body-frame goal geometry owns mean turn direction, while verified targetward response may withdraw only optional steering components and must leave the traveling base gait intact
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator ratings, source-task routes, and fixed approach distances
policy_translation: start from the evaluated trajectory-efficiency-supervised posterior headroom branch and add the separately evaluated response-confirmed release of distributed mean curvature using normalized gait activity, recent turn rate, bearing rate, and persistent bearing; neither gate can add authority or suppress the unit-gain lagged wave
falsification: reject if target capture or the compact diagonal topology is lost, arrival and mean distance regress beyond the trajectory-supervised branch without a compensating load reduction, force or moment exceed both component branches, the traveling bend weakens, or a held-out wake exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate as a small compatible combination of the two
independently positive sampled mechanisms. Use the assigned parent's
trajectory-efficiency supervisor to yield only the optional `8%` posterior
half-cycle residual during coherent closure and use the response-confirmed
release to withdraw at most a bounded fraction of the distributed mean
curvature only when anterior gait activity is established, heading rotates
toward the target, and bearing shrinks.

The combination preserves the filtered body-frame bearing, `12 deg` total
curvature ceiling, `40/60 -> 35/65` allocation, anterior state-feedback
oscillator, posterior lag and damping, and unit-gain traveling wave. The two
gates cannot add steering and fall back continuously to their evidenced base
commands when their observations are absent or confidence is low. CFD should
test whether the curvature release retains its faster approach while the
trajectory supervisor retains some load relief; no same-worker improvement is
claimed.
