# Posterior-coast terminal-course candidate

## Visual diagnosis before the policy edit

- All four assigned rollouts satisfy the frozen evidence contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders
  or prewarm, finite dynamics, and inertial moving-window transport. Three are
  byte-identical v34 posterior-coast replications; each captures at
  `25.0635T`, minimum/final distance `0.7499725L`, mean scored distance
  `2.352216L`, and score `-0.452083`. The fourth is the v27 course-preview
  control, which captures at `24.5795T` and `0.746968L` but has a worse
  `2.360439L` mean distance and `-0.460673` score.
- Both rows of the combined sheets were inspected from release to termination.
  In the v34 top-down row, the fish self-propels diagonally through a coherent
  alternating mid-plane street, executes a bounded terminal hook, and crosses
  the target circle without wake breakup. Its oblique row independently shows
  compact alternating Lambda2 structures behind the body through capture,
  with no visible three-dimensional instability. The v27 sheet has the same
  productive broad trajectory family, but its terminal frame shows the tail
  pinned at `-45 deg`; the sampled trace reports `23.47%` posterior hard-stop
  occupancy and markedly larger planar load peaks. This is an actuator-quality
  failure despite semantic capture, not passive advection.
- Trace diagnostics confirm why v34 is the carrier to preserve. Relative to
  the inherited v32 braking reserve, its posterior-only non-braking rate guard
  retains zero posterior hard-stop occupancy and the low peak body-frame
  force/yaw-moment class (`0.0244/0.0337/0.0162`) while reducing posterior and
  any-joint exact-rate occupancy from `5.806/15.163%` to
  `4.586/13.869%`. Three identical completed samples replicate its semantic
  success. Its limitation is terminal robustness: the crossing lies only
  `0.0000275L` inside the `0.75L` capture boundary.
- The inherited terminal collision-cone experiment supplies a compatible,
  completed control rather than a speculative gain. On v32 it preserved the
  same `24.6290T` capture and low-load route while changing final distance from
  `0.748702L` to `0.747850L` and score from `-0.462093` to `-0.461276`.
  It did not beat v34 as a standalone descendant, but it demonstrates that a
  body-frame velocity-line residual can act only inside `1.6L` without losing
  capture or the posterior braking reserve. The three v34 replications now
  provide the independent carrier evidence needed for a clean compatibility
  test.

## Policy hypothesis

Preserve v34 byte-for-byte outside the normalized `1.6L` terminal range,
including its anterior phase anchor, phase-lagged posterior carrier,
course-preview steering allocation, posterior stopping-stroke reserve, and
posterior coast-rate guard. Add only the completed collision-cone residual:
form signed velocity-line miss as range times the normalized body-frame
velocity/target cross product; activate bounded steering inside the near range
and outside the previously tested `0.70L` miss corridor; admit it through
unused signed intercept headroom. It is independent of instantaneous closing
sign, so a within-beat closing reversal cannot erase a geometrically necessary
terminal correction.

Expected evidence is the established coherent diagonal wake and v34 far route,
capture with more margin than `0.0000275L`, zero posterior hard-stop occupancy,
posterior/total exact-rate occupancy near the v34 class, and peak planar loads
remaining below about `0.035`. Falsify the combination if any output differs
for `distance_L >= 1.6`, capture is lost or delayed materially, crossing margin
does not improve, posterior hard-stop contact returns, or the wake/load class
regresses. The candidate's CFD result is not claimed here; EvE evaluates it
after this worker exits.

bookshelf_consulted: true
source_domain: terminal target capture and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an established phase-lagged propulsive rhythm while a bounded sensory residual persists through a transient observation-gate reversal
transferable_invariant: a near-target velocity-line miss should retain bounded steering authority through a brief within-beat closing-sign reversal without altering the demonstrated far carrier
nontransferable_details: published gains, dimensional cadence, species kinematics, full-body envelopes, exact vortex phases, the numerical capture radius, and task-specific routes
policy_translation: compute signed miss only from normalized body-frame target geometry and velocity, range-gate it near the target, and blend it through unused two-joint intercept headroom while retaining the proprioceptive posterior feasibility layers
falsification: reject if far commands change, capture or the coherent wake is lost, the crossing margin fails to improve, posterior hard-stop protection regresses, or peak planar loads leave the replicated v34 class

## Pre-evaluation validation

- The required public-contract state returns exactly two finite accelerations.
  All `89` distinct direct `params.FIELD` references resolve among the `91`
  fields owned by `target_policy_params()`.
- Across `58,320` states spanning range, target angle, body-frame velocity,
  both joint positions and rates, closing sign, and turn rate, candidate output
  is bit-for-bit identical to the sampled v34 parent whenever
  `distance_L >= 1.6`. A near state outside the miss corridor activates the
  residual, and mirroring target and lateral velocity reverses the residual to
  numerical tolerance.
- The reusable-guidance semantic check, Julia public-contract check, and solver
  editable-boundary audit pass. The configured check runner was invoked, but
  its pinned `gpt-5.4-mini` model is unavailable on this account; its three
  declared no-CFD commands were therefore run directly and separately. No
  formal CFD was run.
