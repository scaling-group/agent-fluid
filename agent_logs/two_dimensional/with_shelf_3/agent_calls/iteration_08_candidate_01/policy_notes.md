# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. The fish begins outside the
  strongest wake, while the target lies inside the merged second-row wake; this
  is identical initial-condition evidence for every sampled candidate.
- All four current samples reach the target. The three strongest samples are
  byte-identical implementations and visual replays of the promoted posterior
  half-cycle controller. Their released sheet shows immediate targetward
  rotation, a persistent body-generated traveling wake, a compact diagonal
  crossing into the developed cylinder wakes, and direct first entry into the
  `0.75L` capture circle. The repeated metrics agree exactly: capture at
  `32.472`, `1.64761L` mean distance, and score `0.224538`.
- The distinct `0.140088` sample is the same bearing-filtered, scheduled
  curvature controller without posterior half-cycle amplification. Its sheet
  retains the useful trajectory topology but turns and translates targetward
  more slowly, reaching at `35.0625` with `1.73388L` mean distance. The promoted
  mechanism raises mean targetward velocity magnitude (`-0.334/-0.140` versus
  `-0.310/-0.129` world components) and shortens the rollout, while similar
  relative-crossflow RMS (`0.245` versus `0.247`) argues against a merely calmer
  wake realization.
- The speed gain has a load boundary. Both distinct policies touch the
  `260/1800 deg` joint velocity/acceleration envelopes. The faster policy raises
  lateral-force RMS from `56.57` to `68.70` and yaw-moment RMS from `793.76` to
  `931.60`; its lower total command energy comes from earlier termination, not
  lower mean effort. Extra posterior authority must therefore be transient and
  response-gated rather than a scalar increase held throughout the turn.
- No failed rollout is present in the four current samples. The inherited
  optimizer notes identify an informative downstream-exit negative result:
  unrestricted bearing-trend feedback upstream of the oscillator centers
  collapsed the traveling bend to `0.140/0.163 rad` peak joint excursions and
  exited at `16.956` with negative progress. This candidate uses a bearing trend
  only to remove an optional positive pulse; it cannot reduce the completed
  controller below its evaluated posterior-wave command.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirection and sensor-feedback robotic-fish CPG turning
source_mechanism: large direction error triggers bounded asymmetric redirection, and observed heading response releases the burst back toward the steady propulsive rhythm
transferable_invariant: a small turn-congruent posterior pulse may persist only while normalized body-frame target error is large and recent error history does not yet show alignment response; the proven traveling wave remains the lower command bound
nontransferable_details: published gains, burst durations, dimensional frequencies, species-specific C-start kinematics, exact vortex phases, actuator shares, and source-task routes
policy_translation: preserve the evaluated filtered bearing, bounded mean-curvature allocation, oscillator, posterior lag, and 8 percent half-cycle asymmetry; use the sign-consistent recent bearing-window response to gate at most one additional small posterior half-cycle pulse that vanishes with alignment
falsification: reject the response-gated burst if capture is lost or not earlier than 32.472, mean distance is not below 1.64761L, the compact diagonal topology changes, or force, moment, or saturation residence rises without a navigation gain

## Candidate hypothesis

Add exactly one feedback mechanism to the promoted controller: a bounded
response-gated burst on the already identified turn-helping posterior
half-cycle. Recent bearing-window rate is normalized by the owned bearing scale
and control period. A sign-consistent decrease in bearing magnitude smoothly
releases the extra pulse; absent history, worsening alignment, or weak response
retains it. Persistent bearing magnitude also gates the pulse, so it disappears
at alignment.

The extra gain is capped at four percentage points above the evaluated eight
percent asymmetry. The base curvature request, `40/60 -> 35/65` allocation,
anterior oscillator, posterior lag, damping, and completed eight-percent
half-cycle path remain unchanged. Because the new trend signal can only gate
the extra nonnegative pulse, it cannot reproduce the inherited propulsion-
collapse topology caused by inserting a signed derivative into the centers.
The expected result is a quicker initial redirect followed by the evaluated
traveling wave once target-relative response is established; no new CFD result
is claimed before downstream evaluation.
