# Evidence-backed crossflow-confidence candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled solver rollouts are finite captures from direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  Three policy-equivalent v34 samples capture at `18.403006 T`,
  score `-0.140449`, and total/observed distance integrals
  `2.027810/1.418099 L`.  The v38 crossflow-confidence sample captures at
  `18.232491 T`, improves score to `-0.126500`, and lowers those integrals to
  `2.012983/1.399804 L`.
- I inspected the combined sheets from release through capture.  The v34 and
  inherited v37 sheets show both the top-down mid-plane vorticity row and the
  oblique body/Lambda2 row: the fish is self-propelled along a smooth
  target-signed arc, and its compact startup structures develop into a
  coherent alternating posterior wake without passive advection, collision,
  domain exit, or instability.  The v38 top-down row retains the same coherent
  wake and visibly reaches the target sooner, but every v38 oblique keyframe is
  black.  That is an evaluation-artifact failure, so the v38 rollout supports
  planar route and load conclusions but not a new claim about its 3D wake
  structure; the valid v34/v37 oblique evidence is the preservation baseline.
- Relative to v34, v38 is closer by about
  `0.0241/0.1060/0.1434/0.1415 L` at `4/8/12/16 T`.  Its mean/max speed is
  `0.7032/0.9519 L/T` versus `0.6961/0.9476 L/T`, while any-joint
  acceleration-limit residence falls from `42.14%` to `41.54%`.  Peak
  normalized planar force and yaw moment remain essentially unchanged at
  `0.03068/0.01579`.  Thus the improvement is route-wide sensing quality, not
  a terminal-sample accident or an unbounded propulsion increase.
- Relative to the assigned parent's monotone crossflow-pose controller, v38
  arrives `0.09350 T` sooner, lowers observed integral from `1.417990` to
  `1.399804 L`, lowers maximum speed from `0.9631` to `0.9519 L/T`, and lowers
  acceleration-limit residence from `43.55%` to `41.54%`, with the same force
  and moment scale.  The band-pass confidence therefore survives closed-loop
  CFD as a better boundary than treating greater crossflow as greater pose
  certainty.
- No sampled rollout changes termination class.  The inherited informative
  failure remains the whole-wave route-rate projection: despite an organized
  wake, it turned with the wrong sign, exited at `8.4755 T`, reached only
  `12.2107 L`, and raised peak normalized force/moment to about
  `0.3025/0.1347`.  The v38 fluid cue stays out of rate feedback, redirect
  selection, oscillator dynamics, and direct actuation for that reason.

## One-candidate policy hypothesis

Materialize the completed v38 crossflow-confidence controller as the sole
candidate.  Preserve the evaluated state-feedback traveling wave, posterior
lag, raw large-error redirect, mean-preserving whole-wave pose rejection,
head-only route-rate correction, raw half-cycle steering, closing-response
cadence release, bearing-divergence recovery, approach schedule,
carrier-first rejected-steering allocation, and componentwise acceleration
bounds.  Retain the one evidenced flow-side mechanism: normalize the magnitude
of local body-frame crossflow, pass it through the smooth band-pass confidence
law, multiply it by de-meaned anterior joint phase, and add the bounded odd
term only to proportional gait-pose rejection.

This choice tests reproducibility of the strongest sampled finite policy
without mixing in a new residual whose contribution could not be separated.
Expect capture near `18.2325 T`, observed integral near `1.3998 L`, the same
top-down alternating wake, maximum speed below `0.952 L/T`, acceleration-limit
residence near `41.6%`, and normalized force/moment near `0.03068/0.01579`.
Falsify the candidate if capture or the route-wide lead does not reproduce,
the speed/action/load envelope materially grows, or a valid later oblique
sheet shows loss of the established three-dimensional wake organization.

```text
bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target geometry from fast flow-correlated locomotor sensing and bound the confidence of the fluid-side correction
transferable_invariant: normalized body-frame flow may refine gait-pose rejection when coupled to observed joint state, kept small, and made to yield for disturbance-like magnitudes
nontransferable_details: published gains, species kinematics, clocked CPG phase, exact vortex phase, dimensional flow scales, cylinder-wake synchronization, full-body envelopes, and prescribed routes
policy_translation: retain the evaluated band-pass magnitude confidence on local body-frame crossflow, multiply it by de-meaned anterior joint phase, and apply the odd bounded term only to proportional pose rejection in the two-joint state-feedback contract
falsification: reject if the earlier capture and route-wide distance lead fail to reproduce, speed or actuator/load residence materially grows, or a valid oblique evaluation shows that the established organized 3D wake was not preserved
```

## Evidence boundary

The numerical and visual outcomes above come only from completed sampled CFD,
the assigned parent, and inherited optimizer logs.  The candidate placed in
this workspace will be evaluated after worker exit; no same-worker CFD result
is claimed.

## No-CFD implementation audit

- The sole candidate has SHA-256
  `bbe6ffbb32f9b95da3e575b44339c76746fcfd3d6d1420e7e7abed5983317d2a`
  and is byte-identical to the completed sampled v38 policy.
- The required guidance checker passes with a material reusable update.  The
  configured Julia contract returns two finite accelerations, and the
  deterministic schema guard finds all `61` direct `params.FIELD` references
  among the `63` fields returned by `target_policy_params()`, with none
  missing.
- The solver-boundary check passes with only
  `cases/dogfish_3d_shape_policy/candidate_target_policy.jl` changed from the
  frozen solver baseline.  No CFD was run.
- The prescribed `.codex/agents/check-runner.toml` agent was invoked first,
  but its pinned `gpt-5.4-mini` model is unavailable for this account.  Its
  exact three no-CFD commands were therefore executed locally and passed.
