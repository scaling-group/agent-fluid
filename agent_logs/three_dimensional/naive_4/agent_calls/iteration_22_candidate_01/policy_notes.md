# Candidate diagnosis and hypothesis

## Prior evidence

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm snapshot, capture termination, `239`
  moving-window shifts, and capture on step `2919` at `16.054375T`.
- The combined sheets for the repeated assigned parent
  (`solver_31b486aa171c`) and the strongest sampled result
  (`solver_ecbe2be01c45`) show the same self-propelled, target-directed arc.
  In both top-down rows, a coherent alternating wake grows behind the fish and
  stays attached to a productive traveling bend; in both oblique rows, compact
  alternating Lambda2 structures persist without an out-of-plane instability.
  The sheets are visually indistinguishable because the tested feedback
  changes begin only inside the last `0.842L`.
- Two byte-identical parent copies finish at `0.746211886L`, distance integral
  `1.930147117L`, and score `-0.047280745`. A response-gated handoff of the
  high-authority redirect toward cruise curvature changes only the final 17
  states and improves these to `0.746069908L`, `1.930027864L`, and
  `-0.047133097`. An independent bounded terminal-yaw damping branch changes
  only the final 16 states and improves them further to `0.746050715L`,
  `1.930011784L`, and `-0.047113178`.
- Both positive variants preserve the pre-terminal route, arrival step,
  acceleration-limit residence (`49.195%/21.857%`), joint extrema, force and
  moment peaks, and the two-view wake. The damping variant also lowers mean
  absolute posterior acceleration from `24.597870` to `24.589733 rad/T^2`.
  These are narrow crossing-shape improvements, not new trajectory or held-out
  robustness evidence.

## One candidate

Use the sampled terminal-yaw damping branch together with the independently
positive redirect-to-cruise handoff. Both are driven by the existing normalized
body-frame closing/alignment response, alter only posterior mean curvature,
and leave the carrier, base steering sign, anterior corridor release, and wave
allocation unchanged. The hypothesis is that their small compatible reductions
of excess target-signed terminal curvature will add constructively: the current
route and capture step should remain unchanged while the final crossing and
distance integral improve. Reject the combination if it changes any milestone
through `1.25L`, delays or loses capture, disrupts either wake view, increases
hard-limit residence or load peaks, or produces a worse final/distance-integral
result. The post-exit CFD evaluation, not this note, decides that test.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture control
source_mechanism: modulate a rhythmic carrier with bounded sensor-feedback steering, then damp excess yaw or slip only on a verified closing approach
transferable_invariant: preserve the productive traveling-wave carrier while a normalized body-frame response gate hands excess terminal turning authority toward a lower-authority mode
nontransferable_details: published gains, dimensional beat settings, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: use closing proximity, predicted miss, bearing reopening, and target-signed normalized yaw to combine two bounded posterior mean-curvature reductions; retain the two-joint state-feedback oscillator and all far-field commands exactly
falsification: reject if pre-terminal milestones or wake coherence change, capture is delayed or lost, or crossing, effort, saturation, or load evidence regresses
