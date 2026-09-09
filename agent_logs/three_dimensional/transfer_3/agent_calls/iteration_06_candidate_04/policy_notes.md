# Candidate diagnosis and policy hypothesis

All four sampled rollouts satisfy the direct-uniform still-water contract with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm, so their translation and
wakes are self-generated. I inspected both rows of the combined keyframe sheets
for the assigned seed (`solver_97bc3c03d55b`), the strongest finite score
(`solver_adc862529891`), the closest-approach regression
(`solver_b22e8cf1f277`), and the course-response failure
(`solver_7108cd3d3374`). The useful fast carrier forms a long alternating
top-down vortex street and compact oblique Lambda2 structures without visible
wake collapse. The route, rather than propulsion, remains the failure: the
strongest score exits the upper boundary at `y=15.20L`; the two more advanced
steering variants reach `4.158L` and `4.358L` but pass the target roughly
`4.2--4.5L` above it, then continue through the left boundary.

The sampled policy comparison separates the remaining problem from a scalar
curvature adjustment. A one-joint phase-conditioned yaw residual reaches
`5.658L`; two-joint yaw-recoil projection plus slip reaches `4.158L`; and a
direct target-versus-velocity course loop reaches `4.358L`. All three retain
the coherent `28 degree`, `0.55T` carrier, but all actuate steering through a
persistent posterior equilibrium offset and leave the same uncaptured
left-going trajectory family. The inherited half-cycle experiment is not a
counterexample: it simultaneously weakened the carrier to `20 degree`,
`0.70T`, advanced only to `12.195L`, and exited upward, so it did not isolate
asymmetric steering on the evidenced propulsive gait.

Instantaneous body-lateral velocity is also strongly beat-contaminated. Across
the strongest, closest, and course-response samples its RMS is
`0.353U`, `0.307U`, and `0.385U`. The common rate-only projection
`v_y + 0.11*phi_dot1 - 0.04*phi_dot2` reduces those residuals to approximately
`0.128U`, `0.105U`, and `0.125U`, respectively. The candidate therefore keeps
the fast joint-state traveling bend unchanged, compares normalized body-frame
target course with this phase-conditioned measured course, and translates the
bounded course error into posterior half-cycle amplitude asymmetry rather than
another mean-curvature/yaw-rate loop. Positive initial course error strengthens
the positive posterior-wave half-cycle, retaining the calibrated
positive-bend-to-negative-yaw sign; the imbalance reverses continuously when
the measured course crosses the target course.

Expected evidence: retain the long coherent wake and strong world-minus-x
translation, but turn the travel course downward early enough that center y
falls materially below the `13.7--14.0L` closest-approach band of the two best
geometric near misses. Falsify the mechanism if the upper exit recurs, if the
trajectory remains nearly horizontal and passes more than `4L` above the
target, if asymmetry destroys the alternating wake, or if minimum distance
does not improve beyond `4.158L`. The current candidate's CFD result is not yet
available and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric flapping
source_mechanism: sensor-gated half-cycle amplitude asymmetry superposed on a propulsive rhythm
transferable_invariant: preserve the state-driven traveling wave while persistent observed course error makes one beat side slightly stronger, with the imbalance vanishing or reversing at alignment
nontransferable_details: published gains, clock-driven phase, linkage geometry, species-specific envelopes, dimensional rates, exact vortex phase, and task-specific routes
policy_translation: compare normalized body-frame target course with phase-conditioned body-frame velocity course, then use the bounded error to scale the two sides of the posterior state-feedback wave on the preserved two-joint carrier
falsification: reject if the coherent carrier weakens, initial steering has the wrong sign, the same more-than-4L high pass and left exit remains, or closest approach does not beat 4.158L
