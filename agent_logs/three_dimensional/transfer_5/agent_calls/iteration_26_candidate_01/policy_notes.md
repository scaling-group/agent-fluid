# Candidate diagnosis and hypothesis

The sampled rollouts are valid direct-uniform still-water evaluations with
`U_infinity=(0,0,0)` and capture termination. The top-down and oblique rows of
the combined sheets show self-propulsion rather than advection: by `5T` the
fish has formed a compact alternating wake, by `9--18T` the vortex street is
coherent and trails the moving-window fish, and by `23T` the fish bends toward
the target without wake collapse. The split-observer sample
`solver_8ae803ceeb4c` and v33 comparator `solver_2546ece173ab` are visually
nearly indistinguishable, so the small terminal metric changes—not vortex
appearance—are the relevant evidence.

The split observer captured at `23.8370T` with score `-0.535013`, mean/final
distance `2.433468/0.746096L`, inside-`3L` mean absolute yaw `1.67938 rad/T`,
mean absolute target-cross-track speed `0.23868U`, and peak moment `0.013581`.
Relative to v33 at `23.8425T`, `-0.535091`, `2.433543/0.746165L`,
`1.67999 rad/T`, `0.23924U`, and `0.013730`, it is a narrow useful improvement,
although peak yaw rises from `3.18484` to `3.19386 rad/T`. Two independently
written split-observer samples have bit-identical CFD trajectories and three
sampled sheets share the same keyframe hash; these repeats establish a stable
baseline rather than a reason for another observer-gain change. The inherited
negative result that sent the distributed rate into both terminal roles
regressed to `23.8700T`, score `-0.536789`, and mean/final distance
`2.434939/0.747952L`, so the continuous course observer must remain
anterior-only.

Policy hypothesis: retain all route feedback, response-released redirect,
smooth command projection, split terminal observers, anterior-only terminal
correction, and posterior traveling-wave target. The remaining correction
selects its half-cycle from posterior tangent displacement alone, even though
the terminal yaw peak occurs during a fast beat. Add a bounded state-derived
quadrature term `(phi_dot[1]+phi_dot[2])/omega` to the normalized posterior
tangent used only by that half-cycle selector. This predicts the approaching
tail side without a clock and should begin the already successful anterior
counter-curvature earlier, reducing peak terminal yaw/moment without changing
course authority or posterior wave generation.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric half-cycle turning
source_mechanism: infer oscillator phase from displacement-velocity quadrature and modulate only the useful half-cycle
transferable_invariant: joint displacement and normalized joint velocity provide a body-intrinsic phase predictor without elapsed time
nontransferable_details: published CPG gains, clock phase, species-specific envelopes, exact wake phase, and prescribed routes
policy_translation: add one bounded normalized full-tail rate quadrature to the existing posterior-tangent phase gate while preserving the split observers and two-joint carrier
falsification: reject if capture is lost or delayed beyond the split baseline, mean/final distance regresses, the coherent alternating wake changes, peak yaw or moment rises, or joint/command feasibility worsens

