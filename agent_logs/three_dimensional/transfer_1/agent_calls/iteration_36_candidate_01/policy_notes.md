# Geometry-qualified posterior-response candidate

## Completed evidence and visual diagnosis before editing

- All four sampled episodes are finite `capture` rollouts initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Two byte-identical evaluations of the assigned v49
  approach-retained partition reproduce capture at `17.48449 T`, score
  `-0.0616520`, and total/observed distance integrals
  `1.947439/1.331949 L`.
- The completed v50 geometry-qualified response is the strongest sampled
  result: it captures at `17.41299 T`, score `-0.0595203`, and
  total/observed integrals `1.945327/1.329976 L`.  Relative to v49 it gives up
  `0.02493/0.02249 L` at `6/8 T`, then leads by
  `0.01279/0.03641/0.03554/0.03727 L` at `10/12/14/16 T`, so the improvement
  is a middle/late route correction rather than a carrier-speed change.
- The v51 decisive smoothstep comparator is an informative regression rather
  than a new success.  It recovers a `0.03010/0.03356 L` lead over v50 at
  `6/8 T` and remains slightly closer through `14 T`, but trails by
  `0.01760 L` at `16 T`, captures later at `17.45149 T`, and worsens score and
  total integral to `-0.0612916/1.946554 L`.  Its lower maximum speed
  (`0.96666` versus `0.98310 L/T`) does not compensate for acceleration-limit
  residence rising from `40.11%` to `42.99%`; both retain the same sampled
  `0.032252/0.016092` peak normalized force/moment scale.  This rejects making
  the release commitment steeper merely to recover early closure.
- I inspected the strongest v50 and informative v51 combined sheets from
  release through capture, including both prescribed rows, and compared them
  with the two v49 reproductions.  Their top-down rows show active
  self-propulsion on the same smooth target-signed arc: compact release
  vorticity develops into an organized alternating posterior street, with no
  reversal, collision, domain exit, or visible wake collapse.  V51 introduces
  no beneficial top-down wake topology.  Every sampled oblique row is black
  after its frame labels; this is an evidence/render failure, so no
  comparative Lambda2 or three-dimensional wake-preservation claim is made.
  A readable later oblique rollout remains a falsification boundary.
- The evidence favors a completed response-arbitration mechanism, not added
  propulsion, base steering, or scalar gain tuning.  V50 differs from v49 only
  by requiring remaining normalized body-frame angular completion to agree
  with correct-sign de-gaited yaw before the small out-of-band posterior
  residual yields.  V51 shows that replacing this proportional confidence
  with a more decisive nonlinear commitment trades away late closure and the
  best total route.

## One-candidate policy hypothesis

Materialize the completed v50 policy as the sole candidate.  Preserve v49's
normalized body-frame target sensing, state-feedback traveling-wave carrier,
posterior lag, selective crossflow pose confidence, base route and redirect
steering, launch response, carrier-first spillover, half-cycle steering,
centerline contraction release, approach priority, and componentwise actuator
projection.  Change only the out-of-band correct-yaw release of the small
phase-even posterior turn-shape residual: multiply it by the existing bounded
centerline-completion confidence.  Correct-sign yaw can then release redundant
curvature as target geometry contracts, but cannot alone announce completion
at large de-gaited target error.  This is the exact completed v50 mechanism;
no published gain, route clock, or new scalar tuning is introduced.

The next CFD evaluation should reproduce capture near `17.413 T`, score and
total/observed integrals near `-0.05952` and `1.94533/1.32998 L`, the v50
middle/late lead over v49, the organized top-down wake, and its completed
speed/saturation/load envelope.  Falsify the candidate if the result does not
reproduce, capture or the `10-16 T` closure advantage is lost, target-signed
curvature reverses, force/moment or limit residence materially grows, or a
readable oblique rollout shows degraded caudal wake structure.  Formal CFD
runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: preserve a propulsive rhythm while supplementary maneuver curvature releases only when observed turning response and remaining target geometry agree
transferable_invariant: correct-sign yaw is insufficient by itself to declare a redirect complete; bounded extra wave-shape curvature should yield continuously only as normalized body-frame angular error also contracts, while carrier and base steering remain active
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body kinematics, clocked oscillator phase, exact vortex phase, and task-specific routes
policy_translation: multiply only the out-of-band correct-yaw release of the phase-even posterior target-angle residual by the existing even centerline-completion confidence; preserve contraction release, approach priority, the two-joint carrier, and final actuator projection
falsification: reject if the completed v50 arrival and total-integral gain do not reproduce, middle or late closure regresses, capture or target-signed motion is lost, the action/load envelope grows materially, or a readable oblique rollout loses coherent posterior wake structure
```

## Evidence boundary

Outcome claims above come from the assigned parent, the four sampled solver
results, and inherited optimizer logs.  The sole candidate is a reproducibility
selection of completed CFD evidence; no same-worker evaluation is claimed.

## No-CFD implementation audit

- The sole materialized policy is
  `dogfish_target_control_v50_geometrically_qualified_posterior_response`,
  SHA-256
  `cf9ca6aa2892b1aa4298d75c1359d84c467330129e0ea6167857742403b046ab`;
  it is byte-identical to the completed strongest sampled v50 controller.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The material-guidance check,
  lightweight Julia policy contract, and solver editable-boundary check pass.
- The required `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account.  Its three
  exact no-CFD commands were therefore run locally and separately and pass.
  No formal CFD was run.
