# Phase 2 candidate diagnosis and hypothesis

## Evidence diagnosis

- All three finite sampled rollouts report direct uniform still-water
  initialization with `U_infinity=[0,0,0]` and no prewarm snapshot. The
  combined sheets were inspected from release through termination in both the
  top-down vorticity and oblique body/Lambda2 rows.
- The transferred seed (`solver_c61359212990`) is self-propelled and sheds a
  coherent alternating wake. It closes from `12.33L` to `4.78L`, but its path
  continues below the target and exits the lower virtual boundary at
  `27.49T`. Raw acceleration exceeds the physical limit on `71.4%/78.4%` of
  joint samples and the two speed limits engage on `8.2%/10.3%`; a small
  steering residual therefore has little dependable authority over the
  clipped carrier.
- The geometry-gated mean-curvature redirect (`solver_cc8652ccb895`) is the
  strongest finite example. Its two visual rows show a long coherent wake and
  a materially different, target-directed trajectory: it reaches `1.135L` at
  `26.78T`, versus the seed's `4.78L`, and command-limit occupancy falls to
  `32.1%/26.0%`. This is evidence that reallocating the carrier toward a
  bounded large-error curvature is useful rather than merely dramatic.
- The remaining miss is terminal, not a lack of propulsion. At closest
  approach the redirect policy is still moving at about `0.643U`; its head is
  below the target, joint 1 is at `-0.775 rad` (near the `0.785 rad` limit),
  and the head acceleration is exactly the `30.54 rad/T^2` command cap. The
  top-down path and oblique history both show the upward recovery arc arriving
  after the target has passed behind; the fish then crosses the left boundary.
- The phase-demodulated redirect (`solver_6c3918c39ae8`) is an informative
  counterexample: its short wake accompanies a tight wrong-way rotation,
  only `0.21L` of closest progress, and upper-boundary exit at `8.48T`.
  Target-error sign or beat-side demodulation should not replace the sampled
  geometry-gated equilibrium redirect without new sign-calibration evidence.
- Local-flow magnitudes remain small in these quiescent examples (at most
  about `0.042U` longitudinal and `0.022U` lateral for the near miss), so the
  terminal failure does not justify a wake-phase or crossflow-rejection term.

## Candidate hypothesis

Start from the evidenced large-error redirect. Add one continuous terminal
approach-hold mechanism driven only by normalized distance and closing speed:
while the fish is near and still closing, reduce carrier cadence and add
bounded joint-rate damping, while leaving the target-relative curvature
equilibrium active. This should spend less of the final approach at the
acceleration/angle envelope and give the already-correct recovery turn enough
distance to cross the `0.75L` capture circle. Far from the target, while
receding, and after alignment, the existing posterior-lag carrier remains
unchanged.

Falsification: reject the approach hold if it loses the coherent traveling
wave before reaching `3L`, increases command/speed/angle saturation, stalls
outside the capture circle, or preserves the same below-target near-miss and
left-domain topology. A success, a minimum distance below `0.75L`, or a
materially slower and differently terminated near pass would support it.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish gait modulation and terminal target capture
source_mechanism: sensor-gated approach hold that relieves rhythmic propulsion while preserving bounded steering feedback
transferable_invariant: retain the posterior-lag carrier far away, then continuously reduce excess drive and damp joint motion only when normalized distance is small and measured closing remains positive
nontransferable_details: published CPG gains, species-specific kinematics, dimensional frequencies, exact vortex phases, and prescribed interception routes
policy_translation: a smooth gate from `distance_L` and `closing_speed_L` lowers the state-feedback oscillator cadence and adds bounded joint-rate damping; body-frame geometry continues to command the two-joint mean-curvature redirect
falsification: reject if far-field propulsion changes, approach stalls above `0.75L`, saturation or load spikes grow, or the same below-target pass and left-boundary exit recur
