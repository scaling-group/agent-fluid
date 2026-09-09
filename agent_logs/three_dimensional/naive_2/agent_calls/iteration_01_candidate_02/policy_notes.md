# Wake-policy candidate notes

## Evidence diagnosis

Only one sampled rollout is present, so `solver_5434ff87b2ba` is both the best
finite example and the informative failure; there is no sampled success to use
as a positive comparator.  The assigned parent contains the fresh-lineage
control contract but no completed-outcome lesson, and no inherited optimizer
log existed in this workspace before these notes.  The rollout diagnostics
confirm direct uniform quiescent
initialization (`U_infinity=(0,0,0)`), no cylinders, and no prewarm snapshot.

Both rows of `wake_keyframes.jpg` show self-propulsion rather than advection.
The top-down row develops a strong curved track and the oblique row shows a
coherent alternating three-dimensional wake, so the seed's posterior-lagged
carrier is worth preserving as a mechanism.  It does not stabilize the route:
the fish begins only about `0.155 rad` off the target bearing, reaches a minimum
distance of `12.0694L`, then turns through a large arc and exits the upper
virtual boundary at `t/T=8.5965`, with final distance `12.3647L`.  The computed
body-frame bearing changes from `+0.155` to about `-1.264 rad`, consistent with
overshoot rather than inadequate propulsion.  The trace also reaches the
`260 deg/T` joint-rate limit, raw accelerations reach about `75.4 rad/T^2`, and
heading rate reaches about `2.79 rad/T`; this makes scalar amplification of the
same drive an especially poor next test.  Local head-flow magnitude remains
small (at most about `0.0255U`) relative to body lateral velocity (about
`0.502U`), so a wake-crossflow mechanism is not evidenced in this still-water
failure.

## Policy hypothesis

Retain a joint-state oscillator and posterior phase lag, but lower its natural
frequency/amplitude scale so its steady traveling bend can stay inside the
actuator envelope.  Center both joint rhythms on one bounded mean-curvature
bias computed from target bearing, body-frame lateral velocity, and measured
yaw rate.  The bearing term supplies the missing route command; slip and yaw
terms release or reverse the bias as the body responds.  The command is
reflection-compatible, contains no clock or world-coordinate route, and is
clamped below the episode acceleration limit.

Falsification: reject this mechanism if evaluation does not materially delay
the `left_domain` exit, does not keep bearing from crossing into the same large
opposite-sign arc, or still spends appreciable time at rate/acceleration
limits.  Even with longer survival, reject it as target control if minimum and
final distance do not improve together.  A near-target miss would instead be
new evidence for approach scheduling, which this first far-field candidate
deliberately omits.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish mean-curvature turning
source_mechanism: bounded average joint curvature superposed on a propulsive rhythm
transferable_invariant: separate the self-sustaining traveling bend from a bounded, observation-driven mean-turn request and release that request using measured body response
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact vortex phase, and prescribed routes
policy_translation: center the two-joint state-feedback carrier on a tanh-bounded bias from normalized body-frame bearing, lateral velocity, and yaw rate; retain posterior lag and clamp acceleration
falsification: the transfer fails if it preserves the same early opposite-bearing boundary-exit topology, destroys the coherent propulsive wake, or replaces rate saturation with persistent acceleration clamping
