# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm artifact.
- The prefilled distance/closing allocator is self-propelled, not advected:
  its top-down row shows a coherent alternating wake from release through the
  first pass, and its oblique row shows persistent three-dimensional Lambda2
  structures. It reaches `1.7328L` at `22.81T` but retains about `0.7U` mean
  speed, bends only after the target has passed astern, makes a broad return
  loop, and exits at `52.48T` with `6.7926L` remaining. Thus propulsion and
  wake formation survive; insufficient timely redirect authority is the
  failure.
- Both observation-gated redirect examples remove that failure topology. The
  velocity-course-gated controller captures at `0.7493L` and `21.17T`; the
  yaw-response-gated controller captures at `0.7464L` and `21.22T`. In both
  combined sheets, the initially coherent wake is followed by a smooth
  target-directed arc rather than the parent's overshoot/loop, while the
  oblique row retains compact three-dimensional wake structures up to capture.
- The course-gated capture has the better sampled score (`-0.2853` versus
  `-0.2886`) and lower mean absolute joint commands (`18.65,18.04` versus
  `21.33,19.74 rad/T^2`). Both have zero residence above 90% of the joint-angle
  limit, comparable peak force coefficient (`0.025`) and peak moment
  coefficient (`0.013`), and about 35% command residence above 90% of the
  smooth `31 rad/T^2` bound. This favors the smaller course-gated redirect,
  while retaining command residence as a held-out robustness concern.
- The scalar-bearing failure also forms a coherent wake but exits after only
  `21.79T`, reaches just `5.3570L`, and spends `50--64%` of the rollout above
  90% of the command bound. Wake strength or larger scalar action alone is
  therefore not a substitute for a fore/aft-aware redirect.

## Policy hypothesis

Retain the evidenced state-feedback traveling-bend carrier and distance/
closing headroom allocator. Add one continuous terminal redirect driven by
the normalized body-frame mismatch between target direction and actual
velocity course. Gate it by proximity, observed speed, and course error; map
it to aligned bounded head bias and posterior curvature. This should reproduce
the sampled course-gated policy's timely turn and capture without a clock,
world coordinates, a memorized route, or a larger acceleration envelope.
Falsify the mechanism if formal evaluation loses capture, reproduces the
first-pass loop, destroys the coherent wake, creates joint-limit residence, or
materially exceeds the sampled command/load histories.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological C-start and closed-loop robotic-fish direction tracking
source_mechanism: strong bounded curvature for a large observed direction error, released as the measured response aligns with the requested course
transferable_invariant: redirect authority should grow with observed route mismatch and relax continuously with alignment while preserving the propulsive carrier
nontransferable_details: species-specific body envelopes, published gains, dimensional frequencies, exact transient timing, and task-specific routes
policy_translation: use normalized body-frame target and velocity vectors to gate aligned two-joint mean curvature inside the approach region, with joint-state oscillation retained and all commands softly bounded
falsification: reject if capture or first-pass radius does not improve over the allocator parent, or if wake coherence, command residence, joint limits, force, or moment regress
