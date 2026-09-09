# Phase-compensated terminal-course candidate

## Evidence and visual diagnosis before editing

- All four sampled solver evaluations and the assigned parent's completed
  evaluation are valid direct-uniform still-water rollouts with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their combined sheets
  show body-connected alternating mid-plane vorticity and compact oblique
  Lambda2 structures. The fish are self-propelled; neither passive advection
  nor failure to form a wake explains the misses.
- The sampled prefill has the best scalar score (`-7.405`) but misses by
  `4.650L`. The three closer sampled policies reach `2.595--2.703L`, then curl
  toward the upper-left boundary with high joint-limit occupancy and peak
  normalized planar loads as large as `0.753/0.317`. Their visually dramatic
  terminal curls are therefore not useful interception mechanisms.
- The inherited course-residual trajectory is the useful baseline. A smooth
  target-bearing mean-curvature handoff reached `1.033L` with no dwell above
  `40 deg` and only `0.034/0.017` peak normalized force/moment. The assigned
  parent's closing-speed-gated damped hold retained those low loads and
  improved the minimum only to `1.008L`, then exited the lower boundary with
  `9.228L` final distance. At closest approach (`16.132T`) its head is
  `(9.756,8.834)L`, velocity is `(-0.737,-0.692)L/T`, and speed is
  `1.011L/T`: the target lies up-left while translation remains down-left.
  The hold therefore failed its semantic and termination falsifiers and did
  not materially shed terminal speed.
- The top-down and oblique rows retain an orderly propulsive street through
  the approach, then show the trajectory peeling sharply downward after the
  target. A stronger closing brake is not supported: an inherited common-mode
  curvature/braking trial regressed to `2.167L`. The remaining defect is that
  body bearing turns before translational course, while beat-correlated sway
  contaminates the instantaneous course signal used for terminal steering.
- A one-period analysis of the two inherited near-miss trajectories finds the
  same lateral carrier model from normalized joint rates. Subtracting
  `-0.90*phi_dot_1/omega + 0.47*phi_dot_2/omega` from body lateral velocity
  reduces beat-scale lateral residual RMS from `0.252--0.267` to
  `0.075--0.076 L/T` under cross-application of either fit. On the `1.033L`
  baseline this phase separation reduces terminal mean-turn sign reversals
  from five to one without changing the far-field controller.

## Single candidate hypothesis

Restore the low-load `1.033L` course-residual/terminal-mean controller and
replace the failed damped hold with one new mechanism: a phase-compensated
terminal course-to-curvature handoff. Outside the smooth `3L` terminal gate,
the evidenced traveling-bend carrier and raw target/course half-cycle steering
remain unchanged. Inside it, subtract the two-joint-rate carrier model from
body lateral velocity, form a bounded target-versus-corrected-course error,
and use that slow residual to set the shared mean bend. This gives accumulated
cross-track miss a persistent actuator channel before radial closing speed
collapses, without adding time, route state, stronger scalar braking, or a
second candidate.

Support requires capture or, more weakly, a closest pass below `1.008L` with a
target-side recovery or better termination while retaining the coherent
far-field wake, zero `40 deg` dwell, and low loads. Falsify if the corrected
course loses the inherited `1.033L` approach, repeats a lower/left escape
without a closer pass, creates joint-limit dwell or load growth, or merely
changes beat-phase action without making the terminal turn request more
persistent.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish capture
source_mechanism: separate rhythmic carrier motion from a slower target-directed mean-turn channel, then use observed approach state to hand authority between them
transferable_invariant: preserve the propulsive traveling wave while removing its repeatable phase component from terminal course feedback so persistent cross-track error, not beat sway, biases mean curvature
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized two-joint rates to predict body-frame lateral carrier velocity and feed the residual target-versus-course angle into the bounded shared terminal equilibrium
falsification: reject if capture, closest approach, termination, wake coherence, joint reserve, and normalized loads do not improve together over the 1.008--1.033L near-miss evidence

## Dry validation only

The mandated guidance-materiality, Julia policy-contract, parameter-schema,
and editable-boundary checks pass. A `202,500`-state grid spanning joint angles
through `45 deg`, joint rates through `260 deg/T`, fore/aft and lateral target
geometry, body velocity, and terminal/far distances produced finite actions
strictly inside the smooth `30 rad/T^2` envelope; exact left/right reflection
error was `0.0`, and nonfinite observation fallbacks remained finite. Against
the inherited `1.033L` terminal-mean controller, a separate probe grid gives a
maximum far-field action difference of only `2.79e-4 rad/T^2` at `6L` while
allowing a material terminal difference inside `1.5L`. These are algebraic
checks, not CFD evidence; downstream evaluation must decide the physical
falsifiers above.
