# Terminal head-response redirect candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm snapshot, finite moving-window dynamics, and capture.
  Their combined keyframe sheets are byte-identical. Three policies are the
  identical `v40` law and the fourth contains a selector masked by the existing
  allocation floor, so the samples reproduce one physical result rather than
  four mechanisms: capture at `19.684490 T`, score `-0.261384287`, mean/final
  distance `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and
  `243` moving-window shifts.
- I inspected the release-to-capture combined sheet in both views. The
  top-down row starts from quiescent fluid and develops a coherent alternating
  posterior wake on a compact target-directed path, establishing
  self-propulsion rather than advection. The oblique row retains finite,
  localized Lambda2 structures following the fish. There is no collision,
  boundary exit, joint-stop dwell, wake collapse, or volume-filling
  instability before capture. The useful traveling bend, broad geometry
  redirect, and terminal posture therefore remain protected behavior.
- The inherited posterior-convergence allocator is the most informative
  visual failure. It remains finite and initially sheds an alternating wake,
  but then turns into the large loop visible in the top-down row; the late
  wake becomes long paired bands and the oblique structures become sparse and
  separated. Range backtracking rises from `0.006661 L` to `4.441875 L`, path
  length from `12.951133 L` to `30.804515 L`, moving-window shifts from `243`
  to `602`, capture moves to `45.848015 T`, and score regresses to
  `-0.929745304`. This is stable mis-steering, not a numerical failure.
- The assigned parent's response-aligned posterior damping relief is the
  closest active comparison. It changed `413/3579` reconstructed outer
  commands and was exactly absent at or below `4 L`, yet CFD delayed the
  `4/3/2/1 L` crossings and regressed score and mean distance to
  `-0.263092620` and `2.152556228 L`. It also raised whole-rollout
  `|action|>30 rad/T^2` counts from `1368/1973` to `1407/2012`. Although final
  capture was `0.060499 T` earlier, the upstream perturbation changed the
  realized terminal state: below `1.6 L` high-command counts changed from
  `0/0` to `18/14`, and local force/moment maxima rose from about
  `0.01150/0.00619` to `0.02073/0.01106`. Same-state terminal silence is not
  rollout-level noninterference, and instantaneous posterior error-velocity
  closure is not a safe traveling-wave feasibility cue.
- On the reproduced `v40` trajectory, the body-frame target lateral component
  remains positive below `1.6 L`. During the final capture approach its
  directly observed seven-step window rate changes from helpful negative to
  worsening positive, reaching about `0.188--0.192 L/T` near `0.86--0.80 L`
  and remaining positive near crossing. At the same time the target-angle
  redirect is already active, so the evidence supports testing response of
  that existing equilibrium rather than adding a new steering sign or another
  outer allocator.

## Policy hypothesis

Preserve `v40`'s state-feedback oscillator, cadence, posterior lag, outer
allocator, course consent, intercept corridor, acceleration ceiling, and
terminal carrier/posture combiner. Add exactly one terminal response
mechanism: when the target remains closing, the large-angle redirect is
active, and the directly observed normalized body-frame target lateral vector
is moving farther toward its current side, smoothly increase both existing
redirect equilibrium components by the same small bounded fraction. Scaling
the anterior bias and total posterior tangent together preserves their
established allocation and does not introduce a joint-role split, a new turn
sign, beat-side logic, added cadence, or a world-frame route. The mechanism is
identically absent outside the existing `1.6 L` terminal proximity gate and
when the measured head-relative lateral response is helpful.

The CFD hypothesis is quicker arrest of the final wrong-way head response with
an unchanged outer trajectory and coherent two-view wake. It is falsified by
dormancy; any command change outside `1.6 L`; delayed or lost capture; worse
score, mean/final distance, or range backtracking; increased terminal
saturation, joint-stop dwell, force, or moment; changed outer topology; or
degradation of either wake view.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and classical mean-curvature turning
source_mechanism: preserve the directed traveling bend while sensory direction response modulates the existing mean offset
transferable_invariant: a target-relative redirect may increase its existing two-joint equilibrium only when normalized body-frame head response is worsening in the commanded terminal turn regime
nontransferable_details: published feedback gains, dimensional rates, species curvature envelopes, exact tail-beat or vortex phases, robot geometry, and task-specific routes
policy_translation: use the signed body-frame target lateral component, its directly observed finite-history rate, target closure, redirect activation, and terminal proximity to scale both established redirect equilibrium components by one small bounded common factor
falsification: reject dormancy, outer leakage, slower or lost capture, worse distance integral, changed compact topology, renewed terminal clipping or load growth, joint-stop dwell, instability, or degradation of either wake view

## Pre-CFD boundary

Only common scaling of the already selected large-angle redirect equilibrium
may change, and only under the direct terminal head-response gate. The current
worker cannot claim improvement because the candidate CFD rollout occurs only
after exit. Static replay must establish bounded activity and exact outer
isolation before completion.

## State replay and non-CFD validation

- Replaying the baseline and candidate on all `3,579` stored `v40` states
  changes `116` two-joint outputs. The first active state is at
  `18.314987 T`, `1.597324 L`, and the last is the stored capture state at
  `19.684490 T`, `0.748302 L`; there are exactly zero command changes outside
  `1.6 L`.
- The common redirect-equilibrium scale stays in `[1.0, 1.05]`. The largest
  per-joint same-state command difference is `0.273711 rad/T^2`, far below the
  inherited `30.543262 rad/T^2` software ceiling. This proves bounded activity
  and outer isolation, not a coupled hydrodynamic improvement.
- The lightweight Julia contract returns a finite two-joint action. A
  deterministic grid of `9,000` finite extreme states remains inside the
  declared acceleration ceiling. The schema audit resolves all `92` direct
  `params.FIELD` references among the `93` fields returned by
  `target_policy_params()`; only metadata `version` is intentionally
  unreferenced.
- The semantic guidance check and solver editable-boundary check pass. No
  formal CFD rollout was run.
- The prescribed `.codex/agents/check-runner.toml` role was invoked after the
  edits, but its pinned `gpt-5.4-mini` model is unsupported for this ChatGPT
  account and failed before executing a check. The manifest's three commands
  were therefore run separately as the established fallback; each passes.
