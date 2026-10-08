# Multi-wake candidate diagnosis

## Evidence read before the edit

- The current sampled set contains three byte-identical replications of the
  strongest policy and one useful rate-only contrast. The replicated policy
  reaches the target after `137.357` released units with `4.184L` mean
  distance, `90228` total command energy, and `0.12955/14.75/303.02` RMS
  relative crossflow/force/moment. The rate-only contrast also captures, but
  takes `149.605` units with `4.358L` mean distance, `96933` energy, and
  `0.13206/15.49/308.48` crossflow/force/moment. This supports retaining the
  existing positive-closing-speed qualification of bearing-rate damping; it
  is a semantic response test rather than evidence for a scalar retune.
- The shared held-fish sheet shows the common initial condition: four
  developed, staggered vortex streets merge around and downstream of the
  target while the fish is held in the upper right. The replicated best
  released sheet shows active redirection down and upstream, alternating
  posterior-lagged bends, a broad jagged lower-midcourse excursion, correction
  back toward the wake centerline, and target entry from the right. Its
  `-10.914L` upstream displacement and mean streamwise body velocity `-0.0791`
  versus mean local flow `-0.0542` confirm self-propulsion rather than passive
  advection. There is no sampled termination-failure keyframe, so the assigned
  parent's latest slower finite capture is the most informative visual
  regression.
- In that inherited rollout, attenuating the direct moment residual when
  hydrodynamic torque appeared to dissipate yaw retained the alternating wave
  and eventual capture, but visibly lengthened the zigzag approach. Capture
  regressed to `205.519` units, mean distance to `6.209L`, total energy to
  `134893`, and RMS crossflow/force/moment to `0.13320/16.53/317.07`.
  Mean upstream speed fell from `-0.0791` to `-0.0531`. Thus moment-times-yaw
  sign is not a useful permission signal here; the sampled direct normalized
  moment residual, its sign, and its full authority should be restored.
- Earlier inherited negatives reach the same boundary by different routes:
  slow bearing-divergence gating, a shared route-plus-moment saturation,
  route-driven posterior asymmetry, a direct lateral-target residual, and an
  additive crossflow residual all preserve or lose useful parts of the gait
  while delaying capture. The replicated best already reaches
  `30.846 rad/time^2` anterior acceleration against the `31.416` limit, so the
  new candidate neither adds turn authority nor moves route control to the
  posterior joint.

## Policy hypothesis

Make exactly one feedback-topology change to the replicated `137.357`-unit
scaffold. Preserve instantaneous body-frame bearing as route owner, the direct
normalized moment residual, anterior joint-state half-cycle steering, and the
unmodified posterior traveling bend. Refine only the existing progress gate
on bearing-rate damping: positive radial closing speed is necessary but is not
sufficient evidence that an apparent aligning response is contracting the
broad redirect. Split the bounded bearing-rate response by sign. Preserve the
current divergence correction, but release turn authority for an aligning
bearing rate only in proportion to a bounded body-frame lateral-convergence
check derived from lateral target direction and windowed lateral-target rate.
Radial approach with a widening lateral excursion therefore keeps the full
bearing redirect without removing the existing response to bearing growth.

This is not a direct lateral-target turn residual and does not increase the
maximum half-cycle asymmetry. The formal expectation is preserved capture and
upstream alternating propulsion with a tighter lower-midcourse arc, earlier
arrival or lower mean distance, and no increase in energy, loads, or anterior
cap contact. Falsify it if capture is delayed beyond `137.357`, if the lower
excursion or zigzag widens, if the lateral response gate suppresses useful
bearing-rate damping during target approach, or if upstream progress,
alternation, distance, effort, and loads fail to improve together. The new CFD
result is produced only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and nonsteady fish redirect control
source_mechanism: retain rhythmic propulsion and release a strong redirect only after observed target-relative response confirms useful alignment and translation
transferable_invariant: persistent normalized body-frame route error remains authoritative until measured response contracts both radial distance and signed lateral target error
nontransferable_details: published gains, dimensional beat settings, species-specific redirect kinematics, robot linkage geometry, exact vortex phases, cylinder layout, and source-task routes
policy_translation: preserve the two-joint state-feedback half-cycle traveling bend, direct normalized yaw-moment residual, and bearing-divergence correction, then qualify only the aligning bearing-rate release by positive closing progress and bounded body-frame lateral-error convergence
falsification: reject if capture or upstream alternating propulsion is lost or delayed, the lower excursion widens, or mean distance, command effort, crossflow, force, moment, and actuator-cap contact fail to improve jointly against the replicated baseline
