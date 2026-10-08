# Candidate wake-policy notes

## Evidence diagnosis before edit

All four sampled solver rollouts are valid direct-uniform still-water
evaluations with `U_infinity=[0,0,0]`, no cylinders, no prewarm, finite
dynamics, and capture termination. The strongest finite sample is the repeated
split-observer baseline (`solver_8ae803ceeb4c`, reproduced exactly by
`solver_f5ac4c378d79` and semantically by `solver_3cb46b9057a1`): it captures
at `23.8370T` with score `-0.535013`, scoring mean/final distance
`2.433468/0.746096L`, and inside-`3L` mean/peak absolute yaw
`1.67938/3.19386 rad/T`. Its peak absolute moment is `0.013581`, peak joint
speed is `4.53786 rad/T`, and the smoothly projected peak command is
`31.3853 rad/T^2`. The assigned-parent v33 comparator captures at `23.8425T`
with slightly worse score and mean/final distance
`-0.535091/2.433543/0.746165L`; no sampled rollout has a different failure
topology.

I inspected both rows of the combined keyframe sheets for the repeated split
baseline, v33, the inherited rate-led phase candidate, and the inherited
half-cycle envelope-redistribution candidate. In the top-down mid-plane row,
each fish moves from rest under its own actuation, turns along the same smooth
target-directed arc, and leaves a coherent alternating vorticity street. In
the oblique Lambda2 row, compact three-dimensional structures persist from the
developing wake through the final bend. There is no visible passive advection,
wake collapse, collision, boundary exit, or instability. The differences are
below the keyframe cadence, so the finite trajectory, yaw, moment, joint, and
command histories decide the mechanism comparison rather than vortex
appearance.

The inherited completed results reject the two advertised next steps from the
parent. Advancing the existing half-cycle selector with normalized joint-rate
quadrature retained the `23.8370T` capture, but worsened score and scoring
mean/final distance to `-0.535363/2.433747/0.746448L`; it raised inside-`3L`
mean yaw from `1.67938` to `1.67996 rad/T` and peak moment from `0.013581` to
`0.013888`, despite trimming peak yaw to `3.18881 rad/T`. Redistributing `12%`
of the anterior oscillator envelope between observed half-cycles also retained
the capture step and lowered mean/peak yaw to `1.67906/3.18426 rad/T`, but
regressed score and mean/final distance further to
`-0.536347/2.434528/0.747467L` and raised peak moment to `0.013790`. Thus
neither earlier phase selection nor cycle-balanced amplitude modulation
preserves the baseline progress/load balance. Together with the older
one-sided-envelope regression, this is evidence to stop manipulating the
carrier's timing or energy envelope at the terminal correction.

## Policy hypothesis

Retain the repeated split observer, body-frame target-course feedback,
response-released C-bend, state-derived position-only half-cycle gate, all
correction magnitudes, posterior lag/amplitude, cadence, and smooth command
projection. Preserve the existing anterior correction's restoring-acceleration
effect, but inject it as a bounded residual outside the Van der Pol energy
coordinate. In concrete terms, the oscillator energy term remains centered on
the established redirect plus continuous terminal course target, while
`omega^2 * terminal_anterior_counter_curvature` is superposed on the anterior
restoring acceleration. This removes only the unintended path by which the
phase-selected residual shifts the anterior limit-cycle envelope; it does not
retime the gate, change amplitude, add authority, or touch the posterior wave.

The mechanism predicts split-baseline capture and wake coherence with no worse
joint or command feasibility, while reducing the small progress/load trade
caused by coupling transient terminal steering into carrier energy injection.
Falsify it if CFD delays or loses capture, worsens score or mean/final distance,
changes the coherent alternating wake, raises mean/peak yaw or moment, or
increases joint/command-limit exposure relative to the repeated split baseline.

bookshelf_consulted: true
source_domain: residual CPG control for robotic-fish direction and path following
source_mechanism: superpose bounded feedback steering on a stable rhythmic carrier instead of changing the carrier's phase or amplitude state
transferable_invariant: separate slow target-directed residual authority from the internal energy coordinate that sustains the propulsive rhythm
nontransferable_details: published residual gains, clocked CPG phase, species-specific envelopes, exact vortex phases, dimensional frequencies, and task-specific routes
policy_translation: keep the normalized body-frame split observer and position-only beat gate, but apply its existing anterior half-cycle curvature as an additive restoring residual outside the Van der Pol energy-centering term
falsification: reject if capture/progress, coherent wake, yaw or moment histories, or actuator feasibility regress against the repeated split-observer baseline

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable on this account and failed before reading the files.
  Its prescribed checks were therefore run directly and separately.
- The guidance-materiality check initially found the assigned parent duplicated
  in the rendered workspace `README.md`. Removing only the duplicate marker
  made the assignment unambiguous; the rerun passes and confirms that these
  notes exist and `control_experience.md` contains a semantic reusable update.
- The solver boundary check passes with exactly one nonempty
  `candidate_target_policy.jl`; its SHA-256 is
  `44c8b4a662a138753354761a25c9346b28b9ebd7e3aa71ce8522b9d325dd4a15`.
- The Julia smoke command cannot start because this workspace has no Julia
  executable. A deterministic static schema audit finds `69` unique direct
  `params.FIELD` references among `71` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. Parentheses and
  brackets balance, and the candidate contains no explicit time/step input,
  random source, file I/O, cylinder state, mutable global state, or memorized
  route. No formal CFD was run.
