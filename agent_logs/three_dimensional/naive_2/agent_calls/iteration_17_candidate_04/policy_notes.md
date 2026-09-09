# Restoring-half-cycle posterior terminal pulse

## Evidence diagnosis

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no prewarm, and no cylinders.  Both rows of each
  combined sheet were inspected.  The three capture sheets show self-propelled
  targetward motion with a compact, body-connected alternating mid-plane wake
  and a small coherent oblique Lambda2 wake; there is no imposed-flow
  advection.  The full-circle approach-braking failure initially makes useful
  leftward progress on a similar wake, but then curls upward, carries a broad
  curved wake across the target station, reaches only `4.64998L`, and exits the
  left boundary at `20.0337T` with distance back at `5.70592L`.
- The predicted-miss base captures at `16.0105T` and `0.74772L`.  The assigned
  posterior-pulse policy is byte-identical in the `solver_4a4abee43950` and
  `solver_d32fb3a02de7` samples and captures in both at `16.0435T/0.74934L`
  and `15.9830T/0.74998L`.  Their scores (`-0.03031`, `-0.02444`) straddle the
  base score (`-0.02805`), so these data support repeat semantic success and
  wake preservation, not a claimed scalar advantage of the pulse.
- The terminal histories remain phase-sensitive.  At capture, posterior rate
  is `-3.54 rad/T` in one repeat and at the `-4.538 rad/T` envelope in the
  other; direct trajectory aggregation puts each joint within `1%` of its rate
  envelope for about `13.2%` of both repeated captures.  The current
  `abs(qd1)` pulse is positive on both stroke directions.  Depending on
  instantaneous course-request sign it can therefore accelerate the posterior
  joint farther into its current rate or oppose it.  The compact wake and
  repeated capture argue against changing the far-field carrier, predictor,
  mean bend, or yaw-confirmed handoff.

## Candidate hypothesis

Retain the inherited composite exactly except for the phase detector of its
terminal posterior actuator.  Normalize the signed product of terminal turn
request and posterior joint rate by the carrier rate `omega*amplitude`, and
recruit the pulse only when its requested bend opposes the measured posterior
motion.  This is a reflection-equivariant, joint-state half-cycle gate: it
keeps the pulse available to arrest the wrong stroke and reshape the terminal
traveling bend, but removes same-direction pulse reinforcement that can spend
rate reserve.  Reject the mechanism if evaluation loses capture or the compact
alternating wake, worsens approach time/distance, pins a joint, or increases
rate occupancy or normalized force/moment relative to the sampled composite.

bookshelf_consulted: true
source_domain: robotic-fish CPG and asymmetric-flapping turning
source_mechanism: gate a bounded steering modulation by the observed beat half-cycle while preserving the propulsive rhythm
transferable_invariant: directional steering authority can be concentrated on one measured stroke direction instead of biasing both halves of the carrier
nontransferable_details: published duty ratios, oscillator gains, robot geometry, clock phase, and species-specific tail kinematics
policy_translation: use normalized posterior joint rate times body-frame terminal turn request to gate only the existing posterior pulse; retain the state-feedback carrier and two-joint acceleration contract
falsification: reject on lost capture, weaker target progress, wake decoherence, posterior pinning, increased rate occupancy, or larger normalized planar loads
