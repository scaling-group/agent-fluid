# Candidate visual diagnosis and policy hypothesis

All sampled evaluations report direct uniform still-water initialization with
`U_infinity=0`; none uses a prewarm snapshot. The top-down and oblique rows
show that the naive carrier and both posterior-only steering variants build a
coherent alternating wake. The target-blind seed moves `(-0.925,+1.200)L`,
reaches `12.0782L`, and then exits the upper boundary at `8.547T`. Its heading
spans `0.602` to `-1.201 rad`, while its body-frame target bearing goes from
about `+0.155` to `-1.296 rad`: propulsion is present, but low-frequency yaw is
not regulated.

The assigned parent moves the mean bend into both joints. Its top-down sheet
is nearly wake-free through `8T`, and the oblique row likewise shows little
Lambda2 structure before the late tight arc. Cross-checking the trajectory,
the anterior maximum falls from `0.459 rad` in the seed to `0.175 rad`, mean
force magnitude falls from `0.0077` to `0.0003`, and the fish moves only
`-0.003L` in x before leaving at `13.288T` with distance `13.4114L`. Thus the
apparently smoother yaw history is mainly a quenched carrier, not useful
steering.

Both posterior-only variants retain the anterior carrier. The strongest uses
bearing plus a short bearing-trend lookahead; its two visual rows retain the
alternating wake, it moves `(-1.919,+1.200)L`, and it improves minimum/final
distance to `11.4131/11.4209L`. This is useful directional progress, but it
still exits upward at `9.740T`; bearing has already crossed from `+0.131` at
`4T` to `-0.260` at `5T`, then reaches about `-1.25` at `9T`. Its posterior raw
acceleration exceeds the envelope in `54.9%` of samples, so more curvature or
carrier gain is not supported. The missing semantic capability is an explicit
low-frequency yaw-response target that releases and reverses the posterior
mean bend before geometric error alone drives another saturated turn.

Policy hypothesis: preserve the naive anterior state-feedback oscillator and
posterior traveling-wave lag exactly. Predict only the bounded body-frame
bearing, map that geometry to a bounded desired yaw rate, compare it with the
observed episode-window turn rate, and use the residual to command posterior
mean curvature. This should keep the strong sampled wake while reducing the
large negative-yaw overshoot and upper-boundary exit. Falsify it if the next
CFD rollout loses coherent thrust, does not improve bearing sign/distance or
termination relative to the posterior-only lookahead result, or increases
joint limiting.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and fish turning by tail-beat bias
source_mechanism: sensor feedback modulates a bounded mean curvature around an existing propulsive rhythm
transferable_invariant: preserve the state-encoded traveling bend while target geometry requests a bounded turn and measured yaw response releases or reverses that request
nontransferable_details: published gains, clock-driven phases, species-specific envelopes, exact tail-beat timing, and task-specific routes
policy_translation: normalized body-frame bearing and bearing trend set a desired yaw rate; normalized observed turn rate closes a posterior-only mean-curvature loop while joint state retains oscillator phase
falsification: reject if wake/thrust collapses, turn error keeps the same diverging sign, upper-boundary termination is not improved, or actuator limiting increases
