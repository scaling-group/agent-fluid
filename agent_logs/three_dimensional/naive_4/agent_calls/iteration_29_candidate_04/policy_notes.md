# Candidate diagnosis and hypothesis

## Evidence diagnosis

- The assigned parent is the sampled `solver_07403e1ebc74` policy. It captures
  at `15.977511T`, final/minimum distance `0.744403L`, distance integral
  `1.928581L`, score `-0.045506`, and 238 moving-window shifts. The three other
  sampled policies are byte-identical copies of the no-recovery comparator and
  capture at `16.054371T`, `0.745846L`, distance integral `1.929840L`, score
  `-0.046900`, and 239 shifts. All report direct uniform still-water
  initialization with zero background velocity.
- In both combined sheets, the top-down row shows self-propelled target-directed
  translation and a coherent alternating vorticity sheet rather than passive
  advection; the oblique row shows paired three-dimensional Lambda2 structures
  remaining organized through capture. The parent and comparator are visually
  indistinguishable through the `4/8/12T` frames. Their only sheet-level
  difference is the terminal sampling time, so the parent's scalar gain cannot
  be claimed as a visibly stronger early wake.
- Trace cross-check narrows the effect. Relative to the comparator, the parent
  raises mean absolute posterior acceleration over `0-3T` from `19.476` to
  `22.522 rad/T^2` and mean forward speed only from `0.10835` to `0.10911U`.
  It delays the `8L` and `6L` milestones by `0.0165T` and `0.011T`, leaves the
  `4L` and `2L` milestones at the same logged times, then advances `1.25L` by
  `0.0385T` and capture by `0.0769T`. Across the whole rollout, posterior mean
  command, acceleration-limit residence, speed-limit residence, and peak
  lateral force rise from `24.585` to `25.473 rad/T^2`, `21.79%` to `22.58%`,
  `5.86%` to `6.30%`, and `0.03239` to `0.03334`, respectively.
- During the common first `5T`, forward body-force coefficient is aiding on
  about `57%` of samples. Time-aligned comparison shows the parent's blanket
  emphasis changes forward force by about `-2.1e-6` on already-aiding samples
  but by `+6.9e-5` on braking samples (`-2.0e-5` versus `+9.3e-5` over
  `0-3T`). This does not prove instantaneous causality, but it identifies a
  falsifiable response partition: the added posterior wave is most defensible
  while measured forward reaction is braking, not after thrust is already
  aiding.
- The inherited route-wide residual line-rate failure (`0.785816L` near miss,
  curl-away upper exit at `29.293T`, score `-10.1782`) remains the informative
  failure boundary. It rules out widening another steering residual. The new
  test therefore preserves every navigation and terminal expression and
  changes only the parent's low-speed propulsion supplement.

## Policy hypothesis

Keep the parent's normalized forward-speed recovery envelope, but admit its
supplemental posterior traveling-wave amplitude only through a smooth gate on
negative body-frame forward hydrodynamic force. Forward-aiding force releases
the supplement immediately to the proven carrier. This is response gating, not
a scalar gain retune: it tests whether tail emphasis can convert a braking
reaction interval without spending added authority on already-propulsive
intervals. It is reflection equivariant, bounded, has no clock or route memory,
and leaves mean curvature, redirect allocation, approach settling, and exact
actuator projection unchanged.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics supply a large share of reactive thrust, while measured response can modulate rather than replace the rhythmic carrier
transferable_invariant: add bounded posterior wave authority only while normalized propulsive response is deficient, and release it when forward reaction becomes aiding
nontransferable_details: published gains, species envelopes, dimensional frequencies, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: multiply the existing low-forward-speed posterior-wave supplement by a smooth gate on negative `-state.force_body_L[1]`; preserve the base two-joint carrier and all target-response steering
falsification: reject if early milestones or capture regress, the alternating two-view wake loses coherence, the gate merely reproduces the comparator, or command limiting and force/moment peaks worsen without distance-integral benefit
