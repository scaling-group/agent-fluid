# Mature-carrier feasibility governor candidate

## Evidence and visual diagnosis before editing

- The four current solver samples satisfy the frozen rollout contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture
  termination. Their trajectories and combined sheets are byte-identical.
  Three contain the identical `v40` law and the fourth contains a dormant
  `v41` selector, so they reproduce one physical result: capture at
  `19.684490 T`, score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, and `243`
  moving-window shifts.
- I inspected the full release-to-capture combined sheet. The top-down row
  begins from quiescent fluid and develops a coherent alternating posterior
  wake along a compact target-directed path, establishing self-propulsion
  rather than advection. The oblique row contains finite, localized Lambda2
  structures rather than a volume-filling instability. Nothing immediately
  before capture indicates collision, boundary exit, joint-stop dwell, or wake
  collapse.
- The assigned parent's low-speed energy-bootstrap rollout is the informative
  failure comparison. It also starts from uniform still water and retains a
  coherent finite wake, but the top-down path bends below the compact corridor
  and needs a pronounced late correction. Although its `12 L` crossing moves
  from `3.806 T` to `3.190 T`, capture regresses to `23.408014 T`, score and
  mean distance regress to `-0.380336665` and `2.277320982 L`, and window
  shifts rise from `243` to `264`. The related phase-space-deficit recovery is
  consistent: it crosses `12 L` at `2.954 T` but captures only at
  `22.962509 T`, with score `-0.330184330` and mean distance `2.226326690 L`.
  Their anterior/posterior angle extrema grow to about `0.772/0.706 rad`
  versus `0.662/0.531 rad` for `v40`. Faster release progress is therefore not
  evidence that the mature traveling bend benefits from added oscillator
  energy.
- The less invasive inherited outer posterior-divergence allocator also fails
  the distance-integral test. It captures slightly earlier at `19.585491 T`
  and remains finite, but delays the `10`, `4`, and `2 L` crossings, regresses
  score/mean distance to `-0.272400020`/`2.162221182 L`, and raises overall
  high-command counts. Together with the logged `46.145020 T` loop from lag
  shortening, this says to preserve the posterior phase target and avoid
  adding another after-clipping allocation branch.

## Policy hypothesis

Preserve the reproduced `v40` target geometry, mean-curvature equilibria,
posterior lag formula, saturation allocator, and terminal posture exactly.
Add one upstream feasibility mechanism for the mature outer carrier: compute a
nominal drive from the current two-joint state, then permit a small continuous
cadence reduction only when all of these normalized observations agree:

- center translation already has established positive target closure;
- the nominal rhythmic acceleration exceeds the software envelope;
- independent clipping would materially rotate the nominal two-joint
  acceleration direction;
- posterior tracking error is material; and
- the target is outside the protected `4 L` band and large-angle redirect is
  quiet.

The posterior target uses `phi_dot1 / omega`, so changing `omega` while leaving
the lag coefficient unchanged preserves the intended state-derived traveling-
bend phase geometry for sinusoidal motion. Acting upstream should reduce an
infeasible requested cadence instead of altering the phase target or stacking
another output limiter. Startup receives no support because target closure is
not established; the complete terminal law receives none because of the outer
gate. The candidate is falsified if the branch is dormant, changes any command
at or below `4 L`, delays the `10/4/2 L` crossings or capture, worsens the
distance integral, increases sustained saturation or loads, changes the
compact route, creates paired wake bands or a loop, causes joint-stop dwell or
instability, or degrades either wake view.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish CPG control
source_mechanism: retain a directed posterior-lagged traveling bend while sensory feedback adjusts rhythmic rate to actuator and follower feasibility
transferable_invariant: subordinate requested cadence to established target-closing response and posterior tracking capacity without changing the traveling-wave phase geometry
nontransferable_details: published gains, dimensional frequencies, Strouhal targets, species amplitude envelopes, exact phase or vortex timing, full-body waveforms, and task-specific routes
policy_translation: use body-frame target/course alignment, normalized center speed, normalized posterior target error, nominal acceleration headroom, redirect state, and distance to gate a bounded reduction of state-derived omega before recomputing both joint commands
falsification: reject dormancy or any slower/lost capture, worse distance integral, changed terminal command, altered compact topology, saturation or load growth, joint-stop dwell, instability, or degradation of either wake view

## Validation boundary

Reconstruction on all `3,579` stored `v40` states changes `448` commands. The
first changed state is near `5.907 T` and `11.155 L`, after the excluded first
`3 T`; the last is near `15.439 T` and `4.001 L`. No reconstructed command at
or below `4 L` changes. The cadence reduction remains at or below its declared
`3%` ceiling, all outputs remain within the existing software acceleration
limit, and the largest same-state command delta is
`1.587324 rad/T^2`. These checks establish that the new conjunction is active,
finite, bounded, and isolated from startup and the terminal band. They cannot
establish a coupled hydrodynamic improvement; only a later formal CFD
evaluation can do that.

## Final non-CFD checks

- The semantic guidance check passes after removing a duplicated assigned-parent
  catalog entry from the rendered workspace `README.md`.
- The lightweight Julia contract check passes with finite two-joint output,
  and a deterministic grid of `32,805` extreme but finite states stays within
  the declared software acceleration limit.
- The editable-boundary check passes. A direct schema audit finds all `97`
  referenced `params.FIELD` names among the `98` fields returned by
  `target_policy_params()`; only metadata `version` is intentionally
  unreferenced.
- The prescribed pinned check-runner was invoked but its configured
  `gpt-5.4-mini` model is unavailable for this account, so it failed before
  executing a check. An independent fallback runner executed the exact three
  commands from its manifest separately and reported PASS for each. No formal
  CFD rollout was run.
