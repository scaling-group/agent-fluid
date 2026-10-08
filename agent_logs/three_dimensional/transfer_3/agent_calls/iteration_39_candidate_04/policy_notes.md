# Posterior moving-target feedforward candidate

## Evidence and visual diagnosis before editing

- All four current solver samples satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Their
  trajectories and combined keyframe sheets are byte-identical. Three policies
  are byte-identical `v40`; the fourth adds a dormant selector. They therefore
  reproduce one physical behavior, not four controller mechanisms: capture at
  `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and `243`
  moving-window shifts.
- I inspected both rows of the reproduced combined sheet from release through
  capture. The top-down row shows self-propelled progress from quiescent fluid,
  a compact target-directed path, and coherent alternating shedding by the
  middle approach. The oblique row shows finite, localized three-dimensional
  Lambda2 structures following the body rather than a diffuse or volume-filling
  instability. The final frames show a curved, quiet posture gliding through
  the capture circle without collision, exit, wake collapse, or passive
  advection.
- The most informative inherited visual failure is the completed posterior-
  convergence allocator. It begins with an alternating wake but turns the
  compact approach into a large loop with long paired top-down vorticity bands
  and sparse late oblique structures. It remains finite and eventually
  captures, but only at `45.848015 T`, score `-0.929745304`, with `602` window
  shifts. Thus an active, bounded posterior error-velocity selector can destroy
  the route even when it preserves capture and numerical stability.
- Complementary inherited rollouts close nearby loci. Posterior-divergence
  output coupling regresses score/mean distance to `-0.272400020` and
  `2.162221182 L`; two low-response oscillator-energy mechanisms advance the
  first threshold but bend the route and capture only near `23 T`; and the
  mature upstream cadence governor changes `448` reconstructed outer commands
  yet regresses to `-0.266846005` with `250` window shifts. These results reject
  more energy, cadence relief, lag rewriting, and another after-clipping
  allocation selector. They do not test tracking a moving posterior target
  without changing that target.

## Initial policy hypothesis and pre-edit falsification

Preserve `v40`'s anterior oscillator, posterior target and lag coefficient,
target geometry, output allocator, intercept corridor, and complete terminal
law. Add one small posterior follower mechanism upstream of allocation. The
existing target

`mean_tail_tangent - q1 - drive_tail_lag_gain * qd1 / omega`

moves continuously, but the follower's damping currently references zero
posterior velocity. Estimate the target velocity from the same joint state and
anterior acceleration. The first proposal admitted that term only when target
motion was carrying the reference farther from the observed posterior angle,
with established positive target closure, quiet large-angle redirect, available
posterior command headroom, and actual distance above `4 L`.

Same-state replay falsified that conjunction before CFD: it changed only `42`
of `3,579` stored commands, all between `0.011` and `1.182 T`, by at most
`0.0164 rad/T^2`. No established-speed state had both a receding reference and
usable headroom. The proposal was therefore startup-local and effectively
dormant, exactly the opposite of its intended locus, and is not the final
candidate.

## Revised policy hypothesis before the final edit

Use the same moving-reference derivative estimate without classifying the
instantaneous error direction. Standard moving-reference tracking supplies a
small fraction of target velocity to the posterior damping reference whenever
the target is moving materially and the posterior command has headroom. Add a
separate body-frame center-speed gate, along with positive closure, quiet
redirect, and distance above `4 L`, so the mechanism begins only after the
release transient and withdraws before the protected terminal band. This is
not another convergence/divergence error selector: posterior error sign never
chooses allocation, phase, or authority.

The target, phase-lag formula, oscillator energy, cadence, mean curvature,
output allocator, and every terminal command remain unchanged. This is
moving-reference tracking feedforward, not scalar-only damping or gain tuning.
The expected signature is smaller posterior tracking excursions and slightly
faster middle-distance progress while retaining the compact alternating wake.
It is falsified by dormancy, any command change at or below `4 L`, slower
`10/4/2 L` crossings or capture, worse distance integral, increased saturation
or loads, a wider path or loop, joint-stop dwell, instability, or degradation
of either wake view.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish CPG control
source_mechanism: preserve a directed posterior traveling bend by coupling the follower to the moving rhythmic reference rather than adding gait energy or rewriting its phase target
transferable_invariant: posterior actuation should track the existing propagating bend reference with response-aware coordination while target geometry and bounded authority remain separate
nontransferable_details: published gains, dimensional frequencies, species envelopes, exact vortex or oscillator phase, full-body kinematics, robot geometry, and task-specific routes
policy_translation: estimate posterior target velocity from normalized two-joint state and the state-feedback anterior acceleration; add a small bounded moving-reference term only after body-frame translation and target closure are established, with quiet redirect, outer distance, and posterior command headroom
falsification: reject if the branch is dormant, leaks to 4 L or below, delays or loses capture, worsens distance progress, changes the compact route, increases clipping or loads, causes joint-stop dwell or instability, or degrades the alternating top-down or localized oblique wake

## Candidate boundary

Only the posterior follower's moving-reference tracking term may change. The
new term will be continuously gated and capped as a fraction of the existing
software acceleration limit. The rejected receding-reference conjunction is
removed rather than stacked with the revised mechanism. Same-state
reconstruction can establish activity, finiteness, boundedness, and terminal
isolation, but no hydrodynamic benefit is claimed before a later formal CFD
evaluation.

## Final non-CFD validation

- Reconstructing the sampled `v40` observations changes `305/3,579` commands,
  beginning at `3.4045 T`, `12.1027 L` and ending at `15.2625 T`, `4.1567 L`.
  The maximum/mean-active command differences are
  `0.84249/0.61346 rad/T^2`; the moving-reference term itself remains below its
  declared `0.91630 rad/T^2` cap. It changes `0` commands at or below `4 L`.
- Every reconstructed output remains within the existing
  `30.54326 rad/T^2` software ceiling. Equal-state `|action|>30` incidence is
  unchanged at `1,369/1,973` anterior/posterior samples, so the mechanism is
  active without manufacturing a same-state reduction in saturation counts.
  These are isolation and activity checks, not CFD evidence.
- A deterministic grid of `32,805` finite and nonfinite-input edge states
  returns finite bounded two-joint actions; all `19,683` cases at or below
  `4 L` are exactly equal to sampled `v40`. All `97` direct `params.FIELD`
  references resolve against the `98` fields returned by
  `target_policy_params()`; metadata `version` is intentionally unreferenced.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account and failed before executing a command. The
  workspace guidance-materiality check, lightweight Julia contract, and solver
  editable-boundary check were run directly and repeated by an independent
  read-only fallback; all three pass after removing one duplicate assigned-
  parent marker from the rendered workspace `README.md`. No formal CFD was run.
