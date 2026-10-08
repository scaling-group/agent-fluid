# Energy-partitioned posterior-work phase reference

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, trajectories, and both rows of the
  combined keyframe sheets. Every sampled episode is a stable capture from
  direct uniform still water with `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders. In the top-down row each fish self-propels from rest and forms a
  coherent alternating vorticity street; the oblique row retains compact
  paired posterior Lambda2 structures through capture. There is no passive
  advection, wake breakup, collision, or out-of-plane instability. Route and
  closure histories, not gross wake existence, distinguish the candidates.
- The phase-consistent posterior-work policy is the sampled score leader, with
  two byte-equivalent evaluations at score/mean distance
  `-0.064599/1.950823L`. It preserves first-`3T` mean distance/speed at
  `12.214593L/0.2519U`, but captures at `18.0125T` on a
  `13.2330L/0.7417L` path/cross-track and has only `0.6637/0.0678`
  near/final target-course alignment. Its coherent wake therefore accompanies
  a useful integrated-closure gain and a real route-width cost.
- The assigned consensus-gated wave-target reserve is a balanced comparator:
  it captures at `17.7870T`, shortens path/cross-track to
  `12.9495L/0.5193L`, and raises near/final alignment to `0.8366/0.2863`,
  but weakens first-`3T` distance/speed to `12.220562L/0.2459U` and regresses
  score/mean distance to `-0.073937/1.959602L`. Its acceleration-ceiling
  residence remains high at `69.85/65.34%`, so the evidence does not support
  another scalar gain or desaturation edit.
- The latest inherited completed rollout tested the obvious separation of
  propulsion and steering in the score leader's phase guard: replacing the
  combined posterior target by the oscillatory wave target alone. It retained
  capture and the coherent two-view wake, improved arrival/path/cross-track
  from `18.0125T/13.2330L/0.7417L` to
  `17.8585T/12.9783L/0.5621L`, and kept the same force/moment and actuator
  class. However, it lost the early carrier benefit
  (`12.214593L/0.2519U` to `12.218702L/0.2469U`) and regressed score/mean
  distance sharply to `-0.080637/1.966422L`. Thus an always-separated phase
  reference is a concrete negative result: later workers should not retry it
  as a generic route repair.
- The unguarded work reserve and assigned consensus reserve bound the same
  tradeoff. The former captures at `17.8695T` with
  `-0.072146/1.958037L` score/mean distance and a
  `13.0071L/0.6102L` route; the latter is slightly straighter but no better in
  scored closure. Across all comparisons, RMS force/moment remains about
  `0.0158/0.0082`, and posterior acceleration-ceiling residence remains
  `65--66%`; wake strength and output saturation do not explain the ordering.

## One policy hypothesis

Start from the sampled score-leading phase-consistent posterior-work policy
and preserve its anterior state-feedback oscillator, posterior lag and base
emphasis, odd body-frame target-to-curvature map, error-qualified far/middle
route observer, approach handoff, cadence schedule, closure/carrier reserve
gate, half-cycle steering, and reversal-preserving rate governor. Change only
the phase-consistency reference for the extra posterior work. During a deep
observed anterior carrier-energy deficit, include the full bounded
mean-curvature steering target so the posterior joint can bootstrap the useful
target-directed bend seen in the score leader. As carrier energy recovers
toward the existing reserve onset, continuously remove that steering component
from the phase reference, leaving the oscillatory lagged-wave target to decide
whether additional work is directionally consistent. The interpolation uses
the existing normalized carrier-energy gate, adds no gain, clock, stored
phase, coordinate, route, or task identity, and changes neither the base wave
nor the steering command.

Expected evidence is retention of the score leader's first-`3T`
`12.2146L/0.2519U` carrier benefit and mean distance near `1.9508L`, while
arrival, path, cross-track, and near alignment move toward the always-separated
rollout's `17.8585T/12.9783L/0.5621L/0.8096`. Falsify the mechanism if early
closure regresses toward the always-separated result, if score/mean distance
loses the sampled leader's gain, if route metrics do not improve, if capture
or reflection behavior fails, if actuator/load class increases, or if either
top-down or oblique wake coherence deteriorates.

bookshelf_consulted: true
source_domain: Lighthill posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: bootstrap a posteriorly emphasized target-directed bend during a measured carrier deficit, then separate recovered traveling-wave propulsion from slower mean-curvature steering
transferable_invariant: deficit recovery may temporarily coordinate propulsion with the full commanded bend, but once normalized oscillatory response returns, extra posterior work should be phase-consistent with the traveling wave rather than admitted by a steering offset
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: interpolate the posterior-work phase reference from the combined wave-plus-steering target at deep carrier deficit to the lagged wave target at the existing carrier-energy recovery boundary, using normalized joint angle-rate energy and the unchanged body-frame turn request
falsification: reject if first-3T closure or sampled-best mean distance is lost, route/arrival does not improve, actuator or load class worsens, reflection behavior fails, or either coherent visual wake view deteriorates

## Lightweight validation

- The dedicated check-runner was invoked as required, but its pinned model was
  unavailable to the current account and the checker process did not start. I
  therefore ran its three immutable non-CFD commands separately. The guidance
  check first exposed a duplicated assigned-parent marker in the rendered
  workspace `README.md`; removing only that duplicate left the parent choice
  unchanged, and the rerun passed the material-guidance check.
- Using the workspace's installed Julia binary, the policy loads, materializes
  its parameter tuple with `L=64.0`, and returns two finite accelerations for
  the check-runner state. The repository boundary check passes with
  `candidate_target_policy.jl` as the only editable solver difference.
- A focused drive-module check confirms that the new phase reference equals
  the full wave-plus-steering target at zero carrier energy, transitions
  strictly between its endpoints at partial recovery, equals the lagged wave
  target at the existing recovery boundary, remains finite under active work,
  and mirrors its two accelerations and phase reference when joint state and
  turn request are reflected. This is a contract/mechanism check, not CFD
  evidence; the rollout predictions above remain unvalidated until EvE runs.
