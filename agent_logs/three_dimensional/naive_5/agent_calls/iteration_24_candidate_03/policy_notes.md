# Target-policy candidate notes

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and terminate in capture.
  Three are semantically identical coordinated-envelope policies and reproduce
  `0.749242L` capture at `26.2955T`.  The assigned parent adds a near-goal
  course-response residual and captures at `0.749090L` at `26.3010T`.
- The combined sheets contain no true failed termination.  In both unique
  sheets, the top-down row shows genuine self-propulsion from rest, a coherent
  alternating vorticity street, and a late target-directed hook.  The oblique
  row shows a compact connected 3D Lambda2 wake through capture.  The wake
  trails the body through 252 inertial window shifts, so the motion is neither
  imposed-flow advection nor a moving-window artifact.  The assigned parent
  and its comparison are visually indistinguishable at the sampled keyframes.
- The parent retains the coordinated command envelope's useful safety result:
  zero sampled angle, exact speed, or acceleration-limit contacts, peak planar
  force/yaw moment `0.01883/0.00979`, and mean distance `2.51988L`.  Relative
  to the repeated comparison, however, its terminal course residual improves
  the first-crossing endpoint by only `0.000152L`, delays capture by one solver
  step, and changes mean distance by only `0.000105L`.  That is not a new
  success, termination class, useful route, or material capture funnel.
- The inherited logs make this a concrete negative result rather than an open
  scalar branch: terminal pulses, damping, recoil, deeper curvature,
  traveling-bend variants, instantaneous intercept suppression, and now an
  additional anterior course-response amplitude all preserve the same
  grazing-pass topology or regress.  A first-crossing endpoint within one
  `0.0055T` step of the `0.75L` threshold is not clearance evidence.
- A frozen-state audit identifies a different selector defect.  Below
  `1.75L`, the short-window line-of-sight steering side conflicts with the
  persistent body-frame velocity/target course side in `140/366` samples.
  Conflict falls to `11/139` below `1.10L` but returns in `11/47` samples below
  `0.85L`, including capture: projected miss remains about `0.704L` and the
  course selector requests the calibrated negative side, while the
  beat-scale line-of-sight selector has reversed positive.  Thus the two
  positive-deficit channels can oppose each other precisely where the parent
  intended persistent miss correction.

## Policy hypothesis

Preserve the evaluated traveling-bend carrier, large-error redirect,
positive-only response-deficit law, coordinated acceleration envelope, and
angle/rate viability guards.  Make one semantic change to near-goal guidance:
use the existing smooth approach-times-miss gate to blend the short-window
line-of-sight steering side toward the persistent body-frame course side.
Outside the measured corridor the sampled controller is exact.  Inside it,
agreement changes almost nothing, while a beat-scale line-of-sight reversal
cannot override a still-large projected course miss.  The existing separate
course-response residual is retained, so this tests signal arbitration rather
than another steering-amplitude retune.

The falsifiable expectation is capture with a less tangential terminal route,
a projected miss materially below the parent's `0.704L` without later arrival,
and the same coherent wake and zero-contact actuator behavior.  Reject the
mechanism if it changes the far route, over-turns before the target, loses
capture or propulsion, or raises limit residence, planar force, or yaw moment
materially.  The new CFD outcome is produced only after this worker exits and
is not claimed here.

bookshelf_consulted: true
source_domain: wake-interaction signal separation and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve a productive coupled rhythm while preventing a fast alternating feedback cue from overriding a slower persistent route-error cue
transferable_invariant: when two normalized steering observations disagree near a goal, persistent target-course geometry may smoothly arbitrate beat-scale target-line rotation without replacing the propulsive carrier
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, exact vortex or joint phases, full-body waves, and task-specific routes
policy_translation: retain the two-joint state-feedback carrier and positive yaw-response deficit; only inside the existing normalized approach/miss corridor blend the line-of-sight turn side toward the body-frame velocity/target course side
falsification: reject if the far command changes, the terminal course already converges without conflict, the fish over-turns or misses, or wake coherence, actuator contacts, command clipping, force, or yaw-moment exposure worsens

## Non-CFD implementation audit

- Replaying reconstructed observations from the assigned-parent trajectory
  changes `366/4782` two-joint commands, all between `1.749169L` and capture;
  all `4416` farther commands are exact pass-throughs.  The maximum joint
  acceleration difference is `2.660897 rad/T^2`, well inside the unchanged
  coordinated envelope and downstream viability guards.  This proves locality
  and material activation only, not the unevaluated closed-loop outcome.
- A synthetic strong terminal conflict changes the parent command from
  `(3.7541,-2.4897)` to `(2.3936,-2.4897) rad/T^2`, while a reflected state
  produces the exact negation.  A far state matches the parent bit-for-bit;
  all tested outputs are finite and bounded.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account.  Its three exact checks were run
  separately: guidance semantic delta/schema, finite two-joint Julia contract,
  and solver editable-boundary all pass.  The guidance check first exposed a
  duplicate prefill label in the rendered workspace `README.md`; the duplicate
  is now explicitly labeled as a duplicate sample.  No CFD was run.
