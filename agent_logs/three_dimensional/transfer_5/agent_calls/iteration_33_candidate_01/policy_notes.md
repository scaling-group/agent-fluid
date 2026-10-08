# Candidate wake-policy notes

## Evidence diagnosis before editing

All four sampled solver artifacts are finite, direct-uniform still-water
rollouts with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
capture termination. Three reproduce the split-observer baseline at
`23.83702T`, score `-0.53501328`, and scoring mean/final distance
`2.433468/0.746096L`; their two policy texts are behaviorally equivalent and
their wake and trajectory evidence repeats deterministically. The fourth is a
completed target-progress-qualified carrier release. It improves capture to
`23.37501T`, score to `-0.50515772`, and scoring mean distance to `2.402131L`,
while retaining capture at `0.748882L`.

I inspected the combined sheets and both view-specific sheets for that
strongest sampled rollout and for the assigned parent's completed one-sided
joint-speed feasibility projection. Both start from direct uniform quiescence
and self-propel on the established smooth target-directed arc. The top-down
rows show an ordered alternating mid-plane wake from release through the
terminal bend; the oblique rows retain compact three-dimensional Lambda2
structures without passive advection, wake breakup, collision, boundary exit,
or instability. The progress-qualified fish is already at about `7.3L` from
the target at `14T`, compared with about `7.6L` for the feasibility projection,
so its gain is visibly consistent with faster translation rather than a
different route or a rendering artifact.

The trajectory histories make both tradeoffs explicit. Relative to the
repeated baseline, progress qualification changes inside-`3L` mean/peak yaw
from `1.67938/3.19386` to `1.71255/3.29199 rad/T`, mean/peak absolute moment
from `0.006388/0.013581` to `0.006591/0.014507`, and mean/peak target-cross-track
speed from `0.23868/0.56914U` to `0.23513/0.61953U`. Full-rollout anterior and
posterior speed-cap residence remains mixed at `11.20%/4.85%`, versus
`11.58%/4.59%` for the baseline, and projected commands remain just below the
`31.42 rad/T^2` limit. Thus the score and translation improvement is real, but
it is not evidence for a stronger cadence gain or for extending the release
into terminal steering.

The assigned parent's feasibility projection is the informative negative
comparison. It reduces full-rollout speed-cap residence to `0.64%/0.20%` and
inside-`3L` residence to `0.49%/0.33%`, but delays capture to `24.16701T`,
regresses score and mean/final distance to
`-0.555298/2.453906/0.748632L`, and raises peak moment over the baseline to
`0.013971`. This falsifies the premise that discarded outward acceleration at
the speed clamp is the present progress bottleneck. Do not stack that
projection onto the faster carrier or widen/increase it without new evidence.

## Single candidate hypothesis

Promote the exactly evaluated target-progress-qualified carrier release as the
one candidate. It preserves the split observer's target steering, response-
released C-bend, posterior traveling wave, terminal feedback roles, and smooth
command projection. Its only causal policy change relative to the
behaviorally replicated carrier is to replace the closing-deficit cadence cue
with a bounded normalized body-frame measure of positive target-radial
translation divided by swimmer speed and gated smoothly from rest. Selecting
the evaluated artifact avoids combining it with the rejected speed-feasibility
layer or introducing an unevaluated scalar retune.

The expected result is deterministic reproduction of the sampled
`23.375T` capture, `2.402131L` mean distance, coherent alternating wake, and
finite actuator envelope. Treat the mechanism as a conditional progress
improvement, not a terminal-load solution. Falsify its promotion if repeat or
held-out CFD loses capture, coherent wake topology, or its sampled progress,
or if yaw, cross-track motion, moment, or limit residence escalates beyond the
already measured tradeoff. Do not respond to such a result by increasing the
cadence reserve.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and classical traveling-wave propulsion
source_mechanism: preserve a posterior-lagged rhythmic carrier while sensory task feedback modulates a small propulsion reserve separately from route steering
transferable_invariant: release carrier reserve only during bounded target-directed translation while leaving the established traveling-wave geometry and steering roles intact
nontransferable_details: published gains, dimensional frequencies, clocked oscillator phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity observations to form positive radial progress divided by swimmer speed with a smooth motion gate, and apply it only to the existing small cadence reserve
falsification: reject if repeat or held-out CFD loses sampled capture, progress, coherent wake, bounded commands, or worsens yaw, cross-track, moment, and joint-limit exposure beyond the measured tradeoff; never justify a stronger scalar gain from the shelf

## Validation plan

Do not run formal CFD in this workspace. After materializing the evaluated
policy, update the durable evidence bank, invoke the configured check runner,
run its prescribed static checks if needed, and use the lightweight Julia
smoke only if the runtime is available.

## Validation status

The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
is unsupported by this account and failed before workspace inspection. Its
prescribed checks were therefore run directly. The guidance checker first
found the assigned parent duplicated in the rendered workspace `README.md`;
removing only that duplicate assignment marker repaired the input, and the
rerun passes with a material reusable guidance update. The solver edit-boundary
check also passes.

Julia is not installed, so the lightweight runtime smoke cannot launch. A
deterministic static audit finds exactly one nonempty candidate, both public
functions exactly once, and `69` unique direct `params.FIELD` references among
`71` returned fields with no undeclared reference; only `version` and
`control_period` are metadata. The policy contains no explicit clock/step
input, randomness, file I/O, cylinder cue, mutable global state, or memorized
route. Its SHA-256 is
`436afc58a96c53e8d2e4687a19c95c0adb841e641dfc5c865ed3fefb18021fd7`,
an exact byte match to the successfully evaluated progress-release sample.
No formal CFD was run.
