# Evidence-selected terminal course-continuity candidate

## Visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen contract: direct uniform
  still-water initialization (`U_infinity=[0,0,0]`), no cylinders, no prewarm,
  and moving L64 storage.  Three v35/v36 samples capture at `24.6730T` and
  `0.748684L`, with mean distance `2.348256L` and score `-0.448647`.  The v36
  course-sign veto is behaviorally inactive: its complete `4486`-row trajectory
  and combined keyframes are byte-identical to v35.
- Both rows of the strongest sampled v38 sheet and the replicated v35 sheet
  were inspected from release through capture, along with the inherited v37
  terminal-hold regression.  The top-down views begin wake-free and show
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and a bounded final hook into the capture disk.  Their oblique views
  retain compact alternating three-dimensional Lambda2 structures through the
  redirect.  The fish is not passively advected, the wake does not collapse,
  and there is no visible instability or out-of-plane escape.  No failed CFD
  sheet is present in the supplied artifacts; inherited audited failure metrics
  are therefore used only as numerical context, not as an invented visual
  comparison.
- The v38 terminal course-continuity sample preserves the same capture step and
  visually indistinguishable route, but improves terminal distance from
  `0.74868423L` to `0.74864119L`, mean distance from `2.34825575L` to
  `2.34822794L`, and score from `-0.44864657` to `-0.44861015`.  This is a
  replicated-policy comparison against three identical v35/v36 outcomes, but
  the magnitude is too small to claim a new trajectory or semantic class.
- Carrier relief is the informative negative.  The inherited two-joint v37
  terminal hold changed `292/4486` parent states and captured `0.011T` sooner,
  but worsened mean distance/score to `2.348972L/-0.449580`, narrowed the
  crossing margin to `0.000339L`, and raised lateral-force/yaw-moment peaks.
  Its posterior-only successor instead arrives later at `24.6840T` and also
  worsens terminal distance, mean distance, and score to
  `0.748847L/2.348385L/-0.448786`.  The coherent wake and established carrier
  are not the defect to perturb on this nominal route.

## Policy hypothesis

Use the positively evaluated v38 terminal course-continuity controller as this
workspace's single candidate.  Preserve the v35 anterior state-feedback phase
anchor, lagged posterior traveling wave, course-preview steering, steering
priority, posterior stroke braking reserve, posterior rate coast, and every
owned gain.  Change only the course-preview scheduling already completed in
v38: outside the owned `2.10L` approach neighborhood retain the original
body-axis passage release exactly; inside it, continuously bridge that release
toward the existing bounded velocity-course correction while range is still
closing.  This distinguishes inertial intercept completion from the target
passing the body axis without adding a clock, route, coordinate, new
acceleration source, or scalar retune.

Expected evidence is deterministic reproduction of the sampled v38 capture,
with no far-path command change, capture near `24.6730T`, mean distance no worse
than `2.348228L`, terminal distance no worse than `0.748642L`, the coherent
three-dimensional wake, zero posterior hard-stop occupancy, and the inherited
low-load class.  Falsify the mechanism if replication loses the small measured
advantage, alters any command at or beyond `2.10L`, changes the established
route, loses capture, or worsens hard-stop, exact-rate, raw-command, force, or
moment behavior.  Held-out poses or reflections must be used before treating
this terminal bridge as a broadly useful mechanism.

bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish coupled oscillators
source_mechanism: preserve a propulsive rhythm while target-relative velocity-course feedback remains active until the observed intercept is complete
transferable_invariant: body-axis passage is not route completion; retain bounded body-frame course correction only while range is near and measured closing remains positive
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, prescribed paths, exact vortex phases, Strouhal targets, motor models, and task-specific routes
policy_translation: preserve the evaluated two-joint carrier and safety layers, and bridge only the existing normalized velocity-course request across its body-axis release inside the owned approach neighborhood
falsification: reject if the far path changes, the sampled score and margin advantage do not replicate, capture or coherent wake is lost, or saturation and load classes regress

## Pre-evaluation validation

- The single candidate is byte-identical to the positively evaluated v38
  sample (LF SHA-256
  `af644f1ff4c30e6622c05ba38976d83edbd7c6454c8ded5c3cc89dc9e6f01887`).
  This is evidence selection, not a same-worker CFD claim.
- The prescribed public-contract state returns exactly two finite joint
  accelerations.  The deterministic schema audit resolves all `84` direct
  `params.FIELD` references among the `86` fields returned by
  `target_policy_params()`.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account; its exact three no-CFD commands were then run
  locally and separately, and all passed.  No formal CFD was run.
