# Wake-policy candidate diagnosis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: it shows the
  fish held above and downstream of the target while the four staggered
  cylinder streets develop and overlap around the target corridor. The
  released sheets never reach that corridor. They show an active diagonal
  leftward leg followed by a sharp nose-up pitch and upper-domain exit, so the
  unresolved problem remains far-field course retention rather than wake
  exploitation or tight-radius capture.
- The current `behind_bearing_fraction=-0.25` prefill is the strongest sampled
  finite rollout by score and lifetime. It is modestly self-propelled upstream:
  mean x velocity is `-0.0627` versus local flow `-0.0454`, with head travel
  `(-4.44,+1.78)L`, minimum/final range `6.63/9.43L`, progress `0.241`, and
  release lifetime `74.48`. Its sheet nevertheless shows the same late upper
  return, and finite RMS force/moment are already `76.8/1030`.
- The other three sampled fore/aft combinations bracket zero versus negative
  rearward bearing authority and a `0.02` rearward turn-damping boost. All exit
  through the same upper boundary with about `+1.80L` head-y travel. Removing
  rearward bearing moves `-4.36L` upstream and reaches `6.64L`; adding damping
  while retaining bearing moves `-4.23L` and reaches `6.71L`; combining bearing
  shutoff with extra damping moves `-4.15L` and transiently reaches `6.57L` but
  worsens mean/final distance, score, and lifetime. Thus the small minimum-range
  gain in the coupled variant is not a recovery mechanism, and the rearward
  steering factorial is locally negative for the visible exit topology.
- Joint diagnostics expose a shared terminal actuator signature that those
  geometry variants do not remove. The sampled anterior speed maxima are
  `250--260 deg/time` despite a `200 deg/time` soft guard, while anterior action
  stays near the `1600 deg/time^2` soft limit and anterior angle reaches
  `32.6--34.9 deg`. In the best prefill specifically, joint one reaches about
  `254 deg/time` and `34.3 deg`; joint two remains near `191 deg/time` and
  `25.9 deg`. The existing speed threshold is above the inherited nominal
  anterior orbit near `184 deg/time`, but its damping gain of `6` does not keep
  the terminal excursion away from the hard `260 deg/time` cap.
- Inherited logs close two tempting geometric alternatives. Short-window
  opening-speed attenuation damaged the approach and raised loads, while a
  full-circle target-vector bearing moved only `-0.57L`, reached just `9.27L`,
  produced negative progress, and exited after `52.40`. Another bearing or
  target-motion rewrite is therefore less isolated than acting on the common
  high-speed state that immediately accompanies the failed pitch.

## Candidate hypothesis

Preserve the best sampled prefill's oscillator, gait, `0.60` bearing gain,
`12 deg` steering ceiling, `-0.25` rearward bearing fraction, fixed `0.04`
turn damping, joint thresholds, and acceleration limiter. Reuse its evaluated
signed fore/aft gate only to increase overspeed damping after the target passes
abeam: keep the existing gain `6` while the target is ahead and ramp in a
bounded boost of `12`, for a rearward total of `18`. At the prefill's roughly
`54 deg/time` excess over the soft guard, the added term contributes about
`650 deg/time^2` of opposing acceleration; it is zero below `200 deg/time` and
does not alter the inherited nominal `184 deg/time` orbit. The posterior joint
also remains unchanged unless it independently crosses the same threshold.

This is one isolated test of whether the upper pitch is sustained by an
insufficient terminal speed guard, not a claim of same-worker CFD improvement.
It is supported only if the rollout retains roughly `-4.4L` upstream travel and
a `6.6L` approach, reduces anterior peak speed materially below `254--260
deg/time`, and delays or removes the upper return without increasing loads. It
is falsified if the fore/aft gate activates early enough to shorten the useful
leg, the anterior speed and upper exit remain unchanged, propulsion collapses,
a lower return appears, or force/moment rise. The mechanism is bounded and uses
only normalized body-frame target geometry and joint state; it contains no
coordinate, clock, route, prescribed inflow, remote probe, target-station
signal, or omitted-shelf dependency.
