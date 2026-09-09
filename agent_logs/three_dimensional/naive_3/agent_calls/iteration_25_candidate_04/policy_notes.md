# Response-selected posterior counterstroke candidate

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase 2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and finite dynamics through the `100T` horizon. I
  inspected both rows of every combined keyframe sheet, comparing the
  geometry-released horizon parent (`solver_101212af2a5e`) with the strongest
  sampled response-hold result (`solver_2c7a9d1d6ee7`) and the weaker
  contraction and radial-release variants. The top-down sheets show coherent
  alternating vorticity streets grown from quiescent release, while the
  oblique sheets retain compact three-dimensional Lambda2 structures around
  the body and wake. The fish are self-propelled; passive advection, wake
  collapse, collision, and numerical instability do not explain the misses.
- The assigned-parent logs proposed holding the C-turn until measured course
  response aligned. Its completed rollout is the strongest current scalar
  result: relative to the geometry-only C-turn, it improves scored mean
  distance from `4.714L` to `4.458L` and increases post-`20T` residence inside
  `3L` from about `0.7%` to `22.1%`. It does not produce capture or a closer
  first pass (`2.377L` versus `2.346L`), and it still travels about `0.635U`
  after `20T` with mean absolute target-ray/course error about `1.72 rad`
  inside `3L`. Its top-down path is a tighter repeated circuit, not inward
  course convergence.
- The other response edits are completed negatives. Contracting the traveling
  wave under poor closure reaches only `2.484L` and ends at `4.673L`; releasing
  recovery from instantaneous radial response reaches only `2.532L`, raises
  post-pass speed to about `0.727U`, and spends the horizon in `3--5L` circuits.
  All four samples retain the horizon/loop class. The three response variants
  also leave posterior acceleration-clamp residence near `0.10`, whereas the
  anterior carrier is already clamped for about `0.71--0.73` of samples in the
  same-curvature policies. More anterior curvature, another response
  threshold, or scalar drive relief is therefore unsupported.
- Inherited pre-recovery logs further close static differential S-bends,
  anterior duty changes, posterior harmful-half-cycle notching, phase-gate
  broadening, and yaw-moment residuals in the old powered lower-exit topology.
  They nevertheless provide a sign calibration: with positive lateral/course
  error, `qd1 < 0` tracks the harmful yaw half-cycle, so a later recovery action
  can select `qd1 > 0` without a clock. The open uncertainty is not whether to
  prolong or weaken the same C-turn, but whether its observed barely-ahead,
  still-tangential release can drive a distinct targetward posterior stroke.

## Policy hypothesis

Start from the completed response-hold policy and preserve its oscillator,
cruise curvature, posterior brake, proximity-selected phase lag, target-behind
C-turn onset, command reserve, and useful lateral/course response selector.
Change only what that selector actuates. Once the target has crossed ahead but
remains strongly lateral and translational course remains misaligned, release
the same-curvature hold and use measured anterior-joint velocity to apply a
bounded targetward posterior counterstroke on the useful half-cycle. This is a
response-selected second stage: body-behind geometry requests the evidenced
C-bend, while measured target-side crossing plus course mismatch requests a
contralateral posterior beat. It has no clock, maneuver state, world
coordinate, route, or exact wake phase.

Support requires preserving the coherent inbound wake and target-behind
recovery while producing capture, a closer return leg, clear inward-course
convergence, or another semantic improvement without higher clamp/load
residence. Reject the mechanism if it changes far-field release, repeats the
same `2.3--5L` orbit, creates a tight curl or lower exit, collapses the wake,
or drives materially more posterior saturation. Formal coupled CFD occurs
only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG turning
source_mechanism: a strong observed-error C-bend is followed by a contralateral propulsive stroke selected by measured maneuver response and gait phase
transferable_invariant: use response, rather than elapsed time, to switch a bounded redirect from body curvature to a targetward posterior half-cycle while retaining the traveling carrier
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequencies, robot duty ratios, prescribed body waves, exact vortex phases, capture radius, and task-specific routes
policy_translation: normalized body-frame target lateral projection and target-ray/course error gate an ahead-side correction; the sign of course error and measured anterior joint velocity select a reflection-equivariant posterior counterstroke under the two-joint acceleration contract
falsification: reject if cruise or target-behind recovery changes, wake coherence or inward progress degrades, posterior clamp/load residence rises, or the same noncapturing horizon circuit remains
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. After the edit, trace replay and
dry controller probes may establish only selector locality, phase selection,
reflection equivariance, finite outputs, schema ownership, and command bounds.

## Implemented candidate and non-CFD probes

The candidate retains the geometry-only target-behind C-turn and converts the
assigned parent's lateral/course response hold into a posterior counterstroke.
The response gate is multiplied by the ahead-side complement of the original
C-turn selector; its signed stroke is then admitted on the `course_error *
qd1 > 0` half-cycle. The maximum posterior target displacement is owned by
`target_policy_params()`, and the action remains clamped to the existing
`+/-28 rad/T^2` reserve.

Selector replay on the completed response-hold trace gives mean/maximum
completion weight below `0.000001/0.000007` through the first `2T` and only
`0.000194/0.0130` through `12T`. At the strongest first-pass counterstroke
state (`17.440T`, `2.459L`), completion and useful-phase weights are
`0.539/0.922`, producing an `8.882 deg` posterior target displacement. Direct
controller replay there changes the geometry-only action from
`(27.49, 7.43)` to `(27.49, 27.66) rad/T^2`; the assigned parent's prolonged
same-curvature hold would instead produce `(9.42, -15.84)`. This is a material
posterior half-cycle topology change while the anterior action follows the
evidenced geometry release. At the recorded minimum, the selected phase is
weak and the candidate remains bounded at `(28.0, 20.20) rad/T^2`.

Counterfactual action replay over the complete response-hold trace gives
anterior/posterior clamp fractions `0.727/0.107`, versus `0.727/0.101` for the
completed parent; the small posterior increase is a falsification quantity for
the later coupled rollout, not a prediction of its trajectory. Mirrored
target, velocity, joint, bearing, and yaw states return exactly negated actions
with zero floating-point residual. The required guidance check, lightweight
Julia policy contract, parameter ownership through direct execution, and
solver editable-boundary check pass. No formal CFD was run.
