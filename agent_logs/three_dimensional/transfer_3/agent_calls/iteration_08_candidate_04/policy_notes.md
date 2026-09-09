# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct` initialization with
  zero background velocity, no cylinders, and no prewarm. The combined sheets'
  top-down rows show alternating reverse-wake streets and their oblique rows
  show finite three-dimensional Lambda2 structures, so the motion is
  self-propelled rather than advected.
- The phase-conditioned yaw-residual reference has the best finite score
  (`-7.550`) and retains a coherent carrier, but rises from about `13.75L` to
  `15.34L`, exits the upper boundary at `16.77T`, and never gets closer than
  `5.658L`.
- Full-course release reaches `4.358L`; raw-slip and phase-separated-slip
  variants reach `4.158L` and `4.128L`. Their wake remains coherent and local
  flow stays small, yet all cross the target x station about `4.1--4.4L` high
  and continue to a left-domain exit. The inherited parent logs also preserve
  the same left-exit class for the latter two and a later regression with only
  `8.507L` minimum/final distance, so the lineage has no successful semantic
  release to retain.
- The two closest variants already increase posterior excursion to about
  `0.578 rad` and commanded posterior acceleration to about `124--125 rad/T^2`,
  versus `0.463 rad` and `88.7 rad/T^2` for the better-scoring reference.
  More posterior mean-curvature authority or another recoil coefficient is
  therefore not supported: it spends more command without changing the
  left-exit topology.

## Policy hypothesis

Preserve the evidenced joint-state traveling-bend carrier and use the
low-speed-gated, body-frame target-course error as the slow turn request.
Replace the posterior mean-curvature/yaw-rate loop with a bounded half-cycle
amplitude asymmetry: enlarge the posterior carrier half-cycle on the requested
turn side and shrink the opposite half-cycle, while keeping both sides active.
This tests a different steering actuator rather than another scalar change to
the failed mean-curvature structure. It should lower the target-station
crossing and avoid the repeated left exit without erasing the alternating wake.
Reject the mechanism if the target-line height/termination does not improve,
if the posterior joint approaches its hard limit, or if either wake row loses
the coherent propulsive street.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and averaging models
source_mechanism: target-feedback modulation of asymmetric flapping half-cycles
transferable_invariant: route error can steer a rhythmic swimmer by smoothly strengthening the useful bend half-cycle and weakening the opposite one while preserving oscillation
nontransferable_details: published gains, clock-driven phase, robot geometry, species kinematics, dimensional frequency, and prescribed routes
policy_translation: normalized body-frame target and velocity course form a bounded turn request; observed joint state identifies posterior carrier side and applies bounded reflection-equivariant half-cycle scaling
falsification: reject if target-line height and left-exit topology persist, posterior saturation increases, or top-down and oblique evidence shows weakened propulsion
