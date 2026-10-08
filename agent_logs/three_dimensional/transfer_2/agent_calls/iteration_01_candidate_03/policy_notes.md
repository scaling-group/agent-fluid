# Multi-wake target-policy candidate notes

## Evidence diagnosis

The only sampled solver is simultaneously the strongest finite example
available and the informative failure case.  It used direct uniform still-water
initialization (`U_infinity=[0,0,0]`), no cylinders, and remained numerically
stable.  Both keyframe rows show self-propulsion with a coherent alternating
wake: the top-down sheet shows sustained downstream vortex shedding, while the
oblique Lambda2 sheet shows a three-dimensional but planar-following wake with
no heave/roll/pitch escape.  This is not passive advection or a prewarm artifact.

The useful part of the transferred seed is propulsion.  Speed settles near
`0.8 U`, and target distance falls from `12.3277 L` to `4.7800 L` at
`t=17.853 T`.  The failure is a sustained wrong-way curl rather than loss of
thrust.  After the first alignment, reconstructed body-frame target bearing
grows from about `+0.10 rad` over `6-8 T` to `+0.77 rad` over `14-16 T`, while
mean heading grows from about `0.42` to `0.76 rad`.  The seed simultaneously
raises its mean tail tangent from about `+0.04` to `+0.17 rad`; it passes below
the target, distance rises to `9.7089 L`, and it exits the lower virtual-domain
boundary at `t=27.495 T`.  Joint angles remain inside the 45-degree limit, but
the raw carrier commands exceed the `1800 deg/T^2` acceleration envelope on
about 71% of joint-1 and 77% of joint-2 samples; joint speeds are at least 99%
of their limit on about 11% and 13% of samples.  An additive steering
acceleration can therefore be erased by carrier clipping even though angle
authority remains.  Local flow stays small (roughly
`|u_local| < 0.026 U`) relative to swimming speed and there are no cylinders,
so wake-rejection feedback is not supported by this rollout.

## Policy hypothesis

Keep the seed's state-feedback oscillator and posterior lag, but replace the
competing tail-only mean tangent plus acceleration-bias steering with one
target-driven mean-curvature primitive.  Map the signed bounded turn request
to the same mean joint bend for both joints; center the head oscillator on that
bend and make the posterior target oscillate with lag around it.  The local 3D
turn-sanity convention says a positive joint bias produces negative yaw, so a
positive body-frame target bearing must request positive mean bend.  Gate the
bias continuously with observed target geometry, so it releases rather than
becoming a hidden C-start stage.  Centering the oscillator itself moves the
steering request upstream of acceleration clipping; it should preserve the
productive traveling wave while giving persistent bearing error a coherent yaw
moment instead of an S-shaped mean pose whose anterior and posterior steering
contributions compete.

Falsification: reject the translation if the next rollout does not reverse the
post-`6 T` growth of positive bearing, if minimum distance does not improve on
`4.7800 L`, or if the coherent wake/speed collapses, joint saturation becomes
persistent, or the exit merely changes boundary without useful target progress.

bookshelf_consulted: true
source_domain: robotic-fish turning and biological burst redirection
source_mechanism: target-feedback mean-curvature bias with continuous release
transferable_invariant: preserve the propulsive rhythm while a bounded observed target error shifts mean body curvature in the turn-producing direction
nontransferable_details: published gains, dimensional beat frequency, species envelopes, exact burst timing, vortex phase, and world-frame routes
policy_translation: use normalized body-frame bearing and target-vector angle to center both joint-state oscillations on a signed bounded mean bend; retain posterior lag and release the bend continuously near alignment
falsification: no improved closest approach or corrected bearing topology, loss of propulsion, persistent saturation, load spikes, or another non-target-directed domain exit
