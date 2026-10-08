# Step 14 wake-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

All four sampled evaluations satisfy the frozen experiment contract: direct
uniform still water, zero cylinders, the L64 moving window, and `capture`
termination. The combined sheets show self-propulsion rather than advection.
In both the top-down mid-plane row and the oblique Lambda2 row, the baseline,
best-score, closure-qualified, and assigned-parent policies form the same
coherent alternating traveling wake without a visible collapse or instability.
The useful differences are therefore in early propulsion and the accumulated
route, not in gross wake topology.

The no-reserve reference captures at `17.7265T` with score/mean distance
`-0.081395/1.967391L`, center path `12.8468L`, approach/final course alignment
`0.899/0.601`, and final yaw rate `-0.901 rad/T`. The anterior-energy-only
posterior target amplification improves first-`3T` mean distance/speed to
`12.214443L/0.2523U` and score/mean distance to
`-0.073952/1.960279L`, but path rises to `13.0672L`, capture slips to
`17.9740T`, final alignment falls to `0.132`, and final yaw reaches
`-2.146 rad/T`. The closure-qualified sibling retains part of the early gain
(`12.220627L/0.2453U`) while capturing earliest at `17.6935T`; it also improves
mean distance to `1.960960L`, keeps path to `12.8750L`, and finishes at
`0.637` alignment with only `-0.046 rad/T` yaw. This is the only sampled
reserve variant that beats the no-reserve controller on both mean distance and
arrival.

The assigned parent instead requires low absolute posterior angle-rate energy.
It captures at `18.0015T` with score/mean distance
`-0.077585/1.963845L`, path `13.1271L`, approach/final alignment
`0.714/0.181`, and final yaw `-1.287 rad/T`. Thus absolute posterior energy is
not a useful response certificate here: it returns some early distance benefit
but is worse than the closure-qualified sibling on arrival, mean distance,
path, and terminal state. Across all four policies, RMS yaw, force, and moment
remain in the same narrow classes (about `2.05 rad/T`, `0.0158`, and `0.0082`),
and the two visual rows remain near-identical, so load or wake suppression is
not the supported next locus.

## Candidate hypothesis

Keep the error-qualified far-route observer, ordinary approach controller,
direction-selective rate governor, anterior phase-plane carrier, posterior
lag, and odd mean-curvature/half-cycle steering unchanged. Replace posterior
wave-target amplification and the parent's absolute posterior-energy
conjunction with one allocation mechanism: a bounded velocity-aligned
posterior work reserve. The reserve uses the sampled closure qualifier and low
anterior carrier-energy gate, but adds acceleration in the sign of measured
`phi_dot[2]` around the unchanged lagged target. It therefore reinforces
posterior oscillatory energy without moving the mean-curvature target or
prescribing a phase. The acceleration is smoothly saturated in normalized
posterior rate and remains under the existing direction-selective output
envelope.

Expected result: recover a material fraction of the energy-only policy's
first-`3T` distance/speed improvement while retaining the closure-qualified
sibling's near-baseline path, arrival, and terminal alignment. Reject the
mechanism if early distance returns to the no-reserve baseline, if capture is
later than the assigned parent, if path/terminal yaw remains in the
energy-only class, if force/moment or acceleration-ceiling class rises
materially, or if either visual wake row loses coherence.

bookshelf_consulted: true
source_domain: Lighthill elongated-body tail-end propulsion and sensor-modulated state-feedback oscillators in robotic fish
source_mechanism: posterior oscillatory work is reinforced through measured joint response while the traveling-wave phase relation and steering offset remain separate
transferable_invariant: add bounded energy along the observed posterior velocity only when propulsion need is observed, without shifting mean curvature or imposing an exact phase
nontransferable_details: published gains, species-specific amplitudes and frequencies, full-body kinematics, exact vortex phases, and task-specific routes
policy_translation: gate a normalized velocity-aligned `phi_dot[2]` acceleration by deficient anterior phase-plane energy and deficient normalized target closure; retain the existing body-frame route feedback and lagged two-joint target
falsification: reject if early closure is not improved over no reserve, route or terminal state regresses toward the energy-only target-amplification rollout, actuator/load class worsens, or top-down/oblique wake coherence changes
