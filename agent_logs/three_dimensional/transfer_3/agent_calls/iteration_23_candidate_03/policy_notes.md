# Candidate diagnosis and hypothesis

The four sampled rollouts are valid direct-uniform still-water evaluations:
each reports `U_infinity=[0,0,0]`, no prewarm, finite dynamics, and capture.
Both visual rows show self-propulsion rather than advection: the top-down row
develops a coherent alternating wake behind the translating fish, and the
oblique row shows finite three-dimensional Lambda2 structures without visible
instability. The direction-conditioned coupled limiter is the strongest finite
example. It preserves the compact curved approach and quiet terminal glide but
advances capture from the prefilled partially coupled parent's `23.43552 T`
to `21.91201 T`, improves score from `-0.40797361` to `-0.32465929`, and lowers
mean distance from `2.305033 L` to `2.218947 L`.

The two weaker sibling mechanisms separate what mattered. Removing the base
coupling except when clipping already rotated the command regressed to capture
at `23.36951 T` and score `-0.40351798`, so direction distortion is not a
sufficient activation condition. A bounded common attenuation for outward
acceleration near the joint-rate envelope improved the prefilled parent to
`22.89101 T` and `-0.37095517`, showing an independently useful response even
though exact rate-limit contact remained. The winning direction-conditioned
rollout still clips posterior acceleration above `30 rad/T^2` on about `44.1%`
of stored states and places posterior rate above `4.4 rad/T` on about `10.2%`.
Its wake is productive, so this does not justify changing carrier frequency,
amplitude, phase lag, or terminal allocation.

Policy hypothesis: start from the sampled direction-conditioned winner and add
only the sampled common-scale outward-rate headroom gate, dormant at and below
`4 L`. Because the gate attenuates both joint commands by the same factor, it
retains the winning raw command direction while testing whether avoiding the
last outward push near a rate stop improves the outer trajectory. Falsify this
combination if it loses capture, reaches later than `21.91201 T`, worsens score
or mean distance, materially changes the compact approach, increases rate-stop
dwell or loads, interferes inside `4 L`, or degrades either wake view.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and state-feedback robotic-fish oscillators
source_mechanism: a directed anterior-to-posterior traveling bend must retain inter-joint coordination under actuation constraints
transferable_invariant: preserve the observed two-joint command direction and posterior lag rather than pinning one component independently at a limit
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, and prescribed phases or routes
policy_translation: retain the body-frame target controller and sampled direction-conditioned common limiter; add one bounded joint-state rate-headroom gate that applies a shared attenuation only to outward near-limit commands outside the terminal band
falsification: reject on slower or lost capture, worse distance integral, changed terminal commands, increased stop dwell or loads, instability, or loss of coherent top-down and oblique wakes
