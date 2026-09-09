# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. This is the common initial condition,
  not candidate-specific evidence. The representative released sheet shows the
  parent immediately redirecting toward the target, sustaining a body-generated
  posterior traveling wave, and crossing diagonally into the merged wake for
  direct first entry into the `0.75L` capture circle. It is actively propelled,
  does not approach a cylinder, and shows no terminal overshoot or wake-driven
  turn reversal.
- All four current solver samples terminate in the same direct capture at
  `32.4720`, with `1.64761L` mean distance, `46,287.66` total command energy,
  `68.70` lateral-force RMS, and `931.60` yaw-moment RMS. All four policies are
  equation-equivalent (two are byte-identical and two differ only in comments),
  and their keyframe sheets are byte-identical, so the exact metrics establish
  deterministic replay at the common wake snapshot rather than independent
  mechanism evidence.
- The informative completed child in inherited optimizer evidence gates only
  the parent's incremental `8%` posterior half-cycle amplification when
  posterior speed or previous applied acceleration already reinforces that
  increment at a large fraction of the oscillator's own state scales. Its
  released sheet retains the same compact diagonal topology and captures at
  `32.7305`, only `0.2585` later, with `1.64927L` mean distance. Force RMS falls
  from `68.70` to `56.29` (`18.1%`) and moment RMS from `931.60` to `800.58`
  (`14.1%`), while mean command energy and power fall slightly to `1419.87` and
  `108.54`. Total command energy rises `0.4%` because the episode is longer.
- The headroom result does not prove less actuator saturation: inherited logs
  report that both joints still touch the speed and acceleration envelopes, and
  the compact metrics do not expose saturation residence. It establishes a
  navigation/load Pareto mechanism at one wake phase, not efficiency or robust
  capture across changed conditions.
- No failed rollout is present in the current four sampled solvers. The
  inherited failure boundary is the additive bearing-trend policy that erased
  the effective traveling bend, moved downstream, and exited at `16.956` with
  only `0.140/0.163 rad` peak joint excursions and `12.424L` closest approach.
  The current edit therefore adds no signed route-rate, force, moment, or
  crossflow residual upstream of the oscillator centers. A separate completed
  child that used bearing-window response to add a further posterior burst also
  regressed to `32.8240`, `1.66402L`, `70.97` force RMS, and `945.05` moment RMS;
  extra positive burst authority is not promoted.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop sensor-modulated robotic-fish CPG control interpreted through elongated-body posterior reactive propulsion
source_mechanism: yield a turn-congruent posterior rhythmic increment when observed joint state already presses in the same direction, while retaining the underlying lagged traveling wave
transferable_invariant: feedback may withdraw only incremental asymmetry using state normalized by the gait's own angle, speed, and acceleration scales; bounded target-signed mean curvature and the base propulsive wave must remain available
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator shares, and source-task routes
policy_translation: preserve filtered body-frame bearing, bounded shared curvature, oscillator, lag, damping, and the target-helping half-cycle; smoothly gate only its extra gain from posterior speed and previous applied acceleration when they reinforce the proposed wave increment
falsification: reject the gate if a repeated or held-out wake loses direct capture, navigation loss grows materially beyond the sampled 0.2585 time and 0.00166L mean-distance costs, load relief disappears, or saturation and instability worsen

## Candidate hypothesis

Produce exactly one candidate by promoting the completed state-normalized
posterior headroom gate. The policy preserves the evaluated parent's
`0.55`-period, `28 deg` oscillator, bearing-history filter, bounded `12 deg`
mean-curvature request, `40/60 -> 35/65` allocation, posterior lag, damping,
and `8%` maximum target-helping half-cycle mechanism. Posterior speed is
normalized by `amplitude * frequency`, and previous posterior acceleration by
`amplitude * frequency^2`; only pressure aligned with the proposed posterior
increment can smoothly remove that increment.

The gate cannot reduce the controller below the still-successful symmetric
posterior target and introduces no clock, fixed route, configured actuator cap,
or wake-phase assumption. The downstream evaluation should reproduce the
compact direct capture near `32.73` while retaining the inherited force and
moment relief. That expectation comes from a prior completed rollout; this
worker claims no new CFD result before evaluation.
