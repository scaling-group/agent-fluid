# Capture-corridor terminal carrier-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, active moving-window transport, finite dynamics, and capture from
  `12.32772 L`. Three byte-identical copies of the crossflow-supported v26
  controller reproduce score `-0.5281078349`, mean distance
  `2.4291113720 L`, final distance `0.7461675406 L`, and capture at
  `25.1185226 T`. The fourth sample is the v23 paired-release baseline at the
  same capture step but weaker score/mean/final distance
  (`-0.5283387731`, `2.4292937801 L`, `0.7464101911 L`). The repeated v26
  result therefore supports a real late-response mechanism rather than a
  solver-ID or version-label effect.
- I inspected both rows of the combined keyframe sheets for the best v26
  reproductions, v23, and the inherited mean-unloading, admittance, and
  anterior-redistribution regressions. The top-down views show self-propulsion
  along the same compact target-directed arc, with a coherent alternating
  wake through the outer approach and a smooth low-wake terminal crab. The
  oblique views confirm finite three-dimensional Lambda2 structures and no
  collision, domain-exit precursor, passive advection, or instability. The
  candidate differences occur too late to distinguish reliably in the coarse
  sheets, so they must be ranked by trajectory and load evidence rather than
  vortex appearance. No sampled termination-failure sheet exists in this
  workspace; the informative negatives are completed finite regressions, not
  an invented visual failure comparison.
- Cross-checking the traces shows why the v26 behavior should be preserved.
  Below `1.6 L`, v26 has no joint-stop dwell, peak command only
  `0.2432 rad/T^2`, peak planar force coefficient about `0.00214`, and peak
  yaw-moment magnitude about `0.000565`. It maintains speed near
  `0.646--0.654 L/T` while its velocity-to-target angle falls monotonically
  from about `0.443` to `0.310 rad` and constant-velocity transverse miss
  falls from about `0.685` to `0.228 L`. The corresponding v23 course is
  nearly identical, but v26 accumulates a slightly deeper crossing without
  changing the outer wake.
- The assigned parent and inherited logs also bound the edit. Reducing the
  mean bend while holding carrier allocation regresses to `-0.529558`; direct
  mean-curvature admittance regresses to `-0.529967`; zero-sum anterior bend
  redistribution regresses to `-0.528843`; and broader or
  convergence-triggered carrier release previously regressed to about
  `-0.53043` and `-0.53122`. Thus neither more yaw alignment, mean-bend
  unloading, joint-role splitting, nor unconditional extra carrier is
  supported.

## Policy hypothesis

Preserve v26's outer traveling-wave carrier, target-angle redirect, closure
preview, damped two-joint equilibrium, paired settlement-conditioned release,
target-helpful-crossflow relief, and actuator limits. Add one independently
observable terminal mechanism: compute the constant-velocity transverse miss
of the target from normalized body-frame target and velocity vectors. Only
after the current velocity ray enters a bounded capture corridor, while range
is closing, crossflow remains target-helpful, and both joints are settled,
release a small additional *paired* fraction of the equilibrium allocation
toward the existing mean-centered carrier. Fade the release continuously at
the corridor edge. This does not command a world-frame route, add mean bend,
choose a beat phase, split the joints, or change any command outside the late
response gate.

The current trace makes this gate independently active: predicted miss crosses
the proposed partial corridor near `1.4 L` and reaches full support near
`1.1 L`, after the coherent outer wake has already done its work. The expected
result is exact v26 behavior outside that safe intercept state and slightly
more accumulated closure inside it. Reject the mechanism if it changes the
outer trajectory, activates for a receding or unsafe course, delays or loses
capture, worsens mean/final distance, or restores terminal oscillation,
clipping, joint-stop dwell, load growth, looping, or wake degradation. A
one-step-earlier but shallower crossing is not sufficient benefit.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and terminal approach control
source_mechanism: condition rhythmic authority on observed target-response geometry instead of scheduling an unconditional burst
transferable_invariant: preserve a proven traveling carrier and release additional rhythmic authority only when normalized body-frame velocity predicts a safely target-intersecting, positively closing course
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, full-body waveforms, capture routes, and source-task target coordinates
policy_translation: normalized body-frame target and velocity define a bounded constant-velocity transverse-miss corridor that gates a small coordinated reduction of the existing terminal-equilibrium weight after crossflow support and joint settling
falsification: reject if the corridor gate is dormant or active on a receding/unsafe course, if pre-terminal commands change, or if capture depth, distance integral, coherent wake continuity, saturation, joint clearance, loads, or stability regress

The new candidate's coupled CFD evaluation occurs only after this worker exits
and is not claimed as evidence here.

## Non-CFD implementation audit

- The prescribed lightweight contract check loads the policy, resolves its
  returned parameter schema, and produces two finite commands. The guidance
  semantic-change check and solver boundary check both pass; only the allowed
  candidate policy differs under `solver/`.
- Algebraic replay on all `4567` stored states of a completed v26 trajectory
  gives exactly zero command difference at and above `1.6 L`. The new corridor
  activates on `195` late states, first at about `1.4813 L`; `101` active
  states reach full miss support. Its added release averages `0.02283`, peaks
  at `0.03735` under the declared `0.04` bound, and changes either joint
  command by at most `0.01819 rad/T^2` on the inherited states.
- Mirrored synthetic body-frame target, velocity, and joint states give exact
  equality of transverse miss and both corridor supports, while reversing the
  velocity to a receding course makes course support exactly zero. These are
  checks of activation, boundedness, noninterference, and gate symmetry only;
  they do not establish a hydrodynamic improvement.
