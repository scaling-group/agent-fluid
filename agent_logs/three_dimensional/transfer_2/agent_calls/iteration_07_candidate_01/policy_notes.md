# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=[0,0,0]`, no capture, stable dynamics, and `left_domain`
  termination.  Motion in both rows of every combined keyframe sheet is
  therefore self-propulsion rather than imposed-flow advection.
- The top-down rows show a coherent alternating wake throughout the useful
  early diagonal approach.  The oblique Lambda2 rows likewise retain compact
  three-dimensional wake structures: none of the sampled policy differences
  caused a propulsion collapse or visible numerical instability.
- The strongest finite-score sample, the recapture carrier-unload child
  (`solver_b99a83cfb22d`, score `-8.4055`), preserves the approximately
  `3.024L` pass and reduces raw acceleration-envelope exposure to about
  `83.0%`, but still traces the parent's broad northward loop and exits at the
  upper boundary with `7.417L` final distance.  Persistent route-phase relief
  (`solver_016c2732900a`) is visually and metrically the same topology
  (`2.996L` minimum, `7.522L` final).
- The informative failure is the early sector pulse
  (`solver_99c121bdac44`, score `-9.5132`).  It materially improves the closest
  pass to `2.606L`; at that row the head is near `(9.589,6.962)L`, so the
  remaining miss is almost entirely lateral.  But its positive-closing-speed
  multiplier goes to zero at the first distance reversal.  The fish retains
  a coherent, strong westward runout, turns only shallowly, and exits at
  `(0.800,8.522)L` after `39.699T` with `8.714L` final distance and about
  `92.2%` raw acceleration-envelope exposure.
- The inherited posterior recapture proves that bounded mean-tail curvature
  has route-scale yaw authority, while its monotone behind gate proves that
  authority must not remain latched: it overshoots into the upper-boundary
  loop.  The sector-pulse child proves earlier onset is useful but that release
  exactly at zero closing speed is premature.  These two failures bracket a
  state-feedback release condition without requiring a new gain search.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological C-start/burst redirects and closed-loop robotic-fish curvature modulation
source_mechanism: apply bounded curvature for a large observed route error, then release the burst when observed geometry shows the redirect has progressed
transferable_invariant: separate a transient redirect from the propulsive rhythm and terminate it with state response rather than elapsed time
nontransferable_details: species-specific body envelopes, published gains and frequencies, exact burst duration, full-body kinematics, and task-specific routes
policy_translation: preserve the joint-state oscillator and sampled sector onset; use normalized body-frame forward/lateral target components to command signed posterior mean curvature across the first closest-pass reversal, then taper it to zero only through a finite deep-posterior band
falsification: reject if it recreates the upper-boundary loop, loses the sector child's closer pass, increases actuator exposure materially, or fails to create capture, a closer pass, or a useful second approach before domain exit

## One candidate hypothesis

Replace the sector pulse's positive-closing-speed multiplicative gate with a
pure body-frame geometry band-pass.  Entry and lateral deadband remain exactly
as sampled, so the release pose and centered approaches remain unchanged.
Unlike the failed pulse, signed curvature persists briefly after distance
starts increasing; unlike the failed recapture latch, it fades between the
sampled posterior thresholds and is zero when the target is deeply behind.
This is one architectural test of response-based burst release, not
scalar-only tuning.  The falsifiable expectation is preservation of the
`2.606L`-class approach plus enough post-passage yaw for capture or a useful
second approach, without the broad northward upper exit.
