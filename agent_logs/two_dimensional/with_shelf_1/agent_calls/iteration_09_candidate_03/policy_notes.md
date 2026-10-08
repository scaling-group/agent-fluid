# Candidate diagnosis and hypothesis

## Prior evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets; the target lies inside the merged
  second-row wake. This is a common initial condition, not candidate evidence.
- Three sampled policies reproduce the same successful rollout exactly:
  target capture at `36.4705`, mean distance `1.6860L`, total/mean command
  energy `48700/1335.3`, relative-crossflow RMS `0.2397`, and force/moment RMS
  `63.59/953.42`. Their released sheets show an actively self-propelled fish:
  a sharp initial targetward redirect followed by a nearly straight upstream
  traverse into the merged wake and capture circle. Both joints touch the
  `260 deg/time` speed cap and the candidate's `30.0` acceleration envelope.
- The only distinct sampled child fades half-cycle asymmetry with target
  distance. Its sheet is visually indistinguishable and it reaches at
  `36.4540`; total energy and force/moment RMS fall only to `48679` and
  `63.25/950.58`, while mean distance regresses to `1.6862L` and score to
  `0.188396`. This is not a meaningful new trajectory or terminal mechanism.
- No sampled released failure sheet is present in this workspace. The inherited
  failure boundary is the `left_domain` child at `18.304`, negative progress
  `-0.1453`, and head displacement `(+2.392,-2.047)L`; low effort or low loads
  cannot compensate for losing the proven leftward propulsion/steering
  topology.

## Policy hypothesis

The fixed half-cycle asymmetry produced the largest route improvement in the
inherited logs, but also raised mean command energy and force/moment loads.
Distance-only release acted too late to matter. Preserve the evaluated carrier
and allocator, and add one closed-loop redirect mechanism: use raw normalized
body-frame bearing to request an extra bounded half-cycle share only while the
recent bearing window is not already closing. Release that extra share as a
targetward bearing response appears. Phase still comes only from joint state;
course slip remains confined to the steering residual, and raw bearing retains
reserve ownership.

Expected result: retain capture and the compact redirect/upstream topology,
with an earlier or no-slower arrival than `36.4705` without a disproportionate
increase over `63.59/953.42` force/moment RMS. Reject the mechanism if capture
is lost, mean distance worsens materially, the extra burst merely increases
limit contact/load without shortening the redirect, or a changed wake phase
does not preserve the response-and-release behavior.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: strong bounded asymmetric turning while direction error persists, followed by feedback-triggered release when the requested response appears
transferable_invariant: persistent target error and observed targetward response must have separate roles; extra turn authority is needed only when error is present and response is absent
nontransferable_details: published gains, dimensional response times, species kinematics, prescribed duty cycles, exact vortex phase, and source-task routes
policy_translation: schedule a bounded increment to joint-state half-cycle asymmetry from raw body-frame bearing and body-frame bearing-window rate; retain the two-joint oscillator, acceleration residual, and raw-bearing reserve
falsification: reject if target capture or leftward propulsion is lost, if arrival and distance do not improve, or if force/moment load and actuator-limit contact rise without a compact-route benefit
