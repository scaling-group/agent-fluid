# Positive-work carrier decomposition candidate

## Evidence diagnosis before edit

The assigned parent guidance is byte-identical to `optimizer_5281c3e25238` and
its inherited rollout log remains a capture (`solver_078d5446848f`, score
`-0.13665`), so the supported capture scaffold should not be replaced. All four
sampled rollouts are direct, uniform, quiescent initializations and all capture;
the useful comparison is therefore trajectory and actuator quality rather than
termination class alone.

Both rows of the combined keyframe sheets were inspected for the best finite
sample `solver_3fdd63b3fbda` and the informative lower-performing sample
`solver_5fc33d6eb58b`. In both, the fish is visibly self-propelled rather than
advected: a coherent alternating top-down vorticity wake and compact oblique
Lambda2 structures develop behind the body, the body turns toward the target,
and neither wake collapses before capture. The redirect-priority sample reaches
the capture circle at `16.044T`; the dominant-joint sample retains a longer
late hook and reaches it at `17.990T`.

Metrics sharpen the tradeoff. Redirect priority has the best score (`0.05824`)
and distance integral (`1.82409L`) but the longest sampled head path
(`13.178L`), highest planar-force/yaw-moment peaks (`0.03579/0.01770`), and
`12.24%` anterior residence above 99% of the rate envelope. The other carrier
guards capture at `17.418--17.990T` with paths `12.170--12.528L` and peaks no
greater than `0.03198/0.01651`. Thus redirect priority supplies useful semantic
progress, while scaling the entire two-joint carrier remains an overly broad
protection action: positive work at one joint can suppress negative-work
reversal at either joint.

## One candidate hypothesis

Keep the inherited corrected-sign target geometry, response-aware redirect,
distance/closing relief, half-cycle allocation, and traveling carrier. Near
the measured rate envelope, retain the existing common positive-work/redirect
guard request but apply its scale only to each carrier component doing positive
instantaneous joint work. Pass negative-work carrier reversal and all
target-conditioned steering unchanged. This is a mechanism change, not scalar
tuning. It should retain the early `10/8/6/2L` progress of redirect priority
while reducing rate-bound residence, outward impulse, peak load, and late path
curvature. Falsify it if capture/distance integral regress beyond sampled
variation, if the coherent two-view wake breaks, or if rate residence, path,
load, joint margin, or terminal yaw does not improve.

```text
bookshelf_consulted: true
source_domain: classical reactive fish swimming and sensor-modulated robotic-fish CPG control
source_mechanism: sustain a directed anterior-to-posterior traveling bend while bounded state feedback modulates the rhythmic command and target-conditioned asymmetry turns the swimmer
transferable_invariant: preserve posterior lag and the steering residual; near an observed actuator boundary withdraw energy-injecting rhythm without weakening the reversal that sustains the bend cycle
nontransferable_details: published gains, dimensional frequencies, species envelopes, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: use normalized joint rate and instantaneous carrier work in the two-joint body-frame controller; attenuate only positive-work carrier components with one bounded response-gated request
falsification: reject if capture timing or distance integral regresses, wake coherence is lost, or rate residence, peak load, path length, joint margin, and terminal course fail to improve together
```
