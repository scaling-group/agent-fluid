# Course-response release of the outer redirect

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers are byte-identical copies of the v29
  center-velocity intercept controller and reproduce the same finite result:
  capture at `25.118523 T`, score `-0.5280772274`, mean distance
  `2.429087214 L`, final distance `0.746135294 L`, and 268 moving-window
  shifts. Their diagnostics confirm direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and no
  instability. There is therefore no distinct sampled failure sheet; the
  inherited optimizer logs provide the informative negative contrasts.
- I inspected the complete combined keyframe sheet, including the top-down
  mid-plane vorticity row and oblique body/Lambda2 row from release through
  capture. The fish is self-propelled rather than advected: an alternating
  planar wake and finite three-dimensional vortex packets persist along a
  compact but visibly curved target approach. The carrier then subsides into
  a quiet held-bend glide before a clean first crossing. Neither view shows a
  collision, loop, virtual-boundary precursor, out-of-plane excursion,
  terminal thrashing, or wake collapse.
- The assigned-parent guidance and logs establish strict terminal boundaries.
  Predicted center-velocity miss plus the existing settled, closing, helpful-
  crossflow gates is the four-times-reproduced best mechanism. Adding an
  adverse-force veto is independently active but slightly worse
  (`-0.5280778498`), while replacing center velocity with reconstructed
  head-point line-of-sight kinematics is materially worse at `-0.5281959396`,
  mean distance `2.429180928 L`, and final distance `0.746260285 L`. The
  latter uses a seven-step derivative window much shorter than a tail beat.
  Neither result supports another terminal response signal, force gate,
  mean-bend change, joint-role split, or phase selector.
- Stored-state reconstruction exposes a separate outer opportunity. Around
  `15–16 T`, before terminal reallocation, the target-angle redirect remains
  about `0.85–1.0` active while center-velocity course error has temporarily
  contracted to about `0.21–0.18 rad` under positive closure of roughly
  `0.50–0.43 L/T`. Thus translation has responded before body-relative target
  angle has relaxed. A bounded response-earned release can test whether the
  redirect is being held slightly too long without changing its sign or
  replacing target geometry with course steering. On the parent path, a
  course-alignment window ending at `0.28 rad` is inactive throughout the
  proven below-`1.6 L` terminal regime, whose course error stays above about
  `0.31 rad`; the implementation also makes the new branch structurally zero
  there.

## Policy hypothesis

Preserve v29's state-feedback oscillator, posterior lag, target-angle redirect,
closure preview, shared terminal mean-curvature equilibrium, helpful-crossflow
support, center-velocity intercept corridor, coupled carrier release, and all
command limits. Add one outer response-release mechanism: compare normalized
body-frame center velocity with the body-frame target vector, and when their
course error is smoothly inside `0.28 rad` under positive range closure, reduce
the existing geometric redirect weight by at most `3.5%`. The course signal
cannot choose turn sign or add acceleration; it can only release a small part
of a target-angle redirect that remains authoritative and immediately
re-engages as alignment is lost.

The new release uses its own parameterized course window, closure scale, and
authority ceiling. It is continuous, target-relative, and memoryless. The next
CFD evaluation should test whether response-conditioned release restores a
little carrier and avoids excess curvature during the middle approach while
preserving the established terminal intercept and both wake views. Falsify it
if the stored-state gate is dormant, if it changes commands inside `1.6 L`, if
the outer arc broadens or loops, closure slows, capture is delayed or lost,
mean/final distance regresses, or saturation, joint-stop dwell, force/moment
growth, instability, or wake degradation appears.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish rhythmic direction tracking
source_mechanism: release a strong bounded curvature redirect after observed target-relative translational response while retaining the traveling propulsive scaffold
transferable_invariant: corrective curvature may relax continuously after normalized body-frame motion demonstrates course alignment, and must re-engage when that response is lost
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, duty ratios, clock or vortex phase, exact target route, and capture geometry
policy_translation: positive closure and a bounded body-frame target-versus-center-velocity course error may release at most 3.5 percent of the existing redirect weight; target geometry retains sign and the validated terminal controller remains untouched
falsification: reject on a dormant or terminal-active gate, changed turn sign, broader outer path, slower closure, delayed or lost capture, worse distance, renewed saturation or joint stops, load growth, instability, or wake loss

The candidate's coupled-flow result occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Replaying candidate and evaluated-parent algebra on all available stored
  parent states makes the new response branch active from `12.304 L` through
  `3.672 L`. It changes 557 stored commands, reaches the declared `3.5%`
  redirect-release ceiling, and has a maximum two-joint command delta of
  `1.381 rad/T^2`, about `4.5%` of the command envelope. The command delta is
  exactly zero for every stored state at or below `1.6 L`.
- The Julia smoke call returns two finite accelerations. All 81 direct
  `params.FIELD` references are present in the 82-field object returned by
  `target_policy_params()`; the extra field is the version label. The material
  guidance check and downstream solver boundary check pass.
- This audit establishes parameter ownership, bounded activation, exact
  terminal noninterference on the stored trajectory, and finite outputs only.
  It does not establish coupled-flow capture, score, loads, path response, or
  wake quality.
