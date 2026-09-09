# Predictive reversal-preserving carrier guard

## Evidence diagnosis before edit

All four sampled episodes satisfy the experiment contract: direct uniform
`U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination. The
best finite sample is `solver_674e84ea2575` (predictive positive-work guard):
it captures at `15.851T`, versus `15.939T`, `16.088T`, and `16.247T` for the
other samples. Recomputed from the logged trajectories, it also has the
shortest head path (`12.995L` versus `13.107--13.363L`), lowest mean anterior
and posterior command (`16.21/14.89 rad/T^2`), and lowest posterior residence
above 90% of the rate limit (`6.52%` versus `7.93--8.25%`). Its anterior
greater-than-99% rate residence is `9.16%`, down from `11.93--12.18%` for the
two response-release comparisons, while its maximum posterior bend is only
`34.7 deg` rather than `38.6--39.2 deg`.

The combined keyframe sheets for the best sample and the slower prefill show
self-propulsion rather than advection: alternating compact mid-plane
vorticity is shed behind the advancing body from quiescent release, and the
oblique row shows organized three-dimensional Lambda2 structures through the
target-directed arc. Neither view shows a wake collapse or an external flow
event before capture. The predictive sample's late path is visibly more
compact, but its peak planar force/yaw-moment coefficients are higher
(`0.03846/0.01908` versus `0.03477--0.03575/0.01715--0.01783`), so its
trajectory/rate improvement does not establish lower hydrodynamic loading.

The sampled comparison supports adopting `solver_674e84ea2575` as the base,
preserving its full body-frame course redirect, state-derived phase steering,
distance handoff, and short state-space preview. The remaining inconsistency
is local to the rate guard: during the approach it can attenuate carrier
acceleration that opposes joint velocity even though that component pulls the
joint back from the rate envelope. The candidate will pass this negative-work
reversal unchanged while applying the existing common predictive guard only
to positive-work carrier components. This changes energy direction handling,
not a scalar gain, and leaves target-conditioned steering outside the guard.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and robotic-fish coupled-oscillator control
source_mechanism: a posterior-lagged traveling bend sustains reactive thrust, while bounded state feedback modulates the rhythmic envelope without replacing its phase direction
transferable_invariant: preserve the direction and posterior lag of useful traveling-wave reversal; near an actuator envelope, withdraw carrier work that accelerates motion outward before suppressing carrier action that decelerates it
nontransferable_details: published species envelopes, dimensional frequencies, CPG gains, exact tail phases, full-body waveforms, and task-specific routes
policy_translation: retain the sampled two-joint carrier/steering decomposition; use normalized joint rates, bounded carrier acceleration, and the sign of carrier acceleration times joint velocity to preview the rate boundary, scale positive-work carrier with one common guard, and pass negative-work reversal plus body-frame steering
falsification: reject if capture or the early milestone class is lost, head path or distance integral regresses beyond sampled repeat spread, either joint's 90/99-percent rate residence or bend margin worsens, peak force or yaw moment rises above the predictive sample, or either wake view loses the coherent target-directed traveling-wave class

## Expected evaluation signature

The useful signature is capture near the predictive sample's timing with no
loss at the `10/8/6L` milestones, posterior rate residence and bend no worse
than `6.52%/34.7 deg`, and lower or equal peak loading through a smoother
reversal. A faster scalar score alone is insufficient. Because this worker's
CFD runs only after exit, these are hypotheses, not results.
