# Approach-gated target-bearing phase demodulation

## Visual and metric diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm, finite dynamics, and
  `capture`. Three are byte-identical evaluations of the prefilled one-sided
  speed guard, capturing at `0.745621L` and `16.609995T` with score
  `-0.115560`. The distinct lateral-phase observer is the strongest sampled
  result at `0.743958L`, `16.604496T`, and score `-0.113729`.
- I inspected both rows of the combined keyframe sheets for the distinct best
  result and the prefilled control. Both top-down rows show self-propelled
  targetward translation with an alternating signed vortex street, and both
  oblique rows retain finite tail-connected three-dimensional structures
  through capture. Their paths remain visibly wavy near the target. No true
  failure sheet exists in the assigned samples or inherited logs, so the
  prefilled capture is the informative controlled negative rather than a
  fabricated failure comparison; inherited guidance supplies only summarized
  earlier misses, including the `2.169L` upper-exit precursor.
- The diagnostics agree with a narrow trajectory improvement, not a broad
  robustness claim. Relative to the prefill, the lateral-phase observer lowers
  scored distance integral from `1.999656L` to `1.998146L` and arrives one
  logged step earlier. It also raises peak planar force/moment from about
  `0.03583/0.01776` to `0.03716/0.01836`, acceleration-near-limit residence
  from `73.91%` to `74.10%`, and speed-near-limit residence from `27.42%` to
  `27.59%`. Preserve the semantic residual observer, but do not treat its
  small score gain as permission to add carrier strength or curvature.
- The remaining phase contamination is in route geometry itself. A
  zero-intercept fit on the completed best trace inside `6L` gives
  `bearing = -0.9256*q1_carrier - 0.0230*q1_dot + residual`, explaining
  `96.46%` of raw bearing variance with residual RMS `0.0698 rad`. Inside
  `3L`, the fit remains `-0.9354/-0.0200`, explains `96.62%`, and has
  `0.0706 rad` residual RMS. Thus the posterior controller still interprets
  the carrier's own beat-relative orientation as alternating target error,
  consistent with the wavy sheet and high command residence.

## Single policy hypothesis

Start from the evaluated lateral-phase observer and preserve its full carrier,
raw-course anterior center, yaw and lateral response demodulators, posterior
half-cycle structure, speed guard, and evaluated gains. Add one approach-gated
bearing-phase observer after `q1_carrier` is available. Subtract the fitted
centered-joint bearing component from raw body-frame bearing, then use only the
residual bearing and its residual-defined centerline window in the posterior
route, course-brake, yaw-request, and phase-selection path. Keep raw bearing in
the anterior center calculation, and make the new subtraction zero outside the
existing `6.5L` approach boundary, so the demonstrated far route is unchanged.

Expected result: posterior steering should stop chasing beat-synchronous
apparent bearing, retain capture and the connected wake, and reduce approach
waviness or command/load residence without weakening propulsion. Falsify the
mechanism if capture is lost or delayed, the far route changes, the alternating
or tail-connected wake degrades, residual bearing remains carrier-correlated,
or distance integral, joint contact, saturation, force, or moment exceeds the
best sampled envelope.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and residual path-following control
source_mechanism: separate the fast rhythmic locomotor response from the slow body-frame target-direction request before applying bounded steering
transferable_invariant: internally generated beat-relative orientation should not be treated as persistent target-bearing error
nontransferable_details: published gains, species or robot kinematics, dimensional beat timing, prescribed routes, maneuver duration, and exact vortex phase
policy_translation: estimate approach bearing induced by centered anterior joint angle and velocity, subtract it from measured body-frame bearing, and use the residual only in posterior route and response feedback while preserving the raw anterior carrier path
falsification: reject if nominal capture, arrival, distance integral, far-route topology, connected wake, carrier correlation, joint history, saturation, force, or moment worsens

## Evaluation boundary

The favorable lateral-observer evidence belongs to the completed sampled
solver; no CFD outcome is claimed for this child. Later evaluation should
compare capture and arrival first, then distance integral, target-relative
trajectory, raw-versus-residual bearing phase correlation, posterior command
residence, joint limits, force/moment peaks, and both wake views against
`solver_0f91f918d286`. Fixed-pose repetitions do not establish changed-pose or
changed-flow robustness.
