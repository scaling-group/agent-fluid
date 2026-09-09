# Wake-policy diagnosis and candidate hypothesis

## Prior evidence

- All four sampled evaluations are valid direct-uniform, zero-inflow,
  no-cylinder releases and end in capture. The current prefill's response-
  residual redirect is the least useful mechanistic comparison: it captures at
  `16.247T` with distance integral `1.82240L`, head path `13.36290L`, mean
  commands `17.343/15.816 rad/T^2`, and anterior/posterior rate residence above
  99% of the envelope of `12.05/1.32%`.
- The strongest finite sample is the predictive positive-work guard. It
  captures at `15.851T`, improves the distance integral to `1.81025L`, shortens
  the head path to `12.99539L`, and lowers mean commands to
  `16.207/14.890 rad/T^2`. Its anterior/posterior rate residence above 99% is
  `9.16/0.00%` and maximum joint angles are `34.04/34.65 deg`; its boundary is
  a higher peak planar force/yaw moment of `0.03846/0.01908`.
- In both combined keyframe sheets, the top-down row shows self-propelled
  target progress with a compact alternating vorticity street rather than
  advection, and the oblique row shows coherent shed Lambda2 structures. No
  collision, domain exit, prewarm artifact, or disturbance event precedes
  capture. The prefill visibly carries a larger late hook; the predictive
  sample retains the useful traveling wake and takes the shorter approach.
- The predictive sample's remaining rate burden is strongly anterior:
  residence above 90% is `17.18%` at joint 1 versus `6.52%` at joint 2. A
  common positive-work scale therefore lets the anterior bottleneck withdraw
  posterior carrier work while the posterior joint still has rate margin.
  The inherited optimizer scores at steps 34--36 all remain captures, so this
  candidate preserves the complete capture scaffold and changes one actuator-
  allocation mechanism rather than adding another terminal steering residual.

## Candidate

Start from the strongest sampled predictive guard. Retain its full body-frame
target redirect, distance/closing relief, half-cycle steering, response-aware
reversal release, joint-state preview, and shared handling of negative-work
reversal. Split only the predictive *positive-work* attenuation by joint: each
joint's outward carrier component is withdrawn from its own projected rate and
positive power, while target-conditioned steering remains untouched. This can
keep useful posterior thrust when only the anterior rate is near its envelope,
without amplifying either carrier component or using time, route identity, or
world coordinates.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and low-dimensional robotic-fish CPG control
source_mechanism: anterior motion sustains and steers a posteriorly lagged traveling bend, while posterior kinematics retain the principal reactive-thrust role
transferable_invariant: actuator protection should preserve the direction, lag, and posterior contribution of the traveling carrier instead of suppressing both joints whenever only one joint lacks rate margin
nontransferable_details: published species envelopes, dimensional frequencies, gains, full-body waveforms, exact phases, and source-task routes
policy_translation: use normalized joint rates, bounded same-sign carrier acceleration, and joint-state preview to attenuate each positive-work carrier component separately; retain shared negative-work reversal, posterior lag, and body-frame steering
falsification: reject if capture, early milestones, or distance integral regress beyond repeat spread; if posterior rate residence or peak loads rise; if joint margin shrinks; or if either wake view loses the sampled coherent traveling-wave class

The new candidate is not yet evaluated. Its expected signature is unchanged
capture and wake topology, equal or earlier progress, less needless posterior
attenuation during anterior rate contact, and no regression in posterior rate,
load, joint-margin, or path diagnostics.
