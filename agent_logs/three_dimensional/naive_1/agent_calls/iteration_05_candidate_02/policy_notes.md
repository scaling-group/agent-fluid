# Candidate wake-policy notes

## Evidence diagnosis before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and finite dynamics.
The combined top-down and oblique sheets show active translation and coherent
alternating caudal structures, so these are self-propelled route-control
failures rather than advection or wake breakup.

The assigned prefill and the two related half-cycle/redirect variants retain
the earlier upper-exit topology. They leave at about `10.6--11.2T`, with
minimum/final distances of `9.40--10.06L`; their top-down wakes curve toward
the upper boundary and their final centers are near `y=15.20L`. The assigned
parent's inherited logs also show that shared or tail-biased moving curvature
centers regressed to `12.23--15.36L` final distance, sometimes by settling the
carrier near a static bend. Those results rule out another shared-center or
posterior-bias retry.

`solver_f6a7d17d24de` is a materially different and stronger finite example.
Its anterior-only moving center leaves the posterior lag zero-mean, preserves
the strongest staggered wake in both visual rows, survives to `28.59T`, and
reaches `5.033L` at `17.56T` before passing below the target and exiting the
lower boundary at `9.084L`. Its mean speed is `0.683U`, versus `0.387--0.455U`
for the three upper-exit samples, while the zero background and small sampled
local-flow magnitude (`0.0178U` mean) confirm self-propulsion.

The best trace exposes a signal-level defect before that miss. Its signed
slip law uses `bearing - 1.2*velocity_body_y`. Near alignment, beat-scale
lateral velocity can dominate the slow target error in either direction: at
about `4T`, bearing is roughly `+0.10rad` while target-side lateral velocity is
about `+0.42U`, reversing the route request; near `6T`, bearing is only
`+0.02rad` while `-0.50U` wrong-side velocity instead saturates the positive
request. Over the full trace the slip term reverses the bearing's requested
sign on about 11% of samples and later amplifies the growing bearing until the
anterior center stays near its limit. The fish then moves from `5.033L` away
to `9.084L` despite a coherent propulsive wake. This is evidence against
treating instantaneous self-generated lateral velocity as an independent
route-error term.

## One candidate hypothesis

Retain the validated anterior-only mean-curvature carrier from
`solver_f6a7d17d24de`: the same cadence, amplitude, Van der Pol drive,
posterior lag, damping, bearing scale, and curvature limit. Change only the
semantics of slip feedback. Project lateral velocity onto the instantaneous
target side, allow it to unload an existing bearing request without crossing
zero, and ignore wrong-side lateral velocity for route strengthening. Thus
slow body-frame target geometry owns turn direction, while beat-scale slip can
only report that some requested lateral response is already present. The tail
continues to receive only the centered, zero-mean traveling carrier.

The falsifiable expectation is that the controller preserves the long,
coherent lower-route propulsion of the strongest sample but avoids the
alternating request reversals near `4--6T`, reducing the overshoot that makes
the target nearly broadside at closest approach. Reject this translation if
it returns to the `~11T` upper exit, loses the alternating posterior wake,
fails to approach at least as closely as `5.033L`, or retains the same lower
exit without a later/smaller miss. Because the inherited carrier already
requests beyond the acceleration envelope frequently, this candidate adds no
new acceleration residual or larger scalar authority.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake/disturbance-aware swimming control
source_mechanism: keep slow target geometry as the route command and use fast lateral-response feedback only as bounded unloading
transferable_invariant: an oscillatory lateral signal may reduce an already-correct steering request when motion is target-side, but must not independently reverse or amplify the slow route command
nontransferable_details: published feedback gains, species-specific gait envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: body-frame bearing fixes turn sign; normalized body-frame lateral velocity is half-wave projected onto the target side and can reduce bearing magnitude only to zero before driving the validated anterior moving center
falsification: loss of coherent propulsion, return to the early upper exit, closest approach no better than 5.033L, or the same lower-boundary miss without delayed or reduced divergence
