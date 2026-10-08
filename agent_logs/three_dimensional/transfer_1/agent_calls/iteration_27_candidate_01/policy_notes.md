# Multi-wake target-policy candidate

## Pre-edit evidence diagnosis

- All four sampled evaluations are direct-uniform, quiescent (`U_infinity=0`),
  no-prewarm captures.  The strongest finite result, `solver_0711c7882b23`,
  captures at `17.7540 T`, score `-0.07917`, with total/observed distance
  integrals `1.96508/1.34990 L`.  Its top-down row shows a target-directed
  trajectory and a coherent alternating wake from release through capture;
  the readable oblique row shows bounded three-dimensional Lambda2 structures
  attached to the same traveling body wave rather than passive advection.
- Three independently written axial-only launch formulations reproduce an
  identical slower trajectory: capture at `17.8970 T`, score `-0.08687`, and
  total/observed integrals `1.97313/1.35927 L`.  The readable
  `solver_0b60abafcd7c` sheet retains the same organized two-view wake, so the
  difference is route response rather than a wake-topology repair.  The
  `solver_992c5492a1b7` oblique row is black despite the identical numerical
  trajectory and is treated as an evaluation-artifact failure, not contrary
  hydrodynamic evidence.
- The stronger axis-selective controller trails the axial-only comparator by
  `0.0050/0.0196 L` at `2/4 T`, then leads by
  `0.0146/0.0378/0.0714/0.0929/0.0907 L` at `6/8/10/12/16 T`.  Mean/max speed
  rises only from `0.7126/0.9555` to `0.7168/0.9603 L/T`; acceleration-limit
  residence rises from `43.79%` to `44.14%`, while peak normalized force and
  moment remain `0.03225/0.01609`.  During `0-2 T`, only about one third of
  speed is forward-axis response in both rollouts; by `4-6 T` it is about
  `0.89`.  Prolonging the full wave-amplitude launch term on axial deficit
  therefore adds early non-axial motion but loses middle-route closure.

## Policy hypothesis

Preserve the successful total-speed release of the larger posterior launch
term and the axial gate on the smaller phase-even energy residual.  When total
motion has formed but its forward-axis fraction remains low, continuously
exchange only that small energy residual from posterior wave amplitude into
posterior lag.  This keeps authority in a traveling-bend shape without adding
another steering signal or increasing the residual envelope.  The expected
signature is retention of capture and the coherent wake, no worse `2-4 T`
closure, and an earlier `6-16 T` approach without a material increase in the
`0.9603 L/T`, `44.14%`, or `0.03225/0.01609` speed/action/load envelope.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive-thrust theory and traveling-wave fish/robotic-fish control
source_mechanism: posterior phase lag and wave-shape modulation preserve a directed traveling bend while tail kinematics produce reactive thrust
transferable_invariant: when extra amplitude produces non-axial response, preserve bounded posterior authority but express it through traveling-wave lag rather than a larger standing lateral excursion
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame forward speed divided by total body speed to partition the existing phase-even posterior-energy residual between amplitude scale and posterior-lag scale; retain target/closing/approach/turn gates and the two-joint state-feedback oscillator
falsification: reject the transfer if capture, early or middle closure, or readable two-view wake coherence regresses, or if speed, acceleration-limit residence, normalized force, or normalized moment materially exceeds the sampled axis-selective envelope
