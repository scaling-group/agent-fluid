# Split Excess-Energy Regulation Candidate

## Evidence read before the edit

- The shared prewarm sheet shows the fish held at the upper right while the
  four asymmetric cylinder streets develop across the target and release
  corridor. The released sheet then shows a bounded diagonal turn into that
  disturbed corridor, followed by continued upstream-left motion and target
  capture at `73.8593` released time. There is no visible collision, domain
  exit, coil, or terminal loss of control.
- The motion is not just advection. Mean fish x velocity is `-0.14784` while
  mean local flow x is `-0.08219`, giving `0.06565` mean upstream-relative x
  speed. The rollout reaches `0.7490L`, has `2.4800L` mean distance and
  `0.9397` progress, and remains finite at RMS force/moment
  `24.94/410.68`.
- The successful route still exposes an energy/load weakness: both joint
  acceleration commands touch the `28` guard, anterior angle reaches
  `0.5259 rad` despite a `0.3840 rad` requested oscillation amplitude, and
  posterior speed reaches `3.3229`. This is consistent with wake-displaced
  phase-space energy rather than a need for more nominal amplitude.
- All four sampled solver files have the same active parameter values and
  formulas; only comments differ. Their prewarm sheets, released sheets, and
  all physical metrics are byte-for-byte or numerically identical. They are
  therefore replications of one `energy_gain=2.1` controller, not four policy
  mechanisms. No sampled visual failure comparator is present in this
  workspace. The assigned-parent evidence supplies the bounded contrast:
  constant gain `2.05` arrived faster with lower effort/load but slightly worse
  mean distance, while constant gain `2.2` selected a lower correction and
  regressed arrival, mean distance, relative propulsion, effort, and loads.

## Policy hypothesis

Keep the replicated `2.1` gain only when normalized oscillator energy is at or
below the requested orbit, preserving the observed recovery and compact
target-closure mechanism. Add a separately owned `2.2` excess-energy damping
gain used only when energy is above the orbit. The constant `2.2` result is not
evidence for increasing restoration: it changed energy injection and excess
damping together. This candidate isolates the latter so wake-driven overshoot
is damped more strongly without increasing deficit injection, changing gait
frequency, requested amplitude, steering, tail response, or acceleration
guards.

The candidate is supported if it retains target capture and approximately the
`2.1` route/relative propulsion while reducing guard contact, peak joint
motion, command effort, or force/moment load. It is falsified if the split
selects the inherited lower route, loses compact closure, increases load, or
behaves indistinguishably because the evaluated orbit rarely has excess
energy. Its CFD result is intentionally left for the post-worker evaluator.
