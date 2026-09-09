# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. This is the common initial
  condition for every policy, not evidence that one controller generated or
  selected a favorable release wake.
- Three code-equivalent sampled realizations of the assigned ungated
  posterior-half-cycle policy reproduce the same direct capture: the fish
  turns toward the body-frame target immediately, sustains a body-generated
  traveling wake, stays clear of the cylinders, and crosses the `0.75L`
  capture circle at `32.472` release time. Their identical `1.64761L` mean
  distance and `68.70/931.60` force/moment RMS establish fixed-snapshot
  determinism, not robustness to wake phase.
- The sampled response-gated extra burst is the most informative adverse
  visual contrast because no sampled failure sheet is present. It preserves
  target capture but has a visibly wider late wake, arrives later at `32.824`,
  increases mean distance to `1.66402L`, and raises force/moment RMS to
  `70.97/945.05`. This rules out adding target-response-dependent posterior
  authority as the next mechanism. The true downstream-exit failures remain
  inherited metric-and-note evidence rather than a new visual comparison.
- The assigned parent's completed actuator-headroom gate preserves the same
  compact diagonal capture topology and arrives at `32.7305`, only `0.80%`
  later than the ungated benchmark. It reduces force RMS by `18.1%`, moment
  RMS by `14.1%`, and posterior peak excursion from `0.5834` to `0.5684 rad`.
  Local-crossflow RMS is nearly unchanged (`0.29554` versus `0.29506`) and
  relative-crossflow RMS changes only from `0.24511` to `0.24306`, so the load
  reduction is not explained by avoiding the developed wake in these
  aggregate diagnostics. Both policies still touch the hard velocity and
  acceleration ceilings; reduced saturation residence is not established.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and elongated-body posterior reactive propulsion
source_mechanism: preserve a persistent traveling gait while sensor feedback yields only an incremental turn-congruent posterior asymmetry when actuator state already reinforces it near the gait envelope
transferable_invariant: regulate the optional rhythmic steering residual with normalized joint-state headroom without moving oscillator centers or attenuating the base posterior traveling wave
nontransferable_details: published gains, robot or species kinematics, dimensional frequencies, exact actuator ratings, prescribed vortex phase, and source-task routes
policy_translation: normalize posterior speed and prior applied acceleration by oscillator-owned speed and acceleration scales, then smoothly gate only the extra target-helping half-cycle gain when either state reinforces the proposed posterior wave
falsification: reject if direct capture or the compact diagonal topology is lost, arrival regresses materially beyond the observed 0.80 percent trade, or force and moment fail to remain meaningfully lower under a repeat or held-out wake

## Candidate hypothesis

Produce exactly one candidate by promoting the completed posterior-state
headroom gate from the assigned parent. Preserve the filtered body-frame
bearing, bounded `12 deg` total-curvature request, `40/60 -> 35/65` allocation,
anterior state-feedback oscillator, posterior lag and damping, and maximum
`8%` target-helping half-cycle asymmetry.

The one candidate-specific mechanism uses no clock, route, coordinates, or
configured actuator limits. It withdraws only the incremental half-cycle
amplification when observed posterior velocity or the previous applied
posterior acceleration is large in the direction of the proposed wave. The
unit-gain lagged wave and target-signed mean curvature remain available when
the gate closes. This worker does not claim a new CFD result; downstream
evaluation must test whether the inherited load/navigation trade reproduces.
