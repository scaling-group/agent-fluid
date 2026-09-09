# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting vortex streets. It is the certified common
  initial condition and does not establish candidate-specific wake selection
  or wake-phase robustness.
- Three sampled examples are code-identical reproductions of the assigned
  parent's progress-supervised posterior-residual policy. Each reaches the
  target at `32.340` release time with `1.63773L` mean distance, score
  `0.234663`, and force/moment RMS `65.12/888.56`. Their released sheets show
  immediate targetward redirection, a sustained posterior-traveling body wake,
  cylinder clearance, and nose-first entry into the `0.75L` circle. Mean fish
  velocity `(-0.3362,-0.1404)` against mean local flow
  `(-0.1961,-0.1918)`, together with head displacement
  `(-10.9149,-4.2375)L`, confirms active upstream propulsion rather than
  passive advection.
- The only distinct sampled policy composes response-confirmed mean-curvature
  release with that posterior supervisor. It still captures on the same direct
  diagonal, but the late sheet shows a broader body/tail wake and the metrics
  regress to `32.4555` release time, `1.64548L` mean distance, score
  `0.226804`, and `67.83/914.09` force/moment RMS. Posterior excursion also
  rises from `0.57530` to `0.58180 rad`, while relative-crossflow RMS remains
  nearly unchanged (`0.24372` versus `0.24461`), so wake avoidance does not
  explain the regression.
- No sampled released failure sheet exists. The distinct but dominated
  successful composition is therefore the adverse visual comparison;
  inherited downstream exits are retained only as textual boundaries. Those
  logs show that unrestricted bearing-rate recentering erased the traveling
  bend, blanket physical-limit damping delayed capture, and adding a separate
  response-withdrawal layer to the current supervisor worsened navigation and
  loads. Both sampled branches still touch the joint velocity and acceleration
  ceilings, so increasing authority is not supported.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG sensory modulation combined with biological redirect-and-release turning and posterior reactive propulsion
source_mechanism: preserve a persistent traveling gait while verified goal-directed turning may withdraw one optional rhythmic steering residual
transferable_invariant: slow body-frame target geometry owns mean turn direction, and observed correct-sign response may reduce only incremental steering authority without weakening distributed mean curvature or the base traveling wave
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, prescribed maneuver timing, exact vortex phases, actuator ratings, fixed approach distances, and source-task routes
policy_translation: extend the existing posterior-residual supervisor with normalized gait-activity, recent-turn-rate, and bearing-window-rate evidence; combine response confidence with trajectory-efficiency confidence inside the same one-sided headroom gate while leaving mean curvature and the unit-gain lagged wave unchanged
falsification: reject if immediate redirect, the narrow traveling bend, direct capture, or score is lost; if arrival or mean distance exceeds the assigned parent without a repeatable load reduction; if force or moment exceeds `65.12/888.56` without better navigation; or if held-out wake phase exposes switching or propulsion loss

## Candidate hypothesis

Produce exactly one candidate by changing only the confidence signal that
supervises the current optional `8%` target-helping posterior half-cycle
residual. Retain the filtered body-frame bearing, bounded `12 deg` total
curvature, bearing-conditioned `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, and the existing
direction-selective speed/previous-acceleration pressure.

The current gate yields the residual only when history-window target motion is
mostly translational closure. During the initial redirect, body-frame target
rotation makes that ratio small even when the fish is visibly turning the
right way. Add a second confidence estimate inside the same gate: after the
anterior gait is established, require both recent heading rotation toward the
persistent bearing and a shrinking bearing magnitude. Take the larger of this
verified-response confidence and the existing closure confidence. Thus either
coherent translation or coherent redirect may permit actuator-state yielding,
but neither can add authority, change an oscillator center, release mean
curvature, or suppress the base posterior wave. The downstream CFD evaluation
must determine whether earlier residual yielding retains the direct capture
while reducing saturation-driven late oscillation; no same-worker improvement
is claimed.
