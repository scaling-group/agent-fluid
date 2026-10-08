# Speed-observed startup carrier candidate

## Visual and metric diagnosis before the policy edit

- The assigned parent and all four sampled solver candidates are byte-identical.
  Every sampled rollout satisfies the direct-uniform still-water contract with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite moving-window
  dynamics, and capture at `16.604496T`. Each scores `-0.1137286`, crosses at
  `0.743958L`, has scored distance integral `1.998146L`, and performs 237
  moving-window shifts. The repeats establish nominal determinism, not a new
  control improvement or held-out robustness.
- I inspected both rows of a sampled combined keyframe sheet from release to
  capture. The top-down row shows self-propelled left/down translation on a
  shallow target-crossing arc, with a coherent alternating mid-plane vorticity
  street. The oblique row shows compact alternating three-dimensional Lambda2
  structures connected to the posterior body and traveled path. There is no
  passive advection, inherited wake, collision, upper-boundary exit, wake
  breakup, or instability.
- For a controlled contrast, I inspected both rows of the inherited
  high-alignment terminal yaw-release rollout. It preserves the same visible
  arc and connected wake class and arrives one `0.0055T` step earlier, but
  crosses less deeply (`0.744276L`), raises distance integral from `1.998146L`
  to `1.998380L`, and worsens score from `-0.113729` to `-0.114037`. Together
  with the inherited closure-deficit, projected-corridor, line-of-sight-rate,
  bearing, moment, and local-flow residual regressions, this rules out another
  terminal gate or another phase subtraction as the present nominal test.
- The surviving parent instead exposes a startup transient. Its head distance
  decreases only from `12.3277L` to about `12.0132L` during the first `4T`,
  although planar speed later exceeds `1U`. Planar speed first reaches `0.25U`
  near `2.965T` and `0.30U` near `3.553T`. Before `3T`, the sampled joint-speed
  ranges are only about `[-2.41,2.59]` and `[-3.75,3.33] rad/T`, below the
  `4.538 rad/T` clamp, while requested acceleration remains within roughly
  `[-25.63,23.95]` and `[-29.06,29.10] rad/T^2` before the smooth
  `31.416 rad/T^2` envelope. This supports a small startup-only carrier test;
  it does not license higher steady gait gains.

## Sole candidate hypothesis

Preserve the assigned parent's target geometry, anterior course center,
lateral and yaw phase demodulators, posterior route/crossflow/yaw response,
half-cycle steering, acceleration bound, and one-sided speed guard. Add one
new controller mechanism: a normalized body-speed observation smoothly raises
the oscillator angular rate by at most 10% only while planar speed is below
`0.30U`. The gate is one at rest, has compact support, and becomes exactly zero
once the carrier establishes that speed, so the evidenced mature route and
approach law are recovered without elapsed time or a stage counter. The same
effective angular rate drives the anterior state oscillator, the posterior
state-derived lag target, and its tracker so the traveling-wave relationship
remains internally consistent.

Expected test: create useful self-propulsion earlier, reduce pre-approach
distance integral, and retain capture plus the connected two-view wake without
materially increasing joint contact, near-limit residence, force, or moment.
Falsify the mechanism if the startup gate chatters with beat-scale lateral
speed, if it changes the mature trajectory after speed establishment, if it
merely increases saturation or loads, or if arrival, crossing depth, distance
cost, capture, or wake connection regresses. The new candidate has no CFD
result yet; these are evaluation criteria, not claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG locomotion and Lighthill-style posterior reactive thrust
source_mechanism: regulate a productive rhythmic carrier from observed locomotor state while preserving an internally consistent traveling bend with posterior lag
transferable_invariant: use normalized measured speed to recruit bounded carrier authority only while self-propulsion is not established, then recover the evidenced traveling-wave controller continuously
nontransferable_details: published CPG gains, dimensional frequencies and speeds, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: below `0.30U` planar body speed, smoothly increase the state-feedback oscillator rate by at most 10% and use that same rate in both joint-1 drive and joint-2 lag tracking; leave all route and mature-carrier channels unchanged
falsification: reject if startup progress does not improve, if speed-gate oscillation distorts the wake, or if capture, target cost, crossing depth, joint feasibility, force, moment, or mature-route identity worsens

## Evaluation boundary

No CFD result is claimed for this workspace's candidate. Later evaluation
should require capture and the same top-down/oblique wake class first, then
compare distance and body speed through `4T`, time to sustained forward motion,
arrival, scored and observed distance integrals, final crossing depth, joint
excursions, speed/acceleration residence, requested action, force, and moment
against the four exact `-0.1137286` parent rollouts. A nominal improvement would
not establish held-out pose, flow, or carrier-family robustness.
