# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet establishes the common initial condition: the held
fish starts above and downstream of the target while four developed,
interacting wakes span the route. In every released sheet the fish actively
self-propels upstream into that disturbed region rather than riding the local
flow. For the sampled `0.50` phase-opposition policy, mean head velocity x is
`-0.174` versus mean local flow x `-0.123`, and the head travels `-12.28L`.
The keyframes nevertheless show the same route failure: the fish descends
toward the target, crosses its streamwise station above the capture circle,
then curls sharply counterclockwise and is nearly vertical immediately before
the upper-domain exit.

The sampled bracket separates useful far-field approach from failed terminal
control. Raising opposing-phase headroom from `0.35` to `0.50` improves head-x
travel and closest approach from `-11.33L/3.03L` to `-12.28L/2.13L`; the
`0.50` policy is therefore the current far-field anchor despite nearly
unchanged progress (`0.517` to `0.509`). Globally raising the coefficient to
`0.55` instead collapses travel/approach/progress to
`-3.89L/5.70L/0.206`. The newly sampled close-only `0.55` continuation also
fails its boundary: it moves another `0.38L` upstream but worsens closest
approach from `2.13L` to `2.21L`, retains roughly the same `+1.72L` head-y
exit and cap contacts, and raises RMS force/moment from `535/5416` to
`566/5660`. The duplicate `0.50` sample has identical policy checksum and
metrics, so it is confirmation of determinism rather than independent support
for another gain change.

Inherited logs rule out composing the anchor with receding-distance reversal,
signed fore-aft gating, bearing-rate lead, direct lateral-speed or slip
damping, yaw-moment rejection, and posterior-target clipping: those tests all
lose approach or propulsion without changing the upper hook. The current
controller's geometric bearing also normalizes lateral error by the magnitude
of fore-aft error. That is suitable on the demonstrated upstream leg, but it
increases toward a saturated side command as the fish crosses the target
station, precisely where the visible hook begins. None of the inherited tests
replaces that near-target angular normalization with the measured lateral
offset itself while preserving the complete far-field command.

## Single candidate hypothesis

Preserve the complete sampled `0.50` phase-opposition controller at and beyond
`3L`, including its anterior oscillator, posterior traveling wave, body-rate
damping, static request, phase allocation, distance fade, and command cap.
Inside `3L`, smoothly blend only the geometric bearing drive toward
`tanh(lateral_distance_L / 1L)`, reaching the lateral-offset representation at
`1.5L`. The new signal is normalized, bounded, target-relative, and in the
body frame. It retains the steering sign but stops the bearing command from
growing merely because fore-aft separation approaches zero. It does not use
elapsed time, global coordinates, a learned route, prescribed inflow, remote
wake probes, target-station flow, or the failed lateral-velocity/load signals.

The evaluation supports this hypothesis only if it preserves approximately
the `0.50` anchor's upstream leg and improves below its `2.13L` closest
approach, reaches the `0.75L` capture circle, or visibly removes the terminal
upper hook. It is falsified if the blend activates early enough to lose
upstream travel, repeats the same upper exit, or merely lowers load by
attenuating useful propulsion. Such a result should close near-target lateral
offset as a bearing replacement rather than motivate more blend thresholds or
another stacked gate.
