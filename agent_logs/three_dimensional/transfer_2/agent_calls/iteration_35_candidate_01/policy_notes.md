# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled episodes satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`, no prewarm) and capture without instability. No
  inherited optimizer log is present in this rendered workspace, so the parent
  guidance and the four solver evaluations are the available completed
  evidence.
- In both rows of the combined sheets, the fish is self-propelled rather than
  advected: alternating top-down vorticity and compact oblique Lambda2
  structures emerge behind the bending body from quiescent release. The wake
  remains coherent through the smooth target-directed turn and capture; there
  is no visible collision, domain-exit precursor, or out-of-plane failure.
- `solver_1d05d22ea1fe` is the strongest finite example. Its far-only release
  of negative-work carrier reversal captured at `15.939T`, score `0.061891`,
  distance integral `1.82008L`, and head path `13.107L`. Peak planar force/yaw
  moment were `0.03477/0.01715`; anterior/posterior residence above 90% of the
  rate limit was `17.70/8.25%`.
- `solver_f997a0c1ad0f` is the most informative negative mechanism comparison,
  though it also captures. Releasing the redirect boost from same-sign yaw
  response retained the same coherent two-view topology but delayed capture to
  `16.247T`, raised the distance integral to `1.82240L`, lengthened head path to
  `13.363L`, and raised mean command norm from `23.82` to `24.70 rad/T^2`
  relative to `solver_1d05d22ea1fe`; peak load and rate residence did not
  materially improve. The response-gated redirect should therefore be removed,
  not gain-tuned.
- The byte-identical all-distance reversal-release repeats
  `solver_0e3ccca5bc77` and `solver_0e82a9e35a2a` captured at
  `16.088/16.071T` with `13.129/13.166L` paths. They slightly lowered anterior
  above-90%-rate residence to `17.50/17.52%`, but neither establishes a timing,
  integral, or path gain beyond the far-only handoff. Together with the parent
  lesson, this rejects both a hard distance-only rule and unconditional
  all-distance release as portable explanations.

## Policy hypothesis

Start from the strongest sampled full-redirect scaffold. Preserve its
target/closing drive relief, phase steering, traveling-wave allocation, and
common carrier guard. Replace only the hard `6--4L` withdrawal of
negative-work reversal release with a continuous normalized body-frame demand:
same-sign measured yaw may release reversal only as the velocity-course
redirect magnitude becomes resolved. This distinguishes an already aligned
approach (retain phase-coherent joint braking) from a still-needed redirect
(subordinate the carrier to steering) without time, coordinates, or a
distance-only stage.

Expected evidence is retained capture and coherent wakes, early milestones no
worse than the sampled useful class, a path near or below `13.13L`, and reduced
variation or no regression in anterior rate residence versus the far-only
handoff. Falsify the mechanism if it returns the slower all-distance class,
recreates the `13.363L` hook, loses capture, increases load or joint-limit
residence, or disrupts either wake view.

bookshelf_consulted: true
source_domain: biological nonsteady turning and sensor-modulated robotic-fish CPG control
source_mechanism: response-gated C-start-like redirect followed by release into a propulsive traveling wave
transferable_invariant: prioritize bounded steering while directional response is unresolved, then continuously restore the propulsive wave when measured response and course alignment appear
nontransferable_details: species kinematics, published gains, clocked CPG phase, exact vortex phase, dimensional frequency, and task-specific routes
policy_translation: use bounded target bearing, body-frame velocity-course error, recent yaw response, and joint work sign to apply one common negative-work carrier-release factor under the existing two-joint state-feedback contract
falsification: reject if capture timing and distance integral do not beat repeat variation or if path, rate residence, joint margin, force/moment peaks, or coherent top-down and oblique wakes regress
