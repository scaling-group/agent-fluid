# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets, with the target inside their
  merged second-row wake. It is the common initial condition for every
  candidate rather than evidence for a controller difference.
- Three sampled fixed-half-cycle policies reproduce the same target capture at
  `36.4705`, mean distance `1.6860L`, total/mean command energy
  `48700/1335.3`, and RMS force/moment `63.59/953.42`. Their sheets show a
  sharp targetward redirect followed by active, nearly straight upstream
  propulsion; the coherent posterior wake, mean velocity `x=-0.2978`, and
  head displacement `x=-10.914L` rule out passive advection as the transport
  mechanism.
- The assigned parent adds bearing-response-scheduled half-cycle burst and
  preserves that visible route while improving capture time to `34.8205`,
  mean distance to `1.6270L`, total energy to `47151`, and mean upstream
  velocity to `-0.3118`. The gain is not load-neutral: mean command energy
  rises to `1354.1`, RMS force/moment to `77.09/1142.74`, and both joints
  still touch the speed and `30.0` acceleration limits. The parent therefore
  validates feedback-triggered burst as an arrival/route mechanism, not as a
  load-reduction mechanism.
- A sampled joint-speed-gated asymmetry child supplies a negative response
  boundary. It still captures, but arrival regresses to `37.262`, mean
  distance to `1.7186L`, and RMS force/moment increase to `69.02/1065.10`
  versus the fixed-half-cycle baseline, while mean effort changes by only
  `-1.97`. Joint velocity is therefore not an evidenced proxy for hydrodynamic
  load relief in this lineage.
- No sampled released failure sheet is available. The inherited informative
  failure exited right after `18.304` with negative progress and head motion
  `(+2.392,-2.047)L`; its low effort and load do not compensate for losing
  upstream propulsion. Mean bearing steering, the joint-state carrier, and
  raw-bearing reserve must remain active.

## Candidate policy hypothesis

Preserve the assigned parent's carrier, course-response residual, raw-bearing
reserve, base half-cycle asymmetry, and bearing-response burst. Add one
physical feedback role: smoothly release only the *extra* response burst as
the magnitude of observed yaw moment grows relative to a candidate-owned
body-normalized scale. This uses `abs(moment_z_L2)` so it does not guess the
unevidenced sign or lag of a fast wake disturbance. Mean target steering and
the propulsive traveling bend remain untouched even at high load.

Expected test: retain capture and the coherent redirect/upstream traverse,
with arrival between the parent's `34.8205` and the fixed-asymmetry baseline's
`36.4705`, while moving force or moment materially below `77.09/1142.74` and
avoiding a disproportionate mean-effort increase. Reject the mechanism if
capture or upstream propulsion is lost, arrival exceeds `36.4705`, load does
not improve, or the magnitude gate merely substitutes switching for the
parent's bounded burst. The candidate is evaluated only after this worker
exits, so no same-worker improvement is claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and adaptive wake-interaction control
source_mechanism: preserve persistent direction authority while feedback releases an optional asymmetric burst when measured physical response is already large
transferable_invariant: a rhythmic propulsive carrier and mean body-frame route request should remain active while only additional redirect authority is relieved by bounded measured load
nontransferable_details: published gains, robot actuator ratings, species kinematics, dimensional moments, clocked phases, exact vortex phases, and source-task routes
policy_translation: attenuate only the parent's extra bearing-response half-cycle asymmetry with absolute body-normalized `moment_z_L2`; retain base asymmetry, mean steering, raw-bearing reserve, and both joint-state carriers
falsification: reject if target capture or coherent leftward propulsion is lost, arrival exceeds the fixed-asymmetry baseline, or force/moment fail to improve on the parent without a compensating route benefit
