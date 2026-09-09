# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen still-water contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination. I inspected both the top-down
  vorticity and oblique Lambda2 rows of every combined keyframe sheet. The
  baseline geometry-released C-turn (`solver_101212af2a5e`) and the three
  response variants all self-propel with coherent alternating three-dimensional
  wakes; passive advection, wake collapse, collision, and instability do not
  explain any miss.
- The assigned parent's nonclosing carrier contraction
  (`solver_17c80feba915`) falsifies its turn-in-place hypothesis. Relative to
  the baseline C-turn it improves mean distance from `4.714L` to `4.545L`, but
  worsens first-pass minimum/final distance from `2.346/3.902L` to
  `2.484/4.673L` and visibly returns to the same broad powered loop. After
  `18T`, mean speed is `0.645U` rather than the baseline's `0.633U`, while
  anterior/posterior clamp residence remains essentially unchanged
  (`0.712/0.103` versus `0.718/0.104`). Contracting the oscillator envelope
  therefore did not produce the intended speed or turn-in-place response.
- The other two response edits delimit the next action. Holding the sampled
  C-turn until lateral course response appears (`solver_2c7a9d1d6ee7`) gives
  the best mean distance (`4.458L`) and a closer second return (`about 2.60L`
  versus the baseline's `3.15L`) with a coherent wake, but still misses at
  `2.377L` and orbits through the horizon. Multiplying the redirect by radial
  response (`solver_6af775e9aa4a`) instead reduces anterior clamp residence to
  `0.139`, raises post-pass speed to `0.725U`, and regresses mean/minimum
  distance to `4.780/2.532L`. Thus removing proven redirect curvature when
  course briefly closes is harmful, while persistent curvature yields the
  more useful repeated-return topology.
- Across the baseline, parent, and response-hold traces after the first pass,
  median absolute target-ray/course error remains `1.68--1.73 rad` at finite
  `0.63--0.65U` speed. The target is fully behind the body for more than `93%`
  of the baseline post-pass samples and essentially all parent/response-hold
  samples. The missing response is bounded extra turning authority during a
  tangential or receding recovery, not more scalar drive relief.

## Policy hypothesis

Start from the baseline horizon C-turn so release and the closest first pass
remain unchanged. Preserve its target-bearing cruise curvature, phase-lag
carrier, posterior brake, geometry-released same-sign redirect, and wave
envelope. Add one response-selected curvature reserve: only when the target is
fully behind, inside the evidenced loop radius, translational speed is finite,
and target-ray/course dot product indicates tangent or receding motion, add a
bounded same-sign equilibrium bend selected by course-error direction. Positive
radial course response continuously removes only the reserve, never the sampled
redirect. This tests whether response feedback must act on turn authority
rather than on the carrier amplitude or redirect release.

Support requires the same coherent first pass plus capture, a return leg below
`2.35L`, or a materially smaller repeated orbit with improved mean/final
distance and comparable clamp/load residence. Reject if first-pass geometry
changes, posterior limits or loads grow, the wake strongly one-sides or stalls,
or the same `2.5--5L` powered orbit persists.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: apply strong bounded curvature for a large direction error and release that reserve when measured course response appears
transferable_invariant: separate the propulsive carrier from a geometry-and-response-selected turn reserve, preserving baseline propulsion and removing only the reserve after useful alignment
nontransferable_details: published CPG gains, species-specific burst kinematics, dimensional beat frequency, exact maneuver stages, vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target and velocity directions select a reflection-equivariant bounded equilibrium-curvature reserve within the existing two-joint state-feedback oscillator; the proven redirect and carrier remain active
falsification: reject if the first pass changes, limit/load residence rises, propulsion or wake coherence degrades, or no closer return, smaller orbit, capture, or useful distance improvement appears
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. Trace replay and dry controller
checks after the edit can establish selector locality, symmetry, parameter
ownership, finiteness, and bounds only; EvE performs the coupled CFD evaluation
after this worker exits.

## Implemented candidate and non-CFD probes

The candidate retains the baseline C-turn exactly and adds seven owned
course-response parameters. The reserve uses normalized target/velocity dot
product, course-error direction, distance, speed, and the existing target-behind
selector; it adds to both redirect equilibria without changing the carrier,
posterior brake, phase lag, or sampled redirect authority.

Counterfactual selector replay on the completed baseline trace gives zero
reserve at release, through `2T`, and at the sampled `2.3456L` minimum
(`17.8915T`). It remains only about `0.01 deg` at `18T`, then contributes about
`4.18 deg` at `20T` after full redirect engagement. Across states after `18T`,
the mean reserve is about `1.92 deg`; the selector weight averages `0.357` on
receding states versus `0.055` on closing states, and its sampled peak reserve
is about `4.66 deg`. These values establish first-pass locality and material
post-pass authority only; replay cannot predict the coupled trajectory.

All `40` direct parameter references are returned by
`target_policy_params()`. Representative mirrored cruise, recovery, zero-speed,
and large finite states return actions that negate to within `1e-12`; all are
finite and respect the declared `+/-28 rad/T^2` command reserve. The maximum
nominal posterior recovery equilibrium plus its contracted wave envelope stays
below the `45 deg` joint limit. The mandated material guidance/notes check,
lightweight Julia contract, parameter-schema guard, and solver editable-boundary
check pass. No formal CFD was run.
