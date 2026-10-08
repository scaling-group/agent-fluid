# Terminal carrier-energy envelope

## Visual and quantitative diagnosis before editing

- I read the workspace and assigned-parent guidance, all four sampled solver
  scores, observations, metrics, diagnostics, trajectories, and policies, and
  the inherited v19--v22 optimizer notes and completed results. Every inspected
  rollout uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
- I inspected the top-down vorticity and oblique Lambda2 rows for the sampled
  v12 repeat, v16 terminal-envelope result, v20 scalar leader, inherited v19
  allocation result, and inherited v22 gait-demodulation result. All visibly
  self-propel from rest, retain a coherent alternating planar street and compact
  three-dimensional posterior structures through capture, and show no passive
  advection, wake breakup, boundary interaction, or out-of-plane instability.
  The useful distinction is terminal motion and actuation, not wake existence.
- The sampled v16 policy is the strongest established joint score/terminal
  comparator: it captures at `18.0235T`, scores `-0.064545`, has mean distance
  `1.950801L`, center path `13.2111L`, and finishes at `0.1818` course alignment,
  `0.8511U` speed, and `0.4200 rad/T` absolute yaw. The inherited v19 conserved
  forward mean-bend allocation keeps capture and slightly improves path,
  alignment, yaw, and both joints' terminal limit residence, but regresses mean
  distance/score to `1.950985L/-0.064778`.
- The completed v20 yaw-power selector is an informative semantic failure even
  though it is the scalar leader. It improves arrival/mean distance/score to
  `18.0070T/1.950358L/-0.064028`, but final alignment falls to `0.1092`, speed
  rises to `0.8820U`, absolute yaw rises to `0.9840 rad/T`, and both acceleration
  commands are at the ceiling at capture. Instantaneous signed hydrodynamic
  power is therefore too gait-phase-sensitive to select terminal relief.
- The inherited v22 attempt to subtract a fitted carrier-phase yaw estimate from
  terminal rate feedback is also negative. It preserves capture and shortens
  path to `13.1847L`, but worsens mean distance/score to
  `1.951273L/-0.065191`; final alignment is only `0.1287`, speed remains
  `0.8638U`, and absolute yaw is `1.0486 rad/T`. A high fitted phase `R^2` did
  not make that residual a useful closed-loop course observable. This rules out
  another raw-yaw, yaw-power, fitted-yaw-residual, or course-gain variant here.

## Single policy hypothesis

Start from evaluated v19, preserving the odd body-frame target-to-curvature map,
state-feedback anterior carrier, posterior lag/emphasis and phase-consistent
work reserve, far/middle route controller, v16 posterior approach envelope,
curvature-conserving anterior allocation, half-cycle steering, and
reversal-preserving rate governor.

Add one terminal oscillator-energy mechanism rather than another steering
request: form a bounded authority from normalized approach proximity, measured
course misalignment, and speed, and lower the anterior carrier's desired
phase-plane energy only under that authority. Apply velocity-opposing damping
only to energy above the scheduled envelope. The mechanism is exactly inactive
outside `2.10L`, at rest, and on an aligned course; it never changes the mean
bend or posterior target directly. Because distance, speed, alignment, and
phase-plane energy are reflection invariant while joint rate changes sign, the
damping remains equivariant under lateral reflection.

Expected evidence is unchanged far/middle trajectory and two-view wake, retained
capture, less terminal anterior carrier energy and acceleration-ceiling
residence, and lower speed/yaw with alignment improving rather than merely
selecting a fortunate capture phase. Falsify if capture or mean distance
regresses materially, approach time grows without a terminal benefit, limit
residence migrates posteriorly, the same high-speed misaligned capture remains,
or either coherent wake view deteriorates.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal capture
source_mechanism: continuously modulate a rhythmic oscillator's energy envelope from observed task state while preserving the underlying traveling-wave coordination
transferable_invariant: when fast carrier motion dominates a noisy body-rate signal, reduce excess oscillator energy directly in a qualified terminal regime instead of feeding the phase-dominated rate back as another steering error
nontransferable_details: published CPG gains, dimensional cadence, species-specific amplitude envelopes, exact vortex phase, full-body kinematics, world coordinates, capture radius, and task-specific routes
policy_translation: use normalized body-frame distance, target-course alignment, speed, and anterior joint phase-plane energy to add terminal-only velocity-opposing energy bleed while retaining the evaluated two-joint lagged wave and conserved odd mean bend
falsification: reject if pre-approach behavior changes, capture or distance integral worsens materially, terminal speed/yaw/alignment and limit residence do not improve together, reflection fails, or either wake view loses coherence

## Lightweight validation after editing

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported by this account. I ran its immutable commands directly. The
  guidance check initially found the assigned parent duplicated verbatim in
  the rendered workspace `README.md`; removing only the duplicate marker left
  the selected parent unchanged. The rerun passes, as does the solver boundary
  check with `candidate_target_policy.jl` as the sole solver difference.
- Julia is not installed or discoverable, so the executable include/action
  probe cannot run. The deterministic static guard passes: all `65` unique
  direct `params.FIELD` references resolve among the `67` fields returned by
  `target_policy_params`; both public functions occur exactly once, the
  candidate is nonempty, delimiters balance, and no clock, step, random source,
  file I/O, cylinder coordinate, or world-route input appears.
- Replaying the new body-frame gate on the completed v19 trajectory gives zero
  energy authority for every sample at or beyond `2.10L`. Below approach its
  mean/maximum authority is `0.2690/0.7069`; at the sampled capture state the
  scheduled normalized carrier-energy target is `0.5069`. The bleed is zero
  below that target and opposes only measured anterior joint velocity above it.
  Simultaneous lateral reflection leaves distance, speed, course alignment,
  gate, and energy unchanged while flipping joint velocity and the bleed.
  These are contract and activation checks, not CFD evidence; EvE must test the
  capture, terminal state, loads, and both wake views after this worker exits.
