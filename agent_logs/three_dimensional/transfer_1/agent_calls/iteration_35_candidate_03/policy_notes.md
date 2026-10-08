# Decisive geometry-qualified posterior-response candidate

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical v49 evaluations reproduce capture at
  `17.48449 T`, score `-0.0616520`, and total/observed distance integrals
  `1.947439/1.331949 L`.  The completed v50 geometry-qualified response is the
  strongest sample: capture at `17.41299 T`, score `-0.0595203`, and integrals
  `1.945327/1.329976 L`.
- The v50 improvement is a route trade rather than a uniform lead.  Relative
  to v49 it is farther by `0.02493/0.02249 L` at `6/8 T`, then closer by
  `0.01211/0.03641/0.03558/0.03800 L` at `10/12/14/16 T`.  Relative to the
  distance-arbitrated v48 regression it is equal through `6 T`, then closer by
  `0.00040/0.00278/0.01108/0.03448/0.06850 L` at `8/10/12/14/16 T` and
  captures `0.11550 T` earlier.  This supports geometric qualification of the
  supplementary response release while preserving a concrete early boundary.
- I inspected the combined release-to-capture sheets for v50, both v49
  reproductions, and v48, including both prescribed rows.  Every top-down row
  shows active self-propulsion on a smooth target-signed arc: compact startup
  vorticity develops into a coherent alternating posterior street through
  capture, without reversal, passive advection, collision, domain exit, or
  visible wake collapse.  The v48 oblique row is readable and shows compact
  paired caudal Lambda2 structures through capture.  Both v49 sheets and the
  v50 sheet are black after the oblique frame labels, however; that is an
  evaluation/render failure, so neither the v49 nor v50 route change supports
  a comparative three-dimensional wake claim.  A later readable rollout must
  test preservation of the inherited 3D wake.
- Trace metrics favor retaining the carrier and changing only response
  arbitration.  From v49 to v50, mean/max speed changes from
  `0.72473/0.96017` to `0.72826/0.98310 L/T`, any-joint acceleration-limit
  residence falls slightly from `40.17%` to `40.11%`, and peak normalized
  planar force/moment remains exactly `0.032252/0.016092`.  The middle/late
  route gain therefore coexists with a modest speed cost and is not evidence
  for more cadence, amplitude, thrust, or base steering.
- The assigned parent and inherited logs provide the informative negative
  comparisons absent from this all-capture sample.  A normalized-distance
  handoff between bearing contraction and yaw response was behaviorally inert
  through `14 T` and worsened total integral/score to
  `1.950718/-0.06531`; earlier approach-local cadence, thrust, and route-gain
  variants likewise failed to improve total integral.  By contrast, v50 adds
  no route clock or new gain: it requires correct-sign de-gaited yaw and
  remaining body-frame angular geometry to agree before supplementary
  posterior curvature yields.

## One-candidate policy hypothesis

Start from the completed v50 controller and preserve its normalized body-frame
target sensing, state-feedback traveling-wave carrier, posterior lag,
selective crossflow pose confidence, base route and redirect steering, launch
response, carrier-first spillover, half-cycle steering, contraction release,
approach priority, and componentwise acceleration projection.  Change only
the geometric confidence used by the out-of-band correct-yaw release of the
small phase-even posterior turn-shape residual.

Normalize the existing bounded centerline-completion confidence `c` by the
owned dimensionless threshold `posterior_turn_response_completion_full=0.50`,
clamp the result to `u` in `[0,1]`, and pass `u` through the continuous
smoothstep `u^2(3-2u)` before it qualifies the yaw branch.  Frozen completed
traces place the useful early v49 response events around `c=0.38-0.46` and
the v50 middle/late retain-curvature regime around `c=0.03-0.07`; the threshold
therefore expresses an observed response class rather than a published gain.
The map commits more strongly to release when geometry supports completion,
where v49 held the early lead, but remains close to zero for weak completion,
where v50's retained target-signed curvature produced the `10-16 T` lead.  It
does not alter the contraction branch, schedule a route segment, or change
carrier propulsion.  The map is bounded, continuous, and even in signed
body-frame bearing.

The next CFD evaluation should retain v50's middle/late closure, capture,
integrals, coherent top-down wake, and force/moment envelope while recovering
some of v49's `6-8 T` lead.  Falsify the candidate if it loses capture, worsens
either integral or the `10-16 T` checkpoints, fails to improve the early
tradeoff, creates beat-sensitive switching, reverses target-signed motion,
exceeds the sampled `0.984 L/T`, `40.2%`, `0.032252`, and `0.016092`
speed/saturation/force/moment envelope, or a readable oblique rollout shows a
degraded caudal wake.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve the propulsive rhythm while supplementary curvature yields only when observed yaw response and geometric redirection agree
transferable_invariant: response-based release should commit when bounded body-frame completion confidence is strong and retain extra target-signed wave-shape steering when that confidence is weak, while carrier and base steering remain active
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body kinematics, clocked oscillator phase, exact vortex phase, and task-specific routes
policy_translation: normalize the existing centerline-completion confidence by an owned trace-separated threshold and smoothstep it before it qualifies the correct-yaw release of the posterior turn-shape residual; preserve the contraction branch, approach priority, two-joint carrier, and final actuator projection
falsification: reject if v50's middle and late lead, capture, integrals, target-signed arc, or bounded load envelope regresses, if the early tradeoff does not improve, or if a readable two-view rollout loses coherent posterior wake structure
```

## Evidence boundary

All outcome and visual claims above come from the assigned parent guidance,
sampled completed solver traces, and inherited optimizer logs.  The smooth
geometric commitment is one unevaluated state-feedback hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- An initial unnormalized smoothstep was rejected before finalization because
  frozen v50 replay changed only two posterior-action samples over `6-8 T`
  (maximum `0.00011 rad/T^2`) while concentrating changes later; it could not
  test the stated early-recovery boundary.  It was replaced by the completed-
  trace-separated threshold above, not retained as a second candidate.
- The sole materialized policy is
  `dogfish_target_control_v51_decisive_geometry_qualified_posterior_response`,
  SHA-256
  `6825a281ba9ba5115937e1d691393a3c40ad629c1f1de590c1224422e26f5ded`.
  Frozen replay on the completed v50 trajectory changes only the posterior
  action in `93` samples and never the anterior action.  Changes include
  `19/4/7` samples over `0-2/2-4/6-8 T`, with maximum posterior deltas
  `0.02620/0.00807/0.00463 rad/T^2`; later changes remain bounded by
  `0.07037 rad/T^2`, far below the `31.416 rad/T^2` component limit.  These
  are localization checks, not predicted closed-loop gains.
- The final candidate's confidence and yaw-release values exactly match the
  stated normalized smoothstep law on the reconstructed completed trace.  All
  tested actions are finite and componentwise bounded, all `69` direct
  `params.FIELD` references resolve among the `71` fields returned by
  `target_policy_params()`, and the lightweight contract, material-guidance,
  and solver-boundary checks pass.  No formal CFD was run.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account.  The three
  exact configured checks were therefore run locally and separately until
  they passed; the schema guard was also run explicitly.
