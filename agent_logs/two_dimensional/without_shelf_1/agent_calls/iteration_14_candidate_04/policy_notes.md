# Wake-policy candidate diagnosis

## Evidence read before editing

The shared prewarm sheet is common initial-condition evidence: the held fish is
above and downstream of the target while four developed, interacting cylinder
wakes fill the route. The released sheets all show active upstream propulsion,
not passive advection. Their mean head velocities are more negative than their
mean local flow, and their heads move `-8.49L` to `-11.33L` before termination.
Visually, each fish travels left while remaining above the target corridor,
then bends into a broad upward hook; an almost vertical fish crossing the top
boundary immediately precedes every `left_domain` termination.

The phase-opposition anchor is the strongest sampled finite policy. It moves
the head `-11.33L`, reaches `3.03L`, achieves `0.517` progress, and has
mean/final distance `6.44L/6.00L`. This improves materially on the inherited
plain `11 deg` anchor (`-7.89L`, `4.87L`, `0.424`), although it also raises RMS
force/moment from `406/4113` to `511/5305` and retains the upper hook. Its mean
head velocity of about `-0.1707` exceeds the magnitude of mean local x-flow
`-0.1193`, confirming that the improved travel is a controller mechanism.

All three sampled additions to this anchor regress without repairing lateral
failure. A signed-forward bearing gate gives only `-8.49L` travel, `3.45L`
closest approach, and `0.449` progress. Two distance-gated receding reversals
give `-10.15L/-10.83L`, `3.13L/3.10L`, and `0.495/0.507`. All retain roughly
`+1.77L` to `+1.79L` head-y displacement and the same visible upper exit.
Their diagnostics also retain essentially identical maxima: anterior angle
about `0.669 rad`, posterior angle `0.777--0.780 rad`, joint-rate cap
`4.538`, and command cap `28.798`. Thus those gates neither preserve the best
approach nor desaturate the controller. The assigned-parent logs independently
show that absolute lateral-velocity damping and normalized yaw-moment rejection
also reduce approach/progress while leaving the hook, so neither is revived.

## Single candidate hypothesis

Keep the phase-opposition policy unchanged except for an isolated increase of
`steering_opposition_boost` from `0.35` to `0.50`. The improvement from the
plain `11 deg` anchor to the sampled `0.35` phase boost is the only positive
mechanism in the available evidence, whereas every added target-motion, slip,
or load gate regresses. The new gain remains bounded: phase gain stays in
`[1, 1.50]`, extra posterior authority is available only when the current
unsteered posterior phase opposes the bounded target-bearing request, and no
phase of the demonstrated far-field request is attenuated. Propulsion,
heading-rate damping, distance fade, and command ceiling remain fixed so the
evaluation isolates this one axis.

The hypothesis is supported only if the rollout improves on the `3.03L`
closest approach while preserving approximately `-11.33L` upstream travel and
`0.517` progress, without a disproportionate rise above the anchor's
`511/5305` RMS force/moment or longer saturation. It is falsified if the upper
exit remains near `+1.7L`, approach/progress regress, or higher phase gain only
increases load and cap contact. That result would close upward tuning of the
phase-opposition gain and direct later workers to restore `0.35` before testing
a genuinely different normalized observation.
