# Dual-reserve redirect allocation candidate

## Visual and metric diagnosis before editing

All four sampled rollouts and the assigned-parent rollout satisfy the frozen
experiment contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected every current
combined sheet from release through capture, including the top-down mid-plane
vorticity row and oblique body/Lambda2 row. The score-best tail-only residual,
the prefilled joint-reserve allocator, the posterior drive-relief variant, and
the assigned parent's response-release variant all visibly self-propel along
the same direct down-left route. Each retains a compact alternating wake that
stays connected to the posterior body; none shows passive advection, wake
breakup, boundary interaction, or instability. There is no current semantic
failure sheet, so the weaker finite captures are the visual comparators and
the inherited identical-controller `1.01--1.22L` left exits remain the failure
boundary. The images therefore support preserving the carrier and route.

Body-frame reconstruction separates terminal course quality from scalar score.
The tail-only residual is earliest and score-best (`15.1403T/-0.01094`) but
crosses at `1.479L/T` with a `0.651L` constant-course miss, `-4.637rad/T` yaw
rate, `1.269%` posterior `>40deg` dwell, and `0.04041/0.01902` peak normalized
planar force/moment. Miss-conditioned posterior drive relief and the assigned
parent's response release retain capture and the same wake but remain in the
wide-course class (`0.635L` and `0.573L` reconstructed miss). This agrees with
the inherited negatives for broad braking and redirect release.

The prefilled two-joint reserve allocator is a semantic improvement hidden by
its weaker `-0.01764` score: it captures at `15.4464T` with velocity
`(-1.348,-0.231)L/T` and only `0.362L` reconstructed miss, while lowering peak
normalized planar force/moment to `0.03970/0.01889`. Its own hypothesis is only
partly supported, however. Posterior `>40deg` dwell falls from `1.269%` to
`0.996%`, but the transferred residual creates `0.285%` anterior `>40deg`
dwell; near-rate occupancy remains `23.9/22.1%`. The allocator observes only
posterior reserve, so its complement is sent anteriorly even when the anterior
joint is also losing kinematic reserve. More scalar residual gain, another
course request, or a different drive threshold is not supported by this
evidence.

## Single candidate hypothesis

Preserve the prefilled state-feedback traveling carrier, posterior lag and
pulse, body-frame pursuit/course blend, constant-course predictor, mean bend,
shared response-plus-miss handoff, cubic terminal residual, and posterior-first
allocation. Add one compatible control-allocation mechanism: compute the same
smooth angle/rate reserve for the anterior joint, and permit the residual
transferred from a reserve-poor tail to enter the anterior rhythmic channel
only in proportion to anterior reserve. When both joints are reserve-poor the
extra redirect fades continuously; the base carrier and shared steering remain
active. Absolute joint state makes the gate reflection-neutral, and it uses no
clock, route, target identity, world coordinate, force-fit model, or prescribed
wake phase.

The hypothesis is that the allocator's evidenced centered terminal course can
survive without moving avoidable high-angle demand from tail to head. Support
requires capture with reconstructed terminal miss no worse than the prefill's
`0.362L`, materially lower anterior and posterior `>40deg` dwell or near-rate
occupancy, and peak normalized planar force/moment no higher than
`0.03970/0.01889`. Arrival and score should remain competitive with
`15.4464T/-0.01764`, and the direct compact-wake route must survive. Falsify on
lost capture, miss above `0.362L`, slower arrival without joint/load benefit,
unchanged or transferred saturation, wake/route degradation, nonfinite action,
or loss of reflection equivariance. Formal CFD is deferred to EvE and is not
evidence available to this worker.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and bounded residual control
source_mechanism: preserve an autonomous rhythmic carrier while observed actuator state gates the allocation of a low-dimensional directional residual
transferable_invariant: target-relative rhythmic authority should be assigned only through actuators with current kinematic reserve and should fade when no actuator can accept it safely
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phases, hard-coded task coordinates, routes, and waypoints
policy_translation: retain the sampled posterior-first predicted-miss residual, but gate its anterior transfer by normalized anterior angle/rate reserve while preserving the two-joint state-feedback carrier and smooth acceleration envelope
falsification: reject if capture, terminal course margin, arrival, direct routing, compact wake, joint reserve, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract/schema,
and solver editable-boundary checks pass. A deterministic `37,500`-state grid
over normalized body-frame target geometry and velocity, carrier-separated yaw
response, and both joint angles and rates produced finite commands strictly
inside the smooth `30rad/T^2` envelope. Exact left/right reflection error was
`0.0`. Relative to the evaluated prefill, the dual-reserve mechanism changed
`34,386` grid states at numerical tolerance and reached a maximum command
difference of `1.76988rad/T^2`; all `37` direct `params.FIELD` references
resolve to returned fields. Replaying the `2,810` evaluated prefill states
through both algebraic policies changed `1,404` states at `1e-9` tolerance,
with maximum difference `1.70623rad/T^2`. This confirms an active state gate,
not improved dynamics: formal CFD remains deferred to EvE.
