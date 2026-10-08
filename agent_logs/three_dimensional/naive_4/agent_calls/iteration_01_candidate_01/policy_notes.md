# Candidate diagnosis and hypothesis

## Evidence basis

- The sole sampled solver is the assigned naive parent and therefore serves as
  both the best available finite example and the informative failure; no
  successful sampled comparator or inherited optimizer log is present.
- The rollout satisfies the experiment contract: direct uniform initialization
  in still water (`U_infinity=[0,0,0]`), no prewarm, and no cylinders.
- It scored `-14.825231` and exited the upper virtual boundary at `8.547T`.
  Distance improved only from `12.328L` to a minimum of `12.078L`, then
  worsened to `12.380L`; the center moved from `(21.0,14.0)L` to
  `(20.075,15.200)L`.

## Visual diagnosis

- The top-down row shows self-propulsion rather than advection: an initially
  quiescent field develops attached red/blue vorticity and, by `8T`, a clear
  alternating wake while the fish translates roughly `0.94L` leftward.
- The oblique Lambda2 row corroborates a three-dimensional alternating caudal
  wake rather than a pre-existing flow structure. The drive is therefore worth
  preserving.
- The useful leftward approach through about `6T` is lost as the body rotates
  into a steep upward trajectory. Metrics agree: heading spans `0.60` to
  `-1.20` rad, vertical speed reaches `0.619 U`, and the upper-boundary exit
  follows. Joint angles remain below about `26.6 deg`, but joint speed touches
  the `260 deg/T` limit and raw acceleration commands exceed the
  `1800 deg/T^2` envelope in about one third of samples. The failure is not
  numerical instability, but clipping is a real boundary on any steering edit.

## Policy hypothesis

Preserve the seed's observable-state oscillator and posterior lag, but add one
bounded mean-curvature steering mechanism. Map body-frame target bearing plus
measured yaw rate to a small posterior-joint mean-bend target. Bearing supplies
the desired turn sign; yaw rate provides damping so the initially useful turn
does not grow into the observed upward sweep. Keeping steering in the tail
target rather than adding a large raw acceleration should retain the traveling
bend without raising drive frequency or amplitude. Its effect is falsifiable
against both directional progress and actuator clipping.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning control
source_mechanism: target-driven mean-curvature or tail-beat bias superposed on a propulsive rhythm
transferable_invariant: a bounded average bend can steer while the posterior-lagged oscillation continues to generate thrust
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing and observed heading rate to bias the second-joint target within the two-joint state-feedback oscillator
falsification: reject the transfer if evaluation repeats the upper-boundary exit, loses the seed's early distance progress or coherent wake, produces persistent limit contact, or fails to improve horizon or target approach
