# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I read the Phase 2 workspace and guidance contracts, the assigned parent,
sampled policies, scores, compact observations, metrics, embedded wake
diagnostics, and inherited optimizer notes and evaluated descendants. I first
inspected a shared held-fish prewarm sheet, then the released sheets for the
replicated static `tail_steering_gain=0.70` anchor, the assigned parent's
steering-demand schedule, the localized high-speed damping result, and the
inherited static `0.75` posterior-share continuation. I used no omitted
Bookshelf material, neighboring configuration, repository history, coordinate
route, clock, or external research.

The prewarm sheet shows the fish held at the common upper-right release pose
while four staggered-cylinder vortex streets develop and merge around the
second-row target. The fish and wake are the same common initial condition for
all candidates, not evidence for memorizing a release phase, route, or global
position.

The replicated static `0.70` released sheets show a bounded lateral beat,
down-left turn, and compact upstream diagonal approach through the developed
wake. The fish neither loops nor collides and crosses the `0.75L` target circle
after `72.457` release units. Mean fish/local-flow x velocities
`-0.15005/-0.08386` give `0.06620` upstream-relative x speed, so the advance is
materially self-propelled rather than passive advection. Its mean distance is
`2.45409L`, command energy is `51842`, and RMS force/moment are
`23.85/408.89`; both acceleration commands touch the common `28` guard.

The localized high-speed damping sample preserves the same broad finite
diagonal topology and makes no visually dramatic wake excursion, but it is the
strongest current rollout on the corroborating metrics. Relative to the
static `0.70` anchor, it reaches sooner (`70.823`), lowers mean distance
(`2.38538L`), raises upstream-relative x speed (`0.06972`), lowers command
energy (`50756`), and lowers RMS force/moment (`22.72/397.24`). Posterior peak
speed falls from `3.293` to `3.260 rad/time`; anterior peak speed rises modestly
from `3.086` to `3.112`, and RMS relative crossflow changes only from `0.13063`
to `0.13092`. Thus the earlier constant-damping failure does not generalize to
the normalized high-speed gate, although a small transfer to the anterior
joint remains a boundary to monitor.

The assigned parent's bounded posterior-share schedule also improves the
static anchor without a route failure. Using `0.65` share at large steering
demand and recovering `0.70` as bearing aligns, it reaches in `71.615`, lowers
mean distance and energy to `2.42407L` and `51250`, improves upstream-relative
x speed to `0.07111`, and lowers force/moment to `23.26/402.06`. Its posterior
peak speed is slightly higher at `3.299`, so it does not duplicate the damping
gate's peak-speed mechanism. The two evaluated schedules are state-localized
along distinct signals: normalized posterior speed versus bounded bearing
demand.

No current sampled rollout is a semantic termination failure. The inherited
static `tail_steering_gain=0.75` continuation is the most informative failed
optimization hypothesis with visual evidence: it remains finite and broadly
diagonal, but its lower final approach is less compact. It regresses mean
distance to `2.50932L`, raises energy to `52496`, and increases posterior peak
speed to `3.370`, despite `72.275` arrival, `0.06873` relative x speed, and
lower aggregate loads. This confirms that a smooth-looking scalar parameter
continuation can redirect the wake route and that the present candidate should
reuse evaluated bounded gates rather than extrapolate static posterior share.

## Single-candidate hypothesis

Keep the assigned parent's evaluated steering-demand schedule exactly:
`tail_steering_gain=0.65` at saturated bearing demand, blending smoothly back
to the replicated `0.70` aligned anchor with power `2`. Add the independently
evaluated high-speed posterior damping gate without changing its settings:
base damping `0.65`, maximum increment `0.025`, normalized speed threshold
`1.0`, and transition width `0.08`. Preserve the evaluated `0.75` period,
`22 deg` orbit, `2.1` energy restoration, positive bounded anterior steering,
posterior lag, and common `28/28` acceleration guards.

This is one candidate and one executable addition to the assigned parent. It
does not extrapolate either state schedule and adds no coordinate, route,
clock, external phase, or forbidden wake probe. The hypothesis is that the
steering-demand schedule retains its stronger target-relative propulsion while
the speed gate trims its `3.299` posterior peak only near the fastest portion
of each beat, allowing compact capture with lower effort and loads.

The falsifiable expectation is finite capture along the same diagonal corridor
with posterior peak speed below the assigned parent's `3.299 rad/time` and no
material anterior-speed growth beyond `3.112`, while arrival, mean distance,
relative propulsion, energy, and loads remain competitive with the assigned
parent and move toward the localized-damping result. Reject the combination if
the two gates interact to select a deeper or kinked route, delay capture, raise
effort or hydrodynamic loads, or merely transfer speed to the anterior joint.
Even a positive result on this deterministic snapshot remains unproven across
held-out wake phase, inflow, geometry, and target placement. No CFD outcome for
this new candidate is claimed here.
