# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the Phase 2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and finite dynamics. I inspected the combined keyframe sheets for
  the horizon-surviving geometry-released C-turn (`2.346L` minimum) and the
  strongest lower-exit phase-lag near miss (`2.326L`), including both the
  top-down mid-plane vorticity and oblique body/Lambda2 views from release to
  termination. Both are self-propelled and retain a coherent alternating 3D
  wake. The phase-lag fish continues almost straight through the target's
  lateral neighborhood and exits low at `31.741T`; the C-turn bends into a
  broad return loop, remains in bounds through `100T`, and repeatedly crosses
  its own long wake. There is no ambient advection, wake collapse, collision,
  or numerical instability to repair.
- The completed C-turn is a semantic improvement over every sampled and
  assigned-parent lower exit. It changes termination from `left_domain` to
  `horizon`, improves mean/final distance from `8.424/9.213L` for the sampled
  phase scaffold to `4.714/3.902L`, and reduces posterior command-clamp
  residence from `0.355` to `0.104`. The assigned parent's anterior duty
  asymmetry reaches only `2.433/8.434L` minimum/mean and exits low at
  `31.235T`; the sampled moment residual likewise exits low at `2.539L`.
  Thus scalar effort, another inbound phase edit, and wake-moment rejection do
  not explain the C-turn's useful change.
- The C-turn does not improve the first-pass minimum (`2.346L` versus
  `2.326L`), but it produces a genuine return leg with a later `3.145L`
  minimum at `77.83T`. Its fixed body-behind selector then holds nearly full
  redirect for most of the orbit even when translation is already closing on
  the target: sampled two-beat snapshots have positive normalized radial
  closing around `0.6` while the target remains body-behind. The fish therefore
  circulates at roughly `3--5.8L` instead of tightening into the `0.75L`
  capture radius. At the force and yaw-moment maxima (`38.198T` and
  `38.923T`), where the loop visibly returns through its wake, normalized
  radial closing is already `+0.130` and `+0.189`, yet the inherited redirect
  weight remains `1.000`; force/moment peaks reach `0.145/0.070`, about five
  times the lower-exit maxima, even though their full-trace RMS values remain
  comparable. Body-forward geometry is therefore an incomplete release
  signal in this high-sideslip recovery.
- Inherited logs correctly hypothesized a geometry-released C-turn after the
  target crossed behind and falsified more phase/amplitude refinement. The
  newly completed horizon trace now supports the C-turn mechanism but
  falsifies body-ahead alone as its release condition. The missing controller
  capability is response-based release of the already useful redirect, not
  stronger curvature, more propulsion, or another scalar activation change.

## Policy hypothesis

Start from the sampled horizon-surviving C-turn without changing its cruise,
approach, curvature magnitude, two-joint allocation, carrier contraction, or
command reserve. Preserve the full-direction body-behind selector as the
geometric request to begin recovery, but multiply its persistence by a smooth
normalized radial-response gate. When target-relative translational velocity
is receding or tangent, the C-turn remains active; once translation is closing,
the strong same-sign curvature and contracted wave release continuously back
toward the evidenced phase-lag carrier even if the oscillating body still sees
the target behind. This uses measured response rather than elapsed stage or a
stronger bend and directly addresses the broad orbit caused by sideslip.

Support requires preservation of the coherent first pass and return topology,
plus capture, a materially tighter later return, lower mean/final distance, or
reduced self-wake load peaks without greater clamp residence. The mechanism is
falsified by loss of the horizon/return class, renewed lower exit, unchanged
`3--5.8L` orbit, high-frequency load growth, a tight curl, or worse first-pass
approach. Formal coupled CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: a large geometric error selects a bounded curvature burst, while measured directional response releases the burst back into the productive rhythm
transferable_invariant: persist with a strong redirect only until target-relative motion becomes corrective; release on observed response rather than body orientation or elapsed stage alone
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequency, robot duty ratios, prescribed waveforms, exact vortex phases, capture radius, and task-specific routes
policy_translation: multiply the normalized body-frame target-behind C-turn selector by a smooth reflection-invariant radial-closing gate computed from target and velocity unit vectors under the two-joint acceleration contract
falsification: reject if the return leg or coherent wake is lost, the lower exit returns, the broad orbit and self-wake load peaks persist, switching raises loads, or later distance cannot improve without degrading the first pass
```

## Evaluation boundary

The new candidate has no same-worker CFD evidence. Trace replay and dry
controller probes after the edit can establish only selector locality,
symmetry, schema ownership, finiteness, and bounds; they cannot establish a
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate is the sampled horizon-surviving C-turn with one mechanism
change: two owned parameters define a smooth zero-radial-closing transition,
and that response weight multiplies the inherited body-behind selector. All
cruise, phase, brake, redirect-curvature, joint-allocation, wave-envelope, and
command-limit parameters are unchanged. The controller has no clock, stage
counter, mutable state, world coordinate, case identity, file access, or
command boost.

Counterfactual selector replay on the completed C-turn trace leaves the first
pass intact: candidate redirect activation is zero to displayed precision in
the first `2T` and remains zero at the sampled `2.345647L` minimum. When the
inherited geometric selector first exceeds one half at `18.727T`, distance is
`2.434L` and normalized radial closing is still `+0.576`; response release
reduces candidate redirect weight to `0.013`. The candidate selector first
exceeds one half at `18.925T`, distance `2.537L`, just as radial response turns
slightly receding (`-0.008`). Across states where inherited recovery is active,
mean redirect weight changes from `0.995` to `0.564`. At the completed trace's
force and moment maxima, the counterfactual weight falls from `1.000` to
`0.102` and `0.041`, respectively. These are selector measurements on fixed
states, not predictions of the recoupled trajectory or loads.

The lightweight Julia policy contract and solver editable-boundary checks
pass. All `35` direct `params.FIELD` references are declared by
`target_policy_params()`. Representative approach, recovery, closing, and
zero-speed states mirror to exactly negated actions with zero numerical
residual; an extreme finite input remains finite and clamps to the declared
`+/-28 rad/T^2` reserve. The root guidance checker is obstructed before its
semantic comparison because the immutable rendered README lists the identical
assigned parent twice. The unchanged checker passes on a temporary view that
removes only the duplicate parent listing and links the actual notes,
guidance, and parent evidence; that view was removed after the check. No CFD
was run in this workspace.
