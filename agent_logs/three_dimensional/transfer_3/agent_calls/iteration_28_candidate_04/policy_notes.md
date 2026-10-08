# Intercept-deficit carrier rescue

## Evidence and visual diagnosis before the policy edit

- Every sampled solver rollout and both inherited parent rollouts satisfy the
  frozen initialization contract: direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  dynamics, and capture. The two sampled `v37_response_exclusive_allocation`
  policies are byte-identical reproductions at `19.612991 T`, score
  `-0.28294122`, and mean distance `2.17243510 L`.
- I inspected the complete combined keyframe sheets for the sampled `v37`,
  `v38`, and `v39_geometry_agreed` policies and the inherited
  `v39_closure_released` rollout, including the top-down mid-plane-vorticity
  and oblique body/Lambda2 rows from release through termination. The sampled
  policies visibly self-propel along compact target-directed arcs, shed
  coherent alternating top-down vortices, and retain finite localized 3D
  structures. The inherited closure-release child instead overshoots into a
  large loop before capture at `44.885483 T`; its wake remains coherent and
  finite, so that is a route/allocation failure rather than thrust collapse or
  numerical instability.
- The inherited failure also exposes a concrete semantic error. It compared
  `closing_speed_L`, already measured as normalized range per `T`, with
  `course_speed_U / params.L` even though center speed is already numerically
  in the same `L/T` scale. Offline reconstruction shows the resulting release
  was essentially full on `2692/2807` outer states of the best sampled
  trajectory. The intended directional-response test was therefore not
  evaluated; the controller almost always withdrew course allocation while
  closing and recovered it on departure, a topology capable of sustaining the
  observed loop.
- The sampled signed geometry-consistency gate is the strongest finite score
  and a safer baseline. Relative to unsigned `v38`, it improves score from
  `-0.27158268` to `-0.26217996`, mean distance from `2.16212422 L` to
  `2.15193349 L`, capture from `19.998001 T` to `19.783508 T`, and global
  lateral-force/yaw-moment maxima from about `0.02906/0.01678` to
  `0.02740/0.01564`, while preserving both wake views. It also crosses
  `4/3/2/1 L` at about `15.444/16.621/17.804/19.190 T`, earlier than sampled
  `v37` at every crossing.
- The remaining cost is localized after `1 L`. The geometry-agreed policy
  needs about `0.594 T` to cover the final `0.25 L`, versus `0.297 T` for
  `v37`. At its `1 L` crossing the center-course alignment is about `0.748`
  and normalized cross-track sine is `0.664`; at capture those values are
  about `0.445` and `0.895`. The body-frame redirect is nearly full, commands
  settle to roughly `0.166/0.951 rad/T^2`, and yaw rate is only `0.328 rad/T`.
  The fish is therefore stably coasting across the capture boundary with a
  large predicted intercept miss rather than arriving with too much cadence
  or unstable yaw.

## Policy hypothesis

Start from the evaluated `v39_geometry_agreed_course_allocation` policy and
preserve its oscillator, signed outer course/geometry consent, exclusive
response allocator, mean redirect curvature, closure preview, and validated
intercept-supported release. Add one complementary terminal mechanism: below
the existing `1.6 L` relief band, when range is closing, both redirected
joints have settled, and the constant-center-course predictor remains outside
the existing intercept corridor, recover a small coupled share of the same
carrier. The support is the complement of `terminal_intercept_support`, so it
is disjoint from the previously rejected cadence recovery inside an already
supported glide. It neither changes mean curvature nor assigns a special role
to either joint, and it adds no acceleration authority.

The expected effect is to give the strongly bent body enough paired rhythmic
actuation to convert its remaining transverse course into radial progress,
shortening the `1 L`-to-capture segment without altering the already improved
outer path. Falsify this candidate if the new branch is dormant, overlaps the
supported-intercept branch, changes outer commands, delays or loses capture,
creates an overshoot or loop, worsens mean/final distance, restores terminal
bang-bang commands or joint-stop dwell, raises force/moment loads materially,
or degrades either wake view. The new CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: terminal approach scheduling in biological swimming and sensor-modulated robotic-fish coupled oscillators
source_mechanism: retain a bounded coordinated beat when near-target steering still needs hydrodynamic authority, while allowing a quiet hold only after the observed intercept is supported
transferable_invariant: a settled static bend should not coast without rhythmic authority when normalized body-frame translation still predicts a miss; any recovered drive must remain coupled, bounded, and gated by realized response
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact tail or vortex phase, target coordinates, capture route, and actuator hardware
policy_translation: use the complement of the existing body-frame center-intercept support together with normalized proximity, positive closure, and two-joint settled response to recover one small paired share of the existing carrier without changing mean curvature or command limits
falsification: reject on dormancy, overlap with the intercept-supported cadence regime, changed outer commands, slower or lost capture, an overshoot or loop, worse distance integral, renewed clipping or joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- On every stored state reconstructed from the sampled `v37`, `v38`, and
  geometry-agreed `v39` trajectories, the new branch is active on `0/0/80`
  states, respectively. It changes exactly those 80 high-miss terminal states
  of the selected `v39` baseline, changes no state at or above `1.6 L`, and
  changes no fully intercept-supported state. The maximum same-state command
  delta is about `0.03344 rad/T^2`; the sampled acceleration ceiling remains
  `30.54326 rad/T^2`.
- On the inherited loop trajectory, the branch is supported on 603 terminal
  states but remains bounded; that same-state result does not imply the new
  policy would reproduce or repair the loop. Its value is only that the
  terminal cue is independently active on the topology it is intended to
  diagnose.
- A deterministic `321,489`-state grid spanning range, target and center-course
  angles, translation speed, both joint angles and rates, and yaw response has
  `1,224` changed cases. All outputs are finite and within the declared
  acceleration limit; all states at or above `1.6 L` and all fully
  intercept-supported states are exactly identical to the sampled
  geometry-agreed parent. These checks establish activity, boundedness, and
  locus separation, not coupled-flow improvement.
- The parameter-schema audit resolves all `87` direct `params.FIELD`
  references in the `88`-field object returned by `target_policy_params()`;
  only the version label is intentionally unused. The required check-runner
  was invoked but its pinned `gpt-5.4-mini` model is unavailable on this
  account, so its three configured checks were run directly and separately.
  The material-guidance check, lightweight two-output Julia contract, and
  solver edit-boundary check all pass. The guidance check initially exposed a
  duplicate assigned-parent marker in the rendered root `README.md`; removing
  only the duplicate marker repaired parent resolution. No formal CFD was run
  in this workspace.
