# Response-exclusive outer actuator allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen rollout contract: they use
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and terminate by
  capture. The assigned `v36` posterior-response-conditioned limiter captures
  at `20.096998 T`, scores `-0.2975685868`, and has mean/final distance
  `2.188311614 L`/`0.747254848 L`.
- I inspected every combined keyframe sheet from release through capture,
  including the top-down mid-plane-vorticity and oblique body/Lambda2 rows.
  Each fish self-propels from quiescent water along a compact target-directed
  arc and forms a coherent alternating posterior wake with finite localized
  three-dimensional structures. There is no passive advection, loop,
  collision, boundary-exit precursor, wake collapse, or out-of-plane
  instability. The two byte-identical saturation-separated residual rollouts
  visibly enter a quiet held-bend glide after about `16 T`; the assigned
  parent and response-exclusive rollout carry productive undulation to
  capture.
- The duplicated saturation-separated residual policy is the informative
  negative contrast. It captures at `21.735992 T`, scores `-0.3012661700`,
  and has mean distance `2.194857233 L`. Its quiet terminal regime removes
  acceleration-cap contact below `4 L` and reduces terminal force/moment
  maxima to about `0.01615/0.00871`, but the fish reaches `3/2/1 L` only at
  `17.666/19.497/21.252 T`. Preserving the target residual without conditioning
  allocation on posterior response therefore sacrifices useful closure.
- The sampled `v37` response-exclusive allocator is the strongest finite
  result. Relative to the assigned parent it advances capture from
  `20.096998 T` to `19.612991 T`, improves score from `-0.2975685868` to
  `-0.2829412229`, and lowers mean distance from `2.188311614 L` to
  `2.172435105 L`. Its `4/3/2/1 L` crossings are all earlier at
  `15.664/16.890/18.089/19.316 T`, while global force/moment maxima are
  slightly lower (`0.02959/0.01558` versus `0.03039/0.01586`) and both wake
  views remain coherent.
- The improvement does not validate stronger actuation generally. Below
  `4 L`, `v37` still has `432/552` anterior/posterior acceleration-cap
  samples, `121/123` joint-rate samples above `4.4 rad/T`, terminal
  force/moment maxima about `0.02847/0.01519`, and capture yaw rate
  `2.858 rad/T`. Those are downstream phase-space consequences even though
  the allocator branch is algebraically dormant there. This candidate tests
  reproduction of the winning allocation, not scalar gain growth or a claim
  that terminal carryover has been solved.

## Policy hypothesis

Replace the assigned parent's response-only outer limiter with the sampled
response-exclusive allocation while preserving all target guidance, drive,
redirect, terminal mean-bend, intercept-support, and actuator parameters.
When clipping rotates an overloaded outer two-joint command, poor normalized
posterior lag response retains direction-preserving common limiting; as that
response settles, a complementary share preserves the existing bounded
body-frame target residual after limiting the rhythmic drive. The shares
cannot stack, and the normalized distance gate keeps the mechanism exactly
dormant at and below `4 L`.

This is a direct reproduction candidate for the only current policy that
improves the assigned parent's capture time, score, mean distance, all four
late range crossings, and global load maxima together. It adds no cadence,
mean-curvature, force, route, world-coordinate, time, phase-clock, or scalar
gain change. Falsify the reusable result if the next CFD evaluation does not
reproduce capture and the faster distance history, changes the compact arc or
coherent wake, loses stability, or materially worsens joint-stop dwell or
force/moment loads.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated coupled-oscillator robotic-fish path following
source_mechanism: preserve anterior-to-posterior bend coordination during poor posterior response, then expose bounded target feedback only after that response settles
transferable_invariant: when rhythmic coordination and low-frequency route correction share bounded actuators, observed response should select which objective receives allocation priority instead of attenuating or stacking both
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific kinematics, exact phase or vortex timing, actuator models, capture geometry, and task-specific routes
policy_translation: use posterior lag-target error normalized by declared drive amplitude to partition direction-distortion-supported common limiting and drive-first body-frame target-residual allocation outside the normalized terminal band
falsification: reject on failed reproduction, branch overlap or dormancy, terminal same-state interference, slower or lost capture, worse distance integral, changed useful trajectory, renewed stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- The candidate is byte-identical to the sampled response-exclusive policy
  whose CFD evidence motivates this reproduction test. This establishes that
  no undocumented gain or mechanism was stacked onto the tested allocator.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and failed before executing a command.
  Its material-guidance, finite two-output Julia contract, and solver
  edit-boundary checks were then run directly and separately; all pass. The
  Julia contract returns finite accelerations inside the declared envelope.
- The deterministic parameter-schema audit passes: all `84` direct
  `params.FIELD` references resolve in the `85`-field object returned by
  `target_policy_params()`. The duplicate assigned-parent marker in the
  rendered root `README.md` was repaired so the mandatory guidance comparison
  resolves exactly one parent. No formal CFD was run in this workspace.
