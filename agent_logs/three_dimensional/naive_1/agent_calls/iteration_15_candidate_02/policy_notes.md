# Wake-policy candidate notes

## Evidence diagnosis before the edit

- The assigned parent guidance and inherited score logs establish a narrow
  capture-class carrier: target-signed differential curvature, displacement-
  only half-cycle steering, one-sided correcting-yaw release, posterior lag,
  and final acceleration projection. Removing response release or predicting
  phase from joint velocity caused coherent-wake downward `left_domain`
  failures, while direct velocity residuals and pointwise rate barriers were
  also negative. Those mechanisms are held fixed here.
- All four sampled rollouts are valid direct-uniform still-water evaluations
  (`U_infinity=[0,0,0]`) and capture. The two geometry-only files are
  executable duplicates apart from comments; they capture at `18.6505T` and
  `18.6835T` with score-metric mean distances `2.09340L` and `2.09405L`.
  Coupling the envelope schedule to the existing yaw response captures at
  `18.6615T`, `2.09362L`, inside that repeat band, so that extra coupling has
  no evidenced benefit. The range/velocity terminal compound is weaker at
  `19.0520T`, `2.09874L` and has a visibly deeper vertical excursion.
- In every combined keyframe sheet the top-down row develops an alternating,
  target-directed vortex street and the oblique row retains compact caudal
  Lambda2 structures from release through capture. The fish therefore
  self-propels; it is not advected by initialization or moving-window shifts.
  The weaker terminal compound changes route without a corresponding wake
  improvement, so this candidate does not add range or velocity feedback.
- Geometry-only reconstructed actuator statistics remain about `11%/15%`
  joint-rate contact and `61%/73%` acceleration contact. These nearly match
  all other sampled captures. The proposed edit is therefore a route/arrival
  experiment, not a demand-relief claim, and the exact final acceleration
  projection remains unchanged.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological rapid-turn transitions and sensor-modulated robotic-fish CPG turning
source_mechanism: response-gated transition from asymmetric redirect curvature to a posterior-emphasized propulsive beat
transferable_invariant: persistent body-frame target geometry owns turn sign, while observed correcting yaw continuously releases redirect asymmetry and the posterior propulsor may return toward cruise sooner than the anterior steering joint
nontransferable_details: species-specific C-start timing and curvature, published CPG gains, dimensional tail-beat settings, full-body waveforms, and any exact vortex phase or task route
policy_translation: retain target-signed anterior and posterior curvature, but give each a bounded response gate; correcting recent yaw releases posterior mean bias more strongly while leaving the geometry-only envelope, displacement phase, posterior lag, and acceleration projection intact
falsification: reject if capture is lost, either wake row loses coherence, arrival/mean distance does not improve beyond the geometry-only repeat band, the trajectory leaves its compact route family, or demand/load histories worsen materially

## Candidate hypothesis

The current common response gate preserves capture but releases the `4 deg`
anterior and `10 deg` posterior mean-curvature shares in a fixed ratio. Once
recent yaw is correcting the target-side error, retaining that large posterior
mean bend can keep the caudal beat in redirect mode even though the anterior
joint still supplies route authority. The candidate adds one independently
owned posterior response-release fraction. It equals the existing gate when
yaw is not correcting, cannot invert either curvature share, and releases the
posterior mean bias more strongly only during an observed correct-sign
response. The expected result is the same coherent wake and capture topology
with earlier return to a symmetric caudal beat and a meaningfully earlier or
lower-integral approach. CFD evidence is deferred to the downstream evaluator.
