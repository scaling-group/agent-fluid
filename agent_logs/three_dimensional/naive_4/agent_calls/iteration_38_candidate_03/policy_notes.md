# Role-specific response handoff for bounded posterior redirect

## Evidence diagnosis before the policy edit

- All sampled rollouts and the assigned-parent rollout satisfy the frozen
  Phase 2 contract: direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture.
  There is no failed termination in this allocation, so the weaker finite
  captures and inherited mechanism regressions are the informative controls.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the sampled-best translational-persistence policy
  (`solver_1a8c73736b49`), the weaker moment-only policy
  (`solver_2acfcfa19ef8`), and the response-hold regression
  (`solver_9174fd7e4c02`) from release through capture. Each top-down row shows
  a compact release transient developing into a coherent alternating caudal
  wake behind a smooth target-directed arc. Each oblique row shows bounded,
  alternating three-dimensional structures without wake collapse, collision,
  boundary exit, or out-of-plane instability. Since the background velocity
  is zero and the fish traverses the task, the motion is self-propelled rather
  than advected. The sheets are nearly indistinguishable at their sampling
  resolution, so trajectory, response, limiting, and load evidence—not vortex
  prominence—must choose the mechanism.
- Translational target-line opposition inside the existing `2 deg` shared
  correction envelope is the sampled winner. Relative to moment-only, it
  advances the `8/6/4/2/1.25L` milestones by
  `0.0110/0.0385/0.0440/0.0330/0.0440T`, advances capture from
  `15.735508T` to `15.686007T`, lowers distance integral from `1.919818L` to
  `1.916135L`, lowers posterior acceleration-limit residence from `23.59%` to
  `22.34%`, and improves final distance from `0.744372L` to `0.743392L` while
  preserving both wake views. Peak yaw moment rises from `0.01920` to
  `0.02036`, so retaining the route gain without indiscriminately extending
  correction is the relevant boundary.
- The assigned parent's carrier-demodulated yaw handoff is independently
  positive on the moment-only branch: it captures at `15.713508T` with
  distance integral `1.917987L`, ahead of the moment-only `15.735508T` and
  `1.919818L`. However, the sampled combined implementation applies the same
  handoff after moment and translation have already been unioned. That erases
  part of the translation-persistence gain, reaching only `15.697008T`,
  `1.919504L`, and score `-0.036840`, all worse than the sampled-best
  `15.686007T`, `1.916135L`, and `-0.033442` despite an intact wake. This is a
  controller-composition failure: measured target-aiding yaw is evidence for
  releasing anticipatory moment rejection, not evidence that directly
  observed adverse target-line translation has cleared.
- The inherited response-hold policy supplies the opposite boundary. Letting
  translational opposition retain duty after the established raw-error onset
  closes captures at `15.730008T`, increases distance integral to `1.920874L`,
  and scores `-0.038132`. Its path turns farther laterally while losing useful
  forward progress, even though its wake remains coherent. Translation should
  therefore keep the sampled raw-error opening and approach fade; the current
  candidate changes only which response branch the yaw handoff is allowed to
  release.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG direction control
source_mechanism: large target error opens bounded steering, while measured target-aiding body response releases the anticipatory correction back toward rhythmic propulsion
transferable_invariant: response-based handoff must release only the anticipatory steering role whose requested response has appeared; an independent adverse route-response observation must retain its own bounded authority until that observation clears
nontransferable_details: published gains, dimensional yaw and moment scales, species-specific C-start shape, exact tail-beat or vortex phase, clock-defined maneuver stages, world coordinates, and task-specific routes
policy_translation: preserve the normalized joint-state traveling bend and raw-error-opened body-frame translation correction; attenuate only the carrier-demodulated moment-opposition gate with target-signed carrier-demodulated yaw before smoothly unioning it with the unchanged translation-opposition gate under the existing 2 degree ceiling
falsification: reject if capture or an established milestone regresses, distance integral worsens, the coherent two-view wake or force/moment envelope degrades, posterior limiting grows without route benefit, or the reordered handoff changes no feasible posterior action
```

## One candidate hypothesis

Produce exactly one candidate from the sampled-best translational-persistence
policy. Preserve its anterior oscillator, posterior traveling wave, axial-force
response allocation, target/course steering, phase residuals, approach and
terminal shaping, mean-first allocation, and exact actuator projection. Keep
the current raw-error-opened translation-opposition gate unchanged. Compute the
existing target-aiding carrier-demodulated yaw gate before response composition,
multiply only the moment-opposition branch by its complement, and then smoothly
union that handed-off moment branch with the untouched translation branch.

This is a role-specific feedback composition, not a gain change: the same
normalized yaw response that improved the isolated moment controller cannot
silence measured adverse target-line translation. The union remains inside the
same `2 deg` curvature ceiling and retains the same target-defined turn sign.
The falsifiable expectation is to preserve the sampled-best route while
removing moment-only curvature after useful yaw appears. Formal CFD occurs
after this worker exits, so no outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `e23c5d402f18753b5de16b3bb9a6b848ef1fa72a48e9e455a7c05faca3b336ce`.
  Static schema validation resolves exactly 57 fields returned by
  `target_policy_params()` and the same 57 direct `params.FIELD` references,
  with no missing or unused field. The mechanism adds no gain or parameter.
- Counterfactual evaluation on reconstructed states from the sampled-best
  trace changes 85 of 2,852 posterior commands and no anterior command over
  `0.5665-13.8655T`. Mean and maximum changed-command magnitudes are `0.06490`
  and `0.58100 rad/T^2`. One pointwise action newly reaches the acceleration
  ceiling, so closed-loop limiting is an explicit falsification check rather
  than a claimed benefit. The replay establishes non-clamp-equivalent support;
  it does not predict the post-exit CFD outcome.
- A deterministic 5,000-pair sweep across mirrored body-frame target geometry,
  translation, load, joint phase, bearing rate, and yaw response returns finite
  actions inside the declared acceleration envelope with exactly zero lateral-
  reflection error. Non-finite target, velocity, force, moment, bearing,
  bearing-rate, and yaw observations also select finite fallbacks.
- The configured check-runner was invoked as required, but its pinned
  `gpt-5.4-mini` model is unsupported for this account. Its three prescribed
  commands were therefore run directly and separately: guidance materiality,
  the lightweight Julia contract, and the solver editable-boundary check all
  pass. The guidance check first exposed the inherited duplicate assigned-
  parent marker in the rendered `README.md`; removing only that duplicate
  repaired the metadata defect recorded in inherited logs. No formal CFD was
  run.
