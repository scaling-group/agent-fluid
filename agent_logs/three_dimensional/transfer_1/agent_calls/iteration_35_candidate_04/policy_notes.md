# Centerline-deadband-qualified posterior-response release

## Completed evidence and visual diagnosis before editing

- All four sampled episodes terminate in finite `capture` from direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  The
  duplicated v49 samples are byte-identical, so the sampled set contains three
  distinct controllers: the v48 distance handoff, v49 approach-retained
  geometry partition, and assigned prefill v50 geometric qualification.
- I inspected the combined sheets from release through capture.  All three
  distinct top-down rows show active self-propulsion on smooth target-signed
  arcs: compact startup vorticity develops into a coherent alternating
  posterior street, without collision, reversal, wake collapse, or passive
  advection.  V48 also has a readable oblique row with paired caudal Lambda2
  structures through capture.  Both v49 copies and v50 have black oblique rows
  after frame 000; that is an evidence/rendering failure, so neither their
  numerical route gains nor this candidate can be justified as a comparative
  3D-wake improvement.
- V48's normalized-distance arbitration is the informative regression.  It
  captures at `17.52849 T`, score `-0.06531`, and total/observed distance
  integrals `1.950718/1.333644 L`.  V49's response partition plus immediate-
  approach priority improves those values to `17.48449 T`, `-0.06165`, and
  `1.947439/1.331949 L`.  V50 then requires angular completion as well as
  correct yaw before the supplementary posterior curvature yields: it improves
  again to `17.41299 T`, `-0.05952`, and `1.945327/1.329976 L`, with a deeper
  `0.745094 L` terminal sample.
- The v50 gain is a route-semantic result, not generic effort relief.  Relative
  to v49 it is closer by `0.0121/0.0364/0.0356/0.0380 L` at
  `10/12/14/16 T`, but it gives back v49's lead by being
  `0.0249/0.0225 L` farther away at `6/8 T`.  Maximum speed rises from
  `0.9602` to `0.9831 L/T`, while the sampled peak normalized planar force and
  moment remain `0.032252/0.016092`.  The inherited notes also rule out
  reopening carrier cadence, approach thrust, or base route authority: four
  earlier approach-local changes worsened total integral, and v48's distance
  handoff did not reproduce the observed release crossover.
- Frozen-trace reconstruction is diagnostic, not closed-loop evidence.  On
  v50, its existing zero-error-normalized completion averages about `0.69` in
  the `6-8 T` band but only `0.05-0.07` from `12-16 T`.  Re-expressing only
  the correct-yaw qualifier relative to the already owned centerline and sweep
  boundaries raises its mean release from about `0.007` to `0.010` at
  `6-8 T`, while it remains below `0.006` from `12-16 T`.  This localizes a
  small falsifiable change without treating an offline replay as a predicted
  CFD gain.

## One-candidate policy hypothesis

Preserve v50's normalized body-frame sensing, state-feedback carrier,
posterior lag, selective crossflow pose confidence, base route and redirect
steering, launch response, carrier-first spillover, half-cycle steering,
componentwise projection, contraction release, and immediate-approach return
of posterior curvature.  Change only the geometric qualifier on the existing
out-of-band correct-yaw release.  Treat any de-gaited target bearing inside the
controller's existing `centerline_bearing_band` as geometrically complete, and
taper that confidence continuously to zero at `sweep_bearing_band`.  Keep the
existing out-of-band partition weight separate, so exact alignment still
needs no response release and large remaining target error still retains the
supplementary target-signed curvature.

This is a deadband-aware response transition, not a new gain or a distance/
route schedule.  The completed carrier, base steering, target sign, approach
priority, and physical envelope are unchanged.  The next CFD evaluation should
recover some of v49's `6-8 T` lead when correct yaw has entered the accepted
centerline region while preserving v50's `10-16 T` lead, decisive capture,
coherent top-down wake, and sampled speed/load/saturation envelope.  Reject the
mechanism if it loses capture, worsens either checkpoint regime or either
distance integral, creates beat-sensitive switching, reverses the target-
signed arc, exceeds the sampled envelope, or lacks a readable oblique row for
any claimed 3D-wake comparison.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while supplementary curvature releases only after observed correct yaw and an accepted geometric heading region agree
transferable_invariant: a response-triggered steering handoff should use a bounded target-error deadband, retain curvature outside that region, and leave the carrier and base steering active
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body CPG state, exact vortex phase, and task-specific routes
policy_translation: normalize de-gaited absolute body-frame bearing between the already owned centerline and sweep bands, and use that confidence only to qualify the correct-yaw release of the small posterior turn-shape residual
falsification: reject if the v50 late-route and capture gains regress, the v49 early checkpoint deficit is not reduced, switching becomes beat-sensitive, capture or coherent propulsion is lost, or speed, saturation, normalized force, or moment materially exceeds the sampled envelope
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent
guidance, sampled solver evaluations, and inherited optimizer notes.  The
deadband-qualified release is one unevaluated policy hypothesis; formal CFD
runs only after this worker exits.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v51_centerline_deadband_response_release`.  Its new
  completion value is computed only from de-gaited absolute body-frame bearing
  and two existing parameter-owned angular bands; no clock, route coordinate,
  mutable state, new gain, or unowned parameter was introduced.
- A deterministic `131,220`-state comparison with completed v50 changes only
  the posterior action on `1,122` states.  The anterior action is identical,
  all outputs are finite and componentwise projected, all `43,416` sampled
  states outside the sweep boundary are exactly unchanged, and the largest
  posterior difference is `0.05842 rad/T^2`.
- Frozen replay of all `3,166` v50 trajectory rows changes only `152`
  posterior commands, with a maximum difference of `0.07475 rad/T^2`; this
  confirms the intentionally narrow support but is not a closed-loop result.
  The required configured check-runner was invoked but could not start because
  its pinned `gpt-5.4-mini` model is unavailable for this account, matching the
  inherited infrastructure limitation.  Its three exact checks were therefore
  run locally and separately: the lightweight policy contract,
  parameter/guidance checker, and solver editable-boundary check pass.  No
  formal CFD was run.
