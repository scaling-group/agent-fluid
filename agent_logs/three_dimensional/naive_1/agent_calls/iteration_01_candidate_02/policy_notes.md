# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

The only sampled solver is `solver_36a38f7240b3`, the common naive
drive-only seed.  No successful sampled comparator or inherited optimizer log
is present in this workspace, so this candidate does not treat the seed's
finite motion as evidence of successful target control.

The rollout satisfies the experiment initialization contract: diagnostics
report direct uniform still water at `U_infinity=(0,0,0)` and no prewarm
snapshot.  In the top-down keyframe row, the initially wake-free fish produces
an increasingly strong alternating wake, translates left, then bends onto an
upward-curving path that leaves the domain.  The last two frames show lateral
motion and curvature dominating target-directed progress.  The oblique
Lambda2 row independently shows compact three-dimensional structures forming
behind the moving tail, so the motion is self-propelled rather than background
advection; it also shows the wake and trajectory curling together instead of
a straight propulsive street.

The trajectory agrees with that reading.  Distance improves only from
`12.328L` to `12.078L` at `6.36T`, then worsens to `12.380L`; the fish exits the
upper boundary at `8.55T`.  Heading ranges from about `34.5 deg` to
`-68.8 deg`, both joints reach the `260 deg/T` rate cap, and raw acceleration
requests exceed the applied acceleration envelope.  Thus the useful retained
feature is a posterior-lagged self-propulsive oscillation, while the missing
capability is a restoring target-relative mean turn with yaw-rate damping.

## One candidate hypothesis

Preserve the seed oscillator and posterior lag, but center their joint
targets on one bounded mean-curvature command.  Derive that command only from
body-frame target bearing and normalized heading rate: target-side bearing
requests curvature, while yaw already developing in the requested direction
unloads it.  Apply a smaller same-sign share of the bias to the posterior
joint so steering does not replace the traveling bend.  The expected semantic
change is survival beyond the early upper-boundary exit with sustained
distance reduction.  Falsify the mechanism if the turn sign is wrong, the
same upward curl and `left_domain` topology persists, closest approach does
not materially improve, or steering suppresses the visible posterior wake.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning by biased rhythmic curvature
source_mechanism: target-feedback modulation of mean tail-beat curvature
transferable_invariant: persistent target-side error should add bounded average body curvature while measured yaw response releases that curvature and the posteriorly lagged propulsive wave continues
nontransferable_details: published gains, species-specific envelopes, dimensional beat settings, exact wake phase, and prescribed routes
policy_translation: map body-frame bearing and heading rate to a smooth bounded bias around the joint-state oscillator, with a smaller same-sign posterior bias
falsification: reject if turn sign is wrong, upper-boundary exit topology remains, target progress is not improved, or the posterior propulsive wake collapses
