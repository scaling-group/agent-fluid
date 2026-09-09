# Posterior residual with miss-conditioned drive relief

## Visual and rollout diagnosis before editing

All four sampled evaluations report direct uniform initialization in still
water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
and `capture`. I inspected the combined keyframe sheets for the score-best
`solver_e749afa61520` and the weakest sampled capture
`solver_8600d052eff8`, including both the top-down vorticity row and oblique
body/Lambda2 row from release through termination. Both fish self-propel on a
nearly direct down-left route; a compact alternating mid-plane street and
sparse body-connected three-dimensional structures grow behind the posterior
body. Neither sheet shows passive advection, wake breakup, boundary contact,
or instability. The weaker run takes longer to traverse essentially the same
route, so the informative failure is terminal course quality rather than
propulsion or termination class.

The sampled posterior predicted-miss residual is the only new actuator with a
material metric improvement: relative to the prefilled instantaneous
target-line controller, it improves score from `-0.0196486` to `-0.0109428`,
arrival from `15.6893T` to `15.1403T`, and distance integral from `1.90130L`
to `1.89264L`. Its terminal course is still marginal, however: reconstructed
constant-course miss is `0.6511L`, absolute target-line rate is `1.7453/T`,
and speed is `1.4794L/T`. It also raises peak normalized planar force/moment
to `0.0404/0.0190` and has `1.27%` sampled dwell with either joint above
`40 deg`. The force-response and persistent-line-rate samples retain capture
but finish with `0.7441L` and `0.7470L` predicted miss, respectively. Thus the
posterior rhythmic residual is useful for traversal, while none of these
samples establishes a centered terminal approach.

The assigned parent's inherited step-32 note proposes near-field posterior
drive relief but has no formal CFD result in the sampled evidence. It is a
hypothesis, not a positive result. The durable parent guidance rejects another
target-line-rate completion variant, static-bend tuning, and broad carrier
braking; it asks for a separately scheduled terminal residual that tends
rapidly to zero on centered courses.

## Single candidate hypothesis

Use `solver_e749afa61520` as the evidenced base, preserving its state-feedback
oscillator, posterior lag and pulse, pursuit/course blend, constant-course
predictor, carrier-separated yaw response, common response-plus-miss handoff,
shared two-joint half-cycle redirect, and cubic posterior miss residual. Add
one compatible approach-hold mechanism: close to the target and only while
the measured course is closing with predicted miss above `0.5L`, smoothly
reduce the symmetric posterior traveling component. The anterior oscillator,
mean bend, posterior pulse, and both steering residuals retain full authority;
the relief is exactly zero below the miss margin and outside the close/closing
regime.

The hypothesis is that modest tail-thrust relief will give the evidenced
posterior directional residual another corrective beat instead of accelerating
through the capture edge. Support requires capture with predicted miss below
`0.590L` and preferably below the inherited centered reference `0.179L`,
without losing the direct route, compact alternating 3D wake, arrival/distance
advantage, joint reserve, or load scale. Falsify on loss of capture, merely a
slower crossing with miss at or above `0.590L`, altered far-field translation,
wake decoherence, additional joint dwell/rate occupancy, peak normalized loads
above the sampled `0.0404/0.0190` boundary, nonfinite commands, or loss of
reflection equivariance. Formal CFD remains deferred to EvE, so this
candidate's future result is not evidence here.

bookshelf_consulted: true
source_domain: elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics supply a thrust lever while observed approach state continuously modulates the rhythmic command
transferable_invariant: near-field symmetric posterior thrust can be reduced independently of anterior rhythm and directional steering, with full drive restored on an already-centered course
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waves, exact phase lags or vortex phases, task coordinates, and prescribed routes
policy_translation: gate bounded posterior traveling-wave relief by normalized body-frame distance, closing alignment, and excess constant-course miss while retaining the two-joint state-feedback carrier and posterior directional residual
falsification: reject if capture margin and terminal course do not improve together, or if direct translation, coherent wake, joint reserve, boundedness, load scale, or reflection equivariance deteriorates

## Dry validation boundary

The mandated guidance-materiality, lightweight Julia policy-contract and
parameter-schema, and solver editable-boundary checks pass. A deterministic
`59,049`-state grid spanning normalized body-frame target geometry, velocity,
distance, heading response, and both joint angles and rates produced finite
commands within the smooth `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). Relative to the sampled posterior-residual
base, the candidate changed a representative large closing-miss command by
`0.14333 rad/T^2` while far-field and centered-course probes changed by
exactly `0.0`. The approach hold is therefore active and compactly scheduled,
not a comment or scalar-only carrier edit. These checks are algebraic only;
formal CFD remains deferred to EvE.
