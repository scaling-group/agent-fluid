# Candidate diagnosis and hypothesis

All four sampled rollouts report direct uniform quiescent initialization,
`U_infinity=(0,0,0)`, no capture, and `left_domain`; there is no prewarm
artifact to explain their motion. In the strongest finite example,
`solver_ab59732b5ad0`, the top-down row shows a sustained alternating wake and
leftward self-propulsion, while the oblique Lambda2 row confirms a coherent 3D
vortex train through `16.88T`. Its target-versus-course posterior curvature
reduces distance from `12.328L` to a `6.218L` minimum, but the trajectory bends
back toward positive world y and exits at center y=`15.201L`, ending at
`6.272L`. The trace agrees with the image: body-frame lateral course is about
`0.70 rad` near exit while bearing has reversed to about `-1.29 rad`; the
controller therefore requests the corrective tail-bend limit, but posterior
acceleration is already at the envelope in about 61 percent of samples.

The prefilled half-cycle scaler, `solver_e7d052036feb`, visibly curls upward
more sharply and reaches only `11.778L` before an `8.80T` upper exit; its
two-sided strengthening/weakening rule still holds posterior action at the
limit in about 43 percent of samples. The relative-crossflow posterior bias
(`solver_b8cb71a4fd97`) and the one-sided acceleration-lobe policy
(`solver_b80f3041d568`) retain propulsion but reach only `10.883L` and
`11.448L`, respectively. Thus course feedback is the useful observation in
this sample, while two-sided half-cycle amplification is a negative result.

Policy hypothesis: preserve the strong example's anterior oscillator and
target-versus-inertial-course mean-curvature loop. Add one state-phase gate
that attenuates only the posterior wave component opposing the requested turn;
never amplify the aiding lobe. This should free posterior angle/acceleration
headroom when the course has crossed the target line, retain an unmodified
traveling bend when steering is small or the wave already aids the turn, and
remain reflection equivariant. Falsify it if the alternating wake disappears,
closest approach regresses from `6.218L`, posterior limit residence does not
fall, or the same positive-y upper exit occurs without an earlier course
reversal.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping and closed-loop direction control
source_mechanism: use observed directional error to modulate the propulsive rhythm, with bounded half-cycle asymmetry for turning
transferable_invariant: preserve the traveling bend while reducing only the oscillatory component that opposes the demanded turn
nontransferable_details: published gains, duty ratios, clock-driven CPG phase, species kinematics, exact wake phase, and task routes
policy_translation: derive target-versus-course error in the body frame, infer posterior wave side from joint state, and smoothly relieve only the opposing posterior component before adding bounded mean curvature
falsification: reject if wake coherence or the 6.218L closest-approach benchmark is lost, posterior saturation is not reduced, or the upper-exit topology persists without earlier lateral-course correction
