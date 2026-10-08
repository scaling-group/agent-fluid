# Hydrodynamic-moment residual candidate notes

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the Phase 2 flow contract:
  `uniform_direct` initialization, `U_infinity=(0,0,0)`, no prewarm, and no
  cylinders. All remain finite, but all terminate at the upper virtual
  boundary rather than capturing the target.
- The combined sheets were read in both rows. In every top-down row, the fish
  develops a self-generated alternating vorticity wake and translates left,
  then curls upward after crossing the target line. The matching oblique
  Lambda2 rows confirm coherent three-dimensional caudal structures rather
  than passive advection or a planar rendering artifact. There is no visual
  evidence that adding propulsion is the first missing capability.
- The prefilled posterior-only bearing-plus-trend mean-curvature controller is
  the strongest finite sample: it reaches `11.413L`, finishes at `11.421L`,
  and delays upper-boundary exit to `9.740T`. Its path nevertheless changes
  reconstructed body-frame bearing from `+0.155` at release to about `-0.61`
  at `7T` and `-1.25` at `9T`; heading continues large beat-scale reversals
  while the center rises to `y=15.200L`. Its posterior raw command exceeds the
  `31.416 rad/T^2` acceleration envelope in about `54.9%` of logged samples,
  and both joint rates touch the `260 deg/T` limit.
- The inherited half-cycle-asymmetry experiment bounded returned acceleration
  but regressed to `11.778/11.860L` minimum/final distance and exited earlier
  at `8.800T`. The two yaw-rate-feedback samples also preserve the same upper
  exit while reaching only `11.858L` and `12.091L`. Thus neither hard command
  bounding, posterior half-cycle scaling, nor short-window kinematic-rate
  feedback supplied a better cycle-averaged yaw response than the parent.
- Hydrodynamic yaw moment is a distinct evidenced signal. Across the four
  sampled traces its RMS scale is `0.0049--0.0056` in `moment_z_L2`, and its
  correlation with the concurrent measured yaw acceleration is `0.919--0.951`.
  Local crossflow is small (roughly `0.008U` RMS), so the moment is the more
  direct observation for rejecting the carrier's fast yaw disturbance in this
  still-water lane. The evaluated sign convention is also consistent:
  positive moment accelerates positive yaw, while positive posterior mean
  tangent produces the negative-yaw correction used by the best parent.

## Policy hypothesis

Keep the strongest sample's anterior Van der Pol carrier, posterior lag, and
bounded target-bearing mean curvature. Add one small, independently bounded
posterior residual proportional to a saturated normalized hydrodynamic yaw
moment. A positive measured moment adds positive posterior tangent and should
therefore oppose its positive yaw acceleration; reflection reverses both
signals and commands. Unlike the failed turn-rate loops, this feedback acts on
the measured forcing before integrating another large heading excursion. The
route and disturbance terms remain separate so the fast residual cannot erase
the persistent target request. Clamp the combined posterior target inside the
joint envelope and return both accelerations inside the fixed actuator
envelope.

Expected evidence is preservation of the parent's alternating wake and
leftward progress, smaller beat-scale heading reversals after the first target
line crossing, a closest approach below `11.413L`, and a later exit or better
termination class without greater joint-rate residence. Reject the residual
if it amplifies moment/yaw oscillations, suppresses the wake, retains the same
upper-exit topology without distance improvement, or merely trades raw-command
clipping for persistent joint-angle or joint-rate saturation.

bookshelf_consulted: true
source_domain: wake-interacting fish control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-direction steering from a small fast hydrodynamic-disturbance residual
transferable_invariant: persistent body-frame target error should set mean curvature while measured fast yaw forcing receives only enough opposite response to preserve target-directed propulsion
nontransferable_details: published gains, species-specific kinematics, clocked CPG phase, cylinder geometry, exact vortex phase, and task-specific routes
policy_translation: retain normalized bearing-to-posterior mean curvature and add an independently bounded normalized moment_z_L2 term with the evidence-calibrated opposing yaw sign
falsification: reject if yaw/moment oscillation or actuator-limit residence grows, coherent thrust weakens, or closest approach and upper-boundary survival do not improve over the 11.413L and 9.740T parent

The new candidate has no same-worker CFD result; the downstream evaluation is
the first valid test of this hypothesis.
