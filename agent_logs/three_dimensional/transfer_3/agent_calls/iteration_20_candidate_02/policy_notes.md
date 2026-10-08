# Partially coupled saturation for traveling-bend coordination

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts are identical evaluations of the inherited
  `v29` center-translation intercept policy. They satisfy the frozen contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics through 268
  moving-window shifts, and capture from `12.327720 L` at `25.118523 T`.
  Each reproduces score `-0.5280772274`, mean distance `2.429087214 L`, and
  final distance `0.746135294 L`.
- I inspected the complete combined keyframe sheets for the reproduced winner
  and the inherited head-point-rate and cadence-recovery regressions, including
  the top-down mid-plane vorticity rows and oblique body/Lambda2 rows from
  release through capture. All are self-propelled from quiescent flow: a
  coherent alternating wake grows behind the posterior body, follows the same
  compact target-directed arc, and subsides into a quiet held-bend glide before
  capture. Neither view shows passive advection, a loop, collision,
  boundary-exit precursor, out-of-plane instability, wake collapse, or
  terminal thrashing. The mechanisms are visually indistinguishable at sheet
  resolution, so their terminal telemetry supplies the negative contrast.
- Reconstructing head-point velocity from range and line-of-sight rates changed
  118 of 226 stored terminal commands but regressed to score `-0.5281959396`,
  mean distance `2.429180928 L`, and final distance `0.746260285 L`. Recovering
  up to `3%` of the below-nominal cadence under the already supported intercept
  gate was active on 160 terminal states and likewise retained the capture step
  but regressed to `-0.5281246771`, `2.429124662 L`, and `0.746185303 L`.
  Lower terminal command and more terminal cadence are therefore both rejected
  as same-regime refinements of the successful held-bend glide.
- The remaining measured intervention locus is the outer acceleration limiter.
  The reproduced winner reaches its declared `30.54326 rad/T^2` software cap
  on 1,790 anterior and 1,436 posterior commands (about `39.2%/31.4%` of the
  rollout), yet no command reaches that cap inside `4 L`; inside `1.6 L`, maxima
  are only `0.09772/0.24610 rad/T^2`. Independent component clipping can flatten
  the requested two-joint command ratio precisely where the productive wake is
  being formed, while the terminal equilibrium and paired release need no new
  intervention.

## Policy hypothesis

Preserve the reproduced state-feedback oscillator, posterior lag, target-angle
redirect, closure preview, shared mean-curvature equilibrium, helpful-crossflow
and settled-response gates, center-velocity intercept corridor, bounded paired
release, and terminal commands. Replace only the outer carrier's independent
component limiter with a partially coupled limiter: compute the ordinary
componentwise-clipped command and a direction-preserving command obtained by a
single common scale on the raw two-joint vector, then blend a small declared
fraction toward the direction-preserving result. The blend is exactly dormant
when neither raw component exceeds the existing limit and all returned
accelerations remain within that limit.

This is one actuator-coordination mechanism rather than scalar gain tuning. It
uses only the existing two-joint state-feedback command, adds no clock, route,
world coordinate, force cancellation, rate reconstruction, cadence authority,
mean-bend change, beat-side selector, or joint-role split. On the evaluated
trajectory it should act only in the high-command outer carrier and leave the
validated below-`4 L` approach algebra identical. Falsify it if stored-state
replay shows terminal interference or excessive command loss, or if later CFD
delays or loses capture, worsens distance or speed, changes the compact path,
weakens the alternating wake, increases loads or joint-stop dwell, or becomes
unstable.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior command structure and posterior lag while enforcing a bounded actuator envelope
transferable_invariant: when a coordinated two-joint rhythmic command exceeds an actuator envelope, a common bounded scale preserves its requested joint-space direction better than unrelated component flattening
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waves, exact phase lags, actuator models, vortex phase, capture radius, and task-specific routes
policy_translation: blend a small parameter-owned fraction from the inherited componentwise limiter toward a common-scale two-joint limiter only when the raw carrier command exceeds the existing acceleration bound; retain all normalized body-frame guidance and terminal allocation unchanged
falsification: reject on terminal-command interference, excessive outer command reduction, changed mean bend or target path, delayed or lost capture, worse progress or speed, renewed joint stops, load growth, instability, or degradation of either wake view

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Replaying the evaluated parent and candidate algebra on reconstructed stored
  observations changes 2,320 of 4,567 commands, all outside `4 L`; the
  normalized distance gate gives exactly zero difference throughout the
  terminal band. Mean absolute command differences are about
  `0.262/0.229 rad/T^2`, maxima are `2.552/2.097 rad/T^2`, and maximum relative
  magnitude reductions are about `8.7%/6.9%`. Thus the `12%` blend is active
  and bounded without replacing the inherited carrier or erasing its command.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Running its three configured checks directly
  gives PASS for the material guidance update, the finite two-acceleration Julia
  contract, and the solver edit boundary. The deterministic schema audit finds
  all 79 direct `params.FIELD` references in the 80-field parameter object; the
  unreferenced field is the version label. The sample common-scale calculation
  also remains within the declared command limit. These checks establish finite
  output, bounded authority, schema integrity, and terminal noninterference on
  stored states only; coupled-flow score, capture, loads, path, and wake remain
  future evaluation evidence.
