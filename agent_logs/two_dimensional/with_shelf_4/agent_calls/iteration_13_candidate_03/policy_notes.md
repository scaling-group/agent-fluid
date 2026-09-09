# Multi-wake candidate diagnosis

## Evidence read before the edit

- The four sampled solver results are deterministic replications of one
  successful controller trajectory: their released keyframe sheets are
  byte-identical, and every run reaches the target after `137.357` released
  units with `4.184L` mean distance, `90228` total command energy, and
  `0.12955/14.75/303.02` RMS relative crossflow/force/moment. The two policy
  hashes differ only in comments. This is one strong regression baseline under
  a common certified wake snapshot, not four independent robustness trials.
- The shared prewarm sheet shows the fish held in the upper-right while four
  developed, staggered cylinder streets merge around and downstream of the
  target. In the released sheet the fish actively redirects down and upstream,
  retains alternating posterior-lagged bends through a broad lower-midcourse
  excursion, corrects back toward the wake centerline, and enters the target
  from the right. Its `-10.914L` upstream head displacement and mean body
  streamwise velocity `-0.0791` versus mean local flow `-0.0542` confirm
  self-propulsion rather than passive advection. The jagged broad arc is the
  remaining visual opportunity; there is no sampled failure keyframe.
- The strongest sampled rollout already reaches `30.846 rad/time^2` anterior
  acceleration against the `31.416` cap. More unconditioned anterior turn or
  oscillator authority is unsupported.
- The inherited logs provide the informative negative comparisons. Gating the
  moment residual with slow growth of absolute bearing delays capture to
  `149.490`, deepens the lower excursion, and raises mean distance, energy, and
  RMS crossflow/force/moment to `4.428L`, `97418`, and
  `0.13148/16.38/318.46`. A later smooth route-plus-moment authority envelope
  is worse still: capture takes `223.746`, mean distance is `6.429L`, energy is
  `144686`, and RMS crossflow/force/moment are
  `0.13399/16.79/324.37`. Thus slow route divergence and route-saturation
  slope do not identify a helpful fast torque correction.
- The other inherited step-12 mechanism distributes route asymmetry into the
  posterior half-cycle. It retains capture and upstream displacement but
  delays arrival to `196.317`, with `5.718L` mean distance, `131294` energy,
  and `0.13498/15.48/310.21` RMS crossflow/force/moment. Posterior acceleration
  headroom was not evidence that route steering should be added to that
  actuator. Together, these results support preserving the sampled route,
  direct moment sign, anterior half-cycle steering, and unmodified posterior
  traveling wave.

## Policy hypothesis

Make one feedback-topology change to the replicated `137.357`-unit scaffold.
Keep the direct normalized yaw-moment residual at full authority whenever the
hydrodynamic torque is injecting energy into the observed body spin, or when
the power signature is neutral. When normalized moment and normalized heading
rate have opposite signs, the fluid torque is already dissipating yaw; smoothly
attenuate only that portion of the residual instead of spending anterior
half-cycle authority to reject helpful passive damping. Use bounded
`moment_z_L2` and body yaw-rate signals, and retain a nonzero residual floor so
this does not repeat the slow all-or-nothing bearing-divergence gate.

The expected formal test is preserved target capture and upstream alternating
propulsion, with a smoother lower-midcourse correction and jointly lower
arrival time or mean distance plus effort/load than the replicated baseline.
Falsify the mechanism if capture is delayed beyond `137.357`, the lower
excursion widens, upstream translation or the alternating wave is weakened,
anterior cap contact grows, or distance, energy, crossflow, force, and moment
do not improve together. CFD evaluation occurs only after this worker exits,
so these are expectations rather than claims about the new candidate.

bookshelf_consulted: true
source_domain: adaptive wake swimming and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful passive hydrodynamic response and reject a measured torque most strongly when it injects rather than removes yaw energy
transferable_invariant: the sign of normalized hydrodynamic yaw moment times normalized body yaw rate separates rotational energy injection from passive damping without assuming vortex phase
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: preserve body-frame target routing and the two-joint traveling bend, retain full direct moment residual for nonnegative yaw-power signature, and smoothly discount only the dissipative portion with a bounded nonzero floor
falsification: reject if capture, upstream translation, or alternating propulsion is lost or delayed, or if arrival, distance, command effort, crossflow, force, moment, and actuator-cap contact fail to improve jointly against the replicated baseline
