# Carrier-residual yaw-opposition redirect

## Visual and quantitative diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform contract:
  `initialization_mode=uniform_direct`, `U_infinity=(0,0,0)`, no cylinders,
  no prewarm, and finite capture. I inspected the complete combined sheets for
  the sampled-best `solver_5187bb13ebc0` and the informative posterior-release
  regression `solver_736250db9a8b`. In both top-down rows the fish translates
  under its own traveling bend and establishes a coherent alternating red/blue
  wake by `4T`; in both oblique rows compact paired three-dimensional Lambda2
  structures remain attached to the posterior wake through capture. Neither
  view shows passive advection, wake collapse, collision, boundary contact, or
  instability. The sheets are visually almost indistinguishable, so the
  current failures are control-role regressions within the capture class, not
  a different visible termination topology.
- The assigned-parent anterior-only corridor release is the strongest sampled
  finite result: `solver_5187bb13ebc0` and `solver_d97cee67d951` are exact
  policy/trajectory repeats that capture at `16.0545T`, finish at `0.744345L`,
  and score `-0.055617`. Extending the same corridor gate to release posterior
  wave settling in `solver_736250db9a8b` leaves capture time unchanged but
  delays the `0.8L` crossing from `16.0105T` to `16.0160T`, worsens final
  distance to `0.745354L` and score to `-0.056672`, and raises posterior
  acceleration-limit residence from `22.47%` to `22.78%`. The signed-intercept
  half-cycle relief in `solver_da1119fe4fc6` likewise leaves all sampled
  milestones through `0.8L` unchanged and regresses the crossing to
  `0.744660L`, score `-0.055945`. These comparisons reject another terminal
  wave-release wrapper.
- The inherited parent logs supply the other control-role negatives. Releasing
  terminal high-authority mean curvature changed only six posterior commands
  and captured at `0.745652L`, score `-0.056973`; signed terminal centering
  captured at `0.749671L`, score `-0.061164`. The higher-Elo sampled guidance
  also reports replicated pre-limit speed-headroom guarding: it lowered
  limiting and peak loads but delayed every distance milestone and capture.
  A safe projected intercept is therefore evidence only for releasing residual
  anterior braking. It is not evidence for weakening posterior wave shaping,
  mean steering, or another near-limit action.
- A phase fit on the sampled-best trace identifies a distinct unused response
  signal. Normalized anterior position and velocity explain `98.8%` of raw
  heading-rate energy over the full rollout and `99.3%` below `1.75L`; the
  approach fit is approximately
  `heading_rate/omega = 0.020*q1/amp - 0.463*qd1/(omega*amp) + residual`.
  Thus raw yaw damping would mostly oppose the evidenced locomotor carrier.
  At capture, however, target-versus-course error is about `-0.718 rad` while
  raw heading rate is `+3.208 rad/T`; after carrier subtraction the remaining
  yaw is still about `+0.10 rad/T`, opposite the requested turn. This supports
  a small response correction without treating beat-scale yaw as route error.

## Policy hypothesis

Preserve the sampled-best state-feedback oscillator, posterior traveling wave,
carrier-phase-residual redirect selector, raw-error turn direction, one-sided
opposing-wave relief, mean-first posterior allocator, anterior-only intercept
release, bounds, and exact speed-limit projection. Add one compact feedback
mechanism: predict the repeatable normalized yaw response from anterior joint
phase, subtract it from measured normalized heading rate, and admit a small
extra target-directed posterior mean curvature only when that residual yaw is
opposite a reliable raw redirect. Aiding residual yaw receives exactly no
extra bend. The channel is continuous, bounded, reflection-equivariant, has no
clock or route memory, and can act during any speed-reliable redirect rather
than only in the last few capture samples.

Expected result: retain the coherent traveling wake and proven route while
opening high-authority curvature slightly earlier when measured body response
still turns against target demand. This is a new feasible-action mechanism,
not a scalar-only retune. Falsify it if raw-yaw carrier subtraction is not
phase-stable in closed loop, the correction acts when residual yaw already
aids the target, early milestones or capture regress, the visible wake loses
coherence, or increased posterior limiting/load is not compensated by better
distance integral, arrival, or terminal crossing.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG path following and fish turning by bounded rhythmic asymmetry
source_mechanism: separate periodic locomotor response from sensor-measured directional error, then add a bounded steering correction without suppressing the traveling wave
transferable_invariant: preserve repeatable carrier yaw and correct only the residual response that opposes the observed target-directed turn
nontransferable_details: published gains, dimensional beat frequencies, species-specific body envelopes, prescribed oscillator or vortex phase, exact source trajectories, and task-specific routes
policy_translation: normalize heading rate by the owned carrier frequency; predict its reflection-odd carrier component from normalized anterior joint position and velocity; gate a small posterior mean-curvature increment by speed reliability, raw redirect duty, and the positive part of target-opposed yaw residual while leaving carrier wave and terminal role allocation intact
falsification: reject if the channel breaks lateral reflection equivariance, changes action for aiding yaw residual, suppresses coherent propulsion, loses capture or earlier milestones, or raises limiting and loads without a distance-integral or arrival benefit

The candidate has no same-worker CFD result. Fixed-trace replay can establish
signal locality, branch direction, boundedness, and symmetry; only the later
EvE rollout can establish a trajectory or wake improvement.

## Non-CFD verification after the policy edit

- Replay against all `2,919` sampled-best states leaves every anterior command
  exact. The new response channel changes `511` posterior commands by more
  than `1e-4 rad/T^2`, first at `2.7445T` after its explicit forward-speed
  reliability transition, with a maximum and mean changed-command magnitude
  of `8.485` and `1.358 rad/T^2`. It never changes a command when carrier-
  residual yaw already aids the raw redirect. On these fixed states posterior
  acceleration-limit residence falls from `22.51%` to `21.82%`; this is action
  semantics, not a closed-loop load, route, or improvement claim.
- Static schema inspection finds `41` direct `params.FIELD` references and all
  `41` are returned by `target_policy_params()`. A deterministic `2,916`-state
  sweep over joint position, exact joint-speed boundaries, target side,
  bearing, forward/lateral velocity, distance, and heading rate returns finite
  bounded actions, rejects same-sign outward acceleration at either exact
  speed limit, and has exactly zero lateral-reflection error.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this ChatGPT account. Its three
  prescribed commands were therefore run directly and separately: the
  material guidance/provenance check, lightweight Julia policy contract, and
  solver editable-boundary check all pass. The guidance check initially found
  the same assigned parent marked twice in the rendered workspace `README.md`;
  removing only that duplicate restored unique parent provenance. No CFD was
  run.
