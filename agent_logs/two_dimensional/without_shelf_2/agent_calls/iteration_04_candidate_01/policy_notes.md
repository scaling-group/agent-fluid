# Multi-wake candidate diagnosis

## Evidence coverage and visual diagnosis

I used the assigned parent guidance, the four sampled solver results, their
compact observations/metrics/diagnostics, and the inherited optimizer notes.
I inspected the common prewarm sheet and the released sheets for the strongest
finite policy, the assigned-parent policy, and the informative rate-feedback
failure before selecting this candidate. No omitted Bookshelf material,
neighboring configuration, repository history, external research, fixed route,
coordinate, or clock signal was used.

The shared prewarm sheet establishes a common release condition: the held fish
is above and downstream of four developed, interacting vortex streets, while
the target lies in the second-row wake overlap. It is identical across samples
and therefore supplies no policy-specific route or wake-phase evidence.

The assigned-parent `0.55/8 deg` positive-bearing controller is genuinely
self-propelled and finite. Its released sheet shows sustained alternating bends,
an upstream/downward traverse, a wide excursion below the target, and eventual
capture from the right after `130.23` release units. The metrics agree: mean
velocity x is `-0.0835` versus mean local-flow x `-0.0455`, progress is
`0.9397`, mean distance is `3.516L`, and maximum lateral target offset is
`5.425L`. Joint angles and speeds remain below the hard limits and RMS
force/moment are finite at `26.34/427.54`, although both acceleration commands
touch the candidate's `28 rad/time^2` guard.

The strongest sampled policy changes only steering gain/limit to `0.70/10 deg`.
Its sheet retains the same active traveling bend, but reverses the initial
upper-right excursion sooner, follows a visibly tighter approach, enters the
useful target wake from the right, and captures at `91.61` units. Relative to
the parent, mean distance falls from `3.516L` to `2.834L`, maximum lateral
offset from `5.425L` to `4.297L`, and mean upstream-relative x speed rises from
`0.0380` to `0.0515`. The cost boundary is also clear: RMS force/moment rise to
`38.81/550.75`, maximum anterior angle rises from `0.523` to `0.550 rad`, and
the acceleration guard is still reached, though speeds remain near `3.22
rad/time` and the rollout is finite.

The bearing-window-rate sample is the informative failure. Adding a bounded
`0.10`-horizon rate lead to the assigned-parent steering visibly turns the fish
away from the target, leaves it near the right side of the developed wakes, and
ends in a right-domain exit at `158.42` units. Its final/minimum distances are
`13.964/9.749L`, progress is `-0.1240`, and center displacement is
`(+2.200,-2.347)L`. Lower RMS loads (`19.44/310.48`) and lower command effort do
not rescue a controller that never produces target closure. This directly
rules out adding bearing-rate lead to the present candidate.

## One candidate hypothesis

Adopt the evaluated `0.70/10 deg` bounded positive-bearing steering pair while
retaining the parent's `0.75`-period, `22 deg` energy-regulated oscillator,
posterior lag, damping, and `28 rad/time^2` burst guard exactly. This is the
only sampled isolated steering change that improves capture time, distance
integral, lateral excursion, and upstream-relative motion without losing the
target or hard-limit margin. It also avoids extrapolating steering authority
beyond the directly observed finite envelope and excludes the falsified
bearing-rate mechanism.

The later evaluation should reproduce target capture materially earlier than
the assigned parent's `130.23` units, with mean distance near or below
`2.834L`, negative-x relative propulsion, joint angles below `0.55 rad`, and
loads remaining finite. Reject this anchor if it loses capture, develops
persistent guard clipping, reaches a joint hard limit, or drives force/moment
toward the sampled instability scale. Generalization beyond the common prewarm
snapshot remains unproved and must be tested on held-out wake phase or geometry.
