# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The four current shared-prewarm sheets are byte-identical. They show the
  fish held high and downstream/right while the four staggered cylinder wakes
  develop and overlap through the target corridor. This is the certified
  common initial condition, not candidate-specific evidence.
- The four current released sheets are also byte-identical, and their physical
  metrics agree exactly apart from wall time. The `20.25 deg`, `0.67`-period,
  `0.25` bearing-rate-lead anchor is self-propelled rather than merely advected:
  mean head velocity x is `-0.04443` against mean local-flow x `-0.03649`, so
  controller-relative upstream transport is `0.00793`. It makes a broad initial
  loop and several lateral reversals, enters the interacting central wake, and
  captures without collision, exit, instability, or rebound at `244.547` with
  mean/final distance `6.452/0.750L`.
- The released anchor sheet shows that the lateral motion is productive in
  aggregate but not uniformly so. It crosses multiple wake bands and ultimately
  approaches nearly horizontally, while the recorded maximum lateral target
  offset is `4.293L`; RMS relative crossflow, lateral force, and moment are
  `0.13437`, `18.263`, and `362.214`. The opportunity is therefore to reject
  only translation away from the target, not to suppress all lateral motion.
- The informative inherited horizon miss confirms that distinction. Its sheet
  shows wider, jagged reversals and failure to retain the central corridor; it
  finishes at `3.632L` after reaching `3.290L`, with upstream speed falling to
  `-0.02667`. Its slightly lower RMS crossflow and force do not compensate for
  lost capture, and its unchanged `31.055` anterior acceleration maximum shows
  that the failure is route timing rather than propulsion feasibility.
- The newly sampled turn-away heading-rate gate is a mixed but overall negative
  result. Its sheet reaches the target sooner (`238.557`), yet the score-driving
  mean distance worsens from `6.452L` to `7.077L`, controller-relative upstream
  transport falls from `0.00793` to `0.00476`, and RMS force rises from `18.263`
  to `18.354`; only moment and command/power means fall slightly. Together with
  the inherited global heading correction, which delayed capture to `259.160`,
  this exhausts direct body-rotation damping for the current evidence.
- Propulsion and the static bearing/rate bundle remain fixed. The anterior
  acceleration already reaches `31.055 rad/time^2` against the `31.2` policy
  guard, and inherited `0.20/0.30` rate leads, `0.28` bearing scale, and positive-
  closure steering relief all worsened the route. No evidence supports another
  amplitude increase or global steering scalar change.

## Single candidate hypothesis

Preserve the demonstrated oscillator, posterior lag/damping, `10 deg` steering
limit, `0.30` bearing scale, `0.25` bearing-rate lookahead, and all guards. Add
one bounded translational counter-drift term using `state.velocity_body_U[2]`,
which is already part of the normalized body-frame task contract. Clamp lateral
velocity to `0.10`, and activate the correction only when its sign is away from
the current target bearing (`bearing * lateral_velocity < 0`). A smooth weight
normalized by the existing bearing scale and the velocity bound returns the
controller exactly to the sampled anchor for stationary or targetward lateral
translation. With a `0.08` lookahead, the added pre-nonlinearity correction is
bounded by `0.008 rad`, smaller than the failed heading gate's `0.015 rad`
bound and only about five percent of the steering-bias limit.

This tests a distinct translational signal rather than another direct heading,
bearing-gain, or propulsion perturbation. The expected effect is to preserve
useful wake-band crossings and central-wake acquisition while shortening only
the target-away portions of the broad loop. Improvement requires capture with
mean distance below `6.452L` and no material arrival, upstream-transport,
crossflow, force, moment, effort, or guard regression. Falsify the mechanism on
a horizon miss, capture later than `244.547`, mean distance above `6.452L`, a
larger lateral excursion/load, lower controller-relative upstream transport,
or visible high-frequency steering chatter. If falsified, restore the plain
anchor and do not retune this instantaneous lateral-velocity gate without
time-resolved evidence; a later worker should instead test a smoothed distinct
corridor signal or a held-out wake phase.
