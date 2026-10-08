# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled solvers are byte-identical v44 policies with byte-identical
  trajectories and keyframe sheets.  Each reports direct uniform still-water
  initialization at `U_infinity=(0,0,0)`, captures at `24.557514T` and
  `0.747654L`, and has score `-0.447654`.  There is therefore no distinct
  sampled failure image; the applicable failure contrast is the inherited v42
  and v43 coupled-allocation evidence, not an invented visual comparison.
- In the top-down row the fish self-propels from `12.328L` through a coherent
  alternating wake, makes a broad target-directed approach, and finishes with
  a tight curved hook through the capture circle.  The downstream vortices
  remain regularly spaced rather than collapsing into a standing lateral
  wiggle.  The oblique Lambda2 row independently shows compact alternating
  three-dimensional packets shed behind the tail through `24T`, with no
  visible vertical escape or wake breakdown immediately before capture.
- Metrics agree with the visual reading.  Relative to the replicated v41
  control, v44 first changes the anterior command only at `22.269T/1.846L`,
  advances capture from `24.640015T`, improves mean distance from `2.347937L`
  to `2.347238L`, increases crossing margin from `0.001644L` to `0.002346L`,
  and reduces raw-acceleration/any-rate exposure from `73.594/13.839%` to
  `73.393/13.617%`.  Peak lateral force falls from `0.03169` to `0.02893`,
  peak yaw moment stays in the `0.01559` class, and posterior hard-stop
  occupancy remains zero.  Thus anterior approach commitment is useful and
  the carrier/wake should not be replaced.
- A paired fixed-trace comparison evaluates v44 and the proposed mechanism on
  the same reconstructed normalized observations.  The collision-course
  commitment becomes active only after `22.264T`.  During active terminal rows
  the posterior joint is
  frequently close to its negative stroke reserve (ending at `-0.7646 rad`,
  about `-43.8 deg`) while the remaining negative route-steering acceleration
  points farther outward.  The braking reserve removes much of this request,
  making it a narrowly evidenced candidate for withdrawal rather than for
  redistribution to the anterior phase anchor.  This distinction respects the
  v42/v43 negative results for cross-joint headroom transfer and anti-windup.

## Policy hypothesis

Preserve v44's anterior collision-course hold and every far-route term.  Under
the same normalized body-frame range, closing-speed, and projected-miss gate,
attenuate only the posterior additive route-steering component aligned with
the posterior joint's current outward stroke side.  Form the alignment
continuously from posterior angle divided by the existing stroke scale and
route steering divided by the existing steering envelope.  Leave posterior
carrier acceleration, terminal phase residual, inward route correction,
stroke braking reserve, and rate coasting unchanged.  This is a new joint-local
allocation mechanism, not a scalar retune or an extension of the hold to all
posterior authority.

The paired parent-trace audit predicts changes in 209 of 4464 evaluated input
states, first at `22.264T`; all changes are confined to the established
`2.10L` approach neighborhood.  Maximum posterior command difference is
`3.181 rad/T^2`, while late changes shrink to roughly `0.004 rad/T^2` where the
existing braking reserve already dominates.  Formal CFD must falsify the
hypothesis: reject it if capture or crossing margin is lost, if the far route
changes, if posterior hard-stop/rate exposure or peak loads regress, or if the
coherent two-view wake is disrupted.  Later reflected or perturbed tests must
also reject it if the outward component proves necessary for course recovery.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological terminal-approach control
source_mechanism: preserve a traveling propulsive wave while reducing only the steering asymmetry that is counterproductive in the terminal regime
transferable_invariant: separate posterior propulsion from bounded steering and withdraw only state-observed outward steering after a safe closing course is established
nontransferable_details: published gains, species kinematics, exact vortex phase, dimensional timing, and task-specific routes or offsets
policy_translation: use normalized body-frame range, closing speed, projected miss, posterior joint angle, and the owned steering envelope to taper only outward posterior route steering
falsification: reject on lost capture or margin, changed far trajectory, worse stroke/rate/load class, disrupted coherent wake, or failed reflected and perturbed-course recovery
