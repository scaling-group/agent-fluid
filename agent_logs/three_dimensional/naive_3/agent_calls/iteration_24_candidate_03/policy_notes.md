# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the Phase 2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and finite dynamics. I inspected both rows of the combined sheets
  from release to termination for the strongest finite result
  (`solver_101212af2a5e`, horizon) and the assigned-parent failure
  (`solver_b4f7ad49610a`, lower exit). The top-down vorticity rows show that
  both fish self-propel on the same useful diagonal first approach and shed an
  alternating coherent street. The oblique body/Lambda2 rows confirm compact
  three-dimensional wake structures rather than passive advection, collapse,
  collision, or instability. The parent continues downward and leaves at
  `31.416T`; the geometry-released C-turn instead makes repeated target-return
  loops and preserves a structured wake through the `100T` horizon.
- The C-turn is the first sampled semantic improvement in this branch. Against
  the parent's `2.539/8.433/9.189L` minimum/mean/final distances and lower exit,
  it reaches `2.346/4.714/3.902L` and the horizon. It also reduces
  anterior/posterior acceleration-clamp residence from about `0.746/0.350` to
  `0.718/0.104`. Its first-pass minimum at `17.891T` remains a powered lateral
  miss (`0.692U`, local flow about `(-0.019,-0.002)U`), so propulsion and
  stability are not the missing capabilities.
- The new failure is a bounded orbit, not the inherited lower-exit topology.
  After the first pass, distance grows to about `5.8L`, returns to about
  `3.2L`, and then cycles around roughly `3--4.3L`; it never beats the first
  `2.346L` minimum. During most of those loops the normalized target-forward
  projection is negative, the C-turn selector is fully active, speed stays
  near `0.6--0.7U`, and the signed target-ray/course mismatch remains roughly
  `1.4--2.1 rad`. Thus simply holding the same-sign anterior/posterior C-bend
  does not rotate the powered trajectory inward far enough for capture.
- Inherited evidence closes more moment residuals, phase-half-cycle edits,
  scalar drive relief, and static shared bends: the assigned parent's
  course-selected moment rejection regressed below the `2.326L` phase scaffold
  and retained the lower exit, while earlier posterior amplitude attenuation,
  one-sided phase reset, target-behind damping, and shared course curvature all
  preserved their failure classes. The untested change supported by both that
  history and the horizon trajectory is a recovery-only actuator-topology
  switch from a C-bend to a differential posterior counterstroke.

## Policy hypothesis

Start from the complete horizon-producing geometry-released C-turn, preserving
its first-pass oscillator, acute-bearing cruise curvature, alignment envelope,
posterior brake, proximity-localized lag modulation, full-direction recovery
selector, carrier contraction, and command reserve. Add one bounded recovery
follow-through: while the target is deeply behind and the translational course
remains misaligned with the target ray, retain the C-turn targets but add a
bounded posterior acceleration toward the opposite side. The slow body-frame
course error sets the counterstroke sign and magnitude; the existing
backward-target selector
makes it absent on release and the evidenced first approach. This realizes a
state-selected C-to-S transition, intended to turn the thrust vector inward
without adding a clock, hidden stage, route, command boost, or another
posterior amplitude cut.

Support requires preservation of the coherent inbound wake and first-pass
progress plus capture, a materially smaller return-loop radius, a new minimum
below `2.346L`, or better mean/final distance. Reject the mechanism if it loses
the horizon/return topology, changes release or first approach materially,
creates a tight local curl, collapses the wake, increases clamp/load residence,
or preserves the same `3--5L` orbit without a closer return.

```text
bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish asymmetric-flapping control
source_mechanism: a strong whole-body C-bend initiates a nonsteady redirect, then a bounded posterior counterstroke follows observed directional response while rhythmic propulsion remains available
transferable_invariant: when a productive recovery C-bend leaves persistent signed route error, change posterior actuation differentially rather than holding more common-mode curvature or retuning drive
nontransferable_details: species-specific C-start stages, exact counterstroke phase, published gains, dimensional beat frequency, robot duty ratios, prescribed waveforms, vortex phase, capture radius, and task-specific routes
policy_translation: normalized body-frame backward-target geometry gates recovery, while normalized target-ray/course error adds a bounded reflection-equivariant opposite posterior acceleration under the two-joint state-feedback contract
falsification: reject if release or first-pass progress changes, the coherent horizon/return topology is lost, a tight curl or higher clamp/load residence appears, or the return radius and minimum distance remain materially unchanged
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Trace replay and dry
controller probes performed after the edit can establish selector locality,
reflection equivariance, finite outputs, parameter ownership, and bounds, but
cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate starts from the sampled horizon-producing C-turn and adds only
the recovery counterstroke. Deep backward-target geometry and agreement
between lateral target sign and target-ray/course error softly gate an
opposite-sign posterior acceleration capped at `8 rad/T^2`; it neither changes
the anterior C-turn nor raises the existing `+/-28 rad/T^2` command reserve.
There is no explicit time, step count, mutable state, world coordinate, route,
flow-file access, or command boost.

Counterfactual selector replay on the completed horizon trace gives mean/max
counterstroke magnitude below `7e-23 rad/T^2` during the first `2T` and below
`2e-9 rad/T^2` through its sampled first-pass minimum. After `18T`, its
mean/max magnitude is `2.911/6.082 rad/T^2`, with magnitude above `1 rad/T^2`
on `65.4%` of inherited recovery states. Direct controller replay therefore
leaves the inherited anterior/posterior clamp fractions unchanged at about
`0.718/0.104` while producing a material recovery-only action. These are dry
selector measurements on fixed inherited states, not a coupled-flow forecast.

All `36` direct controller parameters are returned by
`target_policy_params()`. Representative approach and deep-recovery states
mirror to exactly negated actions with zero floating-point residual; the
candidate differs from the horizon parent by less than `2e-9 rad/T^2` through
the inherited minimum, and an extreme finite probe remains finite and respects
the command reserve. The mandated Julia contract and solver editable-boundary
checks pass, and an explicit schema audit finds `36/36` referenced parameters
declared. The root guidance checker is obstructed before semantic comparison
by the rendered README listing the identical assigned parent twice; the
unchanged checker passes against a temporary deduplicated view linked to the
actual notes, guidance, and parent evidence, and that view was removed. Formal
CFD was not run.
