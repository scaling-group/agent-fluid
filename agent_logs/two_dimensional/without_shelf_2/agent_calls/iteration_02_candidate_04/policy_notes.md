# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

The assigned parent guidance identifies the `0.55`-period, `28 deg`
target-blind seed as a saturation anchor. Its released keyframes show vigorous
bending and a steep downward trajectory that stays to the right of the target
and never enters the developed four-cylinder wake corridor. The metrics agree:
the fish exits after `50.13` release units with displacement
`(-3.545,-13.300)L`, only `0.0243` progress, both velocity and acceleration
caps active, mean command energy `1496.25`, and RMS moment `541.70`. Although
the body visibly actuates, mean local minus world x velocity is only `0.0311`,
so the effort does not produce enough upstream motion to overcome the flow.

The three current target-aware finite samples expose the other side of the
control envelope. Their keyframes remain near the initial heading with small
bends, then show the fish swept through the downstream/right boundary before
it approaches the target or useful wake region. All terminate in only
`16.27--16.73` units, move `+2.18--2.36L` in x, and have negative progress
`-0.148--0.158`. Their mean x velocity relative to local flow is just
`-0.0160` to `-0.0228`; mean command energy is only `0.218--1.513`, and maximum
joint acceleration is only `1.09--6.59 rad/time^2`. Thus the shared failure is
under-driven gait startup, not an observed inability of the bearing signal to
select a turn. Adding bearing-rate, lateral-velocity, moment, or heading-rate
channels did not compensate for the missing propulsion.

The assigned parent's inherited candidate supplies a separate stability
boundary. Directly moving a `1.05`-period oscillator center with bearing and
raw heading rate, without a candidate-side action bound, reached the `45 deg`
joint-angle and `31.416 rad/time^2` acceleration limits and terminated as
`unstable_dynamics` after `1.009` units. Its RMS force/moment rose to
`9.46e4/1.30e6`. The two released frames show deformation at essentially the
initial position rather than a navigational turn. Raw turn-rate coupling is
therefore excluded from this candidate.

The common prewarm sheet is identical across policies: the fish is held above
and downstream of four developed interacting vortex streets, while the target
lies near the second-row wake overlap. This candidate treats that sheet only
as the shared initial condition and does not infer a fixed wake phase, route,
or global-direction command from it.

## One candidate hypothesis

Use a bearing-only mean curvature with a small `8 deg` bound, but make the
state-phase gait reach a useful limit cycle before downstream advection can
end the episode. An energy-regulated anterior oscillator at `0.75` period and
`22 deg` amplitude has nominal peak speed about `185 deg/time` and nominal
peak restoring acceleration about `1544 deg/time^2`, between the under-driven
successors and the seed while remaining inside the `260/1800` hard envelope.
A candidate-side `28 rad/time^2` bound preserves that margin under wake
disturbance. The posterior joint tracks the opposing oscillatory component
with a velocity lag and carries only part of the modest steering mean, so
propulsion and steering are not collapsed into one saturated bend.

This is intentionally one mechanism test: no heading-rate, force, moment,
flow, clock, coordinate, or route input is added. The expected signature is
joint motion reaching a bounded nontrivial cycle within the first few release
units, x velocity materially more negative relative to local flow than
`0.0228`, survival beyond `16.73`, and subsequent distance closure without the
seed's downward spiral. The hypothesis is falsified if the fish is still swept
out before gait growth, if the `28 rad/time^2` guard becomes persistent
bang-bang action, if force/moment grows toward the inherited instability, or
if positive bearing curvature increases rather than reduces the target
bearing once propulsion is present.
