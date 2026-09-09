# Response-released recovery candidate

## Evidence diagnosis before the policy edit

- The four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and finite dynamics. I inspected the combined sheets
  for the assigned horizon parent (`solver_101212af2a5e`) and the informative
  closest lower-exit failure (`solver_0620d96874f3`), including both the
  top-down mid-plane vorticity and oblique body/Lambda2 rows. Both fish
  self-propel from rest and retain coherent alternating planar and compact 3D
  wake structures. Neither passive advection, wake collapse, collision, nor
  numerical instability explains the miss.
- The three sampled alternatives all remain powered through the lower boundary
  near `31--32T`, with minimum distance `2.326--2.539L`, scored mean distance
  `8.424--8.434L`, and final distance near `9.2L`. Inherited logs show that
  phase-gate broadening, posterior half-cycle attenuation, a one-sided phase
  reset, static differential bends, and a target-behind differential burst all
  retained that failure class. More drive, another phase/amplitude edit, or a
  scalar proximity threshold is therefore unsupported.
- The assigned parent's full-direction C-turn is the first sampled semantic
  recovery success: it preserves the inbound wake, avoids domain exit, and
  survives to the `100T` horizon with mean/final distance `4.714/3.902L`.
  Its first-pass minimum remains `2.346L`, however, and the top-down and oblique
  sheets show broad repeated loops rather than capture. Recorded states confirm
  an orbit: after `20T` the target-behind selector averages `0.937`, speed stays
  about `0.62--0.66U` on later circuits, and target-ray/course error is still
  roughly `1.1--1.8 rad` on close return legs.
- The decisive release states are observable without history or a route. On
  the first pass at `17.891T`, distance is `2.346L`, normalized target-forward
  projection is `0.189`, lateral projection is `0.982`, and course error is
  `1.121 rad`. On the later return at `46.778T`, the corresponding values are
  `3.207L`, `0.137`, `0.991`, and `1.128 rad`. In both cases the target has
  only barely returned ahead while the translational course remains nearly
  tangential; the current selector has already released most of its recovery
  curvature. Geometry-only release is therefore premature in the response
  variable that matters for capture.

## Policy hypothesis

Preserve the complete assigned-parent scaffold and its evidenced
target-behind C-turn. Add one small compatible completion to that mechanism:
hold the same bounded recovery mode while the normalized target remains
strongly lateral and the target-ray/translational-course mismatch remains
large, even if the target has just crossed to the ahead side. The existing
body-frame target unit vector and velocity unit vector provide a continuous,
reflection-equivariant response gate; speed weighting removes the undefined
zero-velocity course. Recovery releases only when either lateral error or
course mismatch has actually fallen, then the original cruise/approach carrier
resumes. This changes the maneuver's feedback topology, not a scalar drive
gain, and adds no clock, stage counter, world coordinate, or memorized route.

Support requires preservation of the coherent inbound wake plus capture, a
smaller return-leg radius, or a material minimum/mean-distance improvement
without increased actuator/load residence. Reject the mechanism if it alters
far-field release, locks into a tighter noncapturing orbit, stalls or collapses
the wake, raises saturation, or produces the same `3--5L` loop with only a
scalar score change. Formal coupled CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish direction tracking
source_mechanism: large observed directional error holds a bounded curvature maneuver until measured geometric response permits release back into the propulsive rhythm
transferable_invariant: release a strong target-relative redirect from observed course alignment rather than from target-side geometry alone
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequencies, robot duty ratios, exact vortex phases, capture radius, and task-specific routes
policy_translation: normalized body-frame lateral target projection and target-ray/course error extend the existing two-joint recovery blend only until translational response aligns
falsification: reject if cruise wake or release changes, saturation or loads rise, capture radius is not approached more closely, or the parent orbit merely tightens without capture or better mean distance
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. After editing, trace replay and
dry controller probes may establish only selector locality, response
sensitivity, reflection equivariance, finite outputs, schema ownership, and
command bounds.

## Implemented candidate and non-CFD probes

The candidate changes only recovery release on the assigned-parent policy. A
quadratic speed gate and a bounded `0.60` maximum response share prevent the
new hold from replacing the target-behind onset or consuming the command
reserve. Counterfactual selector replay on the completed parent trace gives a
mean/maximum response hold of less than `1e-6/5e-6` during the first `2T` and a
mean below `0.00011` through `12T`. At the recorded first and return passes the
hold is `0.312` and `0.299`, respectively, versus old target-behind weights of
only `0.0007` and `0.0026`; across later ahead-but-lateral states it averages
`0.267`. Thus the selector is negligible during evidenced cruise but material
at the diagnosed premature-release boundary.

Direct controller replay at those two recorded states changes the parent
actions from `(19.82,-2.33)` to `(2.62,-23.90)` and from `(20.76,1.41)` to
`(4.26,-22.63) rad/T^2`. This is a material two-joint recovery continuation,
yet both commands remain below the declared `+/-28 rad/T^2` reserve; an earlier
uncapped form that drove the posterior command to the clamp was rejected before
handoff. These are local algebraic probes, not integrated body/fluid evidence.

All direct `params.FIELD` references are owned by
`target_policy_params()`. Mirrored target, velocity, joint, bearing, and yaw
states return exactly negated actions; zero-speed, zero-target, and extreme
finite probes remain finite and bounded. The mandated guidance, lightweight
Julia contract, and solver editable-boundary checks pass after the final edit.
