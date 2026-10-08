# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite, direct-uniform still-water
evaluations with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. They reproduce one behavior: capture at `23.83702T`,
score `-0.53501328`, scoring mean/final distance
`2.433468/0.746096L`, and `236` moving-window shifts. Their combined keyframe
sheets are byte-identical, even though one policy expresses the split observer
with legacy/distributed names and three use explicit course/phase names.

I inspected the combined sheet's top-down mid-plane-vorticity and oblique
body/Lambda2 rows from release through capture. The fish self-propels from
quiescent fluid along a smooth target-directed arc and leaves a coherent
alternating wake with compact three-dimensional structures through the final
bend. There is no passive advection, wake breakup, collision, boundary exit,
or instability. I also inspected both rows for the inherited collision-cone
rollout. Its wake and route are indistinguishable at keyframe resolution, but
the metrics reject it: capture moves to `23.84802T`, score/mean/final distance
regress to `-0.535108/2.433569/0.746175L`, and peak moment inside `3L` rises
from `0.013581` to `0.014020` despite lower mean/peak yaw. Together with the
stronger inherited closing-normalized interception regression
(`23.85352T`, `-0.536326`, `2.434376/0.748282L`), this closes another
target-relative velocity intervention in the terminal steering channel.

The repeated baseline instead exposes an unused propulsion distinction. From
`5L` to `1L`, target-radial translation is already efficient: mean radial
closing divided by swimmer speed is about `0.923` over `5--10L`, `0.948` over
`3--5L`, `0.946` over `2--3L`, and `0.930` over `1--2L`. Yet the existing
progress cadence term is largest at release or when smoothed closing is poor
and becomes nearly zero once closing exceeds its fixed `0.16` scale. It
therefore spends its small carrier reserve on stalled/adverse motion rather
than the long, visibly coherent target-directed translation. The smoothly
projected recorded commands remain just below the `31.42 rad/T^2` limit
(about `31.39 rad/T^2`), so the candidate must not rely on unbounded authority
and must be rejected if the changed cadence increases command-limit exposure.
A bounded observation-semantic change can still be isolated without altering
the established steering or posterior-wave geometry.

## Single candidate hypothesis

Retain the evaluated response-released C-bend, continuous anterior-only course
brake, distributed joint-rate cue only for phase classification, posterior
traveling-wave target, all steering gains, and component-wise smooth command
projection. Replace only the closing-deficit cadence cue with a
target-progress-qualified carrier release. Form target-radial closing from the
normalized body-frame target vector and swimmer velocity, divide positive
radial closing by total swimmer speed, and multiply by a smooth motion gate.
This bounded `[0,1]` signal is zero at rest, lateral motion, or recession and
approaches one only for established target-directed translation. The existing
small progress-cadence authority and distance/turn-load gates remain unchanged.

This should preserve the carrier and course topology while applying the
available cadence reserve over the efficient middle approach, where it can
improve arrival and distance integral without feeding lateral or receding
motion. Falsify the mechanism if CFD delays or loses capture, fails to improve
mean/final distance, changes the coherent alternating wake, worsens terminal
yaw/moment or cross-track balance, or increases joint/command-limit exposure.
In particular, a faster arrival alone is insufficient if it buys progress with
a new load or feasibility defect.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and classical traveling-wave propulsion
source_mechanism: preserve a posterior-lagged rhythmic carrier while sensory task feedback continuously releases a small propulsion reserve
transferable_invariant: modulate the intact carrier from bounded target-directed translation quality, separately from route steering and beat-side correction
nontransferable_details: published CPG gains, dimensional speeds or frequencies, clocked phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: replace the deficit-driven cadence cue with positive target-radial speed divided by swimmer speed and a smooth motion gate, using normalized body-frame target and velocity observations while retaining the split observer and posterior wave
falsification: reject if direct-uniform or held-out CFD loses split-baseline capture/progress, wake coherence, terminal yaw/load balance, or actuator feasibility

## Validation plan

No formal CFD will be run in this workspace. Validate the public function and
parameter schema statically, use the available lightweight policy smoke if the
Julia runtime is present, and invoke the configured check runner after the
candidate and durable guidance are updated.

## Validation status

The configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
unsupported by this account and failed before inspecting the files. Its
prescribed checks were therefore run directly. The guidance checker initially
found the same assigned parent marked twice in the rendered workspace
`README.md`; removing only that duplicate marker repaired the input, and the
rerun passes with a material reusable guidance update. The solver boundary
check also passes, and exactly one nonempty `candidate_target_policy.jl`
exists.

Julia is not installed, so the lightweight runtime smoke cannot launch. A
deterministic static audit finds `69` unique direct `params.FIELD` references
among `71` returned fields, no undeclared reference, and only the `version` and
`control_period` metadata fields unused. Both public functions occur exactly
once, and there is no explicit state time/step input, randomness, file I/O,
cylinder cue, mutable global state, or memorized route. Offline replay of the
new observation on the sampled trajectory is finite and bounded in `[0,1]`;
its mean release changes from `0.897` over `5--10L` to `0.924` over `3--5L`
and `0.928` over `2.1--3L`, where the inherited closing-deficit means were all
below `0.001`. Candidate SHA-256:
`436afc58a96c53e8d2e4687a19c95c0adb841e641dfc5c865ed3fefb18021fd7`.
