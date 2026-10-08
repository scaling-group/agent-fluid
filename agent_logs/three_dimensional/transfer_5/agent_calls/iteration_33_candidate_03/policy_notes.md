# Candidate wake-policy notes

## Evidence diagnosis before editing

All sampled evaluations used direct uniform still water with
`U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite capture
termination. Three sampled policies reproduce the role-separated split-observer
baseline at `23.83702T`, score `-0.535013`, scoring mean/final distance
`2.433468/0.746096L`, and `236` moving-window shifts. The assigned-parent
speed-envelope child did reduce exact anterior/posterior speed-cap residence
from `11.58/4.59%` to `0.64/0.20%`, but it delayed capture to `24.16701T` and
regressed score and mean/final distance to
`-0.555298/2.453906/0.748632L`. This rejects speed-cap suppression as an
improvement: the clipped carrier was still supplying useful propulsion.

The sampled target-progress-qualified carrier instead captures at `23.37501T`,
improves score to `-0.505158`, and improves scoring mean distance to
`2.402131L`. It preserves the split baseline's success and coherent route but
ends slightly farther out (`0.748882L`). It also exposes a bounded trade:
inside `3L`, mean/peak absolute yaw change from `1.67938/3.19386` to
`1.71255/3.29199 rad/T`, mean/peak target-cross-track speed change from
`0.23868/0.56914U` to `0.23513/0.61953U`, and peak absolute moment changes
from `0.013581` to `0.014507`. Exact speed-cap residence remains comparable
(`11.20/4.85%`), while acceleration commands remain smoothly projected below
the `31.42 rad/T^2` physical limit.

I inspected the combined top-down mid-plane-vorticity and oblique body/Lambda2
rows from release through capture for the repeated baseline, the assigned-
parent speed-envelope regression, and the faster target-progress carrier. All
three fish self-propel from quiescent fluid along a smooth target-directed arc
and leave an ordered alternating wake with compact three-dimensional
structures through the terminal bend. None shows passive advection, wake
collapse, collision, boundary exit, or instability. The speed-envelope child
follows the same useful topology more slowly; the target-progress carrier
reaches the same topology sooner without a visible wake-structure loss.

## Single candidate hypothesis

Port only the evaluated target-progress-qualified cadence cue onto the current
role-separated split observer. Preserve the response-released C-bend,
anterior-only continuous course response, distributed two-joint cue only for
phase classification, posterior traveling wave, steering gains, and final
smooth command projection. Replace the old closing-deficit cadence cue with a
bounded product of positive target-radial speed divided by total swimmer speed
and a smooth motion gate. The existing small cadence authority plus distance
and turn-load gates remain unchanged.

This is an observation-semantic mechanism, not a cadence-gain retune. The
sampled implementation improved arrival and distance integral while preserving
capture and wake topology; this port keeps the current observer algebra that
already produced bit-identical baseline CFD. The new candidate itself remains
unevaluated until the downstream CFD run. Falsify it if it fails to reproduce
the sampled progress improvement, loses capture or wake coherence, materially
worsens the documented terminal yaw/cross-track/moment trade, or increases
joint-speed or acceleration-limit exposure beyond the sampled carrier.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and closed-loop robotic-fish CPG modulation
source_mechanism: preserve a posterior-lagged thrust carrier while bounded task feedback releases a small propulsion reserve
transferable_invariant: keep the directed traveling wave intact and modulate its reserve from normalized target-directed translation quality separately from steering
nontransferable_details: published gains, dimensional speeds and frequencies, clocked phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: use positive body-frame target-radial speed divided by swimmer speed and a smooth motion gate only for the existing cadence-reserve input, retaining the role-separated observer and posterior wave
falsification: reject if CFD loses sampled capture/progress or coherent wake topology, exceeds the sampled terminal yaw/cross-track/moment trade, or worsens the actuator envelope

## Validation plan

Do not run formal CFD in this workspace. After editing, statically check the
public contract, parameter schema, prohibited state, and solver edit boundary;
run the available Julia smoke only if Julia is installed; then invoke the
configured check runner and repair any reported issue.

## Validation status

- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account and failed before inspecting the workspace.
  Its three prescribed checks were therefore run directly and separately.
- The guidance-materiality checker passes: these notes exist and
  `guidance/control_experience.md` contains a material reusable update from the
  assigned parent. The solver boundary checker also passes, confirming that
  only the permitted candidate policy differs in `solver/`.
- Julia is not installed, so the lightweight runtime smoke cannot launch. A
  deterministic static audit finds both public functions exactly once, `69`
  unique direct `params.FIELD` references among `71` returned fields, and no
  undeclared reference; only `version` and `control_period` are metadata. The
  policy contains no explicit time/step input, random source, file I/O,
  cylinder cue, mutable global state, or memorized route. Exactly one nonempty
  `candidate_target_policy.jl` exists. Candidate SHA-256 is
  `dd18d4c2791c93cc331e3fda6d72f713cbf68d25b6d5d025ba48e5025fe1859d`.
- No formal CFD was run.
