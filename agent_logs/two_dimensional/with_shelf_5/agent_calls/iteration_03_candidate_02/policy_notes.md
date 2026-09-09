# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The common held-fish prewarm sheet shows the same developed, interacting four-
cylinder streets reaching the upper-right release pose for every candidate.
The target-blind seed then curls into a nearly vertical descent below the wake
corridor and leaves the lower boundary after `50.127`; its displacement is
`(-3.545,-13.300)L`, its minimum distance is still `8.615L`, and its mean
velocity differs from mean local flow by only about `0.038U`. Both joints reach
the rate and acceleration limits. This is primarily uncontrolled advection
with actuator-limited bending, so more scalar drive is not supported.

The sampled bearing-to-mean-curvature policies provide the positive baseline.
With the seed's `28 deg`, period-`0.55` traveling-bend carrier preserved, an
`8 deg` anterior bearing bias and `0.65` posterior share produce a sustained
diagonal traverse into the interacting wake and first-crossing capture after
`93.032`, with progress `0.940`. The released keyframes show active upstream
self-propulsion and correct target-directed turning rather than the seed's
lower-boundary topology. The carrier and far/middle steering should therefore
remain unchanged.

The two successful samples isolate a concrete terminal result. Adding a smooth
amplitude envelope only inside `2.5L` changes neither arrival time nor
termination and changes mean command energy only from `972.51483` to
`972.51450`; RMS lateral force/moment instead move from `95.497/1146.607` to
`95.545/1147.034`. The tiny mean-distance improvement (`4.03252` to `4.03177L`)
does not establish load relief. The final successful sheet still shows a
pronounced curled approach and dense self-wake, while both joint rate and
acceleration caps are reached. Amplitude-only terminal relief is therefore not
a supported answer to the remaining curvature/load problem.

## Policy hypothesis

Preserve the successful carrier, posterior lag, bearing bias, and existing
smooth amplitude envelope. Add one feedback mechanism only in the terminal
neighborhood: blend the far-field angular bearing request into a bounded
normalized body-frame lateral target-offset request. Angular error retains
turn authority while far away, but it need not vanish close to a point target;
lateral offset does vanish with the geometric miss and can release excess mean
curvature without a clock, route, or world coordinate. Reuse the same
smoothstep so the candidate is formula-identical to the sampled success at and
beyond `2.5L`.

The candidate is falsified if it changes the far/middle path, delays or loses
first-crossing capture, reverses turn sign, or retains the same cap-dominated
terminal curl and loads. A later evaluation should compare semantic success,
arrival, closest/mean distance, terminal topology, saturation, command effort,
and lateral force/moment rather than treating a small scalar change as proof.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal target capture
source_mechanism: separate far-field direction steering from near-field geometric miss correction while preserving the propulsive rhythm
transferable_invariant: near a point target, bounded lateral body-frame displacement should release mean curvature as cross-track miss vanishes, while angular bearing remains useful for far-field redirection
nontransferable_details: published gains, dimensional capture ranges, robot or species kinematics, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain bearing-to-curvature outside the approach neighborhood and smoothly blend to the lateral component of `state.target_body_L` inside it; keep the joint-state carrier and posterior lag intact
falsification: reject if far-field behavior changes, capture is delayed or lost, turn sign reverses, or terminal saturation and curl remain materially unchanged

## Pre-evaluation verification

The prescribed no-CFD contract check returned two finite actions and all direct
parameter references resolve to fields owned by `target_policy_params()`. A
formula grid against the sampled successful policy found exactly zero
acceleration difference for every tested state at `distance_L >= 2.5`. At the
`0.75L` capture boundary the smoothstep retains `0.216` of the angular request;
for consistent lateral misses of `0`, `0.25`, `0.50`, and `0.75L`, the blended
anterior biases are `0`, `2.83`, `4.57`, and `5.71 deg`, respectively, versus
the `8 deg` bound. A near-field grid spanning joint angles, rates, bearings,
distances, and both lateral signs remained finite. These checks establish only
localization, continuity, sign symmetry, and bounded algebra; the later CFD
rollout must determine capture and load effects.
