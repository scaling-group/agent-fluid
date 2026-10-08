# Terminal divergence through posterior wave duty

## Completed evidence and visual diagnosis before editing

- All four sampled solvers are byte-identical v50 policies and byte-identical
  trajectories.  Each starts directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm, then self-propels to
  `capture` at `17.41299 T`, score `-0.0595203`, final distance
  `0.745094 L`, and total/observed distance integrals
  `1.945327/1.329976 L`.  Maximum speed is `0.98310 L/T`, any-joint
  acceleration-limit residence is about `40.11%`, and peak normalized
  force/moment is `0.032252/0.016092` in the inherited completed diagnostics.
- The sampled top-down rows show a compact startup disturbance developing into
  an organized alternating posterior vortex street while the fish follows a
  smooth target-signed arc.  Distance falls monotonically through the shown
  `12.8/12.4/10.0/7.4/4.0 L` checkpoints to capture, so the motion is active
  propulsion rather than advection; there is no reversal, collision, boundary
  exit, or visible wake collapse.  Three combined sheets have black oblique
  rows.  The remaining sheet has readable body/Lambda2 views at release,
  `4 T`, `16 T`, and capture, showing compact paired caudal structures, while
  its middle panels are missing.  Because all four dynamics are identical,
  this is a render/evidence anomaly rather than a controller failure or a
  comparative three-dimensional wake improvement.
- No sampled episode is a failure: all four reproduce the same strongest
  finite result.  The informative negative evidence instead comes from the
  inherited optimizer logs.  Instantaneous normalized target/velocity course
  slip has already regressed v50 in ordinary route authority
  (`-0.061186`, `1.946671/1.329989 L`), desired-yaw-rate response
  (`-0.059936`, `1.945663/1.329978 L`), and posterior wave shape
  (`-0.059547`, `1.945350/1.329982 L`), without a wake, arrival, speed, or
  load benefit and with extra posterior limit residence.  A fourth placement
  of the same cue is therefore not a new test.
- A frozen-trace audit also rejects untreated recent line-of-sight rate as the
  replacement cue.  Over the final `2.1 L`, the sum of body-frame
  bearing-window rate and recent yaw rate has `-0.992` correlation with
  anterior joint rate and `0.959` correlation with the already-falsified raw
  course signal.  The seven-step observation window is much shorter than the
  `0.55 T` carrier period, so calling that sum history-consistent would not
  make it route information.

## Sole candidate and policy hypothesis

Preserve v50's completed state-feedback carrier, posterior lag, launch
allocation, normalized target sensing, whole-wave pose rejection, selective
crossflow confidence, base route and redirect, half-cycle steering,
carrier-first spillover, geometry-qualified posterior turn-shape response,
approach priority, and actuator projection.  Add one small compatible
mechanism: when the existing de-gaited body-frame bearing is outside its
centerline band and its carrier-rejected trend is moving farther away, use
that geometric event to request target-signed terminal correction.  Require
the fish to be inside the normalized approach region and positively closing,
and make the request yield during the existing large-error redirect.

Translate that request into posterior half-cycle amplitude asymmetry rather
than another additive route or course residual.  Multiply the zero-mean
posterior traveling-wave target by a bounded duty factor whose sign comes from
the product of the reflection-odd correction request and the reflection-odd
observed carrier-wave side.  The product is reflection-even: it strengthens
the target-signed posterior half-cycle and weakens the opposite half-cycle
without changing cadence, the anterior oscillator, route means, or the
physical action bound.  It is exactly absent outside `2.1 L`, inside the
centerline band, while bearing contracts, while closing is absent, and under a
full redirect.

The next CFD rollout should be identical to v50 through the far and middle
route, retain capture and the organized two-view carrier, then reduce terminal
outward-bearing episodes enough to improve arrival depth/time or the total and
observed distance integrals without increasing the established speed,
saturation, force, or moment envelope.  Falsify the mechanism if it changes an
action outside approach, weakens radial closure, produces beat-synchronous
terminal weaving, arrives later or more shallowly, loses the target-signed arc
or wake coherence, or materially exceeds that envelope.  This candidate is an
unevaluated hypothesis; formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric-flapping control
source_mechanism: steer a continuing propulsive rhythm by bounded half-cycle amplitude or duty asymmetry instead of replacing the carrier with a route torque
transferable_invariant: a target-signed correction can bias opposite halves of an observed traveling wave while preserving its state-feedback phase, posterior emphasis, and action envelope
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, exact oscillator phase, prescribed routes, and vortex timing
policy_translation: use normalized body-frame terminal bearing divergence only as a trigger, then apply a small reflection-equivariant duty factor to the zero-mean posterior wave target while leaving v50's anterior carrier and mean steering intact
falsification: reject if far-route actions change, terminal divergence or capture does not improve, beat-synchronous weaving or clipping grows, or the completed trajectory, speed, load, and readable two-view wake envelope regresses
```

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v54_terminal_divergence_wave_duty`.  All `69`
  distinct direct `params.FIELD` references resolve among the `71` fields
  returned by `target_policy_params()`; the other two fields are the version
  label and inherited `control_period` metadata.
- A deterministic `5,184`-state audit verifies that the new terminal trigger
  is reflection-odd, its posterior duty scale is reflection-even, and the
  isolated modulated drive remains reflection-odd.  It also verifies finite
  bounded actions and exact v50 agreement outside approach, without positive
  closure, and while the head-carrier-rejected bearing contracts.  V50's
  inherited directional gain asymmetry remains unchanged and is not
  misreported as full-policy reflection equivariance.
- Frozen replay on all `3,166` completed v50 trace rows changes no action
  before distance enters `2.1 L`, without positive closure, or while the
  trigger bearing contracts.  The request is supported on `145` rows from
  `15.763 T`, `2.099 L` through `17.248 T`, `0.897 L`; actuator projection
  leaves a finite action difference on only `36` rows.  Maximum reconstructed
  action difference is `1.7561 rad/T^2`, maximum request magnitude is
  `0.49592`, and the largest realized posterior duty shift is `2.490%` even
  though the hard mechanism bound is `8%`.  This establishes scope, parity,
  sign, and headroom only—not a closed-loop performance result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this ChatGPT account.  Its exact lightweight Julia
  contract, material-guidance, and solver editable-boundary checks were rerun
  locally and separately and pass.  The guidance check initially found the
  same duplicated assigned-parent marker documented by inherited workers;
  removing only that duplicate from the rendered workspace `README.md`
  repaired provenance.  No formal CFD was run.
