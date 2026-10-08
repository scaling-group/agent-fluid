# Posterior-coast terminal collision-cone candidate

## Evidence diagnosis before the policy edit

- The sampled evidence contains three byte-identical course-preview captures
  and one posterior-coast capture. All use direct uniform still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. The course-preview
  replicates capture at `24.5795T`, minimum/final distance `0.746968L`, and
  mean distance `2.36044L`; they are replication of one policy, not three
  independent mechanisms.
- Both rows of the combined keyframe sheets were inspected for the sampled
  course-preview capture, sampled posterior-coast capture, and inherited soft
  dual-joint-barrier failure. The capture sheets show self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and compact
  three-dimensional Lambda2 structures that persist through the broad
  target-directed redirect and crossing. The failed barrier also remains
  self-propelled and wake-coherent, but misses outside the circle, curls away,
  and exits above at `36.7510T`; this is a controller/trajectory failure, not
  passive advection, wake breakup, or instability.
- The inherited v32 posterior braking reserve is the actuator baseline to
  preserve: it captures at `24.6290T`, eliminates sampled posterior hard-stop
  occupancy, and limits peak absolute body-frame planar force/yaw-moment
  coefficients to about `0.0241/0.0303/0.0149`. Two dual-joint barriers then
  reduced exact rate occupancy to `0.236%` and `0%` but lost capture at
  `0.933L` and `0.848L`, establishing that active braking of the anterior
  phase anchor is not a safe feasibility projection.
- The sampled posterior-only, non-braking coast guard is a positive
  role-separated result. It preserves capture and zero posterior hard-stop
  occupancy, keeps peak planar force/yaw-moment coefficients in the low class
  at `0.0244/0.0337/0.0162`, and reduces exact rate-limit occupancy from the
  v32 `15.163%` to `13.869%`, with posterior occupancy falling from `5.806%`
  to `4.586%`. Its mean distance improves from `2.36096L` for the inherited
  terminal-cone/v32 trace to `2.35222L`, but capture is delayed to `25.0635T`
  and occurs at the fragile edge `0.749973L`.
- The independently completed terminal collision-cone residual is a small
  compatible terminal mechanism. On v32 it is exactly dormant beyond `1.60L`
  and captures on the same `24.6290T` step while improving final distance from
  `0.748702L` to `0.747850L` and mean distance from `2.36161L` to `2.36096L`.
  It therefore supports testing terminal course persistence on top of the
  successful posterior coast guard without reopening the falsified anterior
  rate-barrier branch.

## Policy hypothesis

Start from the sampled v34 posterior-coast controller without changing its
course preview, cadence, two-joint traveling-wave targets, steering-priority
allocation, posterior stroke reserve, or rate guard. Add the independently
completed terminal collision-cone residual to the existing intercept request.
Use body-frame range times the normalized velocity-target cross product as a
signed miss estimate; activate only inside `1.60L` and outside the evidenced
capture corridor, ignore the noisy instantaneous closing sign, and admit the
residual only through unused signed steering headroom.

This is one terminal feedback mechanism layered onto the validated actuator
controller. It is structurally dormant on the far route. Expected evidence is
preserved self-propelled coherent wake and far trajectory, capture with a
stronger crossing margin than `0.749973L`, zero posterior hard-stop occupancy,
posterior/total exact rate occupancy no worse than `4.586/13.869%`, and peak
planar loads remaining near the v34 low class. Falsify it if capture is lost,
the crossing margin does not improve, any command changes beyond `1.60L`, the
posterior hard stop returns, the rate benefit is materially lost, or the
course residual creates a post-pass loop or load spike.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal target capture
source_mechanism: preserve a phase-lagged propulsive rhythm while a bounded sensory residual maintains correction for an observed terminal course miss
transferable_invariant: keep the demonstrated anterior phase anchor and posterior follower intact while near-target body-frame velocity predicts that the current course will miss
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body envelopes, exact vortex phase, capture radius, and task-specific routes
policy_translation: add a mirror-equivariant near-only velocity-target collision-cone request through unused two-joint steering headroom after preserving the posterior stroke and coast guards
falsification: reject if far commands change, capture or coherent wake is lost, the crossing margin fails to improve, posterior hard-stop protection or rate relief regresses, or loads leave the inherited low class

## Pre-evaluation validation

- All `89` direct `params.FIELD` references resolve among the `91` fields
  returned by `target_policy_params()`, and the prescribed public-contract
  state returns two finite accelerations.
- A `504`-state grid spanning terminal and far range, target side, lateral
  course, closing sign, both joint positions, and sub-band/near-band joint
  rates returns finite commands. Every tested state beyond `1.60L` is
  bit-for-bit equal to the sampled v34 posterior-coast policy.
- Focused terminal probes confirm that the new residual is active for a
  predicted miss, reverses sign with mirrored body-frame lateral observations,
  and is exactly zero beyond its owned terminal range. Direct rate probes
  confirm that the posterior guard coasts at either signed rate boundary and
  passes every velocity-reducing command unchanged.
- The reusable-guidance semantic check, Julia public-contract/schema checks,
  focused mechanism checks, and solver editable-boundary audit pass. The
  configured check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this ChatGPT account; its three declared no-CFD commands
  passed when run directly. No formal CFD was run.
