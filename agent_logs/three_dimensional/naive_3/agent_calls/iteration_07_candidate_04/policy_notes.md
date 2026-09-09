# Course-response burst-redirect candidate

## Evidence-led visual diagnosis

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and finite `left_domain`
  termination. The combined sheets show self-propulsion rather than advection:
  both rows develop a persistent alternating wake behind the fish while the
  body travels from the upper-right release toward and then below the target.
- The best finite sample, the alignment-gated curvature carrier, reached
  `2.443L` at `17.869T`; full-direction posterior gating reached `2.494L`,
  distance-only drive relief `2.845L`, and amplitude-normalized slip/phase-lag
  modulation `2.822L`. All four then receded and crossed the lower boundary at
  roughly `30--31T`. The inherited scalar log adds the same lower-exit topology
  for a closing-response `7--12 deg` equilibrium redirect (`2.729L`) and a much
  worse direction-gated posterior half-cycle asymmetry (`3.661L`). Thus another
  drive gate, equilibrium-gain sweep, or posterior phase/asymmetry variant is
  not supported.
- The top-down rows show a long, coherent alternating vorticity street through
  approach and exit; the oblique Lambda2 rows likewise retain discrete 3D wake
  structures. The failure is not wake collapse or instability. Visually the
  route crosses below the target and never makes a decisive corrective turn.
  The full-direction trace quantifies that miss: distance falls to about
  `2.50L`, but from `15T` to `18T` body-frame direction error grows from about
  `0.80` to `1.62 rad`, target-ray closing speed falls from about `0.52` to
  `0.01 L/T`, and translational course error grows from about `0.81` to
  `1.55 rad` while speed remains about `0.65--0.75 U`. Continued propulsion is
  therefore carrying the fish across the target ray, not into the capture
  disk.
- Joint angles remain within the hard angle envelope and force/moment histories
  stay finite, but the best carrier already holds joint accelerations at the
  policy's `28 rad/T^2` clamp for about `0.746/0.354` of anterior/posterior
  samples. A useful redirect should reallocate the bounded waveform toward a
  mean bend rather than merely add acceleration or increase the clamp.

## Policy hypothesis

Preserve the evidenced `7 deg` full-direction cruise scaffold. Add one
course-response burst primitive: compute the signed angle between the normalized
body-frame target ray and measured translational velocity; when it has the same
sign as target-direction error, apply a bounded extra mean curvature. Balance
the larger mean bend by continuously shrinking the oscillatory wave envelope,
then restore the original traveling wave automatically as target and velocity
align. This is a memoryless, reflection-equivariant C-start-like redirect: it
is weak on the successful far approach, strengthens before the powered lateral
near miss, and releases from measured course correction rather than elapsed
time or a hidden mode. Formal evaluation should reject it if it damages early
progress or wake coherence, creates a tight curl or harder limit residence, or
retains the same `~2.4--2.8L` lower-boundary-exit topology.

bookshelf_consulted: true
source_domain: biological C-start and burst turning; sensor-modulated robotic-fish CPG direction tracking
source_mechanism: strong bounded curvature for a large observed direction error, followed by response-triggered release into the propulsive rhythm
transferable_invariant: allocate rhythmic authority temporarily to a bend when target geometry and measured velocity course agree that a miss is developing, then restore the traveling wave as course alignment improves
nontransferable_details: species-specific C-start shape and timing, published CPG gains, dimensional frequencies, exact wake phase, and task-specific routes
policy_translation: use normalized `target_body_L`, `distance_L`, and `velocity_body_U` to form reflection-equivariant direction/course errors; map their signed agreement to bounded two-joint mean curvature and complementary wave-envelope relief
falsification: reject if early target progress or 3D wake coherence degrades, joint-limit residence grows, a short-wake curl appears, or closest approach and lower-boundary termination remain materially unchanged
