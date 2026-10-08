# Response-aligned posterior damping-relief candidate

## Evidence and visual diagnosis before editing

- All four current solver samples satisfy the frozen experiment contract:
  direct uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture
  termination. Their combined sheets and trajectories are identical. Three
  contain the same `v40` source and the fourth is a source-only `v41`
  variation masked by the existing allocation floor, so the samples reproduce
  one physical result: capture at `19.684490 T`, score `-0.261384287`,
  distance integral `2.151092787 L`, final distance `0.748302400 L`, path
  length `12.951133 L`, and `243` window shifts.
- I inspected the full combined sheet from release through capture. Its
  top-down row starts from quiescent fluid and develops a coherent alternating
  posterior wake along a compact target-directed path, so the fish is
  self-propelled rather than advected. The oblique row retains finite,
  localized Lambda2 structures. Productive oscillation and broad steering are
  already present; no collision, boundary exit, wake collapse, or numerical
  instability precedes capture.
- The assigned parent's mature-carrier cadence governor is the informative
  failure comparison. It also preserves capture and finite coherent structure,
  but its bounded `3%` cadence reduction changes `448/3579` reconstructed
  baseline commands and then delays capture to `20.322491 T`, regresses score
  and distance integral to `-0.266846005` and `2.157538110 L`, lengthens the
  path to `13.310441 L`, and raises anterior excursion from `0.661505` to
  `0.708409 rad`. The `12` and `10 L` crossings remain identical, but every
  crossing from `8 L` inward is slower; high-command counts and peak
  force/moment fall only slightly. Its top-down sheet remains recognizably
  alternating but follows a longer approach, while the oblique structures
  remain finite. Thus the regression is a controlled trajectory/cadence
  coupling failure, not instability or lost propulsion.
- Earlier inherited evidence is consistent with that boundary: adding
  oscillator energy advanced release but increased joint excursions and bent
  the mature route, while shortening posterior lag produced a large loop.
  The current baseline nevertheless reaches the software acceleration cap on
  many outer commands. A same-state audit rejected an initial anterior
  phase-radius damping proposal before CFD: normalized anterior phase radius
  peaks at `1.128` overall but at only `0.894` wherever the mature feasibility
  conjunction is active, leaving the proposed excess-radius barrier dormant.
  High posterior lag-target error, rather than excess anterior radius, is the
  state signal that actually overlaps overload and clipping distortion.

## Policy hypothesis

Preserve the complete reproduced `v40` controller and add one compact
state-feedback mechanism inside the posterior follower, before its existing
allocator: response-aligned damping relief. The current follower damps
absolute posterior velocity even when that velocity is already reducing the
observed lag-target position error. Release only a small bounded fraction of
that damping when `(tail_target-q2)*qd2` is positive. Require the same mature
body-frame feasibility evidence that made the parent test independently
active: positive target-course closure, raw two-joint drive overload,
clipping-induced direction distortion, material posterior lag-target error,
quiet large-angle redirect, and distance above `4 L`.

This is a phase-conditioned follower-response mechanism, not a scalar change
to global damping, cadence, amplitude, or lag. The posterior target, anterior
oscillator, steering terms, and terminal law remain unchanged. It is
identically absent during startup, redirect, motion away from the posterior
target, and the terminal band. It is falsified if same-state reconstruction
finds it dormant or active at/below `4 L`, or if formal CFD slows any mature
crossing or capture, worsens the distance integral, changes the compact route,
increases clipping/load/joint-stop dwell, creates paired wake bands or a loop,
destabilizes the rollout, or degrades either visual view.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and classical elongated-body swimming
source_mechanism: couple a posterior follower to a directed traveling bend while modulating dissipation from observed tracking response
transferable_invariant: preserve the posterior wave target and relieve only dissipation that opposes an already target-closing follower response under measured infeasibility
nontransferable_details: published gains, dimensional frequencies, species amplitude envelopes, Strouhal targets, exact phase or vortex timing, full-body waveforms, and task-specific routes
policy_translation: use the sign and normalized rate of posterior lag-error closure together with body-frame target-course closure, raw drive overload, clipping direction distortion, posterior tracking error, redirect state, and distance to gate a bounded release of posterior absolute-velocity damping before the existing allocator
falsification: reject dormancy, terminal leakage, any slower mature crossing or capture, worse distance integral, altered compact topology, saturation or load growth, joint-stop dwell, instability, or degradation of either wake view

## Validation boundary

Reconstruction on the `3,579` stored `v40` trajectory states finds nonzero
posterior damping relief on `417` states and changes `413` final two-joint
outputs. Activity begins near `5.907 T`, `11.155 L` and ends near `15.439 T`,
`4.001 L`; no branch or output activity occurs at or below `4 L`. Relief
reaches its declared `1.50 rad/T^2` bound, while the inherited allocator limits
the largest final same-state output delta to `0.027607 rad/T^2`. The recreated
baseline commands match the next logged actions within `0.3592 rad/T^2`, small
relative to the `30.5433 rad/T^2` software bound; exact flow-history replay is
not claimed.

The lightweight contract check returns finite two-joint output. A deterministic
grid of `98,415` finite extreme states remains within the declared software
acceleration limit. All `99` direct `params.FIELD` references are present among
the `100` fields returned by `target_policy_params()`; only metadata `version`
is intentionally unreferenced. The semantic guidance check and editable-file
boundary check pass. These checks establish bounded activity and terminal
isolation, not hydrodynamic improvement; the new CFD result belongs to a later
worker.

The prescribed `.codex/agents/check-runner.toml` was invoked after the edits,
but its pinned `gpt-5.4-mini` model is unavailable for this account, so the
agent failed before executing a check. As a fallback, I ran the manifest's
three exact commands separately: semantic guidance PASS, lightweight Julia
contract PASS, and editable-boundary PASS. No formal CFD was run.
