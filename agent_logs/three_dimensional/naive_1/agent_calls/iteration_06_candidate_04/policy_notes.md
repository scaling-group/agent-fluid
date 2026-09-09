# Candidate diagnosis and hypothesis

## Evidence read before editing

All four sampled evaluations satisfy the frozen contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no prewarm or
cylinders, finite dynamics, and valid moving-window transport. Their policy
parameters and executable expressions are identical; source differences are
comments only. All four capture at `0.7482--0.7497L` in
`19.228--19.784T`, while score ranges from `-0.2433` to `-0.2299`. That is a
repeatability band for one controller, not evidence for a scalar gain choice.

I inspected every sampled combined sheet and compared the best-scoring and
prefilled captures with the inherited seed and step-5 failures. The capture
sheets show target-directed self-propulsion: an alternating top-down
vorticity street and compact three-dimensional caudal Lambda2 structures
remain coherent through first crossing. The target-blind seed makes the same
kind of wake but turns away and exits, so wake coherence alone is not route
control. The captured mechanism worth preserving is the normalized lateral
target request, opposite-sign anterior/posterior curvature, and a recent-yaw
gate that may release but not reverse target-owned steering sign.

The inherited step-5 rate guard is a concrete negative result. It preserved a
coherent wake and bounded returned acceleration at `1800 deg/T^2`, but changing
the carrier near the `260 deg/T` rate envelope destroyed the captured route:
minimum distance worsened to `5.3386L`, mean scored distance to `6.4522L`, and
the fish exited the upper boundary at `21.203T` and `5.8866L`. The top-down
and oblique sheets show sustained propulsion along the wrong high-side path.
Thus this candidate must not retry pointwise command limiting or rate gating.

The replicated captures expose a smaller route weakness suitable for an
isolated feedback test. Within `1.5L` of the target, mean absolute lateral
target fraction is `0.351--0.678`, mean absolute body-frame lateral velocity
is `0.251--0.287U`, and the lateral velocity points away from the current
target side on `32.0--70.9%` of rows. The endpoint approaches therefore vary
widely around the capture circle even though all succeed. This supports a
velocity-lead correction to steering magnitude, not a carrier or limiter edit.

## Policy hypothesis

Preserve the successful oscillator, posterior lag, differential curvature,
and one-sided yaw-response release. In the terminal regime only, project
normalized body-frame lateral velocity onto the current target side. The lead
term is zero outside `2.5L`, ramps continuously, and is fully active inside the
evidenced `1.5L` regime. Helpful lateral translation slightly releases
requested curvature; adverse translation slightly strengthens it. Apply the
correction only to request magnitude, with target geometry retaining sign, so
beat-scale slip cannot command a route reversal.

This should retain the evidenced wake and capture while reducing cross-track
motion near the target and tightening the approach trajectory. Falsify the
mechanism if capture is lost, arrival or mean distance worsens materially
beyond the sampled repeat band, the high/low boundary topology returns,
lateral target fraction grows, or wake coherence and load histories degrade.
The current candidate has not yet been evaluated and no outcome is claimed.

bookshelf_consulted: true
source_domain: robotic-fish sensor-feedback direction tracking and wake-interaction control
source_mechanism: distance-gated target-relative lateral-motion feedback around a rhythmic curvature controller
transferable_invariant: preserve the propulsive rhythm and target-owned turn sign while measured motion toward the target releases steering and motion away restores it
nontransferable_details: published gains, robot or species kinematics, dimensional speeds, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: inside a normalized terminal-distance gate, project body-frame lateral velocity onto normalized target side, use a bounded lead term to modulate only differential-curvature magnitude, and retain the two-joint state-feedback carrier unchanged
falsification: lost capture, boundary exit, materially slower distance progress, larger cross-track error, collapsed wake coherence, or worse force and moment histories
