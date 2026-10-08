# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is `solver_3ffc6d12db60`, the prefilled two-joint
  stopping-margin guard.  It captured at `0.749992L` and `27.770T` after
  direct-uniform still-water initialization.  Its top-down sheet shows the
  established alternating reverse-vortex street and the late downward turn
  into the target; the oblique Lambda2 row shows compact, repeatable
  three-dimensional structures without wake breakup or instability.
- The other three sampled solvers are not four independent replications:
  `solver_0ce6bb065e92`, `solver_0061f1229104`, and
  `solver_2f348c086ed4` byte-match the unguarded response-residual policy and
  its combined keyframe sheet.  That rollout captured at `0.749769L` and
  `27.605T`.  Its two visual rows show the same coherent carrier and useful
  route, but diagnostics record three posterior `45 deg` contacts, `11.8%`
  joint-speed-cap residence, `18.7%` acceleration-cap residence, and peak
  planar force/yaw moment `0.03397/0.01548`.
- The assigned parent's symmetric guard removed angle contact, reduced
  speed/acceleration-cap residence to `11.1%/16.8%`, and reduced peak planar
  force/yaw moment to `0.02212/0.01041`.  It also engaged on the anterior
  joint for 648 sampled states versus 257 posterior states, altered the route
  enough to delay capture by `0.165T`, and left only `0.000008L` crossing
  margin.  The scalar score improved only from `-0.710392` to `-0.709920`.
  Thus the safety benefit is evidenced, but guarding both functional channels
  is not yet a robust improvement.
- Inherited logs close scalar terminal-depth, damping, pulse, waveform, and
  instantaneous intercept-hold branches.  They support preserving the
  line-of-sight positive-deficit mechanism and changing allocation rather
  than increasing steering gain.

## Policy hypothesis written before the edit

Keep the evaluated carrier, redirect, terminal miss veto, and inertial
line-of-sight response residual exactly unchanged.  Replace the symmetric
two-joint stopping guard with the same bounded, outward-motion-only guard on
the posterior joint, which is the joint that actually contacted `45 deg` in
the unguarded success.  This preserves the anterior phase-selective steering
channel while retaining a direct test of posterior envelope protection.

Falsification: reject the allocation if the next CFD rollout loses capture,
restores any angle contact, raises speed/acceleration residence or loads toward
the unguarded values, breaks the coherent two-view wake, or fails to improve
the assigned parent's `0.000008L` capture margin without materially changing
the useful route.  One fixed-pose result will not establish held-out
robustness.

bookshelf_consulted: true
source_domain: Lighthill elongated-body theory and carangiform two-joint gait abstraction
source_mechanism: functional separation between anterior wave steering and posterior lagged thrust production
transferable_invariant: preserve the observed anterior steering channel when the evidenced envelope violation is posterior-specific
nontransferable_details: published gains, species envelopes, dimensional frequencies, exact tail phases, and routes
policy_translation: retain normalized body-frame target and response feedback; apply the existing stopping-margin brake only to outward posterior joint motion
falsification: reject if posterior protection no longer prevents contact, if capture is lost, or if wake coherence, propulsion, loads, or limit residence worsen
