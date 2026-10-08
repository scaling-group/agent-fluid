# Candidate diagnosis and hypothesis

The four sampled evaluations satisfy the frozen experiment contract: each
reports direct uniform still-water initialization, zero background velocity,
no cylinders, finite dynamics, and capture. The combined keyframe sheets were
read from release through termination in both their top-down vorticity and
oblique body/Lambda2 rows. All four show self-propelled translation with a
coherent alternating posterior wake, productive rather than merely lateral
oscillation, and the same broad target-directed route. There is no visible
wake-topology failure to repair and no prewarm or passive-advection artifact.

The useful separation is terminal. The mean-first allocator alone
(`solver_57f7c1352c72`) and the closing-conditioned redirect-continuity policy
(`solver_4c0e1314ad61`) share the same `5L`, `2L`, and `1.75L` milestone times,
so their cruise trajectories are an empirical control. Lowering the strong
redirect onset only during reliable approach then advances capture from
`16.258T` to `16.225T`, improves mean distance from `1.94924L` to `1.94670L`,
and reduces near-approach posterior acceleration-limit residence from about
`48.0%` to `28.9%`. It also improves on the inherited stacked parent recorded
at `-0.067754` while preserving capture and the 3D wake. Conversely, increasing
terminal course weight without that allocator/onset scaffold
(`solver_1243aba027e1` versus `solver_a5dc27216aa2`) leaves every sampled
milestone and arrival step unchanged and slightly worsens score; that scalar
blend is not the next mechanism to repeat.

Reconstruction from the logged world trajectory using the policy's own
body-frame formulas exposes the residual defect in the best policy. Inside
`1.2L`, its response error and recent bearing response reverse within a beat:
near the `1.2L` crossing they are approximately `+0.613 rad` and
`-3.95 rad/T`, near `0.9L` they are `-0.041 rad` and `+3.24 rad/T`, and capture
still occurs with approximately `+0.465 rad` response error. An onset gate
driven only by instantaneous error therefore releases authority at the
`0.9L` phase even though recent target-relative motion predicts the error will
reopen.

Policy hypothesis: use `solver_4c0e1314ad61` as the single candidate scaffold
and add one bounded response-lead mechanism. During closing-gated proximity
only, add a small angle predicted from finite, normalized
`bearing_window_rate` to the redirect response error, clamped by the existing
redirect transition width. This should keep mean posterior curvature engaged
through the premature near-zero crossing and ease it when bearing is already
returning, while leaving the far-field carrier, one-sided wave relief, and
mean-first acceleration allocation exactly unchanged. The mechanism is
falsified if capture is lost, the `5L`/`2L` transit changes materially, terminal
response oscillation or posterior limit residence increases, or arrival/mean
distance fails to improve over the `16.225T`/`1.94670L` reference.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish direction tracking
source_mechanism: release a strong bounded redirect from observed target-relative turning response rather than from open-loop phase or elapsed time
transferable_invariant: a large geometry error may open extra curvature, but measured response should continuously anticipate its release while the propulsive carrier remains intact
nontransferable_details: species-specific C-start shapes, published controller gains, dimensional response horizons, exact vortex phases, and task-specific routes
policy_translation: add a bounded approach-gated `bearing_window_rate` phase-lead angle to body-frame target-versus-course error before the posterior redirect gate and command
falsification: reject if early wake or milestones change, capture is lost, terminal error reversals persist, posterior saturation rises, or arrival and distance integral regress
