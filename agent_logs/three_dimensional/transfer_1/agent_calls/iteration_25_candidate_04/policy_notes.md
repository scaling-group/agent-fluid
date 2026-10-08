# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled rollouts report `uniform_direct` initialization,
  `U_infinity=[0,0,0]`, no cylinders, finite dynamics, and `capture`.  Thus
  motion in the sheets is self-propulsion rather than imposed advection.
- The strongest finite sample is v41 (`solver_11077d57175e`): capture at
  `17.9190 T`, score `-0.09321`, and total/observed distance integrals
  `1.97941/1.36531 L`.  Relative to the byte-identical sampled v38 baseline
  (`solver_641b8157ca11` and `solver_6536c01c9e7e`), v41 is closer by
  `0.0227/0.0767/0.1045/0.3625/0.3160 L` at `2/4/8/12/16 T` and captures
  `0.3135 T` earlier.  The v39 reverse-spillover sample is also slower at
  `18.1940 T` with a `2.01039 L` total integral.
- In the top-down rows, v38 and v41 develop a coherent alternating vortex
  street behind the body and turn continuously toward the target; neither
  shows the wasteful lateral escape or wake collapse of an unstable route.
  The readable v38 oblique row shows compact alternating three-dimensional
  Lambda2 structures following the tail.  The v41 oblique row is black, so it
  cannot establish preservation of that 3D structure; this is a visual-evidence
  limitation, not evidence of an absent wake.
- The v41 gain is not free effort reduction.  Relative to v38, maximum speed
  rises from `0.9519` to `0.9675 L/T`, any-joint acceleration-limit residence
  rises from `41.60%` to `44.01%`, and peak normalized force/moment rises from
  `0.03068/0.01579` to `0.03182/0.01608`.  However, posterior acceleration-limit
  residence remains only `5.74%` versus `38.34%` anterior, leaving a specific
  posterior allocation opportunity.  The inherited score-only logs at
  `-0.12978` and `-0.13370` lack trajectories and therefore do not justify a
  competing mechanism.

## Candidate hypothesis

Preserve v41's carrier, steering, crossflow pose confidence, and response-
gated posterior launch.  Add one smooth, locally phase-even allocator
only to the extra launch wave scale.  Its state is the product of the bounded
de-meaned tail tangent and tail-tangent velocity: positive while the posterior
wave moves outward and negative while it returns.  A small even modulation
concentrates launch emphasis in the outward portion without changing route or
redirect mean curvature and without using time, an exact vortex phase, or a
world-frame route.  On an approximately symmetric beat its mean multiplier is
near one, so this tests phase allocation rather than a scalar carrier increase.

Expected result: retain capture and the v41 checkpoint lead while improving
early/middle closure or reducing capture time without materially exceeding
v41's speed, saturation, force, or moment envelope.  Falsify the mechanism if
capture or any `4-16 T` checkpoint regresses, the alternating wake loses
coherence, the readable 3D view degrades, or the action/load envelope grows
without a distance-integral benefit.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and state-feedback robotic-fish wave-shape modulation
source_mechanism: posterior tail kinematics dominate useful reactive thrust, while state-observed phase can allocate rhythmic authority without a clock
transferable_invariant: preserve a traveling bend and concentrate only incremental propulsion in useful posterior motion while retaining bounded target feedback
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body kinematics, exact vortex phases, and prescribed routes
policy_translation: smoothly modulate only v41's response-gated posterior launch scale with normalized de-meaned two-joint tail pose times normalized tail velocity
falsification: reject if v41 capture, route checkpoints, wake coherence, or its established speed, saturation, force, and moment envelope regresses
