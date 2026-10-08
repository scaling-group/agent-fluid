# Direction-conditioned outer limiter coupling

## Evidence and visual diagnosis before the policy edit

- The assigned parent guidance promotes `v33` only after exact reproduction.
  All four current solver examples are byte-identical `v33` policies and
  reproduce the same direct-uniform still-water rollout: capture from
  `12.327720 L` at `23.435516 T`, score `-0.4079736071`, mean distance
  `2.305032573 L`, final distance `0.749060333 L`, and 265 moving-window
  shifts. Their matching policy, keyframe, and endpoint hashes make this
  strong replication of one mechanism, not evidence from four different
  controller structures.
- I inspected the complete combined keyframe sheet, including the top-down
  mid-plane vorticity row and oblique body/Lambda2 row from release through
  capture. The fish self-propels from verified quiescent flow, turns along a
  compact target-directed path, develops coherent alternating posterior
  shedding, and retains finite three-dimensional wake structures. The final
  frames show the inherited quiet held-bend glide rather than terminal
  thrashing, a loop, passive advection, wake collapse, boundary exit, or
  instability.
- No current sampled rollout is a termination failure. The most informative
  available visual contrast is the inherited `v29` componentwise-limiter
  baseline, whose two-view sheet is also coherent and captured but followed a
  slower outer path: `25.118523 T`, score `-0.5280772274`, mean distance
  `2.429087214 L`, final distance `0.746135294 L`, and 268 window shifts. The
  inherited head-point-rate and cadence-recovery tests supply concrete
  negative telemetry contrasts: both changed terminal commands while
  preserving the same visible capture topology, yet regressed to scores
  `-0.5281959396` and `-0.5281246771`. Thus the reusable improvement locus is
  outer joint coordination, not another terminal predictor, cadence recovery,
  or force/yaw override.
- Telemetry cross-checks the visual interpretation. Relative to `v29`, `v33`
  advances capture by `1.683006 T` and reduces mean distance by about
  `0.124055 L`; anterior/posterior cap incidence changes from roughly
  `39.2%/31.5%` to `26.7%/33.0%`, while neither policy clips inside `4 L` or
  dwells at a joint stop. Global force/moment maxima rise only slightly from
  about `0.02834/0.01499` to `0.02858/0.01520`, so load growth remains an
  explicit falsification boundary rather than a reason to discard the
  reproduced semantic gain.

## Policy hypothesis

Preserve every `v33` guidance, carrier, redirect, shared terminal mean-bend,
intercept/crossflow support, and the reproduced base `12%` outer common-scale
blend. Add one bounded actuator-coordination mechanism at the same validated
outer locus: compare the raw two-joint acceleration direction with the
componentwise-clipped direction, and smoothly add at most six percentage
points of common scaling only when their normalized two-dimensional angular
distortion is appreciable. The direction-error gate uses only the current raw
state-feedback command, is dimensionless and sign-symmetric, and is multiplied
by the existing distance gate so it is exactly absent throughout the `4 L`
terminal controller.

This is a feedback-structure test rather than scalar-only gain tuning. It
retains the already reproduced partial coupling as a floor and asks whether
selectively protecting the traveling-bend command during the most
direction-distorting overloads improves the faster path without paying for
stronger common scaling everywhere. Reject it if capture is lost or delayed,
score or mean distance regresses materially, the outer path or either wake
view degrades, terminal commands change, cap or joint-stop dwell grows, force
or moment growth becomes material, or the rollout becomes unstable.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body propulsion together with coupled-oscillator robotic-fish control
source_mechanism: preserve coordinated anterior-to-posterior traveling-bend structure when a bounded actuator envelope engages
transferable_invariant: limiting should preserve the direction of a coordinated multi-joint rhythmic command most strongly when independent component clipping would distort that direction
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact phase lags, vortex phases, capture geometry, and task-specific routes
policy_translation: retain normalized body-frame targeting and the reproduced base outer coupling, then use the sine of joint-space clipping angle to gate one small additional common-scale contribution outside the normalized terminal band
falsification: reject on terminal interference, non-reproduced capture, delayed arrival, worse distance integral, changed trajectory, cap or joint-stop dwell, material load growth, instability, or degradation of top-down or oblique wake coherence

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account. Running its three declared commands
  directly and separately gives PASS for the material guidance update, the
  finite two-acceleration Julia contract, and the solver edit boundary.
- A deterministic schema audit finds all 81 direct `params.FIELD` references
  in the 82-field object returned by `target_policy_params()`; only the
  version label is intentionally unreferenced.
- Synthetic limiter checks confirm exact componentwise output when the outer
  gate is zero, exact raw output without overload, a bounded `0.18` maximum
  blend for a direction-distorting overload, and no returned acceleration
  beyond the inherited limit. A synthetic inside-`4 L` state also returns a
  policy action exactly equal to evaluated `v33`, establishing algebraic
  terminal noninterference without claiming a coupled-flow result.
