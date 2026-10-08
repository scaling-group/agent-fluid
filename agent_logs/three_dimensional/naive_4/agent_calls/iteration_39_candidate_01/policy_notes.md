# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the prefilled `solver_5346e761db5a` policy. Its
  rollout used direct uniform still-water initialization, formed a coherent
  alternating wake, captured at `15.697008T`, traversed `229` moving-window
  shifts, and had distance integral `1.919504L`, final distance `0.743649L`,
  and score `-0.036840`.
- Both the top-down vorticity row and oblique Lambda2 row show self-propelled
  motion rather than background advection: the wake grows from the initially
  quiescent field into a regular posterior vortex street while the target
  approaches the fish. The four sampled sheets retain the same coherent wake
  topology through capture; their useful differences are in closed-loop route
  response below the visual sampling resolution, not wake creation.
- `solver_1a8c73736b49` is the strongest finite sample. It differs from the
  assigned parent by keeping the existing moment-or-translation opposition
  correction available instead of vetoing it when carrier-demodulated body yaw
  becomes target-aiding. It advances every `8/6/4/2/1.25L` milestone, captures
  at `15.686007T`, uses `226` shifts, and improves distance integral to
  `1.916135L`, final distance to `0.743392L`, and score to `-0.033442`.
- This is not a saturation-only advantage. Relative to the assigned parent,
  the strong sample slightly lowers posterior acceleration-ceiling residence
  from `22.63%` to `22.34%` and posterior excursion from `34.58` to
  `34.17 deg`, while mean absolute posterior command rises from `25.136` to
  `25.199 rad/T^2` and peak trace yaw moment rises from `0.01923` to `0.02036`.
  The route improvement therefore survives a mixed load/effort tradeoff.
- The informative controls separate the signals. Reassigning target-line
  translation to terminal damping while allowing aiding-yaw handoff
  (`solver_a3ebfdcbb7c5`) delays every milestone and captures at `15.713508T`,
  distance integral `1.917987L`. Using aiding yaw to hand wave relief back to
  propulsion (`solver_502dfb1f0223`) also delays every milestone versus the
  strong sample and captures at `15.708008T`, integral `1.918172L`. Thus
  realized body yaw is not interchangeable with adverse translation of the
  target line.

## Policy hypothesis

Adopt the single evidenced structural difference from
`solver_1a8c73736b49`: preserve the established traveling-bend carrier, axial
force allocation, terminal shaping, and shared `2 deg` response-curvature
envelope, but remove the secondary carrier-demodulated aiding-yaw veto on the
moment/translation correction. The correction already has cause-aligned
release: it requires reliable raw redirect error and either opposing moment
residual or opposing normalized target-line translation. It therefore goes to
zero when those adverse response signals clear without treating beat-local
body yaw as proof that the route error has been corrected.

Expected result: retain the coherent two-view wake and capture while matching
the sampled improvement in all distance milestones, distance integral, and
window shifts. Falsify the candidate if it loses capture, changes the
far-field wake topology, delays any route milestone, increases distance
integral, or increases limiting/load without a route benefit. The present
rollout does not establish held-out robustness; target geometry or wake
disturbance that decouples line-of-sight translation from useful correction is
an explicit later falsification case.

bookshelf_consulted: true
source_domain: wake interaction and adaptive swimming
source_mechanism: bounded disturbance-response residual that avoids cancelling all lateral motion
transferable_invariant: separate carrier oscillation from persistent route response, and release a small correction when the same adverse body-frame response that opened it clears
nontransferable_details: Karman-vortex timing, cylinder layout, animal kinematics, exact wake phase, published gains, and source-task routes
policy_translation: retain the normalized moment-or-target-line opposition gate inside the existing posterior curvature envelope and remove the unrelated aiding-yaw veto; no gain, frequency, or route is copied
falsification: reject if capture, milestones, distance integral, coherent wake, joint envelope, or load envelope regresses, or if held-out geometry shows adverse target-line translation is not a reliable response signal
