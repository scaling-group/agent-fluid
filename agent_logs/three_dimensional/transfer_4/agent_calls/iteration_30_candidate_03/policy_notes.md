# Target-normal-power mean-bend allocation candidate

## Evidence diagnosis

All four sampled evaluations used direct uniform still-water initialization
with `U_infinity=[0,0,0]`, no cylinders, and the moving-window contract intact;
all reached capture without instability. The combined keyframe sheets show the
same useful mechanism from release through termination: the fish is
self-propelled rather than advected, the anterior oscillation feeds a coherent
alternating top-down wake, and compact paired three-dimensional Lambda2
structures remain attached to the traveling posterior wave. No wake collapse,
boundary interaction, or unproductive standing wiggle explains the small score
differences. The actionable difference is the last `2.10L` of approach.

The strongest sampled policy, yaw-power-selective posterior relief, captured at
`18.0070T` with score/mean distance `-0.064028/1.950358L`, center path
`13.2108L`, final alignment `0.1092`, and final absolute yaw
`0.9840 rad/T`. The weakest sampled capture, terminal-partitioned posterior
work, retained the same visible wake but widened the path to `13.2330L`, raised
the mean distance to `1.950823L`, and ended at only `0.0678` alignment with
`1.0892 rad/T` yaw. Thus the visible vortices are productive but do not resolve
terminal course quality by themselves.

The assigned parent, course-consensus forward mean bend, preserved capture and
improved final alignment/yaw to `0.1951/0.2761 rad/T`, but arrived at
`18.0290T`, lengthened the center path to `13.2163L`, and regressed score/mean
distance to `-0.064510/1.950783L` relative to the strongest sample. Its
course-agreement selector therefore improves terminal attitude without
improving the distance integral. Conversely, the sampled target-normal-power
posterior-relief policy shortened path/arrival to `13.1921L/17.9960T` and
reduced near posterior acceleration-ceiling residence from the best sample's
`75.83%` to `72.38%`, but regressed score/mean distance to
`-0.064407/1.950652L` and ended at worse alignment/yaw
`0.0975/1.2697 rad/T`. This says the target-normal load signal is informative,
while using it to remove posterior propulsion is not a validated terminal
damping mechanism.

## Policy hypothesis

Preserve the assigned parent's full far/middle controller, odd curvature map,
posterior lag, state-feedback cadence, and evaluated terminal posterior-wave
envelope. Replace only the course-turn-agreement gate on its conserved
mean-tangent allocation. During the moving, misaligned approach, project
normalized body-frame velocity and hydrodynamic force onto the instantaneous
target-line normal; when their product is positive, move the parent's bounded
share of the already requested mean tangent forward and subtract the identical
share from the posterior mean. This leaves total signed tangent and posterior
oscillatory authority unchanged, is inactive outside `2.10L`, and is invariant
under lateral reflection because both normal projections reverse together.

The candidate is falsified if pre-approach trajectory or either wake view
changes; capture, score, or mean distance regresses materially; target-normal
power/path do not improve; alignment and yaw do not improve together; or
acceleration/rate residence merely migrates to the anterior joint. The new CFD
result is not available to this worker and is not claimed here.

```text
bookshelf_consulted: true
source_domain: elongated-body swimming and closed-loop robotic-fish steering
source_mechanism: preserve a posterior-lag traveling bend for propulsion while modulating a bounded mean-curvature offset with sensed directional load
transferable_invariant: separate the oscillatory traveling-wave carrier from a conserved, feedback-selected steering allocation so course correction need not suppress posterior thrust
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, exact vortex phase, and task-specific routes
policy_translation: retain joint-state phase and lagged posterior tracking; use normalized body-frame target-normal velocity times force only to select where the existing odd mean tangent acts during approach
falsification: reject if transit or wake coherence changes, capture or distance integral regresses, terminal yaw and alignment fail to improve together, or actuator pressure migrates forward
```
