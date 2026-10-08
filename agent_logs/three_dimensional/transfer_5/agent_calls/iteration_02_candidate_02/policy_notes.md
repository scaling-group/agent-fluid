# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- All four sampled rollouts report `uniform_direct` initialization with inertial
  background velocity `[0,0,0]`; no prewarm/snapshot evidence is present.
- In both the top-down vorticity and oblique Lambda2 rows, sampled capture
  `solver_d594e3893325` builds a coherent alternating wake, preserves forward
  translation, and bends progressively into the target. It captures at
  `25.388 T` after reducing distance from `12.328 L` to `0.749 L`.
- The transferred seed `solver_24bf67867ea8` also self-propels with a coherent
  wake, but its descending arc crosses below the target: closest approach is
  `4.780 L` at `17.853 T` near center `(13.673,7.912)L`, followed by lower-field
  exit at `27.495 T` and `9.709 L`. Its raw command exceeds `1800 deg/T^2` on
  `97.9%` of samples and some joint is near the speed cap on `34.4%`.
- The assigned parent/prefill `solver_f578f8771e8a` eliminates raw acceleration
  exceedance with a response gate, polarity flip, and soft allocator, but both
  views show an early tight fold rather than useful translation. It improves
  only to `12.173 L`, reaches the tail-angle hard limit, and exits the upper
  field at `7.992 T` with distance `13.194 L`. Thus low saturation alone did
  not preserve the carrier's propulsive/steering semantics.
- The sampled capture is not evidence of efficient actuation: `83.1%` of its
  raw requests exceed the acceleration envelope and a joint is near the speed
  cap on `27.0%` of samples. The reusable result is capture topology, not a
  claim that its load history is optimal.

## Candidate hypothesis

Replace the parent response-gated polarity-flipped allocator with the sampled
capture's geometry-gated C-bend redirect. Large normalized body-frame target
error moves the oscillator center toward a same-sign anterior/posterior bend,
reduces drive amplitude, and reduces posterior lag; alignment continuously
returns the controller to the inherited traveling-wave carrier. This retains
the only sampled architecture with semantic capture while changing the
assigned parent from an early wrong-way fold to an evidence-backed redirect.
The expected result is the sampled smooth approach/capture class. Falsify the
transfer if the new evaluation fails to capture, reproduces an early boundary
exit, loses its alternating wake, or increases limit contact beyond the already
high sampled-capture levels.

bookshelf_consulted: true
source_domain: biological C-start/burst redirection and robotic-fish CPG posture modulation
source_mechanism: large observed heading error produces a bounded body-curvature redirect, then releases continuously into a posterior-emphasized traveling wave
transferable_invariant: separate a transient mean-curvature posture from cruise and gate its release by observed target alignment
nontransferable_details: published gains, species-specific C-start kinematics, dimensional cadence, exact vortex phase, and any fixed route
policy_translation: normalized body-frame bearing/vector error blends two observed-joint posture targets, drive-amplitude relief, and posterior-lag relief without time or world coordinates
falsification: reject if capture is lost, wrong-way folding or boundary exit returns, wake coherence collapses, or angle/speed/acceleration limit contact worsens
