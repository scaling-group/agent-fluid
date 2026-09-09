# Middle-field half-cycle course redirect

## Pre-edit evidence diagnosis

All four sampled L64 rollouts are valid direct-uniform still-water episodes:
`U_infinity=(0,0,0)`, no prewarm snapshot, no cylinders, finite dynamics, and
`capture` termination. The combined visual sheets for the strongest sample
(`solver_7b0034b927d0`) and weakest sampled capture
(`solver_5f0cc55f5f2e`) show self-propulsion rather than advection. From release
through capture, both top-down rows develop an alternating, posteriorly shed
wake and both oblique rows show bounded three-dimensional Lambda2 structures
following a smooth curved trajectory. Neither sheet shows a collision, domain
exit, disorganized lateral excursion, or visible wake collapse before capture.
No current sampled rollout is a semantic failure, and the inherited domain-exit
logs provide no keyframes; therefore the weakest sampled capture is the only
valid visual failure-side comparator rather than a fabricated visual diagnosis
of the scalar-only inherited failures.

The metrics make the small but meaningful difference clearer than the nearly
identical sheets. The terminal-only course redirect captured at `20.971T`
with score `-0.27435`; giving that redirect middle-field authority captured at
`20.653T` with score `-0.27336`. On the otherwise terminal-gated controller,
state-derived half-cycle steering captured at `20.207T` with score `-0.22712`,
whereas line-of-sight lead captured at `20.471T` with score `-0.26940`. Thus
half-cycle modulation is the strongest sampled semantic improvement and is
not scalar-only gain tuning. It retained the sampled load envelope (peak
planar force coefficient `0.0244`, peak yaw-moment coefficient `0.0128`) and
kept joint angles below `0.60 rad`, but raised anterior mean absolute command
from `18.67` to `19.29 rad/T^2` and anterior residence above 90% of the smooth
`31 rad/T^2` bound from `34.6%` to `36.6%`. All samples reached the joint-rate
limit, so command headroom remains a falsification boundary rather than a
reason to add more authority.

The inherited optimizer scores also bound the inference: the lineage changed
from repeated domain exits and `2.12--7.53L` near misses to capture only after
the full-vector approach allocator and velocity-course redirect appeared.
Consequently, the traveling-bend carrier, fore/aft-aware target geometry,
approach relief, and bounded course redirect are preserved. The new candidate
tests only whether the evidenced half-cycle mechanism composes with the
parent's earlier middle-field course correction; the available rollouts do not
yet establish that interaction.

## Candidate hypothesis

Retain the prefilled controller's independent `8L`-to-`2L` course-error gate,
and modulate its target-driven mean curvature and anterior steering during the
joint-state half-cycle already moving with the requested route turn. Infer
phase only from normalized `phi_dot1/(omega*active_amplitude)`, keep the
modulation bounded, and leave propulsion amplitude, posterior lag, terminal
drive relief, and course-redirect gains unchanged. Expected result: capture
earlier than the `20.653T` middle-field parent, ideally preserving the sampled
half-cycle controller's `20.207T` class, without changing the coherent wake or
sampled load envelope. Falsify the composition if it loses capture, is slower
than the parent, increases either joint's near-command-bound residence above
about 40%, increases peak force/moment materially beyond `0.025/0.013`, raises
joint-angle residence toward the `45 deg` limit, or produces a visibly less
coherent wake.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping or duty-ratio modulation
source_mechanism: strengthen the turn-producing half-cycle while relaxing the return stroke
transferable_invariant: bounded directional asymmetry can add mean turning authority without replacing the traveling propulsive rhythm
nontransferable_details: published gains, clock phase, robot morphology, dimensional frequency, species kinematics, and task-specific routes
policy_translation: infer beat alignment from normalized anterior-joint velocity and body-frame target turn request, then softly scale the two existing steering contributions
falsification: reject the composition if capture timing, wake coherence, load envelope, joint-limit margin, or command-bound residence regresses against the sampled controllers
