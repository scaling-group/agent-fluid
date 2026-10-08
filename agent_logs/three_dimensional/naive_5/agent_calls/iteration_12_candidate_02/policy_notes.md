# Response-deficit anterior recovery-sweep candidate

## Visual and trace diagnosis before the edit

- Every sampled and inherited evaluation is a contract-valid direct-uniform
  still-water rollout (`U_infinity=(0,0,0)`, no cylinders, no prewarm).  In
  both rows of the combined sheets, the useful finite trajectories carry a
  body-attached alternating top-down wake and a three-dimensional oblique
  Lambda2 trail with the fish.  Their target progress is therefore
  self-propelled rather than moving-window advection.
- The sampled `solver_4f3d51f38935` is the strongest visible finite example:
  it preserves a coherent low-load wake on a broad downward approach and
  reaches `0.832836L`.  At closest approach it is still moving near
  `0.662L/T`; its body-frame projected miss is about `0.806L`, body/course
  slip is about `0.757 rad`, and correct-sign yaw has decayed to about
  `0.488 rad/T` while both joints have settled into a same-sign bend.  Peak
  planar force and yaw moment remain modest at about `0.0214/0.00979`, with no
  angle-limit contact.  The miss is a course-response deficit, not loss of
  propulsion or wake coherence.
- The informative `solver_b6ed3f84ab58` failure remains in the upper corridor,
  reaches only `5.386L`, touches the `45 deg` joint boundary, and raises peak
  force/yaw moment to roughly `0.212/0.0968`.  Its oblique row also shows a
  sharper late curl.  That rules out redistributing more half-cycle authority
  to the posterior joint.  The prefilled `solver_b3b6be8f076f` likewise
  latches into a low-response same-sign bend, reaches only `4.278L`, and exits
  the upper margin, so its strict intercept-release formulation is not the
  carrier to preserve.
- The inherited low-load terminal tests bound the remaining choice.  A
  slip-gated posterior recovery reaches `0.846679L`; the assigned-parent
  closing-gated depth result recorded in guidance reaches `0.827823L`; and an
  anterior same-side, bearing-divergence half-cycle reflex reaches
  `0.831781L`.  All retain `left_domain`, and the latter differs from the
  `0.829828L` response-released baseline by only `0.00195L` in the wrong
  direction.  More static curvature, posterior recovery, and continued
  same-side anterior pumping therefore do not survive as positive mechanisms.

## Policy hypothesis

Recover the low-load response-released, terminal-miss-vetoed controller used
by the inherited near-capture lineage, without the failed same-side terminal
reflex.  Add one different feedback primitive: while the fish is closing in
the capture approach, the projected course remains unsafe, the target bearing
is diverging on the requested turn side, and joint 1 has attained the
same-sign redirect bend, blend only the anterior redirect tracker toward a
small opposite-side recovery target.  This state-selected counterbend unloads
the settled C-bend and can generate a new lateral impulse; its own reduction
of bend attainment removes the sweep without elapsed time or mutable state.
Joint 2 retains the evaluated redirect, and all far-field carrier, entry, and
release expressions remain unchanged.

The falsifiable expectation is the same broad downward, coherent, low-load
trajectory with an earlier course rotation and a first head crossing inside
`0.75L`.  Reject the mechanism if it does not beat the inherited `0.827823L`
minimum, merely changes body heading without reducing projected miss, repeats
the posterior-recovery pass-by, creates repeated bend/recovery chatter,
touches the angle boundary, raises limit residence or loads materially, or
changes the trajectory outside the approach zone.

bookshelf_consulted: true
source_domain: biological C-start recovery and sensor-modulated robotic-fish direction tracking
source_mechanism: a sensed failure of the initial turn bend triggers a bounded contralateral recovery stroke instead of holding the bend or pumping farther into it
transferable_invariant: preserve a productive carrier, but when a completed turn bend has not corrected line-of-sight response, use observed bend state and response error to select one self-terminating counterstroke
nontransferable_details: published gains, dimensional beat timing, full-body C-start stages, species-specific bend envelopes, robot linkage geometry, exact vortex phases, world coordinates, and task-specific routes
policy_translation: normalized body-frame range and projected miss localize the bad approach, signed bearing-window rate detects divergence, positive closing speed and anterior bend attainment gate a bounded opposite-side joint-1 tracker, and the posterior redirect remains fixed
falsification: reject if the minimum does not beat `0.827823L`, course miss does not shrink, the far coherent wake changes, the recovery chatters, or angle, speed, acceleration, force, or moment exposure materially worsens

## Non-CFD implementation audit

Replaying the candidate and the response-released baseline algebra on all
`7286` frozen inherited terminal-reflex trajectory samples changes `280`
commands, all at ranges `0.8318--1.7393L`; there are zero changes at or beyond
`1.75L`.  The largest component change is `4.365 rad/T^2`, mean changed-sample
L1 action difference is `1.589 rad/T^2`, and acceleration-clamp incidence is
unchanged at `2733` samples.  A zero-speed state remains finite, reflected
joint/target/velocity/yaw/bearing-rate state negates both commands exactly, all
direct parameter references are owned by `target_policy_params`, and the
prescribed guidance, lightweight Julia contract, and solver-boundary checks
pass.  These checks establish locality, boundedness, schema coverage, and
reflection equivariance only; they do not predict the unevaluated CFD result.
