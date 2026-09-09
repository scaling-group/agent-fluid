# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting cylinder streets. This wake and release pose are a
  common initial condition, not a candidate-specific advantage.
- All four sampled solver rollouts reach the target. Their released sheets show
  the same useful topology: an immediate targetward redirect, a coherent
  posterior traveling wave during a sustained leftward traverse, and direct
  entry into the `0.75L` circle. Head displacement near `-10.92L` in x despite
  mean local x flow near `-0.20U` corroborates active upstream propulsion rather
  than passive advection. No sampled failure sheet exists, so inherited failures
  are used only as textual boundaries: predictive bearing in persistent route
  steering exited after `18.304` with negative progress, and replacing the
  carrier wholesale became unstable with force/moment RMS `16749.8/290421`.
- The prefilled independent per-joint speed release reaches in `34.8590`, with
  `1.62681L` mean distance, `47176.8` total command energy, `0.24086` RMS
  relative crossflow, and `74.24/1105.81` force/moment RMS. Its keyframe route
  is visually indistinguishable at five-frame resolution from the stronger
  samples, so the finite metrics decide this comparison.
- Three independently sampled copies of the common max-joint-speed release
  reproduce exactly: `34.7105` arrival, `1.62283L` mean distance, `46985.9`
  total command energy, `0.24023` RMS relative crossflow, and
  `68.96/1036.40` force/moment RMS. One shared release therefore dominates
  independent release on every listed metric except mean command energy
  (`1353.65` versus `1353.36`) while retaining capture.
- The inherited child that added previous-command pressure to the common speed
  release also retains capture and the visible route, but regresses arrival to
  `35.1285`, mean distance to `1.64127L`, total energy to `47457.0`, crossflow
  to `0.24265`, and force/moment RMS to `71.47/1078.27`. Both joint speeds and
  both `30.0` acceleration limits remain touched. Command-envelope occupancy
  is therefore not an evidenced earlier release cue in this mechanism.

## Policy hypothesis

Promote the replicated common max-joint-speed release as the single candidate
change. Pressure at either joint is treated as pressure on the coupled traveling
bend, so one bounded signal withdraws the same share of only the optional
response burst from both joints. Preserve the state-feedback carrier, posterior
lag, raw-bearing mean steering and reserve, course-slip correction, signed
assisting-moment credit, and base half-cycle asymmetry. Do not carry forward the
regressive previous-command-pressure gate.

Expected evidence is target reach on the same compact upstream route with
arrival, distance, total effort, crossflow, and load close to the three exact
common-release samples. Falsify the candidate if capture is lost or the sampled
joint advantage fails to reproduce. Even a successful replication remains
bounded to the shared prewarm; a changed wake phase or layout is needed before
claiming robustness.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and organized-wake adaptive swimming
source_mechanism: modulate optional asymmetric turning feedback coherently around a coupled rhythmic propulsive carrier
transferable_invariant: preserve the traveling-wave carrier and persistent route controller while one normalized whole-carrier response signal releases only surplus maneuver authority across the coupled joints
nontransferable_details: published gains, clocked phase, robot or species kinematics, exact vortex phase, dimensional frequencies, cylinder coordinates, and task-specific routes
policy_translation: normalize the maximum observed two-joint speed by the endogenous carrier scale and use it to attenuate one shared response-gated half-cycle asymmetry while retaining normalized body-frame bearing, course, and signed moment feedback
falsification: reject if target reach or coherent upstream propulsion is lost, if the replicated arrival-distance-effort-load advantage does not recur, or if a changed-wake test shows coherent release damages capture
