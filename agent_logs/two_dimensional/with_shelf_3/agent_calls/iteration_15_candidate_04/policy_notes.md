# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed interacting vortex streets. It is identical across the
  sampled rollouts and is therefore common initial-condition evidence, not a
  policy-selected wake phase.
- Three sampled, code-identical progress-headroom rollouts terminate at the
  target after `32.33997` release time with `1.63773L` mean distance and score
  `0.234663`. Their identical released sheet shows an immediate correct-sign
  redirect, a persistent posterior-traveling bend, and a narrow self-propelled
  diagonal through the developed wakes. Mean fish velocity
  `(-0.3362,-0.1404)` against mean local flow `(-0.1961,-0.1918)` rules out
  passive advection as the main source of targetward progress. Both joints
  still touch the velocity and acceleration limits; force/moment RMS is
  `65.12/888.56`.
- The sampled response-release composition and the assigned parent's
  code-equivalent inherited rollout also preserve capture and the same broad
  visual topology, but regress together to `32.45547` release time,
  `1.64548L` mean distance, score `0.226804`, and `67.83/914.09` force/moment
  RMS. The late sheet has a visibly wider body-generated wake. Thus the prior
  hypothesis that independent response-conditioned curvature release and
  progress-conditioned posterior headroom would compose additively is
  falsified on the fixed snapshot: simultaneous authority withdrawal weakens
  navigation and load performance even though it does not change termination.
- No sampled released failure sheet exists. The informative adverse evidence
  is instead this semantic regression plus inherited failures in which blanket
  physical-limit gating delayed capture and unrestricted bearing-trend
  recentering erased the traveling bend and exited downstream. The new test
  must preserve the target-signed mean curvature, unit-gain posterior wave,
  and early redirect rather than adding damping or another scalar burst.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation combined with biological redirect-and-release control
source_mechanism: preserve a persistent propulsive rhythm while sensor-confirmed response schedules bounded optional steering modulation
transferable_invariant: optional feedback modes that withdraw steering authority should share an observed-response arbitration envelope so they do not simultaneously weaken a proven traveling gait
nontransferable_details: published gains, dimensional rates, duty ratios, robot or species kinematics, exact vortex phases, actuator ratings, prescribed maneuver timing, and source-task routes
policy_translation: retain the evaluated body-frame curvature, oscillator, posterior lag, and progress-headroom mechanisms; add response-confirmed curvature release, but continuously restore the optional posterior half-cycle residual in proportion to that release instead of stacking both withdrawals
falsification: reject if direct target capture or the narrow diagonal traveling bend is lost, arrival exceeds `32.33997`, mean distance exceeds `1.63773L`, or force/moment RMS exceeds `65.12/888.56` without a compensating navigation improvement

## Candidate hypothesis

Produce exactly one candidate from the code-identical progress-headroom parent.
Keep its filtered body-frame bearing, bounded `12 deg` distributed curvature,
bearing-conditioned `40/60 -> 35/65` allocation, state-feedback anterior
oscillator, lagged posterior wave, and at-most `8%` target-helping half-cycle
residual unchanged.

Reintroduce the independently useful response-confirmed mean-curvature release:
at most `18%`, and only after the gait is active, heading response has the
requested sign, and persistent bearing is shrinking. Change the failed
composition at one architectural seam: normalize this verified release and use
it to suppress progress-headroom withdrawal of the optional posterior residual.
At zero curvature release the controller is exactly the three-times-repeated
headroom parent; at full verified release it approaches the faster
response-release branch's ungated posterior residual. The target-signed centers
retain at least `82%` of their bounded request and the unit-gain traveling wave
is never withdrawn. This is a state-based arbitration test of non-additive
authority scheduling; no same-worker CFD improvement or held-out wake
robustness is claimed.

## Non-CFD validation

- Guidance provenance and material-update check: pass.
- Deterministic `params.FIELD` declaration check: pass.
- Solver editable-boundary check: pass.
- The configured Julia contract assertion could not execute because this
  worker image has no `julia` executable on `PATH`; no CFD was attempted.
