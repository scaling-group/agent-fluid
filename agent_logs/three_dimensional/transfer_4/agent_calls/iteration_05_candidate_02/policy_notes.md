# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The assigned parent is `optimizer_b6c231502e71`; no inherited
  `logs/optimize/` files were rendered in this workspace, so its curated
  experience and the sampled optimizer guidance are the available inherited
  reasoning. All four sampled solver rollouts report direct uniform still-water
  initialization (`U_infinity=0`) and capture. Three are byte-identical
  rate-governor policies with the same `-0.5127477615` score and `23.3640T`
  arrival; the weaker course-aligned/clamp policy scores `-0.5152774992` and
  arrives at `23.3585T`.
- Both combined keyframe sheets were inspected. In top-down view, the stronger
  and weaker captures self-propel along nearly the same closing course and shed
  a coherent alternating wake from startup through the late target turn; there
  is no visible advection, wake collapse, collision, or instability. In the
  oblique Lambda2 row, the posterior wake remains compact and alternating
  through `20T` and capture. No sampled failure sheet exists in this rendered
  population, so the lower-scoring capture is the most informative contrast,
  not a fabricated failure case.
- The quantitative difference is actuator use rather than wake topology. The
  selected rate governor lowers mean score-distance from `2.412601L` to
  `2.409486L`, center-path evidence in sampled guidance from `13.4189L` to
  `13.3177L`, peak speed from `0.75150` to `0.74281`, and eliminates sampled
  residence within `0.1%` of either joint-rate limit. It retains a substantial
  upstream carrier symptom: joint 1 is still above `96%` of the rate envelope
  for `15.68%` of samples, joint 2 for `3.58%`, while acceleration commands sit
  at the ceiling for `69.61%/50.68%` of samples. The visual wake and peak
  force/moment do not distinguish the variants.

## One candidate mechanism

Preserve the captured odd target-request-to-curvature map and the existing
direction-selective rate governor. Add one upstream, shared phase-energy
feedback to the state-only traveling-wave carrier: form a smooth gate from the
maximum observed joint speed normalized by the owned joint-rate envelope, then
apply common velocity-opposing damping to both carrier joints near that
envelope. The gate is inactive in ordinary phase motion and continuous at both
ends. Because the same damping coefficient acts on each joint while the
posterior target and lag construction are unchanged, this tests carrier-energy
regulation rather than a new route, a direction-specific steering branch, or a
scalar-only cadence change.

Expected result: preserve capture and the coherent alternating wake while
reducing residence above `96%` rate and reducing acceleration-ceiling residence
or mean command effort. Reject the mechanism if it loses capture, materially
worsens distance integral/path or arrival, raises force/moment peaks, or
degrades the posterior traveling wake. A lower rate statistic alone is not an
improvement if propulsion or target progress is lost.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control
source_mechanism: sensor feedback modulates the energy of a low-dimensional rhythmic carrier instead of replacing the carrier with raw high-frequency commands
transferable_invariant: condition a phase-preserving oscillator on bounded normalized joint-state feedback while retaining posterior lag and target-directed steering
nontransferable_details: published CPG topology and gains, dimensional beat frequency, robot or species kinematics, exact vortex phase, and task-specific routes
policy_translation: use max(abs(phi_dot))/owned_rate_limit to gate a shared smooth velocity-opposing damping term inside the two-joint state-feedback carrier; retain the measured odd body-frame target-to-curvature map and downstream reversal authority
falsification: reject if matched CFD loses capture or coherent posterior wake, fails to lower high-rate and acceleration-ceiling residence, or worsens integrated distance, path, loads, or arrival materially
