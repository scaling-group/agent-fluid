# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet is the common held-fish initial condition: four
  interacting vortex streets are fully developed before release, with the fish
  above and downstream of the target. It does not establish candidate-specific
  wake selection or robustness.
- Three sampled policies are code-identical progress-supervised controls. They
  reproduce the same nose-first target capture at `32.340` release time,
  `1.63773L` mean distance, score `0.234663`, force/moment RMS
  `65.12/888.56`, and posterior excursion `0.57530 rad`. Their keyframes show
  immediate diagonal redirection, a coherent posterior-traveling body wake,
  cylinder clearance, and no late route reversal.
- The assigned parent adds verified turn-response confidence at the same
  optional posterior-residual gate. Its released sheet retains the same direct
  topology and active upstream propulsion: mean fish velocity
  `(-0.3366,-0.1408)` exceeds mean local-flow advection
  `(-0.1925,-0.1923)` in targetward x motion. Capture advances slightly to
  `32.318`, mean distance to `1.63741L`, and score to `0.234705`; moment RMS
  and posterior excursion fall to `881.45` and `0.57481 rad`, while force RMS
  rises slightly to `65.52`. This is useful fixed-snapshot evidence for
  response-conditioned withdrawal, but not a new semantic result or a
  robustness claim.
- No sampled released failure sheet exists. The inherited adverse comparison
  remains the dominated successful multi-locus composition (`32.4555`,
  `1.64548L`, score `0.226804`, force/moment `67.83/914.09`), plus textual
  downstream exits where bearing-rate feedback moved oscillator centers and
  erased the traveling bend. Therefore mean curvature and the unit-gain base
  wave must remain outside this candidate's supervisor.
- Replay of the assigned parent's trajectory through its observation formulas
  shows why its new response branch has little authority: requiring
  instantaneous heading rate and history-window bearing shrinkage to agree
  yields mean response confidence `0.00155`. Replacing that beat-sensitive
  conjunction with slow bearing shrinkage and a dimensionless radial-motion
  weight raises replayed mean response confidence to about `0.193`; at the
  active posterior-pressure locus the confidence increase is about `0.0696`.
  This is an offline signal-coverage check, not a prediction of CFD benefit.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect-and-release turning combined with closed-loop robotic-fish CPG sensory modulation
source_mechanism: preserve a persistent traveling gait while observed goal-directed redirection continuously releases only incremental rhythmic steering
transferable_invariant: slow body-frame target geometry should verify correct-sign response and distinguish closing or lateral redirection from recession before withdrawing optional steering authority
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, prescribed maneuver timing, exact vortex phases, actuator ratings, fixed approach distances, and source-task routes
policy_translation: replace the beat-sensitive instantaneous-heading conjunction at the existing posterior-residual gate with gait-qualified bearing shrinkage weighted by the normalized radial component of recent target-vector motion; retain full residual on recession and leave distributed mean curvature plus the unit-gain traveling wave unchanged
falsification: reject if immediate redirect, coherent traveling bend, direct target capture, or score is lost; if arrival or mean distance worsens without repeatable force or moment relief; if recession withdraws rather than restores the residual; or if held-out wake phase exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by changing only the response-confidence signal
inside the existing optional `8%` target-helping posterior half-cycle gate.
Retain the filtered body-frame bearing, bounded `12 deg` total curvature,
bearing-conditioned `40/60 -> 35/65` allocation, anterior state-feedback
oscillator, posterior lag and damping, trajectory-efficiency supervisor, and
direction-selective speed/previous-acceleration pressure.

The inherited instantaneous heading-rate test aliases the tailbeat-scale yaw
oscillation and nearly always vetoes a slow correct redirect. Use the sign of
the history-window bearing change as the response signal instead. Multiply it
by a bounded radial-motion weight formed from closing speed divided by target-
vector speed: coherent closure maps toward one, purely lateral redirection to
one half, and recession toward zero. Gait activity still prevents release
before propulsion develops. The result can only withdraw the optional
posterior asymmetry; it cannot move oscillator centers, weaken the base wave,
or add authority. The later CFD evaluation must decide whether this more
observable redirect-and-release rule improves the direct capture or merely
under-steers; no same-worker rollout outcome is claimed.
