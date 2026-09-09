# Candidate wake-policy notes

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite moving-window
  shifts, stable dynamics, and `capture` termination. They capture in
  `19.706--20.207T` with score `-0.2160--(-0.2309)`, so there is no semantic
  failure in the current batch.
- The combined sheet for the strongest finite sample shows self-propulsion,
  not advection. Its top-down row develops a coherent alternating mid-plane
  wake from release through a smooth left/down target approach; its oblique
  row retains compact three-dimensional Lambda2 structures through the
  terminal arc. The trajectory agrees: distance falls from `12.328L` to
  `6.426L` at `12T`, `3.615L` at `16T`, and capture at `0.747L` and
  `19.706T`, with finite `0.779U` terminal speed.
- The informative inherited full-angle half-cycle failure uses the same valid
  initialization and also has an alternating top-down wake and organized
  oblique caudal structures. Its sheet instead shows a late broad curl away
  from the target. Metrics confirm that it bottoms out at `2.127L` near
  `21.406T`, then exits at `39.407T` with `11.643L` remaining. It averages
  absolute joint commands `(24.07,23.38) rad/T^2`, spends about
  `(51.5%,51.8%)` of rows above 90% of the smooth command bound, and places
  the posterior joint above 90% of its angle limit for `3.34%` of rows.
  Coherent wake production and large action alone therefore do not make a
  capture controller.
- The current redirect family removes that topology without raising the
  `31 rad/T^2` command envelope: all sampled variants capture, use zero
  residence above 90% of the joint-angle limit, and keep peak planar force and
  yaw-moment coefficients near `0.025` and `0.013`. Their mean absolute
  commands are about `17--19 rad/T^2`, with roughly `32--37%` residence above
  90% of the smooth command bound. The durable semantic mechanism is the
  full-vector velocity-course redirect with approach headroom, not another
  route gain.
- The two line-of-sight-lead replicas capture at `19.706T` and `20.036T`; the
  phase-shaped course redirect captures at `20.207T`, and its middle-field
  sibling at `20.124T`. The visual paths are nearly identical before the
  terminal arc, while the inherited logs show that adding joint-state
  half-cycle allocation to the unmodulated redirect improved the earlier
  `20.971T` arrival without changing the force/moment class. The remaining
  testable gap is that the current half-cycle factor shapes route steering but
  leaves the posterior course/line-of-sight redirect curvature unshaped.

## One-candidate hypothesis

Preserve the evaluated traveling-bend carrier, posterior lag, full signed
body-frame target geometry, distance/closing drive relief, velocity-course
error, line-of-sight lead, and smooth command bounds. Extend the existing
joint-state half-cycle allocation to the posterior redirect-curvature term.
Use the bounded composite of route and active redirect requests to select the
useful half-cycle, then strengthen or relax both posterior steering
contributions with the same existing asymmetry factor. Keep the anterior
redirect bias as the slow mean C-bend so the edit does not add a new actuator
channel or erase the proven carrier.

Expected signature: preserve capture and both coherent visual wake rows, begin
or complete the terminal arc at least as promptly as the sampled redirect
family, and lower arrival time or distance integral without materially
exceeding its command/load histories. Falsify the mechanism if capture is
lost; arrival regresses beyond the sampled `19.7--20.2T` band; the trajectory
returns to a `2L`-class miss and outward curl; or command residence, joint
limits, force, moment, or wake coherence worsen.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical fish turning
source_mechanism: target-conditioned half-cycle amplitude asymmetry superposed on a posterior-lagged propulsive rhythm
transferable_invariant: concentrate bounded steering on the observed joint half-cycle already producing the requested turn while retaining the opposite half-cycle and the traveling wave
nontransferable_details: published gains, duty ratios, clock phase, species-specific amplitudes and body envelopes, exact vortex phases, dimensional cadence, and task-specific routes
policy_translation: form a bounded phase request from normalized body-frame route and active course/line-of-sight redirect commands, infer beat side from anterior joint velocity normalized by oscillator angle-speed scale, and apply the existing asymmetry only to aligned posterior route and redirect curvature within the two-joint state-feedback contract
falsification: reject if capture timing or distance integral regresses, the terminal arc oscillates or curls away, coherent propulsion is lost, or command, joint, force, and moment limits worsen
