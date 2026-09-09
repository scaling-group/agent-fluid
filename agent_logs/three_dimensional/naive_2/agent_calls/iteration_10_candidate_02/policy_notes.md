# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=[0,0,0]`) and all terminate at a virtual boundary without
  capture. The combined top-down and oblique sheets show self-propulsion, not
  advection: a coherent alternating wake forms behind the caudal region and
  remains visible while each trajectory opens into a large turn.
- The prefilled course-responsive policy is the closest sampled rollout at
  `2.595L`, but its top-down sheet shows the fish passing above the target and
  curling toward the upper-left exit. The trajectory cross-check locates the
  closest pass at `17.46T`, with the head at `(8.86,12.09)L`, speed about
  `0.96L/T`, heading `1.59 rad`, and both joints pinned at `-45 deg`; both
  joints remain pinned through roughly `20T`. The visually forceful terminal
  curl is therefore an actuator-allocation failure, not useful capture.
- The phase-compensated sample reaches only `4.650L`, while the posterior-bend
  release reaches `3.312L`; both retain coherent wakes but still turn toward
  the upper boundary. The continuous hold sample reaches `2.703L` and then
  pins its posterior joint. Together these controls show that release gates,
  carrier relief, and carrier-relative half-cycle asymmetry change closest
  approach but not the left-exit trajectory class.
- Assigned-parent guidance identifies target-versus-course error as the best
  far/middle signal: its evidenced controller reached `1.173L` without
  `>40 deg` joint dwell or large normalized loads, but crossed below the target
  near `1.05L/T` and escaped lower-left. The inherited completed evaluation of
  the parent's proposed terminal handoff improves the minimum only to
  `1.033L`; it still exits left at `10.375L` final distance with score
  `-11.417`. Thus persistent terminal curvature alone did not close the last
  `0.283L` or change the termination class.

## Policy hypothesis recorded before editing

Preserve the evidenced traveling-bend carrier and course-residual steering in
the far and middle regimes. Inside a smooth body-frame `3L` terminal region,
fade out the failure-prone `signed_asymmetry * abs(carrier)` actuator and fade
in one common-mode mean-curvature PD acceleration, so steering controls slow
average bend while the carrier continues to control beat-scale differential
motion. When normalized closing speed is positive, smoothly reduce the
symmetric carrier further to give the curvature response time to turn the
near-miss into a `0.75L` crossing; do not brake on a receding trajectory, where
propulsion is needed for recovery. This is a feedback-structure change, not a
scalar retune.

Falsification: reject the candidate if it loses the inherited `1.033L`
approach, repeats a left-edge escape without a materially closer pass, pins
either joint near `45 deg`, destroys the alternating wake before the terminal
handoff, or raises normalized force/moment materially above the low-load
course-residual evidence. Capture is the semantic success criterion; a small
minimum-distance gain without capture is only evidence about terminal speed
allocation.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and fish terminal target capture
source_mechanism: separate a fast propulsive rhythm from bounded slow mean-curvature steering, then schedule drive during the terminal approach
transferable_invariant: persistent body-frame target error should bias mean bend independently of beat phase, while excessive positive closing speed should reduce propulsion long enough for the turn response to act
nontransferable_details: published gains, clocked CPG phase, species-specific body envelopes, dimensional tail-beat settings, exact vortex phases, and prescribed routes
policy_translation: use normalized target geometry, body velocity, closing speed, yaw response, and two-joint state to hand off continuously from course-responsive half-cycle steering to common-mode mean-curvature PD with closing-speed drive relief
falsification: no capture or closer pass, repeated left exit, joint-limit dwell, increased load peaks, or loss of the coherent traveling wake
