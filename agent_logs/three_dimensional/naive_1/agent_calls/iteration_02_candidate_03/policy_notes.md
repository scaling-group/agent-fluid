# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the initialization contract: diagnostics
report direct uniform still water at `U_infinity=(0,0,0)`, with no cylinders
and no prewarm snapshot.  None captured the target; every rollout exited the
upper virtual boundary.

The strongest finite sample is the target-blind carrier
`solver_36a38f7240b3` (`-14.8252`).  Its top-down row shows an initially
wake-free fish developing a strong alternating caudal wake and translating
left, followed by an increasingly tight upward curl.  Its oblique Lambda2 row
confirms a coherent three-dimensional self-generated wake along that curved
path, rather than background advection.  The metrics agree: distance fell
from `12.328L` to `12.078L` at `6.358T`, then rose to `12.380L` at the
`8.547T` upper-boundary exit; center motion was about `-0.925L` in x and
`+1.200L` in y, and both joints reached the `260 deg/T` speed limit.

The prefilled mean-curvature candidate `solver_79b9eb651f44` is the most
informative mechanism failure.  The first half of its top-down row has much
weaker wake growth and almost no translation; only later does a broad curved
wake form as the fish again yaws upward.  The oblique row likewise shows that
late caudal structures remain self-generated but follow the wrong-way arc.
Distance improved only to `12.304L`, then worsened to `13.487L` at `10.147T`;
by about `9T` the joints had settled near the commanded static bend
`(-8,-4.8) deg` with essentially zero joint speed.  The alternate shared-mean
candidate `solver_137608088dcd` similarly settled near `(-8,-8) deg` and
exited at `10.543T` with minimum/final distances `12.286/13.401L`.  The
bearing-driven acceleration residual `solver_1c9001e61100` retained visibly
larger joint motion, but still exited at `8.706T` and reached only
`12.228L` before worsening to `13.258L`.

Together with the inherited worker notes, these results falsify the first
generation's shared assumption that a slowly varying bearing-to-static-bend
mapping is an adequate steering actuator for this startup.  The failures do
not justify stronger drive: the seed already forms a propulsive wake and hits
the rate envelope.  They instead motivate changing the actuation primitive
while preserving the unshifted carrier equilibrium.

## One candidate hypothesis

Use body-frame bearing plus normalized measured yaw rate to request a bounded
turn, but express that request as half-cycle restoring asymmetry rather than a
joint offset.  On the target-favored bend side, slightly reduce the restoring
acceleration; on the opposite side, increase it by the same bounded fraction.
The modulation vanishes at zero bend, keeps the only static oscillator
equilibrium at zero, and passes the resulting asymmetric traveling bend
through the seed's unchanged posterior lag.  Positive body-frame bearing
favors positive curvature, consistent with the prior evidence that positive
bend produces the initially correct negative yaw; negative measured yaw
unloads that request before the target crosses the centerline.

The expected semantic change is continued alternating joint motion and wake
formation beyond `4T`, followed by a turn-rate arrest before the repeated
upper-boundary curl.  Falsify the mechanism if the turn sign is wrong, the
same upper exit persists without materially better minimum distance, the
joints again pin at a nonzero bend, or half-cycle modulation increases
persistent saturation while reducing leftward propulsion.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning by asymmetric flapping
source_mechanism: target-feedback modulation of half-cycle amplitude or duty while the propulsive rhythm continues
transferable_invariant: persistent body-frame target error should favor one bend half-cycle without creating a static posture, and observed yaw response should release or reverse that asymmetry
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: map normalized bearing and heading rate to a bounded side-dependent restoring multiplier around the zero-centered joint-state oscillator, retaining the posterior lag unchanged
falsification: reject if carrier activity collapses, a nonzero static bend appears, yaw has the wrong sign, saturation grows without better progress, or the repeated upper-boundary exit remains
