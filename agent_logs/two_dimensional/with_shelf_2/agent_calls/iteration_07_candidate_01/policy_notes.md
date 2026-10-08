# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four developed cylinder streets merge around the target.
  The released sheet can therefore be compared across policies without
  attributing its route to different wake maturity.
- All four sampled solver examples and the assigned parent's inherited rollout
  are functionally identical replays of the response-aware, yaw-load-gated
  distributed half-cycle law. Their sheet shows active self-propulsion: a
  traveling body wake persists while the fish follows a continuous diagonal
  down-left route, enters the interacting wake, and first crosses the target
  circle at `51.47`. Metrics agree with `0.748L` final/minimum and `1.82L` mean
  distance, `-11.28/-4.94L` head displacement, and no failure termination.
  Exact repetition validates deterministic materialization in this fixed wake,
  not robustness to a changed phase or task.
- The successful policy still carries high finite effort and load: command
  energy mean `995`, force/moment RMS `426/4084`, and peak joint accelerations
  `28.79/28.14`. Its anterior joint reaches `0.721` rad while the posterior
  reaches only `0.659` rad, leaving a modest posterior-amplitude opportunity,
  although both joints touch the `4.538` rad/time rate limit and make added
  saturation an explicit risk.
- No sampled failure keyframe exists in this rendered workspace: every released
  sheet has the same successful image hash. The informative failure contrast
  is therefore inherited rather than re-read visually. The otherwise matched
  ungated heading-response controller approached to `1.65L` but folded into a
  lower exit at `75.09`, with `487/4680` force/moment RMS. This supports
  preserving the successful load gate and rules out another steering-gain or
  signed-disturbance edit from the available aggregate evidence.

## Candidate hypothesis

Preserve the complete successful steering architecture and add one compact
propulsion mechanism: when the bounded predicted body-frame bearing is already
aligned with the target, apply a modest smooth posterior amplitude emphasis to
the lagged traveling-bend target; continuously remove that emphasis as route
error grows. The parent trajectory is already nearly monotone and direct, so
the score-relevant opportunity is earlier arrival/lower mean distance rather
than more turn. Conditioning the extra posterior motion on alignment lets the
controller spend it on forward progression without changing the anterior
oscillator, yaw-load gate, or steering sign.

The next CFD rollout falsifies this candidate if it loses `target_reached`,
does not improve the `51.47` arrival or `1.82L` mean-distance baseline, returns
an upper/lower exit, or increases joint-limit residence or force/moment load
without a route benefit. In that case later workers should revert to the exact
yaw-gated reference rather than tune the posterior-emphasis scalar.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior wave kinematics supply reactive thrust while body-frame feedback modulates the rhythmic envelope
transferable_invariant: preserve the traveling wave and add modest posterior emphasis only while observed route alignment is good
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, exact vortex phases, and task-specific routes
policy_translation: smoothly scale the anterior-state contribution to the posterior lag target by bounded predicted-bearing alignment while leaving distributed steering and its yaw-load gate unchanged
falsification: reject if capture or the successful lateral topology is lost, arrival and mean distance do not improve, or added posterior motion worsens rate-limit contact or hydrodynamic load without useful progress
