# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The common prewarm sheet shows the held fish immersed in the same mature,
interacting four-cylinder vortex streets used by every rollout. In the released
sheet, the sampled bounded-bearing carrier is visibly self-propelled rather than
merely advected: it turns from the upper-right release pose, sustains a broad
diagonal traverse through the developed wake, and enters the target circle.
All four sampled candidates reproduce that topology and terminate
`target_reached` in `93.0266`--`93.0706` release time with about `0.940`
progress and `4.032L` mean distance.

The successful variants do not establish meaningful terminal improvement.
The ungated carrier, a `2.5L` amplitude envelope, terminal lateral-error
blending, and terminal bearing-rate lead all retain identical maximum joint
rates and accelerations (`260 deg/time`, `1800 deg/time^2`). Their mean command
energy spans only `972.318`--`972.515`, power `66.820`--`66.869`, RMS lateral
force `95.50`--`95.57`, and RMS moment `1146.61`--`1147.28`; those differences
are too small and inconsistent to support another scalar schedule.

The assigned parent's inherited terminal soft-limiter is the informative
failure. Its released keyframes are almost indistinguishable from the known-good
route through frame 5, but the last frame misses the capture circle. Metrics
confirm a closest approach of `0.802829L`, just outside the `0.75L` boundary,
followed by `unstable_dynamics` at `93.0945`. Mean command energy falls only to
`967.13`, while relative-crossflow RMS rises from about `0.168` to `0.611` and
force/moment RMS explode from about `95.5/1147` to `16456.8/157725`. Thus
removing acceleration authority during positive closing is not benign terminal
relief: it can turn a robust first crossing into a near miss and expose the fish
to a catastrophic late load event.

## Policy hypothesis

Return to the ungated successful carrier and introduce one new steering
mechanism rather than another distance gain: state-derived half-cycle
asymmetry. The existing body-frame bearing command still sets the proven
bounded mean curvature. Joint angle relative to that center identifies the
current half-cycle without a clock. When the bend is on the target-requested
side, modestly strengthen the curvature center; on the opposite half-cycle,
weaken it by the same bounded fraction. Apply the resulting center consistently
to the anterior oscillator and posterior mean target, leaving carrier period,
amplitude, damping, and lag unchanged.

This translation tests whether steering can be distributed through the
propulsive rhythm instead of increased as static curvature. It should retain a
traveling bend while producing a meaningfully different, more direct useful
trajectory. Falsify it if target crossing is lost or delayed, the oscillator
settles toward static bend, boundary/collision/instability replaces success, or
actuator and load measures rise without improved arrival or distance progress.

bookshelf_consulted: true
source_domain: biological and robotic-fish turning by asymmetric flapping or duty-ratio modulation
source_mechanism: strengthen the target-side propulsive half-cycle while retaining an alternating traveling bend
transferable_invariant: a persistent body-frame turn request can modulate opposite halves of an observed joint-state rhythm asymmetrically without requiring clock phase or a larger static bend
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: infer half-cycle from anterior joint displacement about the bounded bearing-driven center, then smoothly modulate that center by target-side alignment and give the posterior mean target the same modulation
falsification: reject if capture is lost or delayed, traveling-bend propulsion collapses, the route does not change usefully, or saturation and force/moment loads increase without better progress

## Pre-evaluation verification

The half-cycle multiplier is smoothly bounded to `0.75`--`1.25`, so the
instantaneous anterior curvature center cannot exceed `10 deg` under saturated
bearing feedback; it returns exactly to the sampled `8 deg` mean-bias formula
when the half-cycle term is zero and is exactly inactive at zero bearing. Every
direct `params.FIELD` reference has a matching field in
`target_policy_params()`. The guidance semantic check and solver boundary check
pass. The Julia contract assertion could not run because this workspace image
does not provide a `julia` executable; no CFD evaluation was attempted.
