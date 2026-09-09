# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the same held pose and fully developed,
  interacting four-cylinder streets used by every sampled rollout. Released
  trajectory differences are therefore controller evidence, not a changed
  initial wake.
- The current distributed acceleration-level half-cycle policy is the strongest
  propulsion sample: it swims `-9.73L` upstream, survives `91.24` release-time
  units, and reaches `4.62L`, but its keyframes show a long downward arc below
  the target followed by lower-domain exit. Its `314/3430` force/moment RMS and
  `0.73` rad anterior bend confirm that the useful upstream wave does not by
  itself bound steering load.
- The inherited heading-response variant materially improves target approach:
  its sheet enters the useful central wake and passes within `1.65L`, while its
  mean distance improves from `9.14L` to `8.72L`. It nevertheless folds into a
  near-vertical downward dive after the close pass, exits sooner at `75.09`,
  gives back upstream displacement (`-8.32L`), and raises force/moment RMS to
  `487/4680`. Thus instantaneous heading lookahead is useful target-response
  evidence but is not a load or overshoot brake.
- The posterior-only asymmetry sample preserves the same lower-exit topology
  with only `-4.56L` upstream travel and `8.20L` closest approach. The opposite
  mean-curvature equilibrium sample is an informative hard failure: it becomes
  unstable after `9.37` with relative-crossflow RMS `1.21` and force/moment RMS
  `23111/397906`. Neither moving steering back to the tail nor recentering the
  oscillator is supported.

## Candidate hypothesis

Retain the inherited heading-response distributed half-cycle controller because
it produced the best sampled target approach. Add one new mechanism: smoothly
attenuate only its steering asymmetry as the magnitude of normalized observed
yaw moment rises, with a nonzero steering floor. This sign-independent load
gate needs no unevidenced moment convention, cannot cancel the symmetric
traveling bend, and should prevent strong wake/body yaw events from amplifying
the persistent downward turn. The next CFD rollout falsifies the hypothesis if
the controller loses the `4.62L` closest-approach and strong upstream-motion
baselines, retains the lower-exit topology without materially reducing load, or
merely shifts the same saturation into the symmetric gait.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve rhythmic propulsion while bounding steering modulation during large observed hydrodynamic yaw loads
transferable_invariant: use slow body-frame target error for route steering and let normalized load magnitude reduce only the steering residual during strong disturbances rather than cancelling all lateral motion
nontransferable_details: published gains, species-specific kinematics, robotic CPG topology, dimensional load scales, exact vortex phases, and task-specific routes
policy_translation: keep the two-joint zero-centered traveling bend and response-damped distributed half-cycle asymmetry; multiply that asymmetry by a smooth floor-bounded function of abs(moment_z_L2)
falsification: reject the transfer if upstream propulsion or closest approach regresses, if moment and cap symptoms do not fall, or if the same downward exit remains with no useful trajectory change
