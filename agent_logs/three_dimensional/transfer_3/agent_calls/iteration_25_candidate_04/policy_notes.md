# Response-exclusive outer allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Two are
  byte-identical evaluations of the direction-conditioned limiter and
  reproduce capture at `21.912008 T`, score `-0.3246592933`, mean distance
  `2.218947189 L`, and final distance `0.747680604 L`.
- The assigned-parent saturation-separated target-residual allocator is a
  genuine improvement over that reproduced baseline: it captures at
  `21.735992 T`, scores `-0.3012661700`, has mean distance `2.194857233 L`,
  and reaches `0.749404609 L`. It reduces outer `|action|>30 rad/T^2`
  incidence from `1190/1757` anterior/posterior samples to `961/612` and
  retains the quiet terminal response, so lower clipping is useful here only
  because target feedback is allocated separately rather than because the
  whole command is attenuated.
- The strongest sampled policy instead conditions a small extra common-scale
  contribution on posterior lag-target error. It captures at `20.096998 T`,
  scores `-0.2975685868`, improves mean distance to `2.188311614 L`, and
  reaches `0.747254848 L`. Its semantic gain is concentrated after the `4 L`
  crossing: it reaches `4 L` at `15.873011 T`, similar to the parent's
  `16.109509 T`, but then captures about `1.82 T` sooner. It enters that band
  along a distinct upper-side trajectory and retains substantial carrier
  response; terminal `|action|>30` occurs on `387/486` samples and terminal
  force/moment maxima rise from about `0.01271/0.00713` to
  `0.02667/0.01348`, while global maxima remain close to the parent at
  `0.03039/0.01586` and the rollout stays finite.
- I inspected the complete combined sheets for the strongest response policy,
  the assigned parent, and the reproduced lower-scoring baseline, including
  the top-down mid-plane-vorticity and oblique body/Lambda2 rows from release
  through capture. Every fish visibly self-propels from quiescent flow along a
  compact target-directed arc, with a coherent alternating posterior wake and
  finite localized three-dimensional structures; none shows passive
  advection, a loop, collision, boundary-exit precursor, wake collapse, or
  out-of-plane instability. The assigned parent and baseline finish in a
  nearly straight held bend. The strongest sample remains visibly undulatory
  at the upper-right side of the capture sphere, consistent with its higher
  terminal speed and loads. There is no failed rollout in the current sample,
  so the reproduced lower-score capture is the informative control contrast.
- The strongest candidate's allocator is algebraically dormant at and below
  `4 L` for a fixed observation, yet its outer changes alter the state that
  enters that band and thereby suppress the previously active terminal hold.
  Offline same-state noninterference therefore did not imply rollout-regime
  noninterference. At the same time, the two new sampled allocators answer
  complementary questions: preserve the traveling-bend command when observed
  posterior response is poor, or preserve slow target feedback once that
  response is already coordinated.

## Policy hypothesis

Use the strongest sampled posterior-response-conditioned coupled limiter as
the outer carrier baseline. Add the assigned parent's drive-first target
residual allocation only in the complementary response regime: normalized
posterior lag support continuously withholds residual priority while the tail
is departing from its state-feedback target, and releases that priority only
as the tail settles. Direction distortion and normalized overload must still
be present. This makes the actuator allocator choose between traveling-bend
recovery and target-residual preservation instead of stacking both mechanisms
on the same overloaded state. The existing normalized outer gate makes the
new branch exactly zero at and below `4 L`; no cadence, mean bend, turn gains,
terminal release, force cancellation, rate reconstruction, world coordinate,
clock, route, or task identity is changed.

The expected benefit is to retain the faster response-conditioned trajectory
while preventing target feedback from being hidden on the subset of outer
states whose posterior joint is already coordinated. Falsify the candidate if
the residual branch is dormant, overlaps the high-lag response branch, changes
same-state commands at or below `4 L`, exceeds the acceleration envelope,
delays or loses capture, worsens mean distance, destroys the faster compact
trajectory, increases joint-stop dwell or global loads, becomes unstable, or
degrades either wake view. The next CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and sensor-modulated coupled-oscillator robotic-fish path following
source_mechanism: preserve anterior-to-posterior bend coordination during poor posterior response while applying target feedback as a separately observable bounded residual after the response settles
transferable_invariant: when rhythmic coordination and low-frequency route correction share bounded actuators, response state should select which objective receives allocation priority rather than blindly attenuating or stacking both
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific kinematics, exact phase or vortex timing, actuator models, capture geometry, and task-specific routes
policy_translation: use posterior lag-target error normalized by declared drive amplitude to make the direction-distortion-supported common limiter and the drive-first body-frame target-residual allocator complementary outside the normalized terminal band
falsification: reject on branch overlap or dormancy, terminal same-state interference, slower or lost capture, worse distance integral, changed useful trajectory, renewed stop dwell, material global load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Reconstructing normalized body-frame observations from all three distinct
  sampled traces shows that the complementary residual branch is active on
  `790/779/804` outer states from the response, assigned-parent, and reproduced
  baseline trajectories. Relative to the strongest response policy, the new
  commands change `790` stored states on its own trajectory with a maximum
  difference of `0.6632 rad/T^2`; the maximum across all three traces is
  `1.3420 rad/T^2`. Intermediate lag support produces a convex transition
  between priorities rather than two full-strength allocations.
- Every reconstructed or synthetic state at and below `4 L` is bit-identical
  to both sampled allocators. A separate `10000`-state stress grid confirms
  finite two-joint output within the declared acceleration limit. These checks
  establish activity, boundedness, and same-state terminal noninterference,
  not coupled-flow improvement or preservation of the realized terminal
  trajectory.
- The lightweight Julia contract, material-guidance comparison, solver edit
  boundary, and deterministic parameter-schema audit pass. All `84` direct
  `params.FIELD` references resolve in the `85`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused by
  the control algebra.
- The prescribed `check-runner` was invoked after the candidate and guidance
  edits, but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT
  account and failed before executing a command. Its three configured non-CFD
  checks were therefore run directly and separately; all pass. No formal CFD
  was run in this workspace.
