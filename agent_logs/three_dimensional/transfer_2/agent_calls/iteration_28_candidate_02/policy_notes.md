# Load-aware redirect-priority carrier candidate

## Evidence read before editing

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, and capture. There is no semantic non-capture in
  this batch, so the lowest-scoring capture is the informative regression
  rather than an invented failure class.
- The combined sheets for the strongest finite sample
  `solver_3fdd63b3fbda` and weakest sample `solver_5fc33d6eb58b` were read from
  release to capture in both rows. Their top-down rows show self-propulsion
  from blank still water, a compact alternating wake, and continuous
  target-directed motion; their oblique rows show coherent three-dimensional
  Lambda2 structures shed behind the caudal region without wake collapse,
  collision, or passive advection. The strongest sample takes a visibly more
  aggressive sweeping arc and reaches the target sooner, while the weaker
  sample retains the same wake class but advances more slowly.
- Metrics make the new mechanism clear. Adding an unfulfilled body-frame
  course redirect to the common carrier allocation advances every
  `10/8/6/4/2/1L` milestone to
  `5.863/7.838/9.779/11.726/14.201/15.604T`, captures at `16.044T`, and lowers
  the distance integral to `1.82409L`. The predictive assigned parent captures
  at `17.418T/1.93044L`, while the dominant-joint governor captures at
  `17.990T/1.98918L`. Thus response-gated redirect priority is a semantic
  improvement, not a scalar-score fluctuation.
- That improvement exposes a physical boundary. The redirect-priority sample
  widens head path to `13.178L`, raises peak planar force/yaw moment to
  `0.03579/0.01770`, and spends `17.76/8.12%` of samples above 90% joint rate,
  versus the assigned parent's `12.528L`, `0.03001/0.01495`, and
  `15.03/0.73%`. Its load peaks occur at only about `0.36--0.62` of the joint
  rate envelope, so another rate-threshold formulation cannot see the event.
  The strong wake and zero angle-limit residence argue for preserving the gait
  and steering scaffold while testing hydrodynamic-load feedback separately.

## One-candidate policy hypothesis

Start from the evaluated redirect-priority carrier/steering decomposition.
Keep its target geometry, response release, common two-joint carrier scale,
and untouched steering residual. Add one bounded load-relief request from the
norm of normalized body-frame planar force and absolute yaw moment. Above the
sampled lower-load envelope, and only while the carrier is doing positive
joint work, smoothly withdraw both carrier accelerations by the same scale.
This makes high reactive load—not another joint-rate threshold—the observation
that requests relief, while preserving target-conditioned redirect authority
and anterior-to-posterior phase.

Expected signature: retain capture earlier than the assigned parent's
`17.418T` and the redirect sample's early milestone class while lowering its
`0.03579/0.01770` peak force/moment, `13.178L` path, and near-rate residence.
Falsify the mechanism if capture, the coherent two-view wake, or early progress
is lost; if timing/integral regress to the `17.418T/1.93044L` parent without a
material load/path benefit; or if peak load, joint-limit residence, command
effort, terminal slip/yaw, or path exceed the redirect-priority sample. In
that case retain the evaluated redirect-priority controller and do not tune
the load scales in isolation.

bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posterior-lag traveling bend while measured mechanical response modulates rhythmic carrier energy separately from directional control
transferable_invariant: withdraw positive rhythmic work with one bounded common scale when normalized hydrodynamic load is high, without distorting inter-joint phase or suppressing target-conditioned steering
nontransferable_details: published gains, species-specific load envelopes and kinematics, dimensional cadence, exact vortex phase, full-body waveforms, and task routes
policy_translation: combine normalized body-frame planar-force magnitude and absolute yaw moment into a smooth overload request; apply it only to positive carrier work and use the same scale for both joint carriers while retaining existing target, course, response, and steering residuals
falsification: reject if load and path do not improve relative to the redirect-priority sample, or if capture timing, distance integral, rate and angle margin, terminal yaw/slip, commands, or either coherent wake view regress beyond the sampled parent classes
