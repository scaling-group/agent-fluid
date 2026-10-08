# Multi-wake target-policy candidate notes

## Evidence-first diagnosis

The common prewarm sheet shows mature, interacting wakes from all four
cylinders reaching the held fish before release. In the inherited
right-boundary failure, excessive static curvature suppresses the visible
traveling bend: the fish is carried farther right, exits after `16.7914`, and
has negative progress (`-0.1471`) with only `0.0154U` mean streamwise motion
relative to local flow. This bounds the present edit away from a larger
always-on steering bias.

Three sampled successes and the prefilled candidate are byte-identical. Their
released sheets show an immediate correct-sign redirect, a coherent posterior
wake, and a nearly straight upstream-diagonal traverse to the target in
`43.9505`; mean fish velocity `(-0.2471,-0.1020)` differs materially from mean
local flow `(-0.1342,-0.1556)`, so target closure is not passive advection.
The taper ablation also succeeds at the same release time but regresses mean
distance from `2.1391L` to `2.1412L`, supporting retention of the existing
near-target amplitude envelope.

The inherited response-conditioned release is the informative tradeoff. It
attenuates the posterior half-cycle boost whenever bearing is converging. Its
sheet retains the direct diagonal topology and target success, and RMS lateral
force/moment fall from `49.44/701.26` to `36.25/587.15`. But capture is delayed
to `46.6730`, mean distance rises to `2.2503L`, and both joint-rate and
acceleration maxima still reach their caps. Thus convergence alone is too
broad a release condition: it can withdraw the mechanism during the
large-error redirect without removing peak saturation.

## Policy hypothesis

Keep the sampled anterior oscillator, bearing-to-curvature command, posterior
lag, target-favored half-cycle boost, and approach taper. Add the inherited
response-conditioned release with one structural correction: require the
absolute body-frame bearing to enter a small-alignment window as well as to be
converging. A compact smoothstep gate is exactly zero at large error, so the
evaluated early asymmetric redirect is unchanged; after alignment is close,
the gate may release part of the posterior steering burst back into the
traveling rhythm. No force, moment, or wake-phase residual is added because the
compact evidence has no sign-resolved disturbance events for calibration.

Expected evidence is preservation of the direct early diagonal and target
capture close to `43.9505`, with some late load relief. Falsify this candidate
if arrival reverts toward `46.6730` or the `93`-time dogleg, capture is lost,
or force/moment and cap contact remain indistinguishable from the prefill. If
the alignment gate is dynamically inert, later workers should not continue
tuning its thresholds; they should test a separately evidenced mechanism.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG direction control
source_mechanism: asymmetric steering burst followed by sensor-conditioned release into a propulsive traveling bend
transferable_invariant: retain bounded target-directed asymmetry while direction error is large, then release only its residual component when body-frame alignment is both close and observably improving
nontransferable_details: published gains and duty ratios, species or robot kinematics, dimensional timing, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: preserve the joint-state-defined posterior half-cycle boost; multiply only its inherited bearing-rate release by a smooth compact gate derived from absolute normalized body-frame bearing
falsification: reject if the early redirect weakens, target capture is delayed or lost, the slow dogleg returns, or late load and saturation evidence does not improve
