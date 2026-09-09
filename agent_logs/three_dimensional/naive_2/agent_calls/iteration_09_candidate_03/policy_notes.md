# Terminal line-of-sight-rate candidate

## Evidence diagnosis before policy editing

- All sampled and inherited evaluations use the required direct uniform
  still-water initialization (`U_infinity=(0,0,0)`), without cylinders or a
  prewarm snapshot. The combined top-down vorticity and oblique body/Lambda2
  sheets were inspected from release to termination for the four sampled
  solvers and both assigned-parent rollouts.
- Both views show self-propulsion with a coherent alternating three-dimensional
  wake. The sampled policies retain useful targetward translation but cross the
  target station high, then curl toward a left-domain exit. The best sampled
  scalar score (`-7.405`) is also the worst sampled close pass (`4.650L`), so it
  is not a semantic improvement over the prefilled `2.664L` pass.
- The assigned parent's course-error controller is the strongest geometric
  evidence: it reached `1.276L` at `17.457T`, versus `2.664--4.650L` for the
  sampled set. Its trace passes below the target rather than repeating their
  high crossing, proving that rotation-invariant target/velocity course
  feedback materially changes the useful trajectory. It still exited left at
  `30.98T` and ended `10.936L` away, so the mechanism did not capture.
- The inherited follow-up's course-aligned whole-gait hold regressed to a
  `3.401L` pass and the same left-domain termination. Together with the sampled
  carrier-only holds (`2.703L` with joint pinning and `3.312L` after tail-bend
  release), this is negative evidence against another broad approach slowdown.
- At the course controller's first `2.0L` crossing, its geometric velocity-to-
  target course error was only about `-0.113 rad` and the inertial target-line
  rate about `-0.060 rad/T`. At closest approach the error had grown to about
  `-1.505 rad` and the line-of-sight rate to `-0.769 rad/T`; the anterior joint
  was at `0.780 rad` and the posterior rate at `-4.307 rad/T`, close to their
  physical limits. The visible late sweep is therefore an un-damped terminal
  interception error, not missing thrust or external crossflow. Peak local
  flow remained small relative to body speed in the direct-quiescent run.

## One candidate hypothesis

Restore the inherited `1.276L` course-error policy, including its evidenced
far-field carrier and ratio-preserving complete-command scaling. Add one new
terminal feedback mechanism: compute inertial line-of-sight angular rate from
the cross product of normalized body-frame target and velocity vectors, divide
by squared target distance with a bounded near-origin floor, and feed a smooth
proximity-gated residual into the existing shared-joint half-cycle actuator.

This signal is rotation invariant and does not require a world heading, clock,
route, or mutable history. It is negligible when the approach line is steady,
but it opposes the large late course request when the target line begins to
sweep rapidly across the fish. The policy should preserve the inherited
targetward leg and coherent wake, then turn less aggressively during the final
`3L` without coasting or changing carrier frequency.

Expected result: capture or a pass below `1.276L`, with no loss of far-field
translation and no worse joint-limit occupancy, force/moment peaks, or wake
coherence. Falsify the mechanism if it restores the sampled high-crossing
topology, repeats a left exit without a closer pass, or suppresses useful
translation before the terminal gate activates.

A dry replay of the new and inherited policies on the inherited recorded
states gives a mean action difference of only `0.00025` outside `4L`, but a
material terminal difference inside `3L`. At the recorded closest state, the
derived line-of-sight rate is `-0.768 rad/T` and the bounded residual is
`-0.501 rad`; the action changes from `(-18.859,-5.207)` to
`(-19.425,-5.760)`. This confirms signal scope and sign on fixed states only;
it is not CFD evidence and cannot establish trajectory improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and terminal capture
source_mechanism: sensor-modulated directional residual over a stable rhythmic gait
transferable_invariant: preserve the propulsive carrier while measured target-line rotation supplies bounded late interception damping
nontransferable_details: published gains, clock-driven phase, dimensional turn rates, species kinematics, exact vortex phases, and task-specific routes
policy_translation: derive a bounded line-of-sight-rate residual from normalized body-frame target and velocity cross products and apply it only near the target through the existing two-joint half-cycle actuator
falsification: reject unless it beats the inherited 1.276L pass or captures without degrading far-field translation, wake coherence, actuator reserve, loads, or termination class
