# Clock-free carrier-energy floor for the replicated capture policy

## Visual and metric diagnosis before the policy edit

- All four sampled solvers are byte-identical direct-uniform still-water
  captures: `U_infinity=(0,0,0)`, no cylinders or prewarm, score
  `-0.1137286`, arrival `16.604496T`, distance integral `1.998146L`, crossing
  depth `0.743958L`, and 237 moving-window shifts. The assigned parent's two
  completed rollouts reproduce the same controller and outcome, so these
  copies are one deterministic behavioral result rather than independent
  robustness evidence.
- I inspected the complete combined sheet. From release to capture, the
  top-down row shows self-propelled left/down closure on a shallow arc and a
  coherent alternating mid-plane vorticity street. The oblique row shows
  compact alternating Lambda2 structures connected to the tail and traveled
  path. There is no passive advection, inherited wake, collision, domain exit,
  wake breakup, or numerical instability. Every available sampled and
  inherited sheet has the same image hash, so a distinct failure image is not
  available; the most informative changed-controller failures are therefore
  the completed metric contrasts preserved in the inherited notes.
- Those contrasts rule out revisiting the late route channels. Closure-
  qualified terminal yaw release kept capture and the same visible wake but
  regressed score/integral/crossing depth to
  `-0.1140375/1.998380L/0.744276L`. Carrier-correlated local-flow subtraction
  likewise retained capture but regressed to
  `-0.115121/1.999280L/0.745252L`, without a feasibility benefit. The sampled
  path is already only about `3.55%` longer than the initial straight-line
  head-to-target distance, and distance rises on only about `1.86%` of steps.
- The completed trace does expose a different, early deficit. Using the
  normalized mean-removed oscillator radius
  `hypot(q1-head_course_center, q1_dot/omega)/oscillator_amplitude`, the mean
  is only `0.304` during the first `1T` and `0.333` through `2T`; it is below
  `0.75` for `96.0%` of the first `4T`. Distance closes by only `0.314L`
  through `4T`, then by `0.927L` from `4T` to `6T` as the carrier becomes
  established.
  This is a measured carrier-build transient, not evidence for another
  terminal gate, target transformation, or scalar gain retune.

## Sole candidate and policy hypothesis

Add one bounded state-feedback mechanism to the sampled controller: compute
the phase-plane radius of the mean-removed anterior carrier and inject a small
negative-damping term only while that radius lies below a normalized energy
floor. The joint state supplies phase and amplitude, so the addition uses no
time, step, world coordinate, or memorized route. It vanishes continuously
above the floor; all target geometry, lateral/yaw demodulation, posterior
half-cycle steering, soft acceleration bounds, and the final-one-percent
speed guard remain unchanged.

Expected test: reach the established traveling-wave regime sooner, replace
part of the high-distance launch interval with productive closure, and retain
capture and the tail-connected two-view wake. The mechanism is falsified if it
does not reduce the high-distance transient and arrival/distance cost, or if it
changes the successful route class, loses capture, creates a disconnected or
violent startup wake, increases joint contact or near-limit residence, or
worsens effort, force, or moment. No CFD result for this candidate is claimed
here.

bookshelf_consulted: true
source_domain: state-feedback fish propulsion and sensor-modulated robotic-fish central-pattern generators
source_mechanism: regulate a rhythmic traveling carrier from its observed joint-state phase and amplitude while leaving slower route feedback separate
transferable_invariant: a propulsive oscillator can replenish a measured deep carrier-energy deficit using clock-free phase-plane feedback that becomes inactive once the productive traveling wave is established
nontransferable_details: published oscillator gains, dimensional beat frequencies, species or robot kinematics, prescribed phase histories, exact vortex phases, and source-task routes
policy_translation: preserve the evaluated body-frame two-joint route and posterior wave controller; add a bounded anterior acceleration term proportional to joint velocity and a normalized carrier-radius deficit below a parameter-owned floor
falsification: reject the transfer unless it shortens the measured low-radius high-distance launch transient while preserving capture, alternating tail-connected wake, route topology, joint feasibility, effort, force, moment, and score

## Evidence boundary

The positive evidence belongs to completed sampled and parent rollouts, and
the negative terminal/flow contrasts belong to inherited completed logs. This
workspace contributes only a candidate hypothesis; its formal CFD evaluation
occurs after exit.
