# Wake-policy candidate notes

## Prior evidence diagnosis

Only the common naive-seed rollout is sampled in this workspace, so it is both
the best finite example and the informative failure.  The held-fish sheet shows
the common four-street wake fully developed before release.  In the released
sheet the fish produces a visible traveling bend and moves under its own gait,
but curls steeply toward the lower boundary instead of holding its initially
reasonable diagonal target heading.  It never enters the useful second-row
target region and exits the domain after only `50.1269` released time units.

The scalar and visual evidence agree: head displacement is `(-3.545, -13.300)L`,
closest distance is only `8.615L`, final distance regresses to `12.123L`, and
progress is `0.0243`.  The episode remains finite and avoids collision, but its
large lateral excursion coincides with RMS relative crossflow `0.1747`, RMS
lateral force `21.94`, and RMS yaw moment `541.70`.  Since the seed reads only
joint state, it has no feedback capable of correcting accumulated heading
error.  The evidence therefore supports adding directional feedback while
preserving the working traveling-bend scaffold; it does not yet establish the
sign or event scale needed for a separate flow/force rejection term.

## Candidate hypothesis

Center the anterior state-feedback oscillator on a bounded bias derived from
the normalized body-frame lateral target ratio, and give the posterior lag
target a smaller bias of the same sign.  This creates mean body curvature
without removing the propulsive oscillation or its posterior phase lag.
Saturating this directional error and choosing bias envelopes that keep the
nominal oscillation inside the `45 deg` joint limits should provide broad
steering without bang-bang action.

Expected semantic change: the fish should correct the visible downward drift,
avoid the early lower-domain exit, survive materially beyond `50.1` released
time units, and reduce target distance below `8.615L`.  This first directional
candidate intentionally excludes wake-disturbance feedback so its causal
contribution remains identifiable.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and fish mean-curvature turning
source_mechanism: target-driven mean-curvature or tail-beat bias superimposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error should create bounded average curvature while the posterior traveling bend continues to supply thrust
nontransferable_details: published gains, dimensional beat frequencies, species-specific curvature envelopes, clocked CPG phases, and prescribed routes
policy_translation: saturate `target_body_L[2] / distance_L` into an anterior oscillator-center bias plus a smaller same-sign posterior bias; retain joint-state phase and posterior lag
falsification: reject or revise if the rollout repeats the lower exit, loses propulsion, hits joint/action limits persistently, collides, becomes unstable, or fails to improve the `8.615L` closest approach
