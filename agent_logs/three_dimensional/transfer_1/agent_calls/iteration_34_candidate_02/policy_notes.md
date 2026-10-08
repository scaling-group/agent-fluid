# Reproduced approach-retained partitioned posterior-turn candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Three byte-identical evaluations of the v47
  contraction-release prefill reproduce capture at `17.53399 T`, score
  `-0.0640479`, and total/observed distance integrals
  `1.949721/1.333721 L`.
- The completed v49 approach-retained geometry partition is the strongest
  sampled candidate: it captures at `17.48449 T`, score `-0.0616520`, and
  total/observed integrals `1.947439/1.331949 L`.  Against v47 it is closer by
  `0.02493/0.02289 L` at `6/8 T` and `0.03254/0.02969 L` at `16/17 T`, while
  trailing by `0.01002/0.02534/0.00116 L` at `10/12/14 T`.  Its earlier,
  deeper crossing (`0.745909 L` versus `0.746974 L`) is sufficient to improve
  both route integral and scalar score despite that middle-route crossover.
- The action and load evidence also favors v49 as a controller mechanism, not
  merely a terminal-sample accident.  Maximum speed falls from
  `0.97314` to `0.96017 L/T`, any-joint acceleration-limit residence falls
  from `42.75%` to `40.17%`, and peak normalized planar force/moment remains
  `0.032252/0.016092` in both traces.
- I inspected the combined and view-specific sheets for the strongest finite
  v49 rollout and a repeated v47 comparator.  Their top-down rows show active
  self-propulsion on smooth target-signed arcs: compact release vorticity grows
  into an organized alternating posterior street through capture, with no
  passive advection, reversal, boundary exit, or visible wake collapse.  All
  four current oblique sheets are black after their frame labels, however.
  That is a rendering/evidence failure, so this generation cannot claim that
  the sampled route improvement preserves the three-dimensional Lambda2
  topology; a readable later rollout must test that boundary.
- The inherited optimizer logs supply the informative negative comparison not
  present among the four all-capture current samples.  A normalized-distance
  handoff between contraction and yaw release changed observed integral by
  less than `0.000077 L` and worsened total integral/score to
  `1.950718/-0.06531`.  A geometry-partitioned sibling improved broad-route
  closure and saturation but crossed shallowly at `0.749953 L`; v49 preserves
  that geometry partition and returns target-signed posterior curvature on
  immediate approach, resolving the recorded terminal boundary without
  reopening cadence, thrust, or base route authority.

## One-candidate policy hypothesis

Replace the v47 prefill with the byte-identical completed v49 policy.  Preserve
the normalized body-frame target sensing, state-feedback traveling-wave
carrier, posterior lag, selective crossflow pose confidence, base
route/redirect steering, launch response, carrier-first spillover, half-cycle
steering, and componentwise acceleration projection.  Change only release of
the already useful phase-even posterior turn-shape residual: use de-gaited
bearing contraction inside the centerline window, use correct-sign de-gaited
yaw outside it, and taper only the yaw-release branch with normalized approach
geometry so target-signed posterior curvature returns near capture.

The next CFD evaluation should reproduce capture near `17.4845 T`, preserve
v49's early and late checkpoint leads, beat v47's total/observed integrals,
remain within the sampled `0.9602 L/T`, `40.2%`, and
`0.032252/0.016092` speed/saturation/force/moment envelope, and retain the
organized top-down wake.  Falsify the candidate if capture or either integral
regresses, the `10-14 T` deficit expands enough to erase the route gain,
target-signed curvature is lost, a held-out mirrored pose does not retain the
route benefit, or speed, saturation, force, or moment materially increases.
Do not assert three-dimensional wake preservation unless a future oblique
sheet is readable; reject the mechanism if such a sheet shows a degraded
caudal wake.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve the propulsive rhythm while releasing supplementary curvature after observed redirection, then let immediate target geometry regain terminal authority
transferable_invariant: supplementary wave-shape steering may yield when a normalized de-gaited response has the requested sign, but the release must remain subordinate to current body-frame target geometry while the carrier and base steering stay active
nontransferable_details: published gains, dimensional cadence or amplitude, species-specific curvature envelopes, full-body kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: partition only the phase-even posterior target-angle residual between body-frame bearing contraction and de-gaited yaw response, then taper the yaw-release branch with the existing normalized approach gate; preserve the two-joint carrier, base steering, and final actuator projection
falsification: reject if the sampled arrival and integral gains do not reproduce, middle-route closure materially worsens, capture or target-signed motion is lost, a held-out mirrored pose loses the route benefit, a readable oblique rollout shows wake degradation, or the established speed/saturation/load envelope is exceeded
```

## Evidence boundary

All outcome claims above come from the assigned parent guidance, sampled
completed solver traces, and inherited optimizer logs.  The sole candidate is
a reproducibility selection of completed v49 CFD evidence; no same-worker CFD
result is claimed.

## No-CFD implementation audit

- The sole policy is
  `dogfish_target_control_v49_approach_retained_partitioned_posterior_turn`,
  SHA-256 `4de1a19cf33218583e9ed51d671c19e8d76854087320f949d7413eb0fd3c8632`;
  it is byte-identical to the completed best sampled controller.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The lightweight Julia contract
  returns two finite bounded accelerations, and the solver editable-boundary
  check passes.
- A deterministic mirrored-state audit gives opposite-sign but unequal actions
  (`(-21.87,-4.19)` versus `(22.43,5.61)`).  This is not introduced by the
  v49 release: the inherited base route maps negative requests with
  `negative_turn_request_gain=0.78`.  Body-frame normalization therefore does
  not establish exact reflection equivariance, and this candidate's evidence
  applies to the completed target-sign rollout until a mirrored closed-loop
  evaluation tests that boundary.
- The configured check-runner was invoked but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact no-CFD commands were run
  locally instead.  After removing the duplicated assigned-parent marker from
  the rendered workspace `README.md`, guidance provenance, policy contract,
  and solver boundary all pass.
