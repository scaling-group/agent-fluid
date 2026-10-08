# Coordinated response-release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, active moving-window transport, and finite capture at
  about `25.11T` from `12.32772L`.
- I inspected every sampled combined sheet from release to capture, including
  both the top-down mid-plane vorticity row and the oblique body/Lambda2 row.
  The fully rendered closure-preview parent and inherited step-6 comparators
  show one compact self-propelled arc, a coherent alternating posterior wake,
  finite three-dimensional shed structures, and a smooth terminal bend into
  the capture sphere. The first two oblique panels of the strongest sampled
  rollout and several panels of the phase-selective rollout are blank. Those
  panels are missing visual evidence, so the visual claim is anchored to the
  fully rendered policies whose pre-terminal controller and top-down path are
  unchanged, then cross-checked against the finite traces and diagnostics.
- The strongest sampled policy is the coordinated response release, duplicated
  exactly as `solver_89a97c83567b` and `solver_b79884a946b7`. Each scores
  `-0.5283387731`, captures at `25.11852T`, reaches `0.746410L`, and has mean
  distance `2.429293780L`. It improves the prefilled closure-preview parent
  (`-0.5300603181`, `25.11302T`, `0.748252L`, mean `2.430635919L`) while
  preserving the same outer wake and trajectory. The extra integration step is
  offset by a deeper crossing and smaller terminal-hold integral.
- Phase-selective departure reallocation is also positive but marginally
  weaker (`-0.5283756345`, mean `2.429298361L`). More importantly, inherited
  completed results show that the two response mechanisms do not compose:
  response-partitioned allocation regresses to `-0.5309900794`, mean
  `2.431336802L`, and final distance `0.749287L`. Posterior-only response
  release also regresses to `-0.5302882262`, mean `2.430852400L`, despite
  retaining capture. Thus the supported unit is the coordinated two-joint
  release; stacking the departure boost or holding the anterior joint fixed is
  not justified by the current evidence.
- All fast variants remain finite and avoid a new trajectory topology, but the
  inherited `51.645T` approach-hold result remains the informative control
  failure: broad drive relief preserves an early wake yet produces a large
  target orbit. The candidate must therefore leave the established outer
  carrier and closure-preview entry/release unchanged.

## Policy hypothesis

Start from the prefilled closure-preview controller and add exactly the
evaluated coordinated response release. The existing normalized body-frame
target geometry and positive-closure preview continue to form a damped
two-joint curvature equilibrium. Maximum joint tracking error, normalized by
the declared carrier amplitude, retains the full bend while either joint is
unsettled; after the pair settles, both joints smoothly recover the already
validated bounded share of the posterior-lag carrier around the same mean
curvature. This preserves a traveling bend instead of splitting the gait by
joint role or stacking a second response signal.

The candidate intentionally matches the twice-evaluated strongest sampled
policy rather than claiming an unsupported same-worker improvement. It is
falsified by a repeat rollout that loses or materially delays capture, changes
the pre-terminal wake/path, reintroduces terminal command caps or load spikes,
or fails to reproduce the sampled advantage beyond deterministic/numerical
variation.

bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG control
source_mechanism: release target-directed curvature control into coordinated rhythmic propulsion only after the observed bend response has formed
transferable_invariant: when steering and propulsion share limited joints, use normalized joint-state response to hand both joints continuously from a strong target-relative bend back to a coordinated traveling carrier rather than using elapsed time or a prescribed phase
nontransferable_details: published gains, dimensional cadence, species-specific C-bend timing and envelope, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: normalized maximum two-joint curvature-tracking error modulates only the existing closure-gated terminal allocation; body-frame target geometry still selects bend sign and equilibrium, and both joints recover the bounded posterior-lag carrier together after settling
falsification: reject if repeated CFD loses the compact capture, changes the outer wake, restores terminal saturation or high loads, or if separating or stacking response mechanisms is later shown to outperform the coordinated handoff robustly

The new CFD evaluation occurs after this worker exits and is not claimed here.
