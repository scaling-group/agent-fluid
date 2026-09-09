# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The assigned parent guidance was produced from the common target-blind seed,
whose inherited notes proposed bounded body-frame bearing-to-curvature feedback
while preserving the posterior traveling bend.  The sampled rollouts now test
that proposal.  Their common prewarm sheet shows the held fish above and to the
right of the target while four developed, interacting vortex streets fill the
downstream corridor; this is shared initial-condition evidence, not a policy
difference.

The seed (`solver_0ce0f9203505`) actively curls down and exits the lower domain
after `50.127` release time.  Its head displacement `(-3.545,-13.300)L`, minimum
distance `8.615L`, progress `0.024`, and clipped joint rates and accelerations
confirm target-blind wrong-lateral propulsion rather than a near capture.  Two
bearing-bias alternatives instead redirect near release and leave on the
downstream side in only `16.791--17.457` time: the `12 deg`/`0.75` tail-share
variant (`solver_c1f78d94eff2`) and the simultaneously slower, lower-amplitude
`10 deg` variant (`solver_1b20554d6f99`) both move about `+2.2L` in x, make
negative progress, and never enter the wake corridor.  The latter confounds
steering with gait changes and therefore does not support slowing the rhythm.

In contrast, `solver_0e81665db579` changes only the seed's equilibria with an
`8 deg` bounded head bias and `0.65` posterior share.  Its sheet shows sustained
self-propulsion along the down-left target diagonal and entry into the central
wake region before capture at `0.749L` after `93.032` time.  The metrics agree:
progress is `0.940`, mean distance is `4.033L`, and head displacement is
`(-10.915,-4.204)L`.  This is the sole demonstrated success and establishes
moderate bearing-to-mean-curvature feedback as the anchor.  It is not yet a
low-load result: both joints reach the rate and acceleration caps, with RMS
lateral force `95.50` and moment `1146.61`, while the keyframe path contains a
broad initial redirect.  Aggregate crossflow and load values do not establish
the sign of a wake-rejection term, so this candidate does not use them.

## Policy hypothesis

Preserve the successful `8 deg` bearing-biased oscillator, its period,
amplitude, and posterior lag.  Add one bounded response-sensitive steering
mechanism: form the curvature request from current bearing plus a short-horizon
projection of `bearing_window_rate`.  When target bearing is already closing,
the rate term releases some mean curvature; when bearing is opening, it adds a
small correction.  Clamp the rate before projection so wake-driven or wrapped
transients can alter the steering argument by at most `4 deg`, and retain the
existing `tanh` and `8 deg` curvature limit.

The expected result is retention of target capture with a more direct redirect,
less steering reversal, and no increase in saturation or load.  Falsify the
new mechanism if semantic success is lost, if the release-side early exit
returns, if arrival or mean distance worsens materially, or if rate feedback
raises switching, force, moment, or saturation.  Because the present CFD
outcome is unavailable until after this worker exits, validation here is
limited to contract, schema, finiteness, and controller-envelope checks.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and response-gated biological turning
source_mechanism: sensor-feedback modulation of a curvature-biased propulsive rhythm, releasing redirect authority once heading response appears
transferable_invariant: persistent body-frame direction error should set mean curvature while observed closure or opening of that error should softly reduce or reinforce the request without disturbing posterior wave lag
nontransferable_details: published gains, dimensional beat frequencies, species-specific kinematics, clocked CPG phase, exact vortex phases, and task-specific routes
policy_translation: add a clipped short-horizon projection of normalized body-frame bearing-window rate to bearing before the successful bounded mean-curvature map; leave the joint-state oscillator and posterior lag unchanged
falsification: reject if target capture is lost, the release-side exit recurs, the route is not more direct, or steering reversal, saturation, force, or moment increases

## Pre-evaluation verification

The required material-guidance, policy-contract/finiteness, and solver-boundary
checks pass without running CFD.  A separate `60`-time-unit controller-only
probe exercised positive and negative bearing with the window rate at its
closing, zero, and opening bounds.  The projected-bearing residual was
asserted at no more than `4 deg`; all actions remained finite, and the clipped
joint integration stayed inside the configured envelope.  Peak bend varied
only from `33.02` to `33.69 deg` across the response cases; rate and acceleration
reached the formal `260` and `1800 deg` caps, consistent with the inherited
successful controller's saturation evidence.  This verifies boundedness, not
hydrodynamic improvement or retained capture; those remain post-worker CFD
questions.
