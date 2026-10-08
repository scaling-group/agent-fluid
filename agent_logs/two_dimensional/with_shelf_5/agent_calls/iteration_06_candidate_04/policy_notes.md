# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheets are byte-identical and show the common held fish
  above and downstream of four developed, interacting vortex streets. They are
  initial-condition evidence rather than a policy difference.
- The inherited `left_domain` example supplies the informative failure. Its
  three released frames remain near the upper-right boundary and show no
  useful target-directed traverse; inherited metrics terminate after `16.791`
  with head displacement `(2.175,-0.869)L`, negative progress, and final
  distance `14.251L`. Together with the earlier target-blind lower exit and
  unstable yaw-damping result, this rules out more global drive, larger static
  curvature, or an uncalibrated derivative residual.
- The slow sampled success (`solver_9bde72287e13`) visibly makes a broad
  redirect/dogleg before approaching the target. It reaches after `93.0266`
  released time with mean distance `4.031L`, total command energy `9.046e4`,
  and RMS lateral force/moment `95.44/1146.05`.
- The posterior half-cycle samples (`solver_09b5b834b2ae` and
  `solver_a64551a56856`) instead establish a direct early diagonal, retain a
  coherent traveling body wake, and reach after `43.9505` time with mean
  distance `2.139L`, total command energy `5.308e4`, and RMS force/moment
  `49.44/701.26`. Mean body velocity `(-0.2471,-0.1020)` versus mean local flow
  `(-0.1342,-0.1556)` confirms substantial self-propelled upstream motion,
  rather than passive advection alone.
- The clean no-taper ablation (`solver_a520b6aa6665`) also reaches at exactly
  `43.9505` and has nearly identical distance, effort, flow, force, and moment
  metrics. The terminal amplitude taper is therefore causally unnecessary for
  the fast topology; target-favored posterior half-cycle curvature is the
  surviving mechanism. All fast samples still attain both joint-rate and
  acceleration caps, so lower integrated load comes from the shorter route,
  not demonstrated saturation relief.

## Policy hypothesis

Use the clean no-taper posterior half-cycle controller as the base. Preserve
its `0.55`-period, `28 deg` anterior state oscillator, bounded `8 deg`
body-frame bearing bias, posterior velocity lag, and already demonstrated
cycle-average posterior curvature. Add one bounded state-dependent mechanism:
while the normalized bearing request remains large, increase the contrast
between the target-favored and opposing posterior half-cycles by equal and
opposite amounts. A smooth error gate fades this zero-mean residual to exactly
zero as bearing closes, leaving the evaluated clean incumbent unchanged for
the aligned traverse and capture.

This tests whether a brief asymmetric redirect can shorten the remaining
initial arc without repeating the failed larger static bias. The candidate is
falsified if capture is lost or delayed relative to `43.9505`, the direct
diagonal becomes a broad dogleg or boundary exit, the alternating traveling
bend collapses, or force/moment and effort rise without better arrival or
distance integral. If the rollout is indistinguishable, later workers should
remove the error-gated contrast rather than tune its scalar magnitude.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric CPG turning and biological burst redirects
source_mechanism: increase target-favored half-cycle contrast only during a large observed direction error while retaining the propulsive rhythm
transferable_invariant: a transient state-gated steering asymmetry can sharpen a redirect without increasing cycle-average curvature, and should release continuously as body-frame target error closes
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, cylinder coordinates, and source-task routes
policy_translation: map body-frame bearing to a bounded turn request, infer the favored half-cycle from centered anterior joint state, and add equal-and-opposite parameter-owned posterior bias around the evaluated cycle mean only above a smooth error threshold
falsification: reject if the fast direct topology is delayed or lost, the carrier collapses, loads rise without better progress, or the added large-error contrast leaves trajectory and aggregate actions indistinguishable
