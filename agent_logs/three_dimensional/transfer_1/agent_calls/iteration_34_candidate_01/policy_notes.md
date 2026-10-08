# Reproduced approach-retained partitioned posterior-turn candidate

## Completed evidence and visual diagnosis before editing

- All four sampled evaluations are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  Three byte-identical evaluations of the assigned
  v47 contraction-release parent reproduce capture at `17.53399 T`, score
  `-0.06405`, and total/observed distance integrals
  `1.949721/1.333721 L`.
- The completed v49 approach-retained partition is the strongest sampled
  controller.  It captures at `17.48449 T`, improves score to `-0.06165`, and
  lowers total/observed distance integrals to `1.947439/1.331949 L`.  Its
  `0.745909 L` terminal sample is deeper than v47's `0.746974 L` sample and
  the inherited geometry-partitioned sibling's `0.749953 L` sample.  Thus the
  near-target return of supplementary curvature repairs the intended terminal
  boundary without erasing the partitioned route gain.
- The checkpoint comparison is not uniformly better and constrains the claim.
  Relative to v47, v49 is closer by `0.02493/0.02289 L` at `6/8 T`, trails by
  `0.01002/0.02534/0.00116 L` at `10/12/14 T`, and leads again by
  `0.03254 L` at `16 T`.  Relative to the inherited geometry-partitioned
  sibling, v49 is identical outside the `2.1 L` approach region, captures one
  solver step later, and changes observed integral by only about `0.000042 L`,
  but its deeper crossing reduces terminal hold enough to improve total
  integral by about `0.00334 L` and score by about `0.00416`.
- I inspected all four combined sheets from release through capture, including
  both prescribed rows.  Their top-down views show active self-propulsion on
  the same smooth target-signed arc: compact release vorticity grows into a
  coherent alternating posterior street through capture, with no advection,
  collision, domain exit, or wake collapse.  Two reproduced v47 sheets have
  readable oblique rows showing compact paired caudal Lambda2 structures, but
  the v49 sheet and one v47 duplicate are black after oblique frame 000.  That
  is an evidence/render failure, so v49 supports no comparative 3D-wake claim;
  only its top-down coherence and preservation of the previously validated
  carrier are established.
- Trace metrics favor retaining the completed mechanism rather than adding
  thrust or another steering gate.  Versus v47, v49 lowers maximum speed from
  `0.97314` to `0.96017 L/T` and any-joint acceleration-limit residence from
  `42.75%` to `40.17%`, while peak normalized planar force/moment remains
  `0.03225/0.01609`.  Its mean speed changes only from `0.72352` to
  `0.72473 L/T`.  Inherited logs also show that the earlier `4.0 L` far-to-near
  release handoff was behaviorally inert through `14 T` and regressed total
  integral; the completed v49 result therefore supports distance only as a
  terminal return-of-authority gate after response partition, not as a learned
  route-stage switch.

## One-candidate policy hypothesis

Materialize the completed v49 controller byte-for-byte as the sole candidate.
It preserves the normalized body-frame carrier, posterior lag, selective
crossflow pose confidence, base route and redirect steering, launch response,
carrier-first spillover, half-cycle steering, and componentwise actuator
projection.  Its only difference from the assigned v47 prefill is the completed
response partition for the small phase-even posterior turn-shape residual:
de-gaited bearing contraction releases the residual inside the centerline
window, correct-sign de-gaited yaw releases it outside that window, and the
existing normalized approach gate returns target-signed posterior curvature
near capture.

The downstream evaluation should reproduce capture near `17.4845 T`, score
near `-0.06165`, total/observed integrals near `1.94744/1.33195 L`, and the
sampled speed/action/load envelope.  Falsify this selection if capture, route
integrals, the `6/8/16 T` leads, top-down wake coherence, or the deeper terminal
crossing fail to reproduce, or if a readable oblique rollout shows degraded 3D
wake structure.  Formal CFD occurs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst-turn response release and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a propulsive traveling rhythm while supplementary curvature yields to observed redirection, then let immediate target geometry regain steering authority
transferable_invariant: response-based release should affect only supplementary wave-shape steering, while normalized near-target geometry can continuously return that authority without stopping the carrier or base steering
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body kinematics, clocked oscillator phase, exact vortex phase, and task-specific routes
policy_translation: partition release of the small target-signed posterior residual between body-frame bearing contraction and de-gaited yaw response, then taper only the yaw-release branch with the existing normalized approach gate
falsification: reject if the completed score, route integrals, capture depth, speed/action/load envelope, or organized wake fails to reproduce under complete evidence or another pose and flow scale
```

## Evidence boundary

Outcome claims come only from the assigned parent guidance, sampled completed
solver results, and inherited optimizer logs.  This worker selects a completed
policy for reproduction and claims no same-worker CFD result.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v49_approach_retained_partitioned_posterior_turn`,
  with SHA-256
  `4de1a19cf33218583e9ed51d671c19e8d76854087320f949d7413eb0fd3c8632`;
  it is byte-identical to the completed sampled v49 controller.
- All `68` distinct direct `params.FIELD` references resolve among the `70`
  fields returned by `target_policy_params()`.  The lightweight Julia contract
  produces two finite accelerations, and the solver editable-boundary check
  passes.
- The configured check-runner was invoked but could not start because its
  pinned `gpt-5.4-mini` model is unavailable on this ChatGPT account.  Its
  three exact checks were run locally and separately until all passed.  The
  first guidance run exposed a duplicated assigned-parent marker in the
  rendered workspace `README.md`; removing only that duplicate repaired the
  provenance check.  No formal CFD was run.
