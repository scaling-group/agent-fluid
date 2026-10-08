# Phase-decoupled closure-qualified approach drive

## Evidence reviewed before editing

- The assigned parent guidance, all four sampled solver scores, observations,
  metrics, diagnostics, trajectories, and policies, plus the inherited step-10
  and step-11 optimizer notes and evaluations, were reviewed. Every sampled
  rollout satisfies direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and capture.
  The four sampled trajectories and combined keyframe sheets are byte-identical;
  three policies are byte-identical and the fourth differs only by whitespace.
  They are deterministic replication evidence for one controller, not four
  independent mechanisms or an informative termination failure.
- I inspected both rows of the sampled error-qualified controller's combined
  sheet and both rows of the inherited progress-qualified approach controller's
  sheet as the most informative weaker comparison available. From release to
  capture, both top-down views show self-propulsion from rest and a coherent
  alternating signed-vorticity street. Both oblique views show persistent,
  compact three-dimensional posterior/Lambda2 structures without collision,
  wake breakup, or out-of-plane instability. Their wake topology is visually
  near-identical, so their metric difference does not support changing the
  traveling wave, posterior emphasis, or steering path.
- The replicated parent captures at `17.7265T`, score `-0.08139542`, mean
  distance `1.967391L`, and final distance `0.747287L`. Replacing its narrow
  course gate with an instantaneous velocity-alignment progress gate also
  captures at `17.7265T`, but regresses to score `-0.08416658`, mean distance
  `1.969622L`, and final distance `0.749986L`; approach speed changes only from
  `0.8846U` to `0.8855U`, while mean alignment slips from `0.8993` to `0.8980`.
  Thus continuous gating is not sufficient when its observation remains tied
  to the fast lateral beat.
- On the replicated trajectory, instantaneous target-to-velocity alignment
  spans `0.601..1.000` inside `2.10L`, falls below `0.82` for `24.9%` of
  samples, and exceeds `0.96` for `49.8%`. In contrast, a distance derivative
  over the policy's `0.55T` control period stays positively closing throughout
  approach (`0.636..0.871 L/T`, mean `0.791 L/T`). This supports separating
  slow target progress from within-beat velocity rather than another scalar
  threshold or terminal steering injection.

## One policy hypothesis

Preserve the replicated error-qualified line-of-sight observer, odd curvature
map, anterior phase-plane oscillator, posterior lag/emphasis, mean-curvature
plus half-cycle steering, and reversal-preserving rate governor. Replace only
the approach cadence classifier: outside approach, keep full far-drive
authority; inside approach, allocate the cadence boost from the already
available co-windowed normalized closing speed. Positive slow closure retains
the carrier, loss of closure continuously releases to the existing distance
fallback, and instantaneous course alignment no longer modulates propulsion.
This is one time-scale-separation feedback mechanism, not scalar-only gain
tuning, and adds no clock, coordinates, route memory, or mutable state.

Expected evidence is retained capture and two-view wake coherence with equal or
earlier arrival, lower mean distance, and no worse path, cross-track, yaw,
force/moment, or actuator-limit class. Falsify the candidate if capture or wake
coherence is lost; score, distance integral, arrival, or route directness
regresses; or a tangential/receding approach retains inappropriate drive.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking with sensor-modulated rhythmic locomotion
source_mechanism: separate a stable fast propulsive rhythm from slower task-level progress feedback
transferable_invariant: modulate carrier authority with a bounded slow target-progress observation so within-cycle lateral velocity does not masquerade as loss of useful propulsion
nontransferable_details: published gains, oscillator frequency, duty ratios, species kinematics, exact vortex phases, dimensional thresholds, target coordinates, and task-specific routes
policy_translation: use co-windowed body-frame closing speed to qualify the existing approach cadence boost while preserving the two-joint traveling-wave and steering contracts
falsification: reject if capture, distance integral, arrival, path, cross-track, actuator/load class, reflection behavior, or either wake view regresses, or if closure loss fails to withdraw the added cadence
