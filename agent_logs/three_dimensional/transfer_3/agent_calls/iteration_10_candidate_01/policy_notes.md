# Paired carrier saturation-allocation candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, active moving-window transport, finite
  dynamics, and capture from `12.327720L` at `25.118523T`. They have the same
  score (`-0.5283387731`), mean distance (`2.429293780L`), and final distance
  (`0.746410191L`). Three sampled policies are byte-identical to the assigned
  prefill; the fourth differs only in version/comment metadata, so there is no
  sampled command-level improvement to inherit.
- I inspected the assigned parent's combined sheet from release through
  capture, including both the top-down mid-plane vorticity row and oblique 3D
  body/Lambda2 row. The fish is self-propelled rather than advected: a coherent
  alternating posterior wake accompanies a compact curved path toward the
  target, finite three-dimensional structures remain visible through the
  approach, and the late held bend enters the capture sphere without a
  collision, boundary-exit precursor, or instability.
- I compared that sheet with the weakest recent inherited mechanism result,
  the target-response carrier-release candidate at score `-0.5312198481`.
  At keyframe resolution its top-down path and available oblique wake retain
  the parent's topology, but numeric evidence rejects it: mean/final distance
  regress to `2.431539484L`/`0.749477029L`. The other recent body-response,
  joint-departure, and shared yaw-response terminal additions also retain
  capture but regress to scores between `-0.529296` and `-0.528782`. Their
  inside-`4L` load maxima remain close to the parent's approximately
  `0.01548/0.00800` force/moment coefficients, so lower terminal loads do not
  rescue the worse target metrics.
- The assigned parent has no inside-`4L` action above `30 rad/T^2`, no terminal
  joint-stop dwell, and only `0.307 rad/T^2` peak action inside `2.4L`; the
  repeated unsuccessful descendants therefore argue against another terminal
  response gate, curvature residual, or carrier handoff.
- A separate actuator-allocation defect is measurable before that regime. Over
  the full rollout the anterior/posterior commands exceed `30 rad/T^2` on
  `40.27%`/`31.77%` of samples. Outside `4L`, at least one joint is at the
  `30.543 rad/T^2` policy cap on `64.73%` of samples, but exactly one joint is
  capped on `38.94%`. Independent component clipping therefore changes the
  ratio of the coupled carrier commands during much of the otherwise useful
  wake-forming approach. This does not prove that saturation caused score
  loss, but it supports one falsifiable allocation test instead of another
  scalar gain change.

## Policy hypothesis

Preserve every parent observation, feedback gain, carrier construction,
closure preview, terminal curvature equilibrium, paired response release, and
declared acceleration limit. Replace only independent clipping of the two raw
carrier accelerations with a paired radial projection: when either component
exceeds the common limit, multiply both by the same bounded factor so their
instantaneous sign and ratio survive. The terminal controller remains
component-bounded and is blended exactly as before.

This is an actuator-allocation mechanism, not amplitude or frequency tuning.
Its expected benefit is a less distorted anterior-to-posterior traveling-bend
command during the outer approach while retaining the established target arc
and terminal capture. Reject it if propulsion weakens, capture is delayed or
lost, mean/final distance regresses, the wake loses its alternating posterior
structure, joint-stop dwell or loads grow, or any pre-terminal gain/geometry
change is needed to make the result look favorable. Because the current CFD
rollout is evaluated only after this worker exits, this note claims bounded
non-CFD behavior only, not improvement.

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave swimming and coupled robotic-fish CPG actuation
source_mechanism: coordinated anterior-to-posterior commands preserve a directed traveling bend that produces reactive thrust
transferable_invariant: when limited joints jointly encode a propulsive wave, saturation should preserve their instantaneous coordination rather than clip each component independently
nontransferable_details: published gains, dimensional cadence and amplitude, species-specific envelopes, exact phase lags, full-body waveforms, vortex phases, and task-specific routes
policy_translation: radially project the normalized two-joint carrier-acceleration vector onto the declared common command limit while leaving target-relative feedback and terminal allocation unchanged
falsification: reject if the outer wake or compact path degrades, capture or distance metrics regress, loads or joint-stop dwell grow, or componentwise clipping proves necessary for thrust in coupled CFD

## Non-CFD implementation audit

- The required guidance-provenance check passes after removing one duplicate
  assigned-parent marker from the rendered workspace `README.md`; the two
  duplicate markers named the same parent artifact.
- The lightweight Julia contract returns two finite commands, and the static
  schema scan resolves all `68` direct `params.FIELD` references in the `69`
  fields returned by `target_policy_params()`.
- In a far-range high-demand synthetic state with terminal reallocation exactly
  inactive, the raw carrier pair `(-45.2001,-33.7206)` is mapped by the single
  scale `0.675734` to `(-30.5433,-22.7862) rad/T^2`; the component limit, signs,
  and raw pair ratio are preserved. This establishes activation and boundedness
  only, not coupled-flow performance.
- The solver editable-boundary check passes. No formal CFD was run.
