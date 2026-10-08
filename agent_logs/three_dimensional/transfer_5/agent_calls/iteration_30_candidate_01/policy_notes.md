# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts and the assigned-parent rollout are finite,
direct-uniform still-water evaluations with `U_infinity=(0,0,0)`, no
cylinders, no prewarm snapshot, and capture termination. The sampled set
reduces to three exact repeats of the split-observer trajectory and its v33
comparator. The repeated split observer captures at `23.83702T`, with score
`-0.53501328`, scoring mean distance `2.433468L`, and final distance
`0.746096L`; v33 is slightly weaker at `23.84252T`, `-0.53509095`,
`2.433543L`, and `0.746165L`.

I inspected the combined keyframe sheets for the repeated split baseline, v33,
and the assigned-parent v41 result, including both the top-down mid-plane
vorticity row and the oblique body/Lambda2 row from release through capture.
All are visibly self-propelled from quiescent fluid, follow the same smooth
target-directed arc, form an ordered alternating wake, and retain compact
three-dimensional vortices through the terminal bend. No sheet shows passive
advection, wake collapse, collision, boundary exit, or instability. The
controller differences are below keyframe resolution, so distance, yaw,
cross-track, moment, joint, and command histories decide the comparison.

The completed assigned-parent v41 rollout falsifies its middle-approach
interception hypothesis. Relative to the repeated split baseline, adding the
closing-normalized collision-line drift as an anterior mean-bend bias delays
capture from `23.83702T` to `23.85352T` and regresses score/mean/final distance
from `-0.535013/2.433468/0.746096L` to
`-0.536326/2.434376/0.748282L`. It lowers inside-`3L` mean/peak absolute yaw
from `1.67938/3.19386` to `1.63733/3.17852 rad/T`, but worsens mean/peak
target-cross-track speed from `0.23868/0.56914U` to
`0.24474/0.58775U` and raises inside-`3L` peak moment from `0.013581` to
`0.013867`. Joint-angle and acceleration limits remain clear, joint-speed
exposure remains comparable, and the visible wake remains coherent. Thus the
offline drift trend did not establish a useful route-control role: reduced yaw
alone traded away the successful capture path and load balance.

## Single candidate hypothesis

Select the independently replicated v37 split course/phase observer as the one
candidate. It restores the strongest completed behavior after the v41
regression: body-frame target geometry and the anterior-only carrier-rejected
rate retain continuous course authority, while the distributed two-joint rate
is scoped only to phase classification of the bounded anterior half-cycle
residual. The response-released C-bend, posterior traveling-wave target,
cadence, near-target course brake, and smooth acceleration projection remain
unchanged. No scalar gain, route schedule, morphology, or episode setting is
tuned.

This is a selection hypothesis backed by three exact CFD repeats rather than a
new offline proxy. It should reproduce capture near `23.837T`, scoring
mean/final distance near `2.433468/0.746096L`, the coherent alternating wake,
and the sampled joint/command envelopes. Falsify the selection if another
repeat loses capture, materially departs from that trajectory, or worsens its
mixed terminal yaw/load balance or actuator feasibility.

bookshelf_consulted: true
source_domain: feedback-modulated robotic-fish oscillators and wake-disturbance control
source_mechanism: preserve the propulsive traveling-wave carrier while separating slow target-course feedback from a fast joint-state phase cue
transferable_invariant: a fast rhythmic observation should remain scoped to beat-side classification and must not replace body-frame route feedback or posterior propulsion
nontransferable_details: published gains, clocked CPG phase, species-specific envelopes, dimensional approach schedules, exact vortex phases, and task-specific routes
policy_translation: select the evaluated split observer that uses normalized body-frame target geometry for continuous course response and the distributed two-joint rate only for the bounded anterior half-cycle residual; retain the posterior traveling wave
falsification: reject if repeated still-water CFD loses split-baseline capture/progress, coherent wake topology, terminal yaw/load balance, or actuator feasibility

## Non-CFD validation

- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unsupported on this account and failed before file
  inspection. Its prescribed reusable-guidance materiality and solver-boundary
  commands were run locally and pass.
- Julia is not installed, so the lightweight runtime smoke command cannot
  launch. The deterministic schema audit finds `69` unique direct
  `params.FIELD` references among `71` returned fields and no undeclared
  reference; the two unreferenced fields are metadata. The policy contains both
  public functions and no clock/step input, random source, file I/O, cylinder
  route, mutable global state, or memorized coordinates.
- Exactly one nonempty `candidate_target_policy.jl` exists. Its SHA-256 is
  `e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35`,
  byte-identical to the completed finite v37 capture artifact. No formal CFD
  was run.
