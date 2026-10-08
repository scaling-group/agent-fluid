# Safe-intercept persistence for moment-residual steering

## Evidence diagnosis before the policy edit

- All four sampled solver evaluations satisfy the frozen contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. I inspected the combined
  sheets for the best sampled moment-residual policy
  (`solver_2acfcfa19ef8`) and the weakest sampled load-consensus policy
  (`solver_006ebd822d4e`) from release through termination. Their top-down
  rows both show a release transient developing into a coherent alternating
  caudal wake behind a smooth target-directed arc, so the zero-background
  translation is self-propulsion rather than advection. Their oblique
  body/Lambda2 rows retain compact alternating three-dimensional structures
  without wake collapse, collision, domain exit, or out-of-plane instability.
  The sheets are nearly indistinguishable; route and response metrics, not
  visible vortex strength, separate the policies.
- The prefilled carrier-demodulated moment policy is the sampled winner:
  capture at `15.735508T`, distance integral `1.919818L`, final distance
  `0.744372L`, `231` moving-window shifts, and score `-0.037222`. Adding a
  corroborating lateral-load curvature increment delays capture to
  `15.746509T`, worsens the integral to `1.921600L`, and scores `-0.039050`.
  Replacing part of the linear carrier classifier with an odd-cubic veto also
  delays capture to `15.741009T` and worsens the integral to `1.920970L`.
  These are negative evidence against more moment authority or broad
  carrier-observer vetoes; the evaluated linear, opposition-only moment branch
  should remain intact.
- The assigned-parent inherited log supplies the clearest release test. A
  policy that attenuates the same moment branch whenever carrier-demodulated
  yaw is target-aiding retains a coherent two-view wake and capture, but loses
  the moment policy's entire route gain: capture moves to `15.768509T`, the
  distance integral to `1.924377L`, final distance to `0.746139L`, and score
  to `-0.042067`. Instantaneous aiding yaw is therefore not sufficient
  evidence that anticipatory moment rejection is redundant.
- The winning policy currently fades moment-residual steering solely with
  proximity. A trace reconstruction of replacing that fade with the existing
  closing predicted-miss corridor leaves every state beyond `1.75L`
  unchanged, but retains feasible moment curvature on 98 sampled states from
  `1.733L` to `0.885L`. The mean and maximum added curvature on those states
  are about `0.435 deg` and `1.540 deg`, below the existing `2 deg` branch
  ceiling; the established corridor then removes it. This is measured
  non-terminal support, not a claim about the unevaluated closed-loop result.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: retain bounded redirect authority while target error remains unresolved, then release it continuously when measured course response establishes a safe intercept
transferable_invariant: preserve the traveling-bend carrier and target-directed base turn while allowing an anticipatory disturbance correction to persist until normalized body-frame target geometry and translation jointly show that the response is sufficient
nontransferable_details: published gains, dimensional yaw or moment scales, species-specific burst kinematics, exact tail or vortex phase, clock-defined maneuver stages, source wake geometry, and task-specific routes
policy_translation: retain the evaluated linear carrier-demodulated moment residual and its existing curvature ceiling, but replace proximity-only fade with the already normalized closing predicted-miss corridor so supplemental moment steering releases only on a reliable capture intercept and automatically reopens if that intercept is lost
falsification: reject if capture is delayed or lost, any established milestone or distance integral regresses, the coherent two-view wake or load envelope degrades, posterior limiting grows without route benefit, or the gate changes only terminal-scale actions
```

## One candidate hypothesis

Produce exactly one candidate by preserving the prefilled anterior oscillator,
posterior traveling wave, positive axial-response allocation, target/course
steering, base and yaw redirect, terminal line-of-sight damping, mean-first
actuation, and exact velocity-limit projection. Change only the release
condition for the successful moment-residual curvature: proximity alone no
longer suppresses it; the correction persists while its measured adverse
moment and reliable target redirect agree, then fades continuously as the
existing closing predicted-miss corridor becomes safe. Loss of closing,
course reliability, or the corridor restores the correction without a clock
or mutable state.

This is a response-conditioned persistence mechanism rather than a curvature
gain change. The falsifiable expectation is to preserve the best policy's
coherent gait and pre-approach route while advancing the `1.25L` or capture
milestone, or lowering distance integral, without increasing the established
force/moment and joint-limit envelope. Formal CFD is post-exit evidence, so no
outcome for this candidate is claimed here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `b1ff4a2e0cc1ea3d54a54ff088f91613536bc01f2eeb4b4365469da67f35541a`.
  The deterministic schema audit finds exactly 56 returned parameter fields
  and the same 56 direct `params.FIELD` references, with no missing or unused
  field. The prescribed lightweight Julia contract returns two finite bounded
  accelerations.
- A deterministic 13,122-state sweep across mirrored target geometry,
  body-frame velocity, joint state, yaw moment, yaw and line-of-sight response,
  and force returns finite actions inside the declared acceleration envelope
  with reflection error below `1e-10`.
- Counterfactual replay on reconstructed sampled-winner states changes only 37
  posterior commands and no anterior commands, from `14.9655T` to `15.6310T`
  and `1.5963L` to `0.8855L`. Mean and maximum changed-command magnitudes are
  `1.1696` and `3.5069 rad/T^2`, with no new acceleration-limit hit. This
  establishes feasible, non-clamp-equivalent middle-approach support but does
  not predict the unevaluated closed-loop hydrodynamic response.
- Guidance materiality, the lightweight policy contract, and the solver
  editable-boundary check pass directly. Invoking the configured check runner
  failed before execution because its pinned `gpt-5.4-mini` model is
  unavailable for this account, matching the infrastructure limitation in the
  inherited logs. No formal CFD was run.
