# Wake-policy candidate diagnosis and hypothesis

## Evidence diagnosis before the edit

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=[0,0,0]`, no cylinders or
prewarm, finite dynamics, and valid combined top-down/oblique sheets. Their
candidate files differ only in comments, so they are four evaluations of the
same executable response-gated differential-curvature controller.

The four rollouts all capture in `19.228--19.784T`, with final head distance
`0.7482--0.7497L` and scores `-0.2433--0.2299`. Their top-down rows show smooth
target-directed self-propulsion and a coherent alternating vorticity street;
the oblique rows show compact paired caudal Lambda2 structures throughout the
approach. Only `2.5--2.6%` of logged distance increments are outward. Maximum
local-flow magnitude (`0.0254U`), planar force coefficient (`0.0319`), and yaw
moment coefficient (`0.0167`) remain finite and tightly repeated. Thus the
normalized lateral direction cosine, opposite-sign anterior/posterior bend,
and one-sided yaw-response release form a reproducible semantic success and
should remain unchanged in this candidate.

The inherited geometry-held failure is the useful counterexample. It preserves
the same coherent wake and reaches `1.0927L` at about `19.06T`, but the visual
sheet shows it curl below and then away from the target before a lower-boundary
exit at `32.071T` and `9.5549L`. The successful response release is therefore
not expendable approach logic.

The repeated capture still uses the actuator envelope as a bang-bang clip.
Across the four samples, raw anterior acceleration exceeds `1800 deg/T^2` on
`61.7--62.2%` of rows and raw posterior acceleration on `71.7--72.3%`; maxima
reach about `63/101 rad/T^2`. Joint rates contact `260 deg/T` on roughly
`10.7--10.9%` and `14.2--14.4%` of rows. The assigned-parent and inherited
notes explicitly leave policy-owned command relief as the next isolated
ablation; a prior `tanh` limiter was bundled with a failed posterior-only route
and therefore did not identify the effect of shaping itself.

## Policy hypothesis

Preserve the successful route computation and traveling-bend carrier exactly,
then pass each raw acceleration through a policy-owned, even-power smooth
saturation whose asymptote is the known actuator envelope. A high-order knee
closely matches the existing hard clip when commands are large and changes
sub-limit commands little, while continuously releasing the repeated
over-limit requests instead of delegating most of each beat to downstream
clamping. This is one actuator mechanism ablation, not a route or scalar-gain
retune.

Falsify the candidate if capture is lost, the geometry-only lower-exit topology
returns, the alternating wake degrades, broad-scale distance progress worsens,
or rate contact and applied command effort fail to decrease. Even if capture
survives, reject the shaping as useful if it merely hides raw over-limit counts
without reducing applied saturation or load histories.

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual locomotion control, with classical swimming-efficiency guardrails
source_mechanism: retain the low-dimensional propulsive rhythm and route modulation while bounding the final actuator command instead of issuing unbounded high-frequency effort
transferable_invariant: a useful traveling bend and its target-signed steering can be preserved while the final state-feedback command respects a smooth finite actuator envelope
nontransferable_details: published gains, dimensional actuator limits, clocked CPG phases, species-specific envelopes, exact vortex phases, and source-task routes
policy_translation: leave the evidenced body-frame route request and two-joint carrier unchanged, then apply the same policy-owned even-power soft saturation independently to both acceleration commands
falsification: reject if capture or wake coherence is lost, distance progress worsens, the lower-exit topology returns, or applied rate contact and load histories do not improve

## Dry validation after the edit

Static inspection confirms that every direct `params.FIELD` reference is
declared by `target_policy_params()`, and the representative contract state
returns two finite accelerations inside the policy envelope. Replaying only the
new saturation map over each sampled raw-command history changes the formerly
hard-clipped applied command by about `0.33/0.25 rad/T^2` on average, keeps
maxima below `31.416 rad/T^2`, and gives an acceleration-squared proxy ratio of
`0.978` relative to the old downstream clip. This dry replay is not a closed-
loop CFD result and cannot establish capture, rate-contact, or load improvement;
those remain the next evaluation's falsification tests.
