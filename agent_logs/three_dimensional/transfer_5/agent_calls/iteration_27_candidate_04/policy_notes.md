# Candidate wake-policy notes

## Evidence diagnosis before editing

- All four sampled solver rollouts and both inherited step-26 rollouts are
  valid direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and capture termination. The sampled
  set has no crash or exit failure, so the informative negative comparisons
  are the two completed mechanism regressions rather than an invented failure
  class.
- I inspected the combined sheets from release through capture for the best
  split observer, its v33 comparator, and both step-26 regressions, including
  the top-down mid-plane-vorticity and oblique body/Lambda2 rows. In every case
  the fish self-propels, develops a spatially ordered alternating wake by the
  middle frames, follows the same smooth target-directed arc, and retains
  compact three-dimensional wake structures through the terminal bend. There
  is no visible advection, wake breakup, boundary contact, or instability.
  The mechanism effects are below keyframe resolution, so trajectory, score,
  joint, yaw, and moment histories decide the comparison.
- The repeated role-separated baseline captures at `23.83702T`, score
  `-0.53501328`, scoring mean/final distance `2.433468/0.746096L`, and inside-
  `3L` mean/peak absolute yaw `1.67938/3.19386 rad/T`. Its inside-`3L`
  mean/peak absolute moment is `0.0063875/0.0135813`, while mean/peak target-
  cross-track speed is `0.23868/0.56914U`. It preserves the coherent carrier
  and smoothly projected command envelope; this is the baseline to preserve.
- The step-26 anterior envelope-relief candidate kept the same capture step and
  lowered peak yaw to `3.18039 rad/T` and mean/peak cross-track speed to
  `0.23829/0.56810U`, but regressed score and scoring mean/final distance to
  `-0.53587987` and `2.434158/0.746981L`; peak moment rose to `0.0138038`.
  Thus removing energy from only the yaw-supporting anterior half-cycle can
  improve lateral regulation while sacrificing target progress and worsening
  the peak load boundary.
- The separate displacement-rate quadrature candidate also kept capture at
  `23.83702T` but regressed score and scoring mean/final distance to
  `-0.53556057` and `2.433904/0.746654L`. It increased mean yaw to
  `1.67990 rad/T`, only reduced peak yaw to `3.19110 rad/T`, and raised peak
  moment to `0.0137249`. This rejects further phase anticipation or a stronger
  distributed observer as the next move.

## Single candidate hypothesis

Retain the evaluated split observer, target-course curvature, response-released
C-bend, posterior lag/amplitude, cadence, and component-wise smooth command
projection exactly. Replace one-sided anterior envelope relief with bounded
beat-side redistribution: on the observed half-cycle supporting excess yaw,
reduce the anterior oscillator envelope; on the opposite observed half-cycle,
return the same bounded envelope fraction. Both gates come from the existing
normalized proximity/speed/excess-yaw counter and body-intrinsic tail tangent,
with no clock, hidden stage, or route coordinate.

This directly tests whether the step-26 yaw/cross-track benefit can survive
when propulsive envelope is redistributed rather than simply removed. It is a
mechanism test, not a cadence or scalar-only gain retune. Falsify it if CFD
loses or delays capture, regresses split-baseline scoring mean/final distance,
changes the coherent alternating wake, fails to improve the mixed yaw/moment
boundary, or increases joint/command-limit exposure. In particular, a lower
yaw peak without split-baseline progress and load feasibility is failure.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: redistribute rhythmic effort between target-relevant half-cycles instead of applying a one-sided global energy reduction
transferable_invariant: preserve the traveling-wave carrier and cycle-scale propulsion while shifting bounded anterior effort away from the beat side supporting unwanted yaw
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, exact duty ratios, exact vortex phase, and task-specific routes
policy_translation: use the existing normalized terminal yaw response and observed two-joint tangent side to reduce the anterior envelope on the yaw-supporting half-cycle and return the same bounded fraction on its opposite half-cycle; leave posterior wave generation and target-course feedback unchanged
falsification: reject if capture/progress regresses, wake coherence changes, peak yaw and moment do not improve together, or joint and smoothly projected command envelopes worsen relative to the repeated split baseline

## Non-CFD validation

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account and failed before inspecting files. I
  ran its three prescribed commands directly and separately.
- The guidance-materiality check initially found the assigned parent listed
  twice in the rendered workspace `README.md`. Removing only the duplicate
  parent block made the assignment unambiguous; the rerun passes and confirms
  these notes plus the semantic `control_experience.md` revision.
- The solver boundary check passes with exactly one nonempty candidate policy;
  its SHA-256 is
  `67dd43d57328345ca392b93de00c8c5e768d81470792c9348c15ff36f1b41a6d`.
- The Julia contract command cannot start because no Julia executable is
  installed. The deterministic static schema audit finds `70` unique direct
  `params.FIELD` references among `72` returned fields with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit time/step input, random source, file I/O, cylinder state, mutable
  global state, or memorized route. No formal CFD was run.
