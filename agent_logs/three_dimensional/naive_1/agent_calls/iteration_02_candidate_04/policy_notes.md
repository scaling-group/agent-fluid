# Candidate-specific wake-policy notes

## Inherited evidence diagnosis

All four sampled episodes satisfy the direct-uniform still-water contract:
`U_infinity=0`, no cylinders, and no prewarm snapshot.  Their top-down and
oblique sheets show self-generated caudal wakes and active motion rather than
advection.  The common target-blind seed is nevertheless the strongest finite
sample: it reaches `12.078L` from `12.328L`, then curls upward and exits at
`8.547T` with final distance `12.380L` and score `-14.825`.

The three first-generation target-steering edits do not validate their shared
mean-curvature hypothesis.  The phase-blind acceleration residual preserves
an alternating joint carrier and avoids the seed's rate cap, but it still
follows the visible upward hook, exits at `8.706T`, and degrades closest/final
distance to `12.228/13.258L` (score `-15.817`).  The two moving-equilibrium
curvature laws survive longer (`10.543T` and `10.147T`) but make even less
initial progress (`12.286L` and `12.304L`) and end at `13.401L` and `13.487L`.
Their traces explain the faint late oblique wakes: by `10T` the joint rates
have fallen below about `0.012 rad/T` and the joints have settled near the
bearing-dependent offsets.  Thus longer survival is not a useful trajectory;
static curvature displaced or extinguished the state-feedback limit cycle,
while an ungated acceleration bias retained propulsion but did not arrest the
wrong-way yaw after bearing changed sign.

The inherited optimizer notes predicted that target-driven mean curvature
would replace the seed's early-exit topology while preserving its traveling
bend.  The completed rollouts falsify that prediction for both tested
realizations.  The reusable signal convention does survive: initial positive
body-frame bearing accompanied a useful decrease in heading/bearing under a
positive bend request, and same-direction negative heading rate should unload
that request; after bearing becomes negative, continuing negative yaw should
strengthen the reverse request.

## Policy hypothesis

Replace the phase-blind/static steering actuator with one compact mechanism:
closed-loop posterior half-cycle amplitude asymmetry.  Keep the seed's
anterior Van der Pol carrier exactly unchanged.  Form a bounded turn request
from normalized body-frame bearing plus normalized heading-rate response, then
smoothly enlarge the posterior lag target only on the requested bend side and
shrink it on the opposite side.  Because the modulation multiplies the
instantaneous lagged carrier, it vanishes when the carrier vanishes and cannot
create the static nonzero equilibrium seen in the moving-mean candidates.  A
strictly positive bounded amplitude scale preserves sign reversibility and
the two-joint traveling-wave contract.

The expected semantic improvement is an alternating posterior wake with a
corrective turn after the bearing crosses zero, rather than another upper-edge
hook.  Falsify the mechanism if posterior oscillation collapses, the amplitude
scale drives more persistent speed/acceleration saturation, minimum distance
does not beat `12.078L`, or the fish retains `left_domain` with final distance
worse than the seed.  A longer episode alone is not improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering by asymmetric flapping and biological turning by biased rhythmic curvature
source_mechanism: sensor-driven half-cycle amplitude asymmetry superimposed on a continuing posteriorly lagged propulsive rhythm
transferable_invariant: strengthen the bend half-cycle requested by persistent body-frame target error while measured yaw response releases the asymmetry and the underlying traveling wave continues
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, prescribed duty ratios, exact vortex phase, and task-specific routes
policy_translation: body-frame bearing and normalized heading rate set a bounded turn request that asymmetrically scales the positive and negative halves of the observed posterior lag target while leaving the anterior state-feedback oscillator unchanged
falsification: reject if the alternating carrier or wake collapses, actuator saturation grows, turn sign is wrong, closest approach fails to beat the seed, or the same upper-boundary exit remains with worse final distance
