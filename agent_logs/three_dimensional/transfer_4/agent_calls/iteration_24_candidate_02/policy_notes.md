# Terminal carrier-energy envelope

## Visual and quantitative diagnosis before editing

- I read the assigned guidance, all four sampled policies, scores,
  observations, metrics, diagnostics, and trajectories, plus the available
  inherited optimizer notes and completed evaluations. I inspected both the
  top-down vorticity and oblique Lambda2 rows for the assigned parent, a
  trajectory-identical sampled comparator, and the two inherited controller
  failures. Every rollout is contract-valid direct-uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, and no cylinders.
- All inspected policies capture by self-propulsion. Their top-down sheets show
  the same coherent alternating street advecting behind the fish, and their
  oblique sheets show compact three-dimensional posterior structures through
  target crossing. There is no passive advection, collision, boundary exit,
  wake breakup, or out-of-plane instability. The images therefore support
  preserving the traveling wave; route and terminal joint histories, not gross
  wake existence, discriminate the candidates.
- Three sampled comparators reproduce the phase-consistent trajectory at
  `18.0125T`, score/mean distance `-0.064599/1.950823L`, center path
  `13.2330L`, final course alignment `0.0678`, and final absolute yaw
  `1.0891 rad/T`. The assigned alignment-qualified posterior-wave envelope is
  the sampled leader: it preserves transit and both wake views, shortens
  path/cross-track to `13.2111L/0.7232L`, raises final alignment to `0.1818`,
  and lowers final absolute yaw to `0.4200 rad/T`, while capturing at
  `18.0235T` with score/mean distance `-0.064545/1.950801L`.
- The remaining approach is energetic rather than starved. Below `2.10L`, the
  leader averages `0.8866U` speed and `1.8883 rad/T` absolute yaw; its anterior
  oscillator energy averages `0.9851` of the nominal limit cycle, while
  anterior/posterior acceleration-ceiling residence remains
  `70.20%/72.47%`. The posterior envelope improved terminal motion without
  appreciably lowering the anterior carrier energy.
- Four course-derived steering follow-ups and two phase-selective steering
  follow-ups now fail to improve the leader despite preserving capture and the
  visible wake. Most recently, the inherited course-to-yaw-rate reference
  regressed score/mean distance to `-0.064995/1.951153L` and increased final
  absolute yaw to `0.570 rad/T`. Fading phase-dependent half-cycle steering
  toward symmetric mean bias regressed to `-0.065055/1.951211L`; it lowered
  final yaw slightly to `0.389 rad/T` but left mean near yaw essentially
  unchanged and did not improve the distance objective. This rules out another
  course/steering allocation edit as the next clean test.

## Single policy hypothesis

Start from the evaluated-best alignment-qualified posterior-wave envelope and
preserve its odd target-to-curvature map, anterior state-feedback carrier,
posterior lag/emphasis, phase-consistent reserve, route observer, mean and
half-cycle steering, symmetric posterior relief, and reversal-preserving rate
governor. Change only the anterior oscillator's energy regulation. Its current
phase-plane pump always targets unit carrier energy. Under the existing
normalized terminal approach/misalignment/yaw relief signal, continuously
lower that energy target toward a bounded floor; outside the `2.10L` approach
region the target remains exactly one, so the sampled transit actions are
unchanged. Mean steering is not attenuated, and the posterior target naturally
follows the measured lower-energy anterior wave while retaining the successful
posterior envelope.

This is a joint-state energy-envelope mechanism, not another steering gain or
cadence scalar. Because the pump changes sign when measured carrier energy is
above the terminal target, it adds dissipation to an energetic stroke and
restores pumping if the stroke becomes too weak. The expected evidence is the
same far/middle route and coherent two-view wake, preserved capture and mean
distance, lower near yaw and anterior acceleration/rate residence, and no
migration of pressure to the posterior joint. Falsify if any pre-approach
action changes, capture/score/path regresses materially, terminal energy and
yaw do not fall, saturation merely migrates, reflection fails, or either wake
view loses coherence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and staged terminal capture
source_mechanism: regulate rhythmic locomotor energy separately from slower direction bias, using observed terminal motion to reduce oscillatory drive while retaining closed-loop steering
transferable_invariant: when a coherent propulsive rhythm reaches the target with excess carrier-scale yaw, lower the oscillator energy target through state feedback rather than repeatedly changing the signed steering map
nontransferable_details: published oscillator gains, dimensional cadence, species-specific envelopes and kinematics, full-body CPG networks, exact vortex phases, world coordinates, capture radius, and task-specific routes
policy_translation: use the existing normalized body-frame approach, course-alignment, and measured-yaw gate to lower only the two-joint controller's anterior phase-plane energy target; preserve mean steering, posterior lag, and the evaluated posterior envelope
falsification: reject if pre-approach actions move, capture or sampled-best distance integral is lost, terminal carrier energy/yaw and actuator residence do not improve, pressure migrates to the posterior joint, reflection fails, or either coherent wake view deteriorates

## Lightweight validation after editing

- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable to this account. Running its immutable
  checks directly gives PASS for the material guidance update and repository
  boundary.
- The exact Julia include/action probe cannot run because this workspace has no
  Julia executable. The deterministic schema substitute finds all `63` direct
  `params.FIELD` references among the `65` fields returned by
  `target_policy_params`; the two unreferenced fields are metadata/adapter
  compatibility (`version` and `control_period`). There is one public params
  function, one public policy function, balanced delimiters, a nonempty
  candidate, and no time, step, random, cylinder-coordinate, file-I/O, or
  world-target route source.
- Replaying the new gate algebra on the sampled leader makes the carrier-energy
  target exactly `1.0` for all `2881` samples at or beyond `2.10L`. Across the
  `396` approach samples it has mean/minimum `0.8780/0.6872`, providing a
  bounded test without suppressing the oscillator. A reflected body-frame
  target/velocity/yaw probe preserves the scalar energy target exactly
  (`0.819933900` on both sides). These are contract and activation checks, not
  CFD evidence; EvE must evaluate the trajectory hypothesis after this worker
  exits.
