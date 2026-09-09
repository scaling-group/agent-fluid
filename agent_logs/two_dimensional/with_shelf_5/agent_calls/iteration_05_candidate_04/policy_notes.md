# Multi-wake target-policy candidate notes

## Evidence diagnosis before the policy edit

The common prewarm sheet shows four mature, interacting cylinder wakes reaching
the held fish at its upper-right release pose. This is shared initial-condition
evidence. The inherited `12 deg` static-bias failure provides the relevant
visual lower bound: it suppresses the traveling bend, barely moves upstream,
and exits through the right boundary after `16.791` with negative progress.
The assigned-parent guidance also records the naive target-blind lower-boundary
exit and the unstable direct terminal-relief experiment, so neither more static
curvature, scalar carrier tuning, nor weaker terminal restorative action is
supported.

The prefilled posterior half-cycle-asymmetry policy is instead the first large
semantic improvement after several nearly identical successes. It reaches the
same `0.75L` target in `43.9505` released time versus `92.988--93.032` for all
three slower sampled alternatives, and reduces mean distance from about
`4.031L` to `2.139L`. Its released sheet changes topology visibly: after a
sharp initial hook near the upper-right boundary, the fish establishes a fast,
nearly direct upstream-left traverse and enters the target along the merged
wake, rather than following the slower policies' broad triangular redirect.
Mean velocity `(-0.2471,-0.1020)` versus mean local flow
`(-0.1342,-0.1556)` confirms controlled streamwise propulsion, not passive
advection.

The improvement is not merely a faster but harsher copy. Total command energy
falls from about `9.05e4` to `5.31e4`, and RMS lateral force/moment fall from
about `95.5/1147` to `49.4/701`, although the shorter run has higher mean
command and power (`1207.8/89.7` versus about `972.5/66.9`), larger relative
crossflow RMS (`0.211` versus `0.168`), and still reaches both joint-rate and
acceleration caps. The target-favored posterior half-cycle is therefore the
mechanism to preserve, while its sharp initial redirect and sustained clipped
authority motivate feedback-conditioned release rather than another gain-only
change.

## Policy hypothesis

Keep the entire demonstrated carrier, bearing-to-mean-curvature command,
posterior lag, target-favored joint-state half-cycle gate, and approach envelope.
Add one bounded response gate to the posterior half-cycle boost: when the sign
of `bearing_window_rate` is opposite the bounded bearing request, the target
bearing is already converging, so smoothly relieve only part of the asymmetric
boost; when alignment is stationary or worsening, retain the full proven boost.
The gate is exactly neutral without usable response history and never increases
the parent's steering authority.

This translates the visible initial hook into a falsifiable closed-loop test.
It should retain the parent's direct, self-propelled topology and capture while
softening overshoot or clipped mean effort during an already successful turn.
Reject it if the initial redirect weakens into the old broad triangular route,
capture is delayed or lost, the hook and action/load evidence do not change, or
the controller becomes sensitive to noisy bearing-rate sign changes.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric tail-beat turning
source_mechanism: sensor-conditioned release of target-favored half-cycle asymmetry after a steering response appears
transferable_invariant: preserve the propulsive rhythm and full bounded steering when target error is static or worsening, but reduce asymmetric steering once observed body-frame target error is already converging
nontransferable_details: published gains and duty ratios, clocked CPG phase, robot or species kinematics, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: retain the sampled joint-state half-cycle gate and multiply only its posterior boost by a bounded one-sided relief derived from the sign of body-frame bearing request times normalized bearing-window rate
falsification: reject if the direct target-reaching topology is lost or delayed, if the initial hook and cap-dominated effort do not improve, or if rate-sign switching increases force, moment, or instability

## Pre-evaluation verification

The response multiplier is bounded to `[0.65, 1]`, equals one without a
bearing response or while target error worsens, and cannot increase the
parent's posterior boost. Every direct parameter reference has a matching
field returned by `target_policy_params()`. A sweep of `8100` combinations of
distance, bearing, bearing-window rate, joint angle, and joint velocity returned
finite actions; neutral and worsening-bearing cases exactly matched the parent,
and the zero-action equilibrium was preserved. The prescribed guidance,
Julia policy-contract, and solver-boundary checks all pass. No CFD rollout was
run; the response-gating performance hypothesis remains for post-worker
evaluation.
