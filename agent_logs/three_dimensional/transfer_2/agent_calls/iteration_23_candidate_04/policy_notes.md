# Terminal course half-cycle allocation candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still water (`U_infinity=[0,0,0]`), no cylinders, no prewarm, and
  the L64 moving storage window.  The top-down vorticity and oblique Lambda2
  rows of the replicated v38 capture and best finite v39 capture were inspected
  from release to termination.  Both show self-propelled diagonal progress, a
  coherent alternating wake, and the same broad terminal hook into the capture
  disk; there is no visible instability, wake collapse, passive advection, or
  out-of-plane escape.  No failed-rollout sheet is sampled in this workspace,
  so inherited failures are used only as audited numerical context.
- Three byte-identical v38 samples capture at `24.673016T`, with score
  `-0.44861015`, mean distance `2.34822794L`, final distance
  `0.74864119L`, and terminal target-relative velocity angle `58.834 deg`.
  The v39 coupled course residual preserves the visual route and capture, and
  slightly improves score, mean distance, final distance, crossing margin, and
  terminal course angle to `-0.44857125`, `2.34820783L`,
  `0.74860227L`, `0.00139773L`, and `58.221 deg`, respectively, while
  arriving one step later at `24.678516T`.
- V39 leaves the actual terminal defect almost unchanged across the whole
  approach neighborhood: mean absolute normalized course error below
  `2.10L` changes only from `0.757266` to `0.757167`.  Raw acceleration
  exposure changes from `73.473%` to `73.613%`, any-joint exact-rate
  exposure from `12.929%` to `12.904%`, posterior exact-rate exposure from
  `3.611%` to `3.610%`, and posterior hard-stop occupancy remains zero.
  Peak planar force/yaw-moment coefficients remain in the same low class
  (`0.0233/0.0320/0.0156`).  The direct residual therefore establishes
  local actuator reachability, not a new course-aligned trajectory.
- Inherited evidence rules out symmetric terminal carrier relief: two-joint
  and posterior-only holds retained the hook but worsened distance/score or
  margin.  It also shows that a phase-selective posterior allocation was useful
  earlier in the lineage, whereas broad dual-joint rate intervention lost
  capture.  Preserve the anterior oscillator, v39 residual, posterior braking
  reserve, and coast guard; test phase selectivity rather than another course
  gain or shared carrier reduction.

## Policy hypothesis

Start from the positively evaluated v39 controller and add one bounded
allocation mechanism.  Inside the existing near-range, positive-closing
course-residual gate, infer posterior beat side from the observed anterior
joint angle and rate.  Taper only the posterior carrier half-cycle that opposes
the signed terminal course correction; leave the complementary half-cycle,
anterior phase anchor, mean-curvature and coupled steering residual, and every
safety layer unchanged.  This converts the evidenced course signal into mild
asymmetric flapping without adding acceleration, a clock, a world-frame
direction, or a memorized route.

The expected result is the v39 far path and coherent wake with a more
course-aligned terminal hook, without the loss of thrust caused by symmetric
carrier holds.  Reject the mechanism if any command changes at or beyond
`2.10L`, capture is lost or delayed beyond v39, terminal course angle does
not beat `58.221 deg`, near-range mean course error does not improve, crossing
margin shrinks, or hard-stop, rate, raw-command, force, or moment classes
regress.  The current worker cannot claim the new CFD outcome.

bookshelf_consulted: true
source_domain: asymmetric-flapping robotic-fish turning over an anterior-anchored traveling bend
source_mechanism: create net turning by mildly weakening only the beat half-cycle that opposes the sensed direction request
transferable_invariant: preserve the organizing propulsive rhythm and complementary thrust half-cycle while a bounded target-relative error reallocates posterior effort by observed phase
nontransferable_details: published gains, duty ratios, dimensional cadence, robot morphology, species-specific kinematics, prescribed paths, exact vortex phases, and task-specific routes
policy_translation: use the normalized mirror-equivariant velocity-course residual and state-derived posterior wave side to taper only opposing posterior carrier effort inside the existing near-range positive-closing gate
falsification: reject if the far route changes, capture or wake coherence is lost, course alignment fails to improve, symmetric carrier-loss behavior returns, or actuator and load classes regress

## Pre-evaluation validation

- A deterministic fixed-state replay over all `4487` rows of the completed
  v39 trace changes only the posterior command on `245` states, beginning at
  `22.2860T/1.8329L` and ending at capture.  The new phase allocator is
  active on `246` states and never at or beyond `2.10L`; maximum same-state
  command change is `0.4167 rad/T^2`, and maximum posterior carrier relief
  is `8.558%`.  This verifies locality and materiality only, not coupled-CFD
  performance.
- A `18,711`-pair grid over reflected joint state and signed raw course
  request gives exactly zero error for odd phase request and invariant
  opposing-half-cycle relief.  The candidate adds no non-finite output in the
  public contract probe.
- The prescribed reusable-guidance, Julia public-contract, solver-boundary,
  and deterministic parameter-schema checks pass.  All `86` direct
  `params.FIELD` references resolve among the `88` fields returned by
  `target_policy_params()`.  The guidance check first exposed a duplicated
  assigned-parent marker in the rendered workspace README; removing only that
  duplicate made the parent baseline unique.
- The configured checker was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account.  An available independent read-only checker
  then ran the same three TOML commands separately and reported PASS for
  guidance semantics, policy contract, solver boundary, and parameter schema.
  No formal CFD was run.
