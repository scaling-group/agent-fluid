# Multi-wake candidate diagnosis

## Evidence read before the edit

- Three sampled policies are exact copies of the prefilled controller and
  deterministically reach the target after `137.357` released units with
  `4.184L` mean distance, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. The fourth
  sampled policy differs only by always applying bearing-rate damping; it
  still captures but takes `149.605` units, has `4.358L` mean distance and
  `96933` energy, and raises the three RMS metrics to
  `0.13206/15.49/308.48`. Positive closing-speed qualification is therefore
  part of the useful route scaffold, not a scalar detail to retune.
- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. The released sheets show both
  sampled policies actively redirecting down and upstream, retaining an
  alternating posterior-lagged bend, crossing the merged wake on a broad arc,
  and entering the target from the right. The faster policy's upstream head
  displacement is `-10.914L`; its mean streamwise body velocity is `-0.0791`
  versus mean local flow `-0.0542`, confirming self-propulsion rather than
  passive advection. No sampled failure sheet is available, so the slower
  finite capture is the visual regression comparator.
- Diagnostics put the faster policy's anterior acceleration at
  `30.846 rad/time^2` against the `31.416` hard limit. Its remaining broad,
  jagged wake crossing is therefore not evidence for stronger gait or steering
  gains. The assigned parent's completed response-gated moment residual and
  smooth route-plus-moment arbitration both retain capture but regress arrival
  to `149.490` and `223.746`, mean distance to `4.428L` and `6.429L`, energy to
  `97418` and `144686`, and all crossflow/load metrics. Other inherited logs
  show posterior route asymmetry also regressing capture to `196.317`. These
  negatives support preserving route ownership, direct moment sign, anterior
  steering allocation, and the unmodified posterior wave.

## Policy hypothesis

Make one new feedback-topology change to the replicated scaffold: retain the
complete target route and direct bounded moment residual, but let the rhythmic
amplitude yield slightly to the magnitude of that same normalized yaw load.
This is a compliance mechanism rather than another route residual or actuator
gain. With zero moment it is exactly the sampled oscillator; with strong moment
it reduces both half-cycles by a bounded fraction while preserving their
target-directed asymmetry, zero mean, joint-state phase, and posterior lag.
The expected effect is less active bending piled onto large wake torque, fewer
anterior cap contacts, and a smoother crossing without surrendering the
direct moment correction that prior arbitration variants weakened.

bookshelf_consulted: true
source_domain: adaptive wake swimming and sensor-modulated robotic-fish CPG control
source_mechanism: compliant rhythmic actuation that yields some active amplitude to strong hydrodynamic loading while retaining direction tracking
transferable_invariant: preserve slow body-frame route ownership and the alternating propulsive wave, but bound active gait amplitude as normalized measured load grows instead of cancelling every wake-induced motion
nontransferable_details: trout Karman-gait phase, muscle-activity levels, published CPG gains, dimensional frequencies, species kinematics, robot linkage geometry, exact vortex timing, cylinder coordinates, and task-specific routes
policy_translation: use the magnitude of the already normalized and sign-evidenced `moment_z_L2` signal to reduce the common oscillator amplitude by at most a candidate-owned fraction; keep its signed residual in the existing anterior half-cycle turn request and leave the posterior target unchanged
falsification: reject if capture is lost or delayed beyond the replicated 137.357-unit trajectory, upstream displacement or alternating bends weaken, the lower excursion widens, or mean distance, command effort, crossflow, force, moment, and anterior cap contact do not improve together

The new CFD result is unavailable until this worker exits and is not claimed as
evidence here.
