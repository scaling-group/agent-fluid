# Candidate diagnosis and hypothesis

## Visual and trace diagnosis before the edit

- All sampled and inherited evaluations are contract-valid direct-uniform
  still-water rollouts (`U_infinity=[0,0,0]`, no prewarm) and terminate at the
  left virtual boundary without capture. In both rows of their combined
  sheets, alternating top-down vorticity and oblique Lambda2 structures trail
  the translating body. The useful approach and the failures are therefore
  self-propelled, not ambient or moving-window advection.
- The assigned prefill (`solver_4f3d51f38935`) is the strongest sampled
  trajectory despite its lower scalar score: it maintains a coherent,
  low-load wake, leaves the high corridor, and reaches `0.832836L` at
  `27.473T`. Peak planar force and yaw moment are about `0.02142` and
  `0.00979`, with no angle-limit contact. At `1.75L` its speed is `0.648L/T`,
  closing speed is `0.465L/T`, and projected miss is `1.218L`; at the minimum
  speed has risen to `0.662L/T` while projected miss remains `0.806L`. Thus
  the fish carries excess translational momentum through an otherwise stable
  capture-scale approach.
- The sampled posterior-redistribution failure (`solver_b6ed3f84ab58`) stays
  in the upper corridor, reaches only `5.386L`, touches the joint-angle limit,
  and produces peak planar force/yaw moment near `0.2124/0.0968`. This rules
  out simply spending more posterior amplitude or acceleration headroom.
- The assigned parent's response-deficit anterior half-cycle residual is now
  completed evidence: `solver_e61dcc1b4221` reaches only `0.831067L`, retains
  `0.664L/T` at closest approach, and has the same coherent pass-by topology.
  The inherited complete curved-gait reactivation likewise regresses to
  `0.875770L` with `0.654L/T` at its minimum. Together with the inherited
  static-depth, damping, isolated-joint, and recoil failures, these results
  show that restoring ordinary propulsive motion or another steering pulse
  does not rotate the velocity enough and does not shed approach speed.

## Policy hypothesis

Recover the response-released, terminal-miss-vetoed low-load controller rather
than the prefill's failed extra static depth. Preserve it outside a bounded
approach zone. While body-frame velocity shows both an unsafe projected miss
and excess positive closing speed, replace the settling redirect with a small
state-feedback oscillation about the calibrated same-sign mean bend, but make
the posterior deviation *lead* rather than lag the anterior deviation. This
reverses the propagation direction of the two-joint bend relative to the
tested propulsive curved gait. The intent is an active braking wave: reduce
forward/closing momentum early enough that the existing mean curvature has
more time to bring the head through the capture circle. The gate is continuous
in normalized range, miss, course observability, and measured closing speed;
it vanishes for a safe intercept or when excess closing has been removed.

The falsifiable expectation is an unchanged far trajectory and coherent wake,
then a measurable reduction from the inherited `0.65--0.66L/T` terminal speed
without the posterior-only load spike, followed by a minimum below
`0.827823L` or capture. Reject the mechanism if speed at closest approach
remains above `0.63L/T`, the same left-domain pass-by persists, the route
changes before the approach gate, the wake loses coherence, an angle boundary
is touched, or force/moment and limit residence move materially toward the
posterior-redistribution failure.

bookshelf_consulted: true
source_domain: Taylor traveling-wave propulsion and sensor-scheduled robotic-fish gait modulation
source_mechanism: reversing the direction of a traveling bend reverses its momentum-transfer role, allowing a rhythmic gait to oppose rather than reinforce translation
transferable_invariant: when a coherent near-target pass-by retains excessive closing speed, change wave-propagation direction under measured approach error instead of adding more steering amplitude or damping a single joint
nontransferable_details: published gains, dimensional frequencies, full-body wave envelopes, species-specific phase lags, exact vortex phases, task coordinates, and prescribed maneuver timing
policy_translation: normalized body-frame range, velocity-target projected miss, course observability, and positive closing speed smoothly select a bounded anterior oscillation about the calibrated mean redirect with the posterior derivative lag sign reversed
falsification: reject if the terminal speed is not measurably reduced, the minimum does not beat `0.827823L`, capture does not occur, or far trajectory, wake coherence, angle clearance, loads, or actuator-limit exposure materially worsen

## Non-CFD implementation audit

Replaying the candidate and assigned prefill algebra on all `7234` frozen
`solver_4f3d51f38935` states changes `1076` actions, all at ranges
`0.8328--2.7493L`, with exactly zero difference at or beyond the `2.75L`
brake boundary. The largest component difference is
`15.4837 rad/T^2`; frozen-state acceleration-clamp incidence decreases from
`2687` to `2667` joint samples. Reflecting lateral target/velocity, heading,
joint angle, and joint velocity negates both commands exactly, and a
zero-speed state returns finite zero action. These checks establish material
activation, locality, boundedness, and reflection equivariance only; they do
not predict whether reverse propagation will brake the coupled CFD trajectory
or claim a same-worker improvement.
