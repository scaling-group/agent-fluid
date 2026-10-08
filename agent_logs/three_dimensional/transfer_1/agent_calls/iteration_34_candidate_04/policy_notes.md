# Bearing-coherent posterior-turn release candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver evaluations are finite `capture` episodes from
  direct uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Three byte-identical v47 contraction-only evaluations
  reproduce capture at `17.53399 T`, score `-0.0640479`, and total/observed
  distance integrals `1.949721/1.333721 L`.
- The assigned-parent guidance selected v47 after an inherited normalized-
  distance handoff failed to create its predicted route: that handoff is
  effectively identical through `14 T`, captures only one solver step earlier,
  and worsens total integral and score to `1.950718 L` and `-0.0653066`.
  Its readable combined sheet retains the same smooth self-propelled arc and
  organized alternating top-down/oblique wake, so the negative result is a
  response-selection failure rather than a carrier or wake-topology change.
- The sampled v49 approach-retained bearing partition is now the strongest
  completed policy.  It captures at `17.48449 T`, improves score to
  `-0.0616520`, and improves total/observed integrals to
  `1.947439/1.331949 L`.  Relative to v47, maximum speed falls from
  `0.97314` to `0.96017 L/T`, any-joint acceleration-limit residence falls
  from `42.75%` to `40.17%`, and peak normalized planar force/moment remains
  `0.03225/0.01609`.  It is closer by `0.0249/0.0229 L` at `6/8 T` and by
  `0.0325 L` at `16 T`, but trails v47 by `0.0100/0.0253 L` at `10/12 T`.
  Thus approach-retaining the posterior turn restores the earlier partition's
  weak terminal crossing without erasing its useful route, but correct-sign
  yaw alone still releases useful target curvature too early in the middle.
- I inspected the combined v49, v47, and failed-handoff sheets from release to
  capture.  Their top-down rows show active target-directed self-propulsion:
  compact startup vorticity develops into an organized alternating posterior
  street along a smooth target-signed arc, with no advection, reversal, domain
  exit, or wake collapse.  The readable v47 and failed-handoff oblique rows
  show compact paired caudal Lambda2 structures through capture.  The sampled
  v49 oblique row is black after frame 000, which is an evaluation/rendering
  failure; it is not used to claim a complete v49 3D wake, and a readable
  two-view result is an explicit falsification boundary for the new candidate.

## One-candidate policy hypothesis

Preserve v49's state-feedback traveling-wave carrier, posterior lag, normalized
body-frame target sensing, selective crossflow pose confidence, geometric
redirect, launch response, carrier-first spillover, half-cycle steering,
approach-retained posterior curvature, and componentwise actuator projection.
Change only the out-of-band yaw-release branch for the small phase-even
posterior turn-shape residual.  A correct-sign de-gaited yaw response is not by
itself completion of target redirection: multiply that release confidence by
the already computed normalized body-frame bearing-contraction response.  The
base route steering remains active, and the supplementary residual returns
when yaw and target-angle response disagree.

Frozen replay of the completed v49 trace localizes this architectural change
without treating it as closed-loop evidence.  It changes no release decisions
from `4-10 T`, then changes about `2.2/27.2/31.3/41.5%` of policy evaluations
over `10-12/12-14/14-16/16-capture T`; it also affects `3.6%` during the
initial `0-4 T` redirect.  The largest release-confidence reduction is
`0.351`.  The added contraction multiplier is bounded and reflection-even
because bearing and its rate reverse together; it adds no handedness beyond
v49's inherited response law.  This is a response-coherence test, not a gain
change or a route/distance schedule.

The next CFD evaluation should preserve v49's `6-8 T` lead and low speed/load
envelope, recover some of v47's `10-12 T` closure, retain the deeper v49
capture and improved total integral, and produce a readable organized wake in
both views.  Falsify the mechanism if early redirection or the v49 checkpoint
lead is lost, the middle-route regression is unchanged, target-signed
curvature oversteers or capture regresses, the approach crossing becomes
shallower, the new gate adds handedness relative to v49, or speed, limit
residence, normalized force, or moment materially exceeds the sampled v47/v49
envelope.  Formal CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while releasing supplementary curvature only after observed steering produces the intended geometric response
transferable_invariant: correct-sign yaw is not sufficient completion evidence when normalized body-frame target angle is not contracting; supplementary curvature should yield only when actuator response and target-error response are coherent
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body or clocked CPG state, exact vortex phase, and task-specific routes
policy_translation: multiply only the out-of-band yaw-release confidence for the bounded phase-even posterior turn residual by the existing de-gaited bearing-contraction response; preserve the carrier, base steering, redirect, approach gate, and final two-joint projection
falsification: reject if v49's early and late leads, capture, total integral, or organized two-view wake regresses, if the middle-route deficit is not reduced, if the new gate adds handedness relative to v49, or if speed, saturation, normalized force, or moment leaves the sampled envelope
```

## Evidence boundary

All rollout outcomes and visual claims above come from the assigned parent,
sampled completed solver results, and inherited optimizer logs.  The coherent
release law is one unevaluated candidate hypothesis; no same-worker CFD result
is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v50_bearing_coherent_posterior_turn_release`, SHA-256
  `9c829a7bc0ca4f6fabcc3ad8cc5c27849ce757bacba624582ef536448ecacb33`.
  Its only behavioral edit from completed v49 is the bearing-contraction
  multiplier on the out-of-band posterior yaw-release branch.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  A `9,216`-state synthetic
  contract audit keeps every output finite and within the componentwise
  acceleration envelope, changes no anterior action, and confirms zero mirror
  error for the newly added contraction factor.
- Frozen replay over all `3,179` completed v49 trace states changes only the
  posterior output in `216` states, with maximum action difference
  `0.12629 rad/T^2`; it changes no action from `4-10 T` on that trace and never
  changes the anterior output.  This is localization evidence, not a CFD
  prediction.
- The configured check-runner was invoked but could not start because its
  pinned `gpt-5.4-mini` model is unavailable for this ChatGPT account.  Its
  three exact non-CFD checks were then run locally and separately: material
  guidance/notes, the lightweight Julia policy contract, and the solver
  editable boundary all pass.  No formal CFD was run.
