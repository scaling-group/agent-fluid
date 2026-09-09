# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no prewarm, and termination by capture rather than
  advection or domain exit. The assigned-parent logs also show that the lineage
  changed from a `3.191L` left-exit miss at step 13 to captures at steps 14--16,
  so preserving response-conditioned route closure has priority over another
  pursuit rewrite.
- In both rows of the combined sheets, the acceleration-feasible response-gated
  replicates (`efd2345fc503` and `d1d920e734e7`) self-propel along a smooth
  target-directed arc and leave a coherent alternating top-down wake plus
  discrete three-dimensional Lambda2 loops. There is no visible loss of the
  posterior traveling wave or out-of-plane instability before capture.
  Their byte-identical policies independently capture at `19.234T` and
  `19.283T`, with scores `-0.17657` and `-0.18218`; this establishes useful
  repeatability and also a small same-policy score/arrival spread that should
  not be mistaken for a gain result.
- The collision-course-gated comparison (`dca1b5640cb9`) also has a coherent
  wake and captures, but takes `19.784T` and scores `-0.20824`. Cross-checking
  the trajectory histories gives local-flow RMS `0.0184U`, close to the best
  replicate's `0.0180U`; this is a low-disturbance allocation problem, not a
  wake-rejection problem. Across the sampled histories the posterior command
  is at the physical acceleration limit for about `73--75%` of rows while the
  anterior route shift already closes the target corridor.

## Single policy hypothesis

Keep the evaluated normalized body-frame bearing/LOS-rate demand, the
response-conditioned anterior oscillator-center shift, explicit acceleration
feasibility, and the posterior phase-lagged traveling wave. Remove the separate
phase-conditioned yaw-error mean curvature from the posterior target. This is
an actuator-allocation change: slow route curvature is owned by the anterior
joint, while the posterior joint supplies the lagged propulsive wave rather
than duplicating the same turn request. It should preserve capture and coherent
wake topology while reducing posterior saturation or load. The new CFD result
is not available in this worker; reject this allocation if capture is lost, if
the arrival corridor materially regresses, or if posterior occupancy/load does
not fall.

bookshelf_consulted: true
source_domain: classical elongated-body swimming and closed-loop robotic-fish turning
source_mechanism: anterior steering with a posterior-emphasized lagged propulsive wave; bounded mean curvature for turning
transferable_invariant: separate slow route curvature from posterior traveling-wave thrust so an added static tail bend does not erode the propulsive wave
nontransferable_details: published gains, species envelopes, dimensional beat rates, multi-link CPG layouts, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and LOS-rate feedback in the anterior oscillator center; make the posterior target only the centered anterior counter-bend plus joint-state phase lag
falsification: reject if capture or coherent alternating wake is lost, or if posterior acceleration occupancy and load fail to decrease relative to the sampled response-gated captures
