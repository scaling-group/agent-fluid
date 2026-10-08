# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=[0,0,0]`; all terminate in capture without instability.  The
  two repeated phase-even posterior-turn-shape evaluations are byte-identical
  outcomes at `17.6440 T`, score `-0.07419`, and total/observed distance
  integrals `1.95985/1.34371 L`.
- The contraction-release parent is the strongest sampled scalar and integral
  result: capture at `17.5340 T`, score `-0.06405`, and integrals
  `1.94972/1.33372 L`.  Its readable combined sheet shows self-propelled
  target-directed motion, a smooth arc, and a coherent alternating wake in
  both the top-down vorticity and oblique Lambda2 rows.  The phase-even
  comparator has the same organized top-down street, but its oblique row is
  black after frame 000, so it cannot support a comparative 3D-wake claim.
- Release on correct-sign de-gaited yaw captures earlier at `17.5065 T` and is
  closer at `14/16 T` (`3.5050/1.9112 L` versus `3.5230/1.9391 L`), but the
  contraction-release parent is closer at `8/10/12 T`
  (`8.6889/6.9540/5.1913 L` versus `8.7061/6.9873/5.2170 L`) and has the
  better total and observed integrals.  Response release also raises mean/max
  speed from `0.7235/0.9731` to `0.7258/0.9815 L/T` while leaving the peak
  normalized force scale at `0.03225` and changing peak moment only from
  `0.01609` to `0.01625`; any-joint acceleration-limit residence falls from
  `43.22%` to `42.70%`.
- The top-level `logs/optimize/` had no prior note, but the assigned-parent
  artifact contains the inherited step 27-31 optimizer logs.  Those logs show
  that response-retained approach cadence and divergence-retained approach
  steering captured only one solver step sooner than the v43 base while
  worsening total integral, and that four approach-local alternatives changed
  observed integral by less than `0.000062 L`.  They then isolate posterior
  wave-shape steering and bearing-contraction release without changing the
  coherent carrier or base route.  Together with the sampled v47 crossover,
  this rules out reopening carrier cadence or route authority and supports
  arbitrating only the supplementary posterior curvature.

## Policy hypothesis

Keep the contraction-release parent unchanged outside its posterior turn-shape
gate.  Use normalized distance to arbitrate between the two independently
useful release observations: far from the target, release the supplementary
posterior curvature only when de-gaited bearing contracts inside the existing
centerline window; once normalized distance crosses `4.0 L`, transition
continuously to release on correct-sign de-gaited yaw response.  The `4.0 L`
handoff is owned by `target_policy_params` and comes from the completed
checkpoint crossover between `12 T` (about `5.2 L`) and `14 T` (about
`3.5 L`), not from a bookshelf gain.  This is a convex far/near mode blend,
not a product of success gates.  Base route steering, the target-signed
redirect, carrier, launch response, and actuator projection stay active
throughout.

Expected result: retain the contraction parent's `8-12 T` distance lead and
integral while recovering the response-gated sibling's `14-16 T` lead and
earlier capture, without a new wake topology or a material increase beyond the
sampled `0.9815 L/T`, `0.03225`, `0.01625`, and `43.22%` speed/load/saturation
envelope.  Reject the mechanism if it loses capture, worsens either middle or
terminal closure, produces oscillatory switching, reverses the target-signed
arc, degrades the two-view wake, or exceeds that envelope.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish gait modulation, with terminal-capture regime separation
source_mechanism: release a bounded redirect after observed turning response, and treat near capture separately from far route correction
transferable_invariant: preserve the propulsive rhythm and base steering while supplementary curvature yields continuously to an observed correct response in the regime where that response is useful
nontransferable_details: published gains, dimensional cadence, species-specific body envelopes, exact vortex phase, full-body CPG state, and task-specific routes
policy_translation: blend two bounded sign-consistent release confidences using normalized body-frame distance; use bearing contraction far away and correct-sign de-gaited yaw near the target, affecting only the target-signed posterior turn-shape residual
falsification: reject if the early integral lead or terminal lead disappears, capture or coherent propulsion is lost, switching becomes beat-sensitive, or speed, saturation, force, or moment materially exceeds the sampled successful envelope
