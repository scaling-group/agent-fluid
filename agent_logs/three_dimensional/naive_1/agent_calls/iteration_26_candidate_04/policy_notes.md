# Candidate diagnosis and hypothesis

The assigned parent (`solver_bd37a8d7a3f9`) and all three sampled controls
terminate in capture under confirmed direct-uniform still water. The parent's
speed-deficit share is allocated to posterior phase lag rather than multiplying
the whole posterior carrier. It captures at `23.122009T` with scored mean
distance `2.133413L`, versus the three executable-equivalent whole-carrier
controls at `23.331013T` and `2.135772L`. The improvement is not a simple early
surge advantage: at `4T` and `8T` the parent is farther from the target
(`11.447/8.822L` versus `11.298/8.694L`), but it is ahead by `12T`
(`6.171L` versus `6.241L`) and keeps that lead through capture. Its peak
command norm falls from about `126.60` to `107.27`, and peak normalized
force/moment fall from `0.03086/0.01621` to `0.03036/0.01586`; mean action is
slightly higher (`60.06` versus `59.04`) and rate-cap occupancy remains finite
at about `11.92/7.06%`.

The top-down parent sheet shows self-propelled motion along the established
S-route, with an attached alternating mid-plane street through the final
target crossing. Its oblique row is blank and therefore cannot support a new
3D-wake claim. A sampled whole-carrier control supplies the informative visual
comparison: it has the same top-down route/wake class, and its complete oblique
row shows discrete three-dimensional Lambda2 structures through capture.
Thus the numerical improvement is consistent with better traveling-wave
allocation, not a visibly different route or wake class, but the parent's 3D
wake still inherits rather than extends the complete-view bound.

The parent computes posterior delay as an angle/velocity quadrature. Increasing
the velocity coefficient changes both phase and the norm of that quadrature.
The candidate will make that allocation explicit: during measured
through-water slowdown it will rotate the posterior carrier toward additional
lag while normalizing the quadrature to its inherited cruise norm. All course,
anterior recovery, rudder, terminal relief, and gate parameters remain
unchanged. This is a one-mechanism test of phase timing without incidental
posterior amplitude recruitment.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and coupled-oscillator swimming control
source_mechanism: a directionally traveling bend with posterior phase lag supplies reactive thrust more reliably than reciprocal or standing motion
transferable_invariant: preserve a bounded posterior-delayed traveling carrier and separate its phase allocation from its amplitude envelope
nontransferable_details: published gains, frequencies, species envelopes, full-body waveforms, exact wake phase, and task-specific routes
policy_translation: use joint angle and normalized joint velocity as quadrature components, increase their speed-deficit-driven posterior phase lag, and normalize their vector norm to the inherited cruise carrier
falsification: reject if capture is later than 23.122009T, scored mean distance exceeds 2.133413L, the established S-route or alternating wake changes, or action, rate-cap occupancy, normalized force, or moment exceed the parent envelope without compensating progress

