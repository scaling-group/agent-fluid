# Braking-enveloped posterior-work candidate

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, all sampled policies, scores,
  observations, compact metrics, diagnostics, trajectories, and inherited
  optimization notes. Every sampled rollout satisfies the frozen contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no prewarm or cylinders, stable dynamics, and capture
  termination at `17.7870--18.0125T`.
- I inspected both rows of the combined keyframe sheets for the score-leading
  phase-consistent work policy, the closure-qualified work comparator, and the
  consensus-qualified wave-reserve comparator. All self-propel from rest,
  establish a coherent alternating mid-plane street, and retain compact
  three-dimensional posterior Lambda2 structures through capture. None shows
  passive advection, collision, wake breakup, or out-of-plane instability.
  There is no literal failure keyframe in the current sample, so the weakest
  sampled route/score state is the visual negative control; the inherited
  translation-qualified work rollout is the semantic failure (`0.9166L`
  closest approach followed by `left_domain`) but has no keyframe in this
  rendered sample.
- Two byte-identical evaluations establish that the current prefill is
  deterministic at score/mean distance `-0.064599/1.950823L`. Relative to the
  unguarded closure-qualified work policy it improves those values from
  `-0.072146/1.958037L` and improves final course alignment from `-0.003` to
  `0.068`, while both visual wakes and the force/moment class remain coherent.
  Its boundary is a later `18.0125T` capture and wider
  `13.2330L/0.7417L` path/cross-track, versus
  `17.8695T/13.0071L/0.6102L` for the unguarded work comparator. The
  consensus wave reserve is straighter (`12.9495L/0.5193L`) but loses scored
  closure (`-0.073937/1.959602L`), so replacing the work mechanism or reducing
  it globally is not supported.
- Inherited completed iterations reject three tempting semantic changes.
  Referencing the work guard unconditionally to the oscillatory wave rather
  than the combined wave-plus-steering target regresses to `-0.080637` despite
  capture and a straighter route; interpolating between those references with
  carrier energy also regresses to `-0.073525`; replacing head-range closure
  by target-projected center translation loses capture and exits the domain.
  These results argue for preserving the evaluated phase reference, progress
  signal, and launch work.
- An offline replay of the score leader's logged state does not predict new
  dynamics, but it localizes the proposed guard. The existing work reserve is
  nonzero only through about `1.71T`. A kinematic braking envelope based on
  posterior rate and the owned acceleration limit retains about `96.9%` of
  logged work magnitude over the first `0.5T`, then withdraws more of the
  later reserve as carrier motion grows; it retains about `88.3%` overall.
  Thus it differs from the failed phase-reference edits: it leaves the useful
  initial combined-target bootstrap nearly intact and targets only work that
  cannot be stopped before the observed posterior target crossing.

## One policy hypothesis

Preserve the score leader's anterior state-feedback oscillator, posterior lag
and emphasis, combined wave-plus-mean-curvature tracking reference, one-sided
phase-consistency guard, odd body-frame steering, error-qualified far/middle
route observer, approach handoff, cadence scheduler, half-cycle steering, and
reversal-preserving rate governor. Add one phase-plane braking mechanism to
the existing extra posterior work: while the posterior joint is moving toward
its current target, estimate its stopping angle as `phi_dot2^2/(2*a_limit)`
from normalized joint state and the policy-owned acceleration envelope. Keep
full work when remaining target error exceeds twice that stopping angle,
withdraw it smoothly over the braking interval, and leave the existing
opposition guard responsible when motion is already away from the target.
This adds no time, memory, coordinates, target identity, prescribed phase, or
new scalar gain.

Expected evidence is retention of the score leader's first-`0.5T` launch and
mean-distance advantage, with reduced posterior overshoot and a route/capture
state moving toward the shorter comparators. Falsify the candidate if early
closure or score returns to the `-0.0735` to `-0.0806` phase-reference class,
capture is lost or materially delayed, path/cross-track fails to improve,
actuator/load residence increases, reflection behavior fails, or either the
top-down or oblique wake loses coherence.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: reinforce a posteriorly lagged traveling bend while observable phase-plane state still permits acceleration followed by bounded braking into the commanded target
transferable_invariant: extra posterior work should cease before measured joint momentum makes target overshoot unavoidable, while the established traveling-wave and mean-steering reference remain unchanged
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, target coordinates, and task-specific routes
policy_translation: compare normalized posterior target error with the stopping angle implied by posterior joint rate and the policy-owned acceleration limit, then smoothly gate only the existing velocity-aligned work reserve
falsification: reject if initial closure or mean-distance benefit is lost, route or capture does not improve, actuator/load class worsens, reflected state behavior fails, or either coherent visual wake view deteriorates

## Non-CFD validation

- The required guidance comparison passes after removing a duplicated rendered
  assigned-parent marker from the workspace `README.md`; the parent selection
  and evidence are unchanged.
- The solver boundary check passes. A deterministic schema scan finds all 60
  direct `params.FIELD` references among the 62 fields returned by
  `target_policy_params()`, with one nonempty policy entrypoint and no hidden
  time, randomness, file I/O, or mutable-global construct.
- Focused numerical checks confirm that the braking gate is zero at one
  stopping angle, one-half midway through the braking interval, and one at two
  stopping angles; it remains finite and identical under mirrored error/rate
  state. This is a mechanism check, not rollout evidence.
- The configured check-runner was invoked, but its pinned model is unavailable
  to this account. Its guidance and boundary commands were run directly and
  pass. The Julia smoke command could not run because `julia` is not installed
  in this worker image. No CFD was run, as required.
