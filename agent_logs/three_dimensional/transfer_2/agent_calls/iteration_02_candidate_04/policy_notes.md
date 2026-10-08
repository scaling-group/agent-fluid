# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The assigned parent is the response-gated redirect candidate
  `solver_dc5e319e8345`.  Its evaluation is a valid direct-uniform still-water
  rollout (`U_infinity=[0,0,0]`, no cylinders or prewarm).  It remains stable
  but exits through the lower virtual boundary at `28.369T`; distance falls
  from `12.328L` to `4.660L` at `18.568T`, then rises to `9.604L`.
- Both rows of the parent's combined keyframe sheet were inspected.  The
  top-down row shows sustained self-propulsion and a strong alternating wake,
  but the body sweeps below the target instead of reorienting after closest
  approach.  The oblique Lambda2 row confirms compact three-dimensional wake
  structures behind the translating fish.  The useful carrier should therefore
  be preserved; the failure is route-scale yaw control rather than absent
  thrust or advection.
- The response-release edit did not change the failure semantics relative to
  the transferred seed `solver_e1a03f18d808`: minimum/final distance changed
  only from `4.780/9.709L` to `4.660/9.604L`, both rollouts exited below, and
  thresholded yaw-rate sign reversals changed from 82 to 84.  In the parent,
  at least one raw joint-acceleration command exceeds the `1800 deg/T^2`
  envelope on `98.0%` of samples, joint-speed components remain within 1% of
  the `260 deg/T` limit on `12.3%` of samples, and peak yaw rate is
  `3.013 rad/T`.  Local flow remains small (`<=0.027U`) relative to body speed
  (`<=0.828U`), so a wake-rejection branch is not supported by this rollout.
- The evaluator's `turn_rate_recent` and `bearing_window_rate` span only the
  seven retained prior integration samples, about `0.0385T` here.  They remain
  tailbeat-scale signals.  Gating route bias directly with that yaw proxy did
  not suppress route-scale reversals, so another release-gain edit would not
  be evidence-led.
- The informative failures bound the next intervention.  The corrected-sign
  static mean-curvature candidate `solver_dc5bdf69e4ab` over-rotates almost
  immediately, reaches only `12.206L`, and exits above at `7.887T`; static
  curvature is therefore not a safe replacement for the carrier.  The
  globally slower, soft-limited progress redirect `solver_a1d9e06dfe8a`
  removes raw acceleration over-limit commands and leaves a coherent nearly
  straight wake, but sacrifices the deep approach (`8.752L` minimum) and also
  exits above.  Its result argues against changing cruise cadence everywhere,
  while leaving a state-conditioned late maneuver test open.

## Candidate hypothesis

Preserve the parent's demonstrated oscillator, posterior lag, target steering,
and response release.  Add one normalized maneuver-allocation mechanism: when
the target is materially off-axis *and* short-window distance progress has
stalled or reversed, continuously reduce carrier cadence; restore the original
cadence as either alignment or closing progress returns.  This leaves the
productive early approach unchanged, lowers the carrier's squared-frequency
acceleration demand only during the failed late topology, and gives the
existing curvature/rate steering a larger share of the fixed actuator envelope.
It does not add a global slow gait, a new steering polarity, or a scalar-only
gain sweep.

On an offline replay of the parent trajectory, the proposed gate is zero at
`4T` and `8T`, about `0.0001` at `12T`, `0.017` at `16T`, `0.322` at the
closest-approach sample, and above `0.96` once distance is increasing near
`20T`.  Thus the test is targeted at the post-approach failure rather than the
carrier segment that produced useful progress.  Expected evidence is retained
early distance reduction and wake coherence followed by a turn back toward the
target before the lower-boundary exit, with less late acceleration clipping.
Falsify the hypothesis if closest approach materially worsens, the same lower
exit persists without delayed distance growth, or the cadence relief destroys
the alternating wake or merely reproduces the globally slow candidate's upper
exit.

bookshelf_consulted: true
source_domain: Sensor-modulated robotic-fish CPG control and biological burst redirect.
source_mechanism: Reallocate rhythmic drive during a large observed route error, then release the maneuver as target alignment or useful translation returns.
transferable_invariant: Preserve the propulsive rhythm during useful closing motion, but temporarily reduce competing carrier demand when persistent body-frame error and lost progress require reorientation.
nontransferable_details: Published gains, dimensional cadence, species-specific C-start timing and shapes, motor dynamics, exact vortex phase, and source-task routes.
policy_translation: Multiply the existing joint-state carrier cadence by a bounded gate formed only from normalized body-frame target angle and normalized closing speed; keep the existing two-joint steering law and continuously restore cruise cadence when either condition clears.
falsification: Reject the transfer if early propulsion degrades, the parent lower-boundary topology remains, actuation remains clipping-dominated during the maneuver, or the fish is redirected into the sampled slow-candidate upper exit.

## Pre-evaluation checks

- The workspace guidance-delta check, lightweight Julia policy contract, and
  solver boundary check pass.  The boundary check confirms that the candidate
  repository differs from baseline only at the authorized policy file.
- A deterministic parameter-schema audit finds no direct `params.FIELD`
  reference absent from `target_policy_params()`.  An aligned, closing test
  observation gives bit-for-bit the assigned parent's action, while an
  off-axis receding observation activates a `0.977` maneuver gate and changes
  the command while remaining finite.
- These are algebraic and contract checks, not new CFD evidence.  Formal CFD
  evaluation remains deferred to EvE after this worker exits.
