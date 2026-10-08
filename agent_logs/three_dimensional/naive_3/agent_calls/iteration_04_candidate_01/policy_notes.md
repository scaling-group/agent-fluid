# Wake-policy candidate notes

## Assigned, sampled, and visual evidence

- The assigned parent is `optimizer_72ea68ac2cad`, whose durable guidance is
  still the fresh-lineage contract. Its inherited logs nevertheless contain
  completed experiments for the common seed, posterior bearing/trend curvature,
  a failed two-joint center shift, posterior yaw feedback, and posterior
  half-cycle relief. The four current sampled evaluations extend that record.
  Every sampled rollout is a valid direct-uniform still-water trial with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, so the visible motion and
  wakes are self-generated rather than ambient advection.
- The strongest finite sample is the body-frame lateral-slip controller
  (`solver_fc78cfbb9251`). Both rows of its combined sheet show a persistent
  propulsive mechanism: the top-down view develops a long alternating signed
  vorticity street, and the oblique view resolves coherent three-dimensional
  Lambda2 structures along the same path. It reduces distance from `12.328L`
  to `2.960L`, with mean distance `7.684L`, and survives to `26.637T`; this is
  materially better targeting than the static bearing/trend carrier's
  `9.141L` minimum and `13.129T` upper exit.
- The lateral-slip sample still does not capture. Its top-down release-to-exit
  sequence bends past the lower target and finishes in a broad clockwise/upward
  departure, while the oblique row shows that the wake remains energetic rather
  than collapsing. At `12T`, distance is `6.675L` and bearing is nearly centered
  (`-0.036 rad`), but body-frame lateral velocity is already about `+0.644U`, so
  the slip term requests a strong recovery before position error grows. By the
  closest point near `17.70T`, bearing has reached about `-0.971 rad`; the fish
  then recedes and exits the upper boundary at center `(4.438,15.200)L`, final
  distance `7.786L`. Thus sensing improved the trajectory, but a saturated
  posterior mean-bend request did not produce enough prompt redirect.
- The phase-referenced yaw-rate sample (`solver_311802a10433`) supplies a useful
  contrast. Its two views retain an alternating wake and a nearly horizontal
  course; it changes the terminal boundary from upper y to left x and reaches
  `4.361L`, but it passes above the target, exits at `(0.795,14.205)L`, and has
  worse mean/final distances (`9.520/9.921L`) than the lateral-slip sample.
  Removing beat-synchronous yaw can stabilize a course without making that
  course target-directed, so replacing slip with a stronger yaw servo is not
  supported.
- The static bearing/trend and half-cycle-relief samples exit the upper boundary
  early at `13.129T` and `12.551T`, with minima `9.141L` and `9.855L`. Inherited
  logs also show that moving the anterior oscillator center reduced its motion
  to roughly `8 deg` and worsened final distance to `13.403L`, while tail-only
  half-cycle variants did not improve termination. These negative results rule
  out another static-offset, joint-center, or half-cycle gain edit.
- On the recorded lateral-slip trajectory, the preserved posterior carrier
  reaches about `31 deg` before the additional `12 deg` mean steering bend. Raw
  action requests already exceed the acceleration envelope frequently. The
  evidence therefore favors reallocating posterior wave authority during a
  demanded redirect, rather than increasing curvature or propulsion gains.

## Policy hypothesis

Preserve the sampled lateral-slip controller's zero-centered anterior
state-feedback oscillator, target-bearing/slip turn signal, posterior lag, and
`12 deg` mean-curvature limit. Add one bounded response-gated wave-shape
mechanism: use the magnitude of that same normalized turn command to reduce the
oscillatory posterior carrier smoothly, while leaving the requested mean bend
unchanged. Full alignment restores the carrier continuously; a saturated turn
request retains half of it. This makes the mean bend a larger fraction of the
tail motion exactly when the sampled controller is already asking for recovery,
without changing the anterior center, adding a clocked stage, increasing peak
curvature, or memorizing a route.

The next rollout should preserve the initial coherent wake and useful leftward
surge, then begin the post-crossing redirect before bearing reaches about
`-1 rad`. Useful evidence would be capture, a closest approach below `2.960L`,
or a better termination with lower late upward drift. Falsify the mechanism if
posterior relief destroys wake coherence or material x progress, increases
limit occupancy, or retains the same upper-boundary exit without a closer or
longer target-directed trajectory.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction control
source_mechanism: preserve a rhythmic propulsive scaffold, but shift authority from the oscillatory tail wave to bounded mean curvature while a large observed turn response is demanded, restoring the wave as alignment returns
transferable_invariant: target-relative steering and propulsive rhythm can share limited actuator authority continuously; large body-frame turn demand should favor redirect curvature, while small demand should favor the full traveling carrier
nontransferable_details: published gains, species-specific C-start shapes, dimensional cadence, clock phase, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: retain the joint-state anterior oscillator and bearing-minus-lateral-slip posterior mean bend; multiply only the lagged posterior carrier by a bounded function of the same normalized turn-command magnitude
falsification: reject if wake coherence or surge collapses, actuator-limit occupancy worsens, or the controller still exceeds roughly `-1 rad` bearing and exits the upper boundary without beating the `2.960L` sampled closest approach
