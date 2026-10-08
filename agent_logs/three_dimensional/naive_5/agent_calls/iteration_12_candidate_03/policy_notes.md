# Terminal C-bend recoil candidate

## Visual and trace diagnosis before the edit

- All sampled and inherited evaluations are contract-valid direct-uniform
  still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  The
  top-down vorticity and oblique Lambda2 rows show body-attached alternating
  wakes translating with the fish, so the long approaches are self-propelled
  rather than moving-window advection.
- The strongest sampled finite rollout, `solver_4f3d51f38935`, keeps that
  coherent wake through a `0.832836L` closest approach and low peak planar
  force/yaw moment (`0.02142/0.00979`), then passes the target and exits left.
  Its deeper same-sign terminal bend reaches about `-24.1/-25.0 deg` at the
  minimum, but the center still moves near `0.662L/T`; added static curvature
  therefore does not supply the missing course-normal impulse.  The
  informative `solver_b6ed3f84ab58` failure stays in the upper corridor,
  touches the posterior `45 deg` boundary, and raises peak force/moment to
  `0.212/0.0968`, ruling out more posterior authority justified by
  acceleration headroom.
- The assigned-parent logs sharpen the terminal mechanism boundary.  A
  closing-gated deeper two-joint target reached `0.827823L`, only `0.002005L`
  better than the earlier `0.829828L` low-load near miss and still outside the
  `0.75L` capture circle.  The subsequent anterior bearing-divergence reflex
  regressed to `0.831781L` with the same coherent pass-by topology.  It changed
  only joint 1 on `330` frozen baseline states and did not turn its predicted
  response deficit into a course correction.
- The other inherited completed terminal branch supplies a complementary
  negative control: slip-gated posterior-only recovery retained the same
  visual route but reached only `0.846679L`.  Thus deeper static C-bends,
  anterior-only phase pulses, and posterior-only S-bend recovery have each
  failed.  Near closest approach both joints are instead nearly settled in
  the same-sign C-bend while speed remains about `0.66L/T`; the untested
  actuator semantic is a coordinated release stroke, not another one-joint
  or scalar edit.

## Policy hypothesis

Recover the evaluated response-released, terminal-miss-vetoed controller
outside the capture approach.  While the fish is still closing on an unsafe
projected intercept inside `1.75L`, use measured two-joint bend attainment to
blend the redirect tracker into one bounded C-to-S recoil: straighten the
anterior joint toward neutral and reverse the posterior joint only modestly to
the opposite side.  As the C-bend unloads, the attainment gate removes the
recoil and returns control to the established redirect/carrier without a
clock, latch, or hidden stage.  This combines the two joints as one traveling
power stroke; it does not increase the far-field oscillator or hold a deeper
mean bend.

The falsifiable expectation is an unchanged far trajectory and coherent 3D
wake, followed by a target-side translational impulse before closest approach
and a first head crossing inside `0.75L`.  Reject the mechanism if it does not
beat `0.827823L`, changes body yaw without reducing projected miss, repeats
the posterior-only `0.846679L` path, touches an angle boundary, or materially
increases actuator-limit residence, force, or moment beyond the low-load
near-miss class.

bookshelf_consulted: true
source_domain: biological C-start burst turning and reactive traveling-wave propulsion
source_mechanism: release an attained C-bend through a coordinated anterior-unbend and posterior-reversal power stroke rather than holding static curvature
transferable_invariant: once bounded preparatory curvature is established, course change requires a dynamic two-joint recovery stroke that accelerates fluid laterally while the target intercept is still unsafe and closing
nontransferable_details: published gains, full-body C-start timing, species-specific envelopes, dimensional beat frequencies, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame distance, projected miss, positive closing speed, and observed bend attainment smoothly blend the two redirect trackers toward a neutral anterior joint and a modest opposite posterior target
falsification: reject if capture fails to beat the `0.827823L` reference, course does not rotate toward the target, the far carrier changes, or wake coherence, angle clearance, loads, or limit residence materially worsen

## Non-CFD implementation audit

Replaying the sampled `solver_4f3d51f38935` trajectory through its policy and
this candidate changes `750` of `7234` frozen-state actions, all between
`0.833L` and `1.748L`; there are zero differences at or beyond the `1.75L`
approach boundary.  The largest component change is `3.025 rad/T^2`, and
frozen-state acceleration-clamp incidence is unchanged (`2687` joint-samples
for each policy).  A direct zero-speed/zero-error state returns `(0,0)`, and
reflecting lateral target, velocity, yaw, joint angle, and joint velocity
negates both commands exactly (maximum algebraic error `0`).  These checks
establish locality, material activation, boundedness, and reflection
equivariance only; they do not predict the new CFD trajectory or claim a
same-worker improvement.
