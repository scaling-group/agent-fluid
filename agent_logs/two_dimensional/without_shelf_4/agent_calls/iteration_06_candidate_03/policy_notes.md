# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held high and downstream/right of the target while the four staggered
  cylinder streets develop and overlap through the target corridor. It cannot
  distinguish policies.
- The inherited `14 deg`, `0.80`-period target-aware controller is the clearest
  advection failure. Its released sheet shows an almost straight fish swept to
  the downstream/right boundary before it enters the useful wake. Metrics and
  diagnostics agree: it exits at `16.747`, moves the head
  `(2.172,-0.814)L`, has `-0.148` progress and only `0.692` mean command
  energy. A merely cap-feasible but weak gait is not useful control.
- The inherited `19 deg`, `0.67`-period policy is the informative near miss.
  Its sheet shows active oscillation, a broad heading correction, and sustained
  upstream-left motion, but repeated wide turns keep it right of the target at
  the full `300` horizon. It finishes at its rollout minimum `5.812L`, moves
  `(-5.846,-4.282)L`, and has mean velocity x `-0.01942` against local-flow x
  `-0.00682`. Maximum anterior acceleration is only `29.138 rad/time^2`, so
  the miss is insufficient corridor acquisition rather than actuator clipping.
- The sampled `20 deg` controller repairs that longitudinal failure while
  preserving the same period, posterior lag/damping, and bounded bearing/rate
  steering. Duplicate fixed-prewarm evaluations reproduce capture at
  `266.255`, `7.218L` mean distance, and head motion
  `(-11.031,-4.702)L`. Its keyframes show the fish self-propelling through a
  broad initial correction, then aligning left into the interacting wake and
  approaching the target from the right without collision or breakup.
- The strongest current result changes only the anterior shell to `20.25 deg`
  plus a mechanically raised inactive guard. Its sheet retains the successful
  route topology but reaches the central wake and target earlier, at `244.547`,
  and lowers mean distance to `6.452L` (`score -4.439` versus `-5.190`). The
  head's mean upstream velocity improves from `-0.04144` to `-0.04443`, while
  the local-flow mean becomes slightly less favorable (`-0.03889` to
  `-0.03649`), supporting increased controller-produced transport rather than
  passive advection alone. The improvement costs higher mean command energy
  (`667.60` to `695.75`) and RMS moment (`353.21` to `362.21`), but RMS force
  is unchanged near `18.26`, RMS relative crossflow rises only from `0.1319`
  to `0.1344`, and the measured `31.055 rad/time^2` anterior maximum stays
  below the `31.2` policy guard and `31.416` episode cap.
- The isolated bearing-scale test provides a negative boundary. Sharpening
  `0.30` to `0.28` at the proven `20 deg` gait still captures, but its sheet
  shows a larger downward/upward detour before final alignment; mean distance
  worsens from `7.218L` to `8.112L`, release time is still `262.895`, and RMS
  force rises to `18.58`. Earlier steering saturation is therefore not a
  supported route-shortening mechanism. Inherited stronger posterior-lag and
  coupled `21 deg`/`0.69` variants likewise lost upstream progress or rebounded.

## Candidate hypothesis

Promote the complete demonstrated `20.25 deg`, `0.67`-period phase-shell
controller as the single candidate. Preserve its `0.65/0.80` posterior
lag/damping, negative bounded posterior bearing/rate correction with `0.30`
bearing scale, and `31.2 rad/time^2` local guard. This is a one-axis improvement
over the assigned `20 deg` prefill and uses only joint state and normalized
body-frame target bearing/rate; it introduces no coordinates, route, clock,
prescribed inflow, remote wake probes, morphology, or episode changes.

The next fixed-prewarm CFD rollout should reproduce target capture near
`244.55`, mean distance near `6.45L`, negative head-x travel, and no guard or
hard-cap contact. Treat the current evidence as one fixed wake-phase result,
not robustness evidence. Falsify promotion if capture is lost, arrival becomes
later than the replicated `20 deg` result, the route rebounds after approach,
or the acceleration guard/load increase becomes active or persistent. Because
`20.25 deg` already reaches `31.055` against the `31.416` hard cap, later
workers should not increase this period's shell without first demonstrating
guard margin; corridor-retention feedback is the safer next axis.
