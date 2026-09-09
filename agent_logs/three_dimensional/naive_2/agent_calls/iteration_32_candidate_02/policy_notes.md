# Anterior predicted-miss residual candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen experiment contract: direct
uniform initialization in still water with `U_infinity=(0,0,0)`, no cylinders,
and no prewarm. I inspected every combined keyframe sheet from release through
capture, including the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. Each fish self-propels on the same direct down-left route
behind a compact alternating, body-connected three-dimensional wake. The
views show neither passive advection, wake breakup, boundary interaction, nor
numerical instability. There is no sampled non-capture sheet, so physical
terminal-course, joint, and load boundaries distinguish useful from weak
captures; inherited `1.01--1.22L` left exits remain the semantic failure class.

The assigned persistent-line-consensus parent `solver_8600d052eff8` captures
at `15.7829T` with score `-0.02023`, terminal predicted course miss `0.747L`,
and normalized peak planar force/moment `0.03553/0.01740`. Direct line-rate
steering `solver_f792c48d0852` improves the miss to `0.674L` and arrival to
`15.6893T`; carrier-separated force re-engagement
`solver_0abf107c2bc4` remains at `0.744L/15.7384T`. These mechanisms preserve
the route and wake but do not recover the inherited centered `0.179L` course.

The new posterior predicted-miss residual `solver_e749afa61520` is the scalar
and arrival best (`-0.01094`, `15.1403T`) and improves terminal miss relative
to the sampled `0.674--0.747L` class, but only to `0.651L`, above its own
`0.590L` falsification boundary. It also raises peak normalized planar force
to `0.04041` and produces `1.2695%` posterior-joint dwell above `40 deg`, while
the other three samples have zero such dwell and peak force at or below
`0.03631`. The final posterior rate is pinned at the `260 deg/T` limit. Thus a
large-miss rhythmic residual is active and improves translation, but allocating
it to the posterior thrust joint is a concrete joint/load negative rather than
a physically clean terminal solution.

## Single candidate hypothesis

Start from the sampled predicted-miss residual controller and preserve its
state-feedback traveling carrier, posterior lag and pulse, body-frame
pursuit/course blend, constant-course predictor, bounded mean bend,
carrier-separated yaw response, common response-plus-miss handoff, shared
half-cycle steering, and smooth acceleration envelope. Replace its tail-only
cubed-miss residual with one anterior-only residual of the same bounded form.
The residual acts only on large signed predicted misses during a closing
terminal intercept and vanishes rapidly on centered courses. The posterior
joint retains the evidenced lagged propulsive target without the extra
large-miss half-cycle authority; the anterior joint supplies the steering
perturbation around its autonomous oscillator.

This tests actuator role separation, not a scalar gain change: the sampled
tail residual improved arrival but concentrated rate-limit dwell and load on
the propulsive joint, while the shelf's qualitative anterior-steering and
posterior-thrust decomposition predicts that moving the residual upstream can
preserve propulsion with cleaner posterior reserve. Support requires capture
with terminal predicted miss below `0.590L`, arrival/score competitive with
the sampled `15.14--15.78T` capture class, zero or materially reduced
posterior `>40 deg` dwell, and normalized peak planar force/moment below the
posterior residual's `0.04041/0.01902`, preferably back in the
`0.037/0.019` class. Falsify on a miss or left exit, course miss at or above
`0.651L`, loss of the direct compact-wake route, new anterior saturation that
merely transfers the problem, degraded arrival without margin improvement,
nonfinite commands, or loss of reflection equivariance. Formal CFD is
deferred to EvE and is not evidence available to this worker.

bookshelf_consulted: true
source_domain: elongated-body reactive-thrust theory and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve a posterior-emphasized traveling wave for thrust while applying bounded sensed steering modulation through the anterior wave generator
transferable_invariant: when extra posterior rhythmic authority improves translation but consumes tail reserve and raises load, separate steering upstream from posterior propulsion rather than strengthening the same tail channel
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, body envelopes, exact phase lags, robot linkage geometry, vortex phases, task coordinates, and capture routes
policy_translation: cube signed normalized body-frame predicted miss and apply it only as a closing terminal anterior half-cycle residual around the unchanged two-joint state-feedback carrier and common response-plus-miss handoff
falsification: reject if capture margin, arrival, direct routing, compact wake, posterior joint reserve, normalized loads, boundedness, or reflection equivariance fails to improve together

## Dry validation boundary

The mandated guidance-materiality and deterministic parameter-schema check,
lightweight Julia policy-contract check, and solver editable-boundary check all
pass. A deterministic `19,683`-state grid over normalized body-frame target
and velocity, joint angles and rates, and yaw response produced finite commands
strictly inside the smooth `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). Disabling only the new anterior residual
changed `7,290` grid states; its maximum command contribution was
`4.20895 rad/T^2`, while a far receding state changed by exactly zero. The
candidate is therefore an active closing-scheduled feedback mechanism rather
than a comment or scalar-only carrier edit. These checks are algebraic only;
formal CFD remains deferred to EvE.
