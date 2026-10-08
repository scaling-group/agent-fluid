# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm,
finite dynamics, and capture. The best finite policy is represented twice by
`solver_a95f7416a3de` and `solver_343870fd8107`; their policy texts differ only
in comments/version provenance and their CFD trajectories are bit-identical at
score `-0.50169148`, mean/final distance `2.399184/0.746948L`, and capture
`23.441015T`. The lowest-scoring sample, `solver_89e2a212c5d1`, is the
informative completed role-separation test at `-0.50284115`,
`2.400084/0.748139L`, and `23.435516T`.

I inspected both rows of the combined keyframe sheets for the best finite
capture and that completed regression from release through termination. Their
top-down mid-plane views show the fish translating under its own alternating
body motion, growing a compact signed-vorticity street, and following the same
left-and-down capture arc; the initially uniform fluid does not advect it. The
oblique views confirm coherent alternating three-dimensional Lambda2
structures behind a continuously undulating body, with no wake collapse or
out-of-plane instability before capture. The images are visually
indistinguishable at their sampling cadence, so they do not support another
gait, posture, or wake-topology change.

Trajectory and diagnostic cross-checks preserve the best sampled controller's
mixed but positive result. Relative to the stabilization-envelope parent
`solver_477c7f626e4f`, the carrier-rejected target-course observer improves
score and mean distance from `-0.502603/2.400102L` to
`-0.501691/2.399184L`. Inside `3L`, it reduces mean yaw from `1.70656` to
`1.68733 rad/T`, mean/peak target-line cross-track speed from
`0.23432/0.62616U` to `0.22592/0.58298U`, and mean/peak absolute moment from
`0.006564/0.015118` to `0.006393/0.013886`. It retains a coherent wake and
smooth projected commands, although capture is `0.066T` later, peak yaw rises
from `3.28817` to `3.34971 rad/T`, both joint-speed traces reach the physical
cap, and the role-separation follow-up fails to improve the trade.

One unmodified fast observation remains inconsistent with the successful slow
observer. Offline replay of the best trajectory shows the windowed
`bearing_trend` has `1.599 rad/T` RMS and correlation `-0.931` with the
window-averaged anterior joint rate. Applying the same signed anterior carrier
coordinate already used by the terminal observer reduces this diagnostic to
`0.585 rad/T` RMS and correlation `0.011`; using the available instantaneous
anterior rate gives `0.429 rad/T` RMS and correlation `-0.089`. The corrected
signed mean remains small outside `3L` and preserves the route-scale changes.
This is evidence that the main controller still mistakes beat-synchronous
apparent bearing motion for route trend, not evidence for a new scalar gain.

## Candidate hypothesis

Preserve the best sampled target-course observer, stabilization-envelope
cadence handoff, C-bend polarity, posterior traveling wave, split terminal
observer, and component-wise smooth command projection. Make one observer
change: construct the main bearing trend from the existing windowed body-frame
bearing rate plus the already calibrated anterior carrier-rate coordinate,
then use that residual in the existing bounded trend feedback. This extends
carrier/route separation to the one main-route derivative that still visibly
tracks the propulsive beat; it adds no steering authority, clock, memory,
world coordinate, or gain retune.

The expected effect is less beat-synchronous route correction while retaining
the slow geometric and course requests. Falsify it if formal CFD loses capture
or the coherent alternating wake, gives back the replicated score/distance and
inside-`3L` cross-track/moment improvements, materially delays approach, or
increases yaw, load, joint-limit residence, or projected-command pressure.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-control signal separation
source_mechanism: sensor feedback modulates a slow directional command only after separating it from the rhythmic locomotor carrier
transferable_invariant: route feedback should respond to persistent target motion rather than re-actuate the observed propulsive carrier
nontransferable_details: published gains, dimensional frequencies, robot morphology, species kinematics, exact oscillator or vortex phase, and prescribed paths
policy_translation: add the existing anterior joint-rate carrier coordinate to the normalized body-frame bearing-window rate before the bounded main-route trend response; leave both two-joint actuation roles and all scalar gains unchanged
falsification: reject if CFD loses capture or wake coherence, regresses replicated course-observer distance/cross-track/moment performance, or worsens terminal yaw, load, and actuator feasibility

The new candidate's CFD result is not available to this worker. A later worker
must evaluate the mechanism from that rollout rather than treating the offline
decorrelation alone as improvement.
