# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `capture` at `16.0545T`. Three repeat the carrier-residual yaw controller
  exactly (`0.747530L`, distance integral `1.931257L`, score `-0.048654`);
  the distinct assigned parent adds a terminal response release and improves
  the same-step crossing to `0.746955L`, distance integral `1.930773L`, and
  score `-0.048055`, with all `8/6/4/2/1.25/1.0/0.8L` milestones unchanged.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the assigned parent, a repeated sampled comparator, and the inherited
  target-bearing-support test. In every case the initially quiescent release
  develops a spatially trailing alternating red/blue wake by about `4T`; the
  oblique row shows corresponding compact three-dimensional posterior
  structures through capture. There is no passive advection, wake collapse,
  boundary interaction, or numerical breakup. The candidate must therefore
  preserve the oscillator, posterior wave, cruise route, and base redirect.
- No failure-class sheet is present: all available visual examples capture
  and are nearly indistinguishable at rendered cadence. The informative
  failed hypothesis is the inherited broad target-bearing-support cap. It
  began modifying the supplemental yaw branch from `1.675L`, preserved the
  wake and same-step capture, but worsened distance integral to `1.931345L`,
  final distance to `0.747637L`, and score to `-0.048763`. By contrast, the
  assigned parent's response-plus-corridor release changed only the terminal
  branch, slightly lowered mean posterior command (`24.616` to
  `24.600 rad/T^2`), and improved the route integral/crossing without changing
  hard-limit residence. This supports a narrow measured-response boundary,
  not earlier proximity-only attenuation or another scalar gain adjustment.
- Reconstructing body-frame target bearing from the assigned-parent trace
  localizes an unmodeled terminal response. Bearing falls from `0.031 rad` at
  `15.895T` to nearly zero at `15.934T`, then reverses and grows to
  `0.178 rad` at capture; its instantaneous rate becomes positive near
  `15.950T` and reaches about `3.26 rad/T`. The existing release uses measured
  body yaw as a proxy and does not directly distinguish improving from
  worsening target alignment. The reflection-even product of bearing and
  bearing rate does: it is positive only when bearing magnitude is locally
  growing, independent of which side the target occupies.

## One candidate mechanism

Keep the assigned parent's evaluated oscillator, carrier-response residual,
base redirect, wave allocation, approach law, anterior corridor release,
exact-boundary projection, and terminal yaw-response release unchanged. Add a
bounded body-frame *alignment-escape* signal to the same terminal-release
selector: normalize bearing rate by carrier frequency, smoothstep the positive
part of `bearing * normalized_bearing_rate`, and combine it with the existing
measured-yaw release only inside the already-evaluated closing capture
corridor. It can only remove supplemental carrier-yaw-residual curvature; it
cannot attenuate base target/course curvature, posterior wave shaping, or
anterior propulsion.

Expected result: preserve the parent's full pre-corridor trajectory and
coherent two-view wake, while releasing the extra curvature promptly if the
actual body-frame target error begins reopening despite a safe closing
intercept. This should retain capture and milestones, and may reduce terminal
tangential motion enough to improve crossing distance or distance integral.
Falsify it if any pre-corridor milestone changes, capture is delayed or lost,
the alternating wake changes, limiting/load growth offsets the terminal gain,
or the added direct-alignment response fails to improve on the assigned
parent's `1.930773L` integral and `0.746955L` crossing.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and biological burst redirect/terminal capture
source_mechanism: preserve the rhythmic carrier and release only supplemental redirect authority when measured target-compatible response supersedes persistent correction demand
transferable_invariant: corrective authority should be gated by normalized body-frame task geometry and observed response; inside a safe closing corridor, growing bearing magnitude is direct evidence that a residual steering correction should not remain blindly engaged
nontransferable_details: published gains, dimensional frequencies, species-specific C-start and capture kinematics, full-body waveforms, exact vortex phases, capture radius, and task-specific routes
policy_translation: form a reflection-even alignment-escape signal from bounded bearing times bearing rate normalized by carrier frequency, and let it extend only the existing corridor-gated release of supplemental posterior yaw-residual curvature
falsification: reject if the release acts outside the closing capture corridor, changes base steering or carrier semantics, loses capture or wake coherence, regresses milestones or distance integral, or fails to improve terminal geometry without adding load or limiting

## Non-CFD verification after the edit

- The final candidate SHA-256 is
  `a9ac52d7a9902c84a8a9e62230528851f36f373921b4a9b871aa0d0e7863fdda`.
  The deterministic parameter-schema guard and lightweight policy contract
  pass, including the new `yaw_alignment_escape_scale` owner field.
- A `26,244`-state deterministic sweep over joint state, both exact speed
  boundaries, target side, bearing rate, body-frame course, yaw response, and
  distance returned finite bounded commands, zero outward acceleration at
  either speed boundary, and exactly zero lateral-reflection error.
- Counterfactual evaluation on the assigned-parent states confirms scope, not
  a new closed-loop outcome: anterior commands are unchanged, only seven
  posterior states differ, every difference is inside `0.8482L`, and the
  maximum posterior change is `0.536 rad/T^2` versus the `31.416 rad/T^2`
  limit. The observed-state normalization was selected to make the structural
  signal testable without broadening it into the failed earlier approach cap.
- The dedicated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. Its three prescribed commands were run
  directly and separately after repairing the inherited duplicate assigned-
  parent marker in the rendered workspace `README.md`; guidance provenance,
  the policy contract, and the editable boundary all pass.

No formal CFD was run. The expected trajectory and wake effects above remain
falsifiable predictions for the post-worker evaluation.
