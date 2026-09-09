# Wake-policy candidate diagnosis

## Evidence read before editing

- Every sampled and inherited rollout reports direct uniform initialization in
  still water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Motion
  in both visual rows is therefore self-propulsion, not ambient advection.
- Both rows of the combined sheets were inspected for all four sampled solvers
  and the three unique inherited evaluations. The sampled `0.74934L` capture
  maintains a coherent alternating top-down street and compact oblique
  Lambda2 structures through `18.6065T`. The sampled `1.26695L` failure also
  builds a strong early wake but turns sharply below the target and later
  coasts, while the `3.0031L` and `3.1135L` failures retain propulsion without
  acquiring the useful route. This supports preserving the sampled traveling
  bend and achieved-course outer loop rather than adding route gain, lowering
  cadence, or suppressing the carrier.
- The assigned-parent evidence makes the threshold capture provisional: the
  identical LOS-guarded policy also missed at `1.7715L`. Adding a normalized
  projected-intercept guard improved the next inherited pass to `1.05090L`
  at `0.8656L/T`, with the alternating wake still present, so that geometric
  veto is the strongest completed terminal mechanism even though the rollout
  retained the lower-boundary exit.
- Two later within-beat realizations are concrete negative evidence. Adding
  joint-state half-cycle steering to the `1.05090L` intercept controller
  regressed to `1.74558L`; posterior phase-lag transfer in another inherited
  branch reached only `1.68181L`. Both remained `left_domain`, slowed closest
  approach to about `0.786L/T`, touched the `260 deg/T` joint-speed limit, and
  clamped returned acceleration on about `70.2/72.3%` and `70.6/72.4%` of
  rows. Their sheets retain a coherent wake into the pass. This falsifies
  another phase estimator, lag modulation, or scalar steering multiplier as
  the next useful change.
- The evaluated intercept controller also clamps acceleration on
  `70.4/69.7%` of rows and both joints touch `260 deg/T`. At its closest row,
  distance is `1.05090L`, speed is `0.8656L/T`, the projected miss is about
  `1.047L`, the approach alignment is already slightly receding, the bounded
  turn request is approximately `+1`, and response release is vetoed. The
  observation and command are therefore informative, but direct summation
  followed by a single final clamp can erase that command whenever the raw
  carrier acceleration is already beyond the envelope in the opposing sign.

## Candidate mechanism and falsification

Start from the completed `1.05090L` intercept-guarded controller. Preserve its
joint-state traveling bend, cadence, achieved-course error, yaw/LOS response
release, and target/velocity projected-pass veto. Add one saturation-aware
control-allocation primitive only in the existing terminal gate: compare the
inherited final-clamp command with a nested-saturation command that first
bounds the carrier and then adds the same steering residual, and smoothly
blend to the latter near the target. This does not add gain or steering
authority. It makes already-requested steering physically visible on the
carrier-opposing saturated half-beat while retaining a bounded alternating
carrier and the exact inherited behavior outside `4L`.

A recorded-trace projection is diagnostic, not a CFD prediction. On the
intercept rollout it changes `34.5/49.5%` of head/tail commands while distance
is below `4L`; projected acceleration saturation in that subset falls from
about `72.5/75.4%` to `40.0/30.3%`. At the `1.05090L` closest row, the blended
head/tail command changes from roughly `-31.42/-29.04` to
`-26.02/-19.43 rad/T^2`, retaining strong oscillatory actuation while exposing
the positive turn residual. Closed-loop CFD must determine whether that
allocation improves the path rather than merely changing the trace replay.

Expected test: preserve far-field closure and the coherent alternating wake,
then cross the `0.75L` radius or materially improve the `1.05090L` inherited
pass with a different useful trajectory and lower terminal acceleration
saturation. The candidate should not reproduce the slow `1.68--1.75L`
phase-asymmetry regressions.

Falsification: reject saturation-priority allocation if behavior outside `4L`
changes, the terminal traveling wake weakens or collapses, the closest pass
does not beat `1.05090L`, the same lower-exit topology remains without a
meaningfully different trajectory, joint-speed saturation or hydrodynamic
loads worsen, or a capture is not repeatable. A new capture is provisional
until an exact-policy repeat succeeds.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual control over rhythmic locomotion
source_mechanism: preserve the rhythmic locomotor carrier while applying a bounded sensor-driven steering residual through a lower-dimensional control channel
transferable_invariant: keep the evidenced traveling bend active, but allocate limited actuator authority so normalized body-frame interception feedback remains effective near the target
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, exact gait or vortex phase, duty ratios, learned policies, and task-specific routes
policy_translation: retain the two-joint carrier and intercept guard, then inside the existing terminal gate blend from final-only clipping to carrier-first nested saturation before adding the unchanged steering residual
falsification: reject if far-field closure changes, the coherent wake weakens, the 1.05090L pass does not improve, terminal saturation or loads worsen, or capture remains irreproducible

## Non-CFD verification

- The required guidance-provenance check, deterministic Julia policy contract,
  parameter-schema guard, and solver editable-boundary check pass. The policy
  returns two finite accelerations inside the actuator envelope.
- A paired synthetic lateral reflection negates both returned accelerations to
  `1e-12`. Direct allocation checks also confirm odd reflection symmetry,
  bounded output at the terminal gate, and bit-exact recovery of the inherited
  final-clamp expression when the terminal gate is zero.
- These checks establish implementation semantics only. No CFD was run, and no
  improvement is claimed for this unevaluated candidate.
