# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet confirms the common held release: the fish starts
  above and downstream of four developed, interacting cylinder streets, so the
  released-path difference is controller evidence rather than wake maturity.
- The posterior-curvature prefill is self-propelled, not merely advected: it
  travels `-10.51L` upstream. Its released sheet nevertheless shows a broad arc
  above the target followed by a near-vertical upper-domain exit at `84.22`.
  The `2.43L` closest, `6.64L` mean distance, and `+1.80L` head displacement in
  y agree with that wrong lateral topology. Its lower force/moment RMS
  (`116/1278`) therefore is not evidence of useful route control.
- All three successful samples implement the same functional distributed
  half-cycle controller (one file differs only in comments) and reproduce the
  same diagonal trajectory and metrics. The released sheet shows an active
  traveling body wake, entry into the merged-cylinder wake, and a continuous
  downward-left approach to the target. Metrics agree: `target_reached` at
  `51.47`, final/minimum distance `0.748L`, mean distance `1.82L`, head
  displacement `-11.28/-4.94L`, and finite though high force/moment RMS
  `426/4084`.
- The inherited optimizer notes identify the causal contrast: moving the mean
  bend to the posterior joint preserved propulsion but did not arrest the
  broad route error, while response-aware distributed half-cycle steering
  approached closely and a smooth absolute-yaw-load gate prevented that
  residual from amplifying a strong wake/body turn. The compact evidence does
  not expose sign-resolved load events, so it cannot justify a directional
  moment or crossflow residual.

## Candidate hypothesis

Replace the prefill's posterior mean-curvature target with the sampled
response-aware distributed half-cycle mechanism. Preserve the zero-centered
joint-state oscillator and posterior velocity lag as the propulsive traveling
bend. Form route steering from normalized body-frame bearing minus a bounded
observed heading response, then use normalized yaw-moment magnitude only to
reduce that steering residual with a nonzero authority floor. Apply the gated
residual compatibly at both joints and retain candidate-owned smooth
acceleration limiting.

This is one structural candidate, not a gain sweep. It should reproduce the
sampled diagonal capture rather than the prefill's upper exit. The next CFD
rollout falsifies it if target capture or strong upstream travel is lost, if a
boundary exit, collision, instability, or nonfinite observation appears, or if
the load gate suppresses the traveling propulsive bend. Identical same-seed
replays establish materialization repeatability only; they do not establish
robustness to wake phase, inflow, geometry, or target changes.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish direction tracking
source_mechanism: retain the propulsive rhythm while observed yaw response and load bound only the slow target-steering modulation
transferable_invariant: separate normalized body-frame route error from fast hydrodynamic yaw response, preserving the traveling wave while reducing added steering when wake/body yaw is already strong
nontransferable_details: published gains, dimensional moment scales, species-specific kinematics, CPG topology, exact vortex phases, and task-specific routes
policy_translation: use bearing minus bounded heading response for route demand and a smooth floor-bounded function of abs(moment_z_L2) to gate only distributed two-joint half-cycle acceleration asymmetry
falsification: reject if target capture or upstream propulsion regresses, a lateral exit returns, loads become unstable, or the gate suppresses the propulsive wave instead of only its steering residual
