# Candidate diagnosis and policy hypothesis

## Evidence read before the candidate decision

- All four sampled rollouts and the assigned-parent rollout use direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and active moving-window shifts. Their motion is released-swimmer
  self-propulsion, not ambient advection or reused-flow contamination.
- I inspected both rows of the combined keyframe sheets for the best-scoring
  sampled capture (`0.74939L`) and the assigned parent's full-band intercept-
  release failure (`1.37249L`). The capture lays down a coherent alternating
  mid-plane street and compact bilateral oblique Lambda2 structures while
  closing on the target. The failure keeps the same qualitative traveling
  wake and active beat through closest pass, then turns below the target and
  exits the lower boundary. The failure is terminal path geometry rather than
  carrier collapse, weak propulsion, background transport, or instability.
- The two exact speed-reserve samples capture at `0.74796--0.74939L` after
  `18.205--18.601T`; the posterior-pulse sample captures at `0.74797L` after
  `18.199T`; and the prefilled unsafe-terminal anterior-transfer sample
  captures at `0.74923L` after `18.749T`. Inherited evaluations nevertheless
  show that baseline, posterior-pulse, yaw-brake, bearing-recovery, phase-
  observer, mean-curvature, and full-band-release variants can all preserve an
  active wake while reverting to lower-side misses. A threshold capture is
  therefore not robust evidence without an exact-policy repeat.
- The anterior-transfer capture retains the sampled scaffold envelope: peak
  speed `0.9215L/T`, peak planar force `0.0310`, peak yaw moment `0.0159`,
  action clipping `68.8%/70.8%`, and exact speed-limit residence
  `10.7%/11.6%`. Its top-down and oblique sheets remain organized through
  capture. This supports compatibility of spatial steering reallocation, but
  one run does not support increasing its transfer, adding actuator-pressure
  scheduling, or stacking another terminal observer.
- The assigned parent's full-band geometry veto is the informative negative
  comparison. It kept the propulsive wake active and improved its inherited
  closest-pass comparison to `1.37249L`, but still exited below at `32.571T`
  with final distance `10.669L`. Expanding or tuning response-release geometry
  is not the supported next step.

## One candidate hypothesis

Retain the exact prefilled
`dogfish3d_unsafe_intercept_anterior_transfer_v1` bytes (SHA-256
`1f096756052e0b0e8f0bf820c5d0063c63dda48138e68b2a6c0d99fdcd9a3592`)
as the sole candidate and obtain the required independent repeat. The policy
preserves the evaluated achieved-course route command, traveling-bend carrier,
response estimator, cadence, sparse outward-carrier reserve, and total
additive steering authority. Only when the existing normalized terminal
projection is capture-incompatible does it move a bounded steering share from
the posterior propulsive joint to the anterior steering joint.

Expected test: reproduce capture while preserving the active two-view wake and
the sampled speed, force, moment, clipping, and joint-speed envelope. An exact
repeat is more discriminating here than changing a coefficient or adding a
second unevaluated mechanism: it tests whether the new spatial allocation
survives the same direct-uniform rollout variability that falsified earlier
single and multiple threshold captures.

Falsification: reject this allocation after an exact miss, upper/lower branch
divergence, wake weakening, changed far-field closure, or actuator/load metrics
outside the speed-reserve envelope. If rejected, do not tune the transfer
fraction or stack the failed observer/release residuals; test a genuinely
different steering realization.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: separate anterior redirection from a posteriorly lagged propulsive wave and release redirection from observed target-relative motion
transferable_invariant: preserve the posterior traveling bend while applying bounded target-directed steering through the anterior spatial channel
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, fixed coordinates, and task-specific routes
policy_translation: retain the normalized body-frame projected-miss and approach gates that transfer only capture-incompatible terminal steering anteriorly while keeping total steering authority and the two-joint state-feedback carrier unchanged
falsification: reject on any exact-repeat miss, loss of wake coherence, far-field divergence, miss-side change, or actuator and load excursion beyond the sampled scaffold envelope
