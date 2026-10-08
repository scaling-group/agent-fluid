# Wave-established launch course allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite moving-window dynamics, and `capture`
  termination. Their trajectory CSVs and both view-specific keyframe sheets
  are byte-identical. Each captures at `19.684490 T` with score
  `-0.261384287`, mean/final distance `2.151092787 L`/`0.748302400 L`,
  `3579` steps, and `243` moving-window shifts. Three policies are the
  byte-identical `v40` baseline; the fourth is `v41`, whose extra terminal
  selector is behaviorally dormant.
- I inspected the complete combined sheet for the reproduced `v40` rollout
  and the assigned parent's independently active `v43` regression, including
  every top-down mid-plane-vorticity and oblique body/Lambda2 keyframe from
  release through capture. In both, the fish self-propels from quiescent water
  on the same compact target-directed arc. A coherent alternating posterior
  wake is visible by `4 T` and remains organized through capture; the oblique
  structures are finite and localized. There is no passive advection,
  collision precursor, boundary exit, wake collapse, or numerical
  instability. The sheets are visually indistinguishable at their resolution,
  while `v43` keeps the same capture step and loads but slightly regresses
  score, mean/final distance, and path length to `-0.261390567`,
  `2.151097816 L`/`0.748308659 L`, and `12.951134 L`. This closes another
  terminal-response selector; the current wake and terminal posture should be
  preserved.
- The remaining measurable weakness is launch, before that coherent wake is
  established. The reproduced fish remains at about `12.328 L` through
  `1 T`, is still at `12.297 L` near `2 T`, and first crosses `12 L` only at
  `3.806 T`. Center speed is only `0.074`, `0.102`, and `0.135 U` near
  `0.5`, `1`, and `2 T`; windowed closure is `-0.010`, `-0.001`, and
  `0.007 L/T`. Nevertheless, the instantaneous center-course signed sine is
  approximately `+0.974`, `+0.954`, and `-0.958`, and both joint commands are
  already near the acceleration envelope. Thus low-speed gait sway is being
  presented to the outer course allocator as a large route miss before either
  translation or the posterior traveling-bend response is trustworthy.
- Completed inherited comparisons rule out using this observation to change
  mean curvature, posterior phase lag, terminal cadence, signed terminal yaw,
  or joint-response posture. In particular, startup mean-curvature support
  delays capture to `23.375013 T`, while an outer phase-lag governor produces
  a large loop and captures only at `46.145020 T`. The positive course-based
  residual allocator must therefore remain available after launch; only its
  evidence-poor arbitration against wave formation is in scope.

## Policy hypothesis

Start from the four-way reproduced `v40` controller. Add one response-consent
mechanism to the existing outer course residual allocator: when posterior lag
response is still poor, discount center-course priority in proportion to its
existing low-translation confidence. Restore the evaluated allocator
continuously as either body translation becomes established or posterior
tracking settles. This changes no oscillator gain, frequency, posterior target,
mean curvature, steering sign, command limit, or terminal rule. It uses only
normalized body-frame course speed and two-joint response already present in
the controller, and the existing outer gate makes it exactly inactive at and
below `4 L`.

The expected trace-level effect is a small launch-only return toward the
response-conditioned coupled limiter while the wake is forming, followed by
exact recovery of the current course allocator before useful range closure.
An in-memory equal-state prototype changes `93` stored commands from
`0.506 T` to `2.640 T`, all between `12.328 L` and `12.239 L`, with maximum
change `0.2161 rad/T^2` and no change at or below `4 L`. This establishes
activity and locus, not a CFD improvement. Falsify the mechanism if it is
dormant in coupled flow, delays propulsion or capture, removes the later
course-allocation benefit, changes the compact route, modifies terminal
commands, increases joint-stop dwell or loads, destabilizes the solve, or
degrades either wake view. The new CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated robotic-fish CPG direction control
source_mechanism: establish the posteriorly lagged propulsive bend before allowing a low-confidence translational course signal to overrule response-preserving actuator allocation
transferable_invariant: when propulsion and route correction share two joints, preserve wave-formation priority while body translation and posterior response are both unestablished, then restore target-relative course authority continuously from observed response rather than elapsed time
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waveforms, exact vortex or beat phase, target coordinates, capture radius, and task-specific routes
policy_translation: combine normalized body-frame center-course speed with normalized posterior lag response to gate only the existing outer course-residual priority; retain the evaluated oscillator, fixed lag target, mean bends, command envelope, and terminal handoff
falsification: reject on dormancy, any command change at or below 4 L, delayed propulsion or capture, loss of later course authority, a changed or looping route, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the evaluated `v40` and implemented candidate on reconstructed
  body-frame states confirms the prototype result exactly: `93` commands
  change from `0.506 T` through `2.640 T`, all in the launch interval from
  `12.328 L` to `12.239 L`. The maximum equal-state difference is
  `0.216069 rad/T^2`, the 90th percentile difference is
  `0.044885 rad/T^2`, and no state at or below `4 L` changes.
- A deterministic `23625`-state sweep across distance, target angle, course
  angle, course speed, joint state, and yaw response finds finite bounded
  outputs and independently active differences. It verifies exact `v40`
  command identity throughout the terminal band and whenever the existing
  course-speed confidence is fully established. These checks establish
  boundedness and selectivity only, not coupled-flow improvement.
- The material-guidance validator passes after removing one duplicated
  assigned-parent marker from the rendered workspace `README.md`. The exact
  two-output Julia contract and solver edit-boundary checks pass. The schema
  guard resolves all `88` direct `params.FIELD` references against the `89`
  fields returned by `target_policy_params()`; only the version label is
  intentionally unused.
- The prescribed check-runner was invoked after the required edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed
  before executing a command. Its three configured checks were therefore run
  directly and separately. No formal CFD was run in this workspace.
