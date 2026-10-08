# Body-translation-qualified posterior reserve

## Evidence and visual diagnosis before editing

- I reviewed the assigned parent guidance, all four sampled scores, policies,
  observations, metrics, diagnostics, trajectories, and combined keyframe
  sheets, plus the inherited optimizer notes that produced the sampled
  reserve variants. Every rollout uses direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, stable
  dynamics, and capture termination.
- I inspected both the release-to-capture top-down vorticity and oblique
  Lambda2 rows for all four samples. They self-propel from rest, establish the
  same coherent alternating mid-plane street, and retain compact
  three-dimensional posterior structures through capture. There is no
  passive advection, collision, wake breakup, out-of-plane instability, or
  termination failure. The strongest finite score and weakest sampled score
  are therefore the useful visual comparison: their wake topology remains
  alike, so route and joint-state evidence—not a new gait—must motivate the
  edit.
- The assigned closure-qualified parent is the fastest and most route-stable
  reserve variant. It captures at `17.6935T` with a `12.8750L` center path,
  `0.457L` maximum head cross-track, `0.881` mean approach alignment, and
  `0.637` final course alignment. The unqualified low-energy reserve has the
  best scalar score (`-0.07395`) and early distance, but captures at
  `17.9740T`, lengthens path to `13.0672L`, reaches `0.663L` cross-track, and
  ends at only `0.132` alignment with `-2.146 rad/T` yaw. Thus observed target
  progress successfully limits the reserve's persistent route perturbation.
- Qualifying the same reserve by posterior angle-rate energy is a concrete
  negative result. It regresses from the assigned parent's
  `-0.07556/17.6935T/12.8750L` score-arrival-path to
  `-0.07759/18.0015T/13.1271L`, increases cross-track from `0.457L` to
  `0.682L`, and lowers final alignment from `0.637` to `0.181`, without a
  distinct wake benefit or lower acceleration-ceiling class. Later workers
  should not stack another joint-energy deficit onto this reserve.
- The assigned parent calls its progress observation co-windowed, but the
  formal moving-window policy tuple exposes only single-step
  `closing_speed_L`; it does not expose `window_closing_speed_L`. On the
  parent trajectory this head-range derivative classifies receding motion in
  `13.2%` of samples through `3T`, whereas normalized target-projected center
  velocity does so in `7.5%`. Both have nearly the same mean early closure,
  but the center-translation measure omits the rotating head-offset component
  that can spuriously reopen posterior reserve during yaw.

## One policy hypothesis

Preserve the assigned parent's anterior phase-plane oscillator, posterior lag
and emphasis, odd mean-curvature map, error-qualified far/middle route
observer, approach handoff, half-cycle steering, cadence schedule, and
reversal-preserving rate governors. Change only the extra posterior reserve's
progress qualifier: project normalized body-center velocity onto the
normalized body-frame target vector and smoothly withdraw reserve as this
translation becomes useful. Keep the existing range-closure deficit for the
separate cadence scheduler. This is an observation-semantic correction and a
propulsion/route allocation mechanism, not a gain-only edit; it uses neither
coordinates, time, route memory, target identity, nor mutable state.

Expected evidence is the assigned parent's coherent two-view wake and capture,
with no worse early distance, score-mean distance, path, cross-track, approach
alignment, arrival, or actuator/load class. The cleaner progress qualifier
should avoid gait- and yaw-driven false reserve reopening. Falsify it if early
propulsion falls back to the no-reserve baseline, if capture or route quality
regresses, if reserve remains active during established target-directed
translation, or if saturation, force/moment scale, reflection behavior, or
either visual wake view worsens.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive propulsion and sensor-modulated robotic-fish state-feedback oscillators
source_mechanism: retain a posteriorly emphasized traveling bend only while measured locomotor state and task-level translation indicate a propulsion deficit
transferable_invariant: posterior recovery authority should release continuously when normalized body-frame translation becomes useful while route steering remains a separate feedback path
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, elapsed startup schedules, and task-specific routes
policy_translation: multiply the anterior phase-plane energy deficit by a bounded deficit of target-projected body-center velocity before scaling the lagged posterior target; leave the established steering and cadence paths unchanged
falsification: reject if early closure, capture, distance integral, route directness, terminal alignment, actuator/load class, reflection symmetry, or top-down and oblique wake coherence regress
