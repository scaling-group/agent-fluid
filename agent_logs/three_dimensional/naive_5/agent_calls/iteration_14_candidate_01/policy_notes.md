# Terminal reverse-wave braking candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In both the
  top-down mid-plane vorticity row and the oblique body/Lambda2 row, alternating
  structures remain attached to a translating fish.  The progress is therefore
  self-propelled rather than ambient or moving-window advection.
- The strongest sampled approach, `solver_4f3d51f38935`, carries a coherent
  low-load wake through a broad downward route, reaches `0.832836L`, and then
  continues left at about `0.66L/T`.  Its top-down frames show a strong curved
  wake near the target at `31T` followed by a regular alternating street at
  `39T`; the oblique row likewise retains organized three-dimensional vortices
  across the pass.  The inherited trace diagnosis puts projected miss near
  `0.806L` while both joints are nearly settled into the same-sign redirect.
  This is a terminal velocity/intercept problem, not wake collapse or weak
  propulsion.
- The informative `solver_b6ed3f84ab58` failure stays in the high corridor,
  touches the posterior `45 deg` boundary, and exits the upper margin at
  `26.043T` after reaching only `5.386L`.  Its approximately tenfold larger
  peak planar force/yaw moment (`0.212/0.0968`) and sharper late body/wake curl
  rule out spending more posterior half-cycle headroom on steering.
  The assigned prefill `solver_12fc3441a636` is also self-propelled and
  low-load, but its yaw-rate closure exits the upper margin at `20.790T` with
  only a `6.268L` approach, so it is not the route carrier to preserve.
- The assigned-parent logs add two completed negative results absent from the
  older sampled sheets.  A coordinated C-to-S recoil reached `0.830575L`; a
  small ordinary traveling wave reactivated about the terminal C-bend
  regressed to `0.875770L`.  Together with the inherited `0.827823L` best
  static-depth result, `0.828153--0.831781L` anterior recovery tests, and
  `0.846679L` posterior recovery, these results close deeper curvature,
  one-joint recovery, one-shot recoil, and renewed forward-wave propulsion as
  semantic improvements.  None changed `left_domain` termination.

## Policy hypothesis

Recover the sampled low-load, miss-vetoed two-joint redirect and its far
carrier, removing its unsupported terminal depth increment.  Only while the
fish is close, still closing, and on an unsafe projected intercept, replace
the settling redirect by a small oscillation about the same mean bend whose
posterior derivative term has the opposite sign from the forward carrier.
This reverses phase propagation through the two joints without changing the
calibrated steering side.  Smooth range, miss, and closing gates make the
brake vanish outside the capture approach, after passage, or once the
projected intercept is safe; observed joint state supplies phase, with no
clock, latch, or route coordinate.

The falsifiable expectation is the same broad, coherent, low-load far route,
followed by a measurable reduction from the roughly `0.66L/T` approach speed
and a head crossing inside `0.75L`.  Reject the mechanism if it does not beat
the inherited `0.827823L` minimum, if velocity direction and magnitude do not
improve despite a visible reversed terminal wave, if the far route changes,
or if angle contact, load, limit residence, or wake disorder move toward the
posterior-redistribution failure.

bookshelf_consulted: true
source_domain: Taylor/Lighthill reactive traveling-wave propulsion and continuous terminal approach control
source_mechanism: the direction of a phase-lagged body wave determines the direction of reactive momentum exchange, while near-target drive can be scheduled separately from far propulsion
transferable_invariant: after a productive redirect has settled but excess closing speed preserves an unsafe intercept, reverse the two-joint wave-propagation sign locally to oppose translation while retaining the evidenced mean steering bend
nontransferable_details: published gains, dimensional frequencies, full-body envelopes, species-specific kinematics, exact vortex phases, world-frame routes, and task coordinates
policy_translation: normalized body-frame range, projected miss from target/velocity cross product, positive closing speed, and observed joint state smoothly blend the mean redirect into a bounded anterior oscillator with a posterior lead rather than the carrier lag
falsification: reject if capture does not occur or minimum distance does not beat `0.827823L`, approach speed or projected miss does not fall, the far carrier changes, or wake coherence, angle clearance, loads, or actuator-limit exposure materially worsen

## Non-CFD implementation audit

Replaying the sampled `solver_4f3d51f38935` trajectory through its policy and
this candidate changes `750` of `7234` frozen-state actions, all between
`0.832836L` and `1.748091L`; there are zero changes at or beyond the `1.75L`
approach boundary.  The maximum component change is `8.4641 rad/T^2`, and
frozen-state acceleration-clamp incidence is unchanged at `2687` joint
samples.  Against the same baseline with only its failed terminal depth
increment removed, the reverse-wave mechanism itself changes `378` states at
`0.861817--1.748091L`, with a maximum component delta of
`9.1895 rad/T^2`, so the new semantic materially activates on the frozen
approach.  All candidate outputs are finite, a zero-speed/zero-error state
returns `(0,0)`, and reflecting lateral target/velocity, yaw rate, joint
angles, and joint velocities negates both commands exactly (maximum algebraic
error `0`).  These checks establish locality, activation, boundedness, and
reflection equivariance only; they do not predict the pending CFD result or
claim a same-worker improvement.
