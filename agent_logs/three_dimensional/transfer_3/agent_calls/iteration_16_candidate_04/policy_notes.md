# Wake-policy diagnosis and candidate hypothesis

## Prior evidence

All four sampled evaluations report direct uniform quiescent initialization,
no prewarm snapshot, finite dynamics, and `capture` termination. The two
top-down and oblique rows were inspected in the combined keyframe sheets for
the strongest finite sample (`solver_efd2345fc503`) and the weakest sampled
score/mechanism comparison (`solver_dca1b5640cb9`). Both fish are
self-propelled rather than advected: an alternating, laterally compact wake
grows behind the body while the moving window follows a continuous
down-left path. The oblique Lambda2 views agree that the caudal motion sheds a
coherent three-dimensional sequence rather than a single startup vortex or a
collapsed wake.

The current feasible LOS-rate/distributed-C-bend policy is duplicated exactly
in `solver_d1d920e734e7` and `solver_efd2345fc503` (same policy hash). It
captures at `19.283T` and `19.234T`, with mean distances `2.071L` and
`2.065L`, scores `-0.1822` and `-0.1766`, and local-flow RMS
`0.0181U` and `0.0180U`. Its returned acceleration lies exactly on the
component limit for `44.9--47.8%` of anterior samples and `73.6--74.9%` of
posterior samples. Thus explicit component clipping is physically bounded but
frequently changes the raw anterior/posterior command ratio.

The intercept-gated variant also captures, but the visual terminal approach is
higher and more laterally directed. Diagnostics agree: it captures later at
`19.784T`, has worse mean distance `2.098L` and score `-0.2082`, ends with
center `y=10.469L`, and carries world lateral velocity `-0.581L/T` versus
`-0.182` and `-0.369L/T` in the duplicated feasible baseline. Its local-flow
RMS remains only `0.0184U`, so there is no strong external wake event to
justify the extra closest-pass/range gate. The uncapped response-triggered
variant is also a capture (`19.888T`, score `-0.2034`) but requests raw maxima
`59.8/124.5 rad/T^2`, confirming that the successful carrier is materially
acceleration constrained.

## Candidate

Preserve the successful normalized body-frame LOS-rate guidance, bounded
response-triggered distributed C-bend, oscillator, and posterior target. Make
one mechanism change at the policy boundary: project the raw two-joint
acceleration pair with one common positive scale into the componentwise
physical envelope. Unlike two independent clamps, this preserves the
instantaneous acceleration direction, including posterior emphasis and the
relative steering/carrier contribution, whenever either joint is constrained.

Hypothesis: retaining the raw inter-joint command ratio through saturation
will preserve the visible alternating wake while reducing saturation-induced
wave-shape distortion. A useful result is still a capture with a better score
or mean distance than the sampled `-0.1766-- -0.1822` / `2.065--2.071L`
repeat band, or a materially lower load/saturation cost without a worse
termination. Falsify the mechanism if the top-down wake weakens, the oblique
vortex sequence loses coherence, capture becomes later than about `19.3T`, or
the fish misses/exits; that would show that independently saturating the
anterior command is part of the effective carrier rather than merely a
projection artifact.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body propulsion (Taylor and Lighthill), with low-dimensional robotic-fish CPG actuation
source_mechanism: a directed body wave with posterior lag and emphasis produces propulsion, while joint coordination is the mechanism rather than either command in isolation
transferable_invariant: preserve the instantaneous anterior/posterior command relationship when the shared gait meets an actuator boundary
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame LOS feedback and the two-joint state-feedback oscillator, but apply one positive common scale to the raw acceleration pair so both components fit the physical envelope without changing their ratio
falsification: reject if capture, distance integral, or wake coherence worsens relative to the duplicated feasible baseline, or if load/saturation histories show no compensating improvement
