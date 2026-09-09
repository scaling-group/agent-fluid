# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled episodes report `uniform_direct` initialization with
  `U_infinity=(0,0,0)`, no prewarm, and `capture`. The strongest scalar result
  is the exact speed-reserve policy in `solver_6b0e320e2f55` (`-0.15140`,
  `18.601T`, `0.74939L`); its same-byte sample `solver_33d16cad6362` also
  captures (`18.453T`, `0.74953L`). The posterior pulse
  `solver_591f46d260e7` arrives earlier (`18.200T`, `0.74797L`) but scores
  worse, while the anterior-transfer sample `solver_55f3a103ab95` arrives
  later (`18.749T`, `0.74923L`).
- In both combined visual rows, all four fish self-propel rather than advect:
  the body advances steadily toward the target while laying down a coherent,
  alternating top-down vortex street and bilateral oblique Lambda2
  structures from release through capture. No sheet shows carrier collapse,
  a gross yaw reversal, or a numerical/wake failure immediately before
  termination. The nearly identical visible trajectories make terminal
  response variability, not propulsion or wake production, the remaining
  control problem.
- The assigned guidance rejects further cadence relief, carrier suppression,
  projected-miss replacement, phase shaping, yaw observers, and fixed spatial
  allocation. Its exact speed-reserve evidence is mixed across inherited
  repeats: coherent capture approaches retain positive closing speed, whereas
  lower-exit repeats must cross zero closing speed after their `1.464--1.646L`
  closest passes. Sampled optimizer guidance sharpens that discriminator: the
  eight-row closing-speed minima below `4L` remain `0.202--0.644L/T` in the
  four current captures, while inherited logs include new lower exits at
  `1.240L` and `1.411L`.

## Policy hypothesis

Keep the assigned exact speed-reserve carrier, course error, intercept guard,
steering magnitude, and joint allocation byte-for-byte in their approach
roles. Add one terminal progress-loss response gate: only inside the existing
terminal region, smoothly veto turn-response steering release as normalized
body-target closing speed falls from zero to a modest negative value. This is
exactly inactive on every sampled capture approach, but restores the already
bounded geometry-signed steering after a closest-pass reversal and releases
again as positive closure returns. It adds no extra steering magnitude and
does not attenuate the traveling bend.

Falsify the candidate if it changes any sampled positive-closing first
approach, loses capture, retains the inherited below-target exit, weakens the
alternating top-down or oblique wake, creates static curvature/coasting, or
worsens clipping, speed residence, force, or moment beyond the repeat-backed
speed-reserve envelope.

bookshelf_consulted: true
source_domain: biological C-start/burst redirect and robotic-fish closed-loop CPG modulation
source_mechanism: geometry-requested redirect is sustained until observed response supports release into the propulsive rhythm
transferable_invariant: separate a persistent route request from a bounded response gate, and release redirect authority only after useful progress resumes
nontransferable_details: species kinematics, published gains and duty ratios, clock phase, exact vortex phase, and task-specific routes
policy_translation: use terminal distance and normalized body-target closing speed to veto the existing response release; retain the body-frame course command and two-joint traveling-bend carrier
falsification: reject if positive-closing capture approaches change, recovery does not improve the lower-exit class, or propulsion, wake coherence, loads, or actuator use leave the established envelope
