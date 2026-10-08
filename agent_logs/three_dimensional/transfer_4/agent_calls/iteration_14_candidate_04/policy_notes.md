# Steering-priority closure-qualified posterior reserve

## Evidence and visual diagnosis before editing

- I reviewed the assigned parent guidance, all four sampled scores, policies,
  observations, metrics, diagnostics, trajectories, and combined keyframe
  sheets, plus the inherited step-12 and step-13 optimizer notes. Every current
  sample uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and capture.
- I inspected the release-to-capture top-down vorticity and oblique Lambda2
  rows for the assigned parent, the score-leading anterior-energy reserve, the
  baseline, and the posterior-response-energy child. All self-propel from rest,
  build a coherent alternating mid-plane street, and retain compact
  three-dimensional posterior structures without passive advection, collision,
  wake breakup, or out-of-plane instability. The wake topology is visually
  near-identical, so route state and actuator histories, not wake existence,
  discriminate these mechanisms.
- The baseline captures at `17.7265T`, score/mean distance
  `-0.081395/1.967391L`, center path `12.8468L`, maximum head cross-track
  `0.5120L`, approach alignment `0.899`, and final alignment `0.601`. The
  unqualified anterior-energy reserve improves score/mean distance to
  `-0.073952/1.960279L` and early speed, but delays capture to `17.9740T`,
  lengthens path to `13.0672L`, raises cross-track to `0.6630L`, lowers
  approach/final alignment to `0.740/0.132`, and raises posterior
  acceleration-ceiling residence from about `64.8%` to `65.9%`.
- The assigned closure-qualified reserve retains nearly all of that distance
  benefit (`-0.075561/1.960960L`) while producing the strongest semantic route:
  earliest capture at `17.6935T`, `12.8750L` path, `0.4571L` maximum
  cross-track, `0.881/0.637` approach/final alignment, and `65.2%` posterior
  acceleration-ceiling residence. RMS planar force and moment remain in the
  same sampled class. This validates task-progress qualification of the
  transient reserve even though it does not win the scalar score alone.
- Adding a second posterior angle-rate energy qualifier does not predict route
  neutrality: it regresses to `18.0015T`, `-0.077585/1.963845L`, `13.1271L`
  path, `0.6824L` cross-track, and `0.714/0.181` approach/final alignment.
  The inherited hypothesis expected joint-response energy to release a
  harmful reserve, but the completed trajectory shows that task-level route
  state is the needed qualifier. The formal moving-window adapter also omits
  `window_closing_speed_L`; the assigned policy therefore uses its explicit
  single-step `closing_speed_L` fallback and must not be described as using a
  one-control-period progress window.

## One policy hypothesis

Preserve the assigned parent's error-qualified far/middle observer, ordinary
approach controller, odd mean-curvature plus beat-synchronous steering,
anterior phase-plane oscillator, posterior lag/emphasis, closure-qualified
energy reserve, cadence schedule, and reversal-preserving rate governor. Add
one bounded steering-priority allocation: multiply only the transient
posterior reserve authority by the complement of the already normalized turn
load. Large current route-curvature demand therefore gives steering priority;
as the body-frame target error and requested turn relax, the posterior reserve
recovers continuously. The mature carrier and both steering channels remain
unchanged. This is a state-dependent separation of redirect and propulsion
recovery, not a scalar-only gain change, clocked phase, coordinate route, or
new terminal intervention.

Expected evidence is retained early distance benefit, capture, and coherent
two-view wake, with path/cross-track/alignment and posterior ceiling residence
at least as good as the closure-qualified parent. Falsify the candidate if
early closure returns to the baseline, capture or score-mean distance regresses,
turn-demand gating delays propulsion without improving route state, load or
limit class worsens, reflection symmetry is lost, or either wake view loses
its coherent posteriorly lagged structure.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish rhythmic locomotion
source_mechanism: prioritize bounded curvature while heading error is large, then release continuously into posteriorly emphasized propulsion as the turn request relaxes
transferable_invariant: separate transient redirect authority from propulsion recovery using observed task error and joint state so added posterior drive does not compete with an active turn
nontransferable_details: C-start timing, species-specific bends, published gains and cadence, oscillator phases, dimensional thresholds, target coordinates, and task-specific routes
policy_translation: multiply the closure-qualified low-carrier-energy posterior reserve by one minus normalized body-frame turn demand while leaving the established two-joint carrier and steering accelerations unchanged
falsification: reject if early progress, capture, distance integral, route directness, alignment, actuator/load class, reflection behavior, or top-down and oblique wake coherence regress relative to the assigned closure-qualified parent
