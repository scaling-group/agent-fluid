# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver rollouts and the inherited completed children are
valid direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
cylinders, no prewarm snapshot, finite dynamics, and capture termination. The
strongest sampled policy is the repeated v37 split observer: three samples are
bit-identical, capture at `23.83702T`, and score `-0.53501328` with scoring
mean/final distance `2.433468/0.746096L`. The v33 comparator is slightly weaker
at `23.84252T`, `-0.53509095`, and `2.433543/0.746165L`.

I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
from release through capture for v33, the repeated v37 baseline, the inherited
rate-led child, and the assigned-parent envelope-redistribution child. In all
four, the fish moves from the quiescent release under its own actuation, forms
a coherent alternating wake by the middle frames, follows the same smooth
target-directed arc, and retains compact three-dimensional vortices through
the terminal bend. There is no visible passive advection, wake breakup,
collision, boundary exit, or instability. The differences are below keyframe
resolution, so distance, yaw, flow, load, joint, and command histories decide
the comparison.

The inherited evaluations close the last proposed mechanisms negatively. A
second displacement-rate phase lead kept the `23.83702T` capture but regressed
score and mean/final distance to `-0.53536267` and
`2.433747/0.746448L`; it reduced inside-`3L` peak yaw and mean/peak target-
cross-track speed from v37's `3.19386 rad/T` and `0.23868/0.56914U` to
`3.18881 rad/T` and `0.23833/0.56788U`, but raised mean yaw to
`1.67996 rad/T` and peak moment from `0.013581` to `0.013888`. The
assigned-parent beat-envelope redistribution also kept the same capture step
and lowered mean/peak yaw to `1.67906/3.18426 rad/T`, but regressed score and
mean/final distance further to `-0.53634711` and
`2.434528/0.747467L`, while peak moment rose to `0.013790`. Thus neither
advancing joint-state phase nor moving anterior envelope energy between
half-cycles preserves the split baseline's progress/load balance.

The remaining measured signal offers a distinct observation test rather than
another actuator retune. Inside `3L`, v37's body-frame local crossflow has
mean absolute/peak magnitude `0.002239/0.005416U`. It correlates `-0.8015`
with yaw moment but only `0.1255` with yaw rate, so it is a plausible soft
indicator of hydrodynamic load phase rather than a route command. In contrast,
relative lateral flow has mean absolute magnitude `0.25099U`, is dominated by
body sway, and correlates strongly with both yaw and target-cross-track speed;
using it would largely duplicate existing kinematic feedback.

## Single candidate hypothesis

Retain v37's course/phase observer split, target-course brake, response-
released C-bend, posterior lag/amplitude, cadence, phase coordinate, correction
magnitude, and smooth command projection. Add one body-frame local-crossflow
consistency gate to the existing phase-selected anterior residual. When the
measured local crossflow implies a hydrodynamic moment already opposing the
observed excess yaw, continuously attenuate only that redundant anterior
residual; otherwise leave it unchanged. Zero crossflow restores the exact v37
path, so the direct-uniform release is unaffected. The signal never changes
route demand, the continuous course brake, or posterior propulsion.

This predicts that avoiding redundant opposition to a helpful self-generated
wake load can retain v37-scale capture/progress while reducing peak moment or
terminal yaw without another joint-phase or envelope intervention. The
correlation establishes a falsifiable sensor role, not causality. Reject the
mechanism if CFD loses or delays capture, worsens scoring mean/final distance,
changes the coherent alternating wake, fails to improve the mixed yaw/moment
boundary, or increases joint/command-limit exposure.

bookshelf_consulted: true
source_domain: wake-interaction and adaptive swimming with body-frame flow feedback
source_mechanism: preserve helpful fluid-induced motion and reject only the portion that reinforces an unwanted response
transferable_invariant: separate slow target geometry from a soft measured hydrodynamic-load cue, and avoid spending actuation against fluid motion already providing the requested correction
nontransferable_details: cylinder layouts, exact vortex phases, prescribed synchronization, published gains, species-specific kinematics, and task-specific routes
policy_translation: use normalized body-frame local crossflow only to attenuate the existing anterior terminal residual when its inferred moment already counters excess yaw; preserve route feedback and the posterior traveling wave
falsification: reject if split-baseline capture/progress or wake coherence regresses, peak yaw and moment do not improve together, or joint and smoothly projected command envelopes worsen

## Non-CFD validation

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account and failed before inspecting the workspace.
- Its prescribed guidance-materiality and solver-boundary commands pass after
  removing the duplicate assigned-parent marker from the rendered workspace
  `README.md`.
- The Julia smoke command cannot start because this workspace has no Julia
  executable. A deterministic static audit finds `70` unique direct
  `params.FIELD` references among `72` returned fields, with no undeclared
  reference; only `version` and `control_period` are metadata. The policy has
  no explicit time/step input, random source, file I/O, cylinder state, mutable
  global state, or memorized route.
- Exactly one nonempty solver candidate exists. Its SHA-256 is
  `cce2a820eda7512f6b9f09de3d46709a57999f333f7e895fbf293a01a89b30d7`.
  No formal CFD was run.
