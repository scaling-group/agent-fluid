# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts satisfy the frozen initialization contract:
  direct uniform still water (`U_infinity=[0,0,0]`), no cylinders, and no
  prewarm snapshot. The three v21 examples are deterministic duplicates
  (score `-0.53064634`, capture at `25.2615 T`); v22 is the informative
  comparator (score `-0.53006032`, capture at `25.1130 T`).
- In both combined keyframe views, the fish is self-propelled rather than
  advected. The top-down row shows a coherent alternating wake through the
  broad target-directed turn and the final curved approach. The oblique
  Lambda2 row confirms a three-dimensional chain of shed structures rather
  than a planar rendering artifact. The wake remains organized as the fish
  enters the capture circle; there is no visible collision, domain-exit
  precursor, or loss of propulsion.
- The assigned-parent lesson records the necessary earlier contrast: the
  transferred seed reached only `4.780 L` with roughly `71.4%/78.4%` raw
  command-envelope incidence, while geometry-gated equilibrium redirection
  reduced incidence to `32.1%/26.0%` and reached `1.135 L`. An uncalibrated
  phase-demodulated redirect instead exited after reaching only `12.12 L`.
  Thus neither the carrier nor the geometry-gated redirect should be replaced.
- The sampled evaluated terminal reallocation converts that near-miss topology
  into capture. Relative to v21, v22's bounded closure preview reduces mean
  distance from `2.431797 L` to `2.430636 L`, advances capture by `0.1485 T`,
  removes terminal `|action|>30` incidence (`2.729%/0%` to `0%/0%`), reduces
  terminal posterior excursion from `0.7213` to `0.6620 rad`, and slightly
  lowers the terminal peak lateral-force/yaw-moment coefficients from
  `0.01593/0.00834` to `0.01548/0.00800`. Its final speed remains high
  (`0.6558 L/T`), so the evidence favors retaining propulsion rather than
  adding generic near-target braking.
- At v22 capture the joint state is `(-0.1092,-0.1983) rad` and the commands
  have fallen to `(0.0626,0.1659) rad/T^2`. Reconstructing the same
  target-relative redirect gives a requested mean bend close to the achieved
  joint state. The terminal PD hold has therefore settled while forward
  momentum remains useful; this creates a testable opportunity to restore
  some traveling-wave carrier around, not instead of, the captured curvature.

## Policy hypothesis

Use v22's closure-previewed range gate unchanged. Add one response-triggered
allocation mechanism inside the already gated terminal redirect: normalize
the maximum two-joint equilibrium tracking error by the declared carrier
amplitude, retain the full damped equilibrium while that error is large, and
smoothly recover a bounded fraction of the posterior-lag carrier once both
joints settle. Because the carrier is already centered on the same head bias
and tail-tangent equilibrium, recovery should add thrust without changing the
target-relative turn sign. The gate uses only current joint state, normalized
body-frame target geometry, range, and measured closure; it adds no time,
route, target identity, or world coordinate.

Falsification: reject the mechanism if capture is lost or delayed, the wake
loses its traveling structure, terminal joint-stop dwell or command clipping
returns, force/moment peaks rise materially, or the trajectory stops matching
v22 before the terminal gate becomes active. If the result is exactly v22,
inspect whether the tracking-error release remained dormant before changing
any scalar.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish CPG modulation
source_mechanism: release a strong bounded curvature response into a propulsive rhythm when observed state shows that the requested bend has formed
transferable_invariant: separate target-relative mean curvature from the traveling carrier, and switch their allocation continuously from observed response rather than elapsed time
nontransferable_details: species-specific C-start kinematics, published oscillator gains and phases, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: use normalized two-joint equilibrium tracking error to retain the v22 damped terminal hold while unsettled and recover only a bounded posterior-lag carrier around the same body-frame target curvature when settled
falsification: reject if recovery changes the pre-terminal path, loses capture, destroys wake coherence, or restores terminal saturation and load spikes
