# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=0`) and terminate by leaving the virtual domain rather than by
  capture. Their combined sheets show self-propulsion and an initially coherent
  alternating top-down wake with compact three-dimensional Lambda2 structures;
  the motion is not passive advection.
- The anterior-only mean-curvature base reaches `5.033L` at `17.56T`, then
  crosses below the target and exits the lower boundary at `9.084L`. From
  `14--20T`, its mean bearing is about `1.178 rad`, mean joint angles are
  `+0.153/-0.014 rad`, and mean recent turn rate is only `+0.074 rad/T`: the
  separated zero-mean tail avoids the earlier opposite tail bias but the
  propulsive strokes largely cancel net redirect authority.
- Bearing-gated posterior carrier relief is the strongest sampled finite
  variant. It preserves the alternating wake, reduces rate-limit occupancy
  from about `14.3%` to `9.7%` and acceleration-limit occupancy from about
  `68.6%` to `47.8%` (both joints pooled), and improves closest approach to
  `4.233L` at `19.25T`. It still misses and exits low at `9.176L`; near closest
  approach bearing is `1.292 rad` while heading changes little on average.
- The assigned response-unloaded prefill reaches `4.376L`, but its top-down and
  oblique rows lose the developed wake late in the rollout. The trace confirms
  gait quenching: after about `20T`, joint 1 settles near its `0.14 rad` center,
  joint 2 near zero, and joint speed, force, and moment decay almost to zero
  before a lower exit. A yaw-response residual that can bring the autonomous
  joint-state oscillator exactly onto its moving equilibrium is therefore not
  a safe redirect mechanism.
- Target-signed slip unloading retains the strong alternating wake and reaches
  `4.252L`, but retains the same lower-exit topology and high saturation. It
  does not improve on the simpler tail-relief variant.
- In the large-bearing portions of the two propulsive base traces, joint-1
  motion toward the requested curvature side coincides with desired-sign
  instantaneous heading rate (about `-1.19 rad/T` with tail relief), while the
  away stroke produces almost equal opposite heading rate (about
  `+1.25 rad/T`). This cancellation is the specific deficit targeted here.

## Policy hypothesis

Start from the evidence-leading anterior-center/posterior-relief controller.
Keep zero posterior mean and the existing body-frame bearing/slip steering.
When bearing is large, redistribute the evidenced relief base's mean posterior
authority: strengthen the lagged carrier while joint 1 moves toward requested
curvature and deepen relief on the cancelling return stroke. The half-stroke
discriminator is normalized joint rate,
`turn_request * qd1 / (omega * amplitude)`, so it is reflection-equivariant and
contains no clock or route memory. This should make the already observed
desired-yaw half-stroke hydrodynamically stronger without increasing the
anterior drive, increasing mean large-bearing carrier authority, or returning
to failed shared/tail-biased static curvature. Replaying this algebra over the
strongest sampled trace predicts posterior acceleration-limit occupancy close
to the symmetric-relief base rather than the unrelieved carrier.

Falsify the mechanism if it quenches or disorders the staggered wake, increases
limit occupancy/load spikes beyond the unrelieved base, loses the `4.233L`
closest approach, or preserves the large-bearing lower-exit topology without a
materially stronger negative mean turn response.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: make the turn-producing half-cycle hydrodynamically stronger than the cancelling half-cycle
transferable_invariant: use observed gait phase and target-signed geometry to distribute propulsive authority asymmetrically across the two half-strokes
nontransferable_details: published gains, clock-driven CPG phase, robot-specific tail envelopes, species kinematics, and prescribed routes
policy_translation: use normalized joint-1 rate times bounded body-frame turn request to redistribute large-bearing posterior carrier authority from the cancelling half-stroke to the desired-yaw half-stroke
falsification: reject if wake coherence or closest approach degrades, saturation/load spikes return, or net yaw and lower-exit topology remain materially unchanged
