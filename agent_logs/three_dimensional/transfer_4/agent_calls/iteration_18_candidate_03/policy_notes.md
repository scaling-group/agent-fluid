# Consensus-vetoed phase-consistent posterior-work candidate

## Visual and quantitative diagnosis before editing

- I read the assigned parent guidance, the four sampled policies and rollout
  artifacts, and the inherited optimizer notes before proposing an edit. All
  four sampled episodes are stable captures from direct uniform still water
  with `U_infinity=(0,0,0)`, no prewarm, and no cylinders. The two
  `-0.064599` samples have identical policy hashes and diagnostics, so they are
  deterministic evidence for one mechanism rather than independent mechanisms.
- In every combined sheet, the release-to-capture top-down vorticity row shows
  self-propulsion from rest and a coherent alternating wake by `4T`; the
  oblique Lambda2 row shows compact paired posterior structures persisting
  through approach. There is no passive advection, wake breakup, collision, or
  out-of-plane instability. The sheets are visually very similar, so route,
  distance, terminal motion, and actuation diagnostics must distinguish them.
  No current sampled solver is a semantic failure; the consensus-qualified
  reserve is the most informative relative negative because its better route
  did not improve integrated score-distance.
- The assigned closure-qualified posterior-work parent captures at `17.8695T`
  with score/mean distance `-0.072146/1.958037L`, center path `13.0071L`,
  maximum head cross-track `0.6102L`, and final course alignment/yaw
  `-0.0027/-3.068 rad/T`. Its coherent wake and useful early closure coexist
  with a course-displacing posterior-work imprint.
- Adding the sampled one-sided tracking-work guard improves score/mean distance
  to `-0.064599/1.950823L` and lowers final yaw magnitude to `1.089 rad/T`,
  while preserving the two-view wake and capture. It does not straighten the
  route: capture slows to `18.0125T` and path/cross-track grow to
  `13.2330L/0.7417L`; acceleration-ceiling residence remains
  `69.47/66.05%`. Thus phase consistency is established for integrated
  closure, not for route control or desaturation.
- The consensus-qualified wave-target reserve is a complementary control. It
  captures sooner at `17.7870T` on a shorter `12.9495L` path with `0.5193L`
  cross-track and `0.8366` mean approach alignment, but its score/mean distance
  `-0.073937/1.959602L` do not beat the assigned parent. Inherited evidence
  also shows why center translation must not replace range feedback: a
  translation-qualified direct-work policy missed capture at `0.9166L` and
  exited at `28.2752T` with score `-11.5034` despite a coherent wake.

## One policy hypothesis

Start from the evaluated phase-consistent posterior-work policy and preserve
its anterior phase-plane oscillator, lagged posterior target, odd mean
curvature and half-cycle steering, far/middle route observer, approach handoff,
cadence schedule, range/carrier reserve gates, one-sided tracking-work guard,
and reversal-preserving rate governor. Add one normalized, body-frame semantic
check: project measured center velocity onto the current head-to-target vector,
convert it to the same bounded no-progress authority as head-range closure,
and use the minimum of both authorities for the extra posterior work. This is
a veto only: either observation of useful closure withdraws recovery, while
neither center translation nor the shelf adds positive steering or propulsion
authority.

Expected evidence is retention of stable capture, the coherent posteriorly
lagged wake, and the phase guard's integrated distance benefit, with path,
cross-track, arrival, or approach alignment moving toward the consensus-gated
sample. Falsify the combination if capture or early closure is lost, mean
distance regresses to or beyond the assigned parent, the already-long phase
guard route worsens materially, translation and range signs disagree
persistently, actuator/load class worsens, reflection behavior fails, or
either visual wake view deteriorates. The new CFD result is not available to
this worker and is not claimed as evidence.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: apply extra posterior oscillatory work only while measured locomotor feedback identifies a deficit, without using that recovery path for route steering
transferable_invariant: posterior recovery demand should release when either of two normalized progress observations detects useful target-directed translation, while measured phase inconsistency independently vetoes work that enlarges posterior tracking error
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, target coordinates, elapsed schedules, and task-specific routes
policy_translation: retain the evaluated one-sided posterior tracking-work guard and multiply its range-qualified reserve by a conservative body-frame target-projected translation-deficit veto
falsification: reject if capture or integrated closure regresses, route geometry does not improve, progress signs disagree systematically, reserve persists during useful translation, loads worsen, reflection behavior fails, or the top-down or oblique wake loses coherence
