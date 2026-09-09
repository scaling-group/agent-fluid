# Response-selected counterbend candidate

## Evidence diagnosis before the policy edit

- All four assigned samples satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected every combined keyframe sheet, including the top-down
  mid-plane-vorticity and oblique body/Lambda2 rows. Each fish self-propels
  from rest, retains a coherent alternating planar street and compact 3D wake
  structures, and completes repeated broad passes around the target. Passive
  advection, wake collapse, collision, domain exit, and instability do not
  explain the remaining failure.
- The geometry-released C-turn is the semantic baseline: it changes the old
  powered lower exit into horizon survival, with `2.346L` minimum,
  `4.714L` mean, and `3.902L` final distance. The assigned parent's
  target-behind/nonclosing wave contraction reaches `2.484/4.545/4.673L`;
  radial-response release reaches `2.532/4.780/4.385L`. Neither captures or
  improves both the closest pass and average orbit.
- The response-held C-turn is the strongest assigned sample by score and mean
  distance (`-5.091`, `4.458L`) and spends more time inside `3L`, but its
  closest pass is still `2.377L` and final distance is `4.163L`. At its first
  and later close passes, target-ray/course mismatch remains about
  `1.02--1.39 rad`, speed remains `0.65--0.69U`, and signed yaw remains about
  `1.35--2.22 rad/T` in the direction that grows the course error. Across its
  trace, anterior/posterior command-reserve residence is about `0.727/0.101`.
  The visible broad loops and the trace therefore indicate excessive
  tangential rotation under the persistent C-bend, not insufficient drive.
- Inherited logs and parent guidance already close further scalar drive,
  proximity, static bend-allocation, duty, and isolated posterior phase or
  amplitude retuning. The new horizon class is valuable and should be
  preserved; the remaining test must change how the redirect responds to
  established yaw rather than merely strengthening or prolonging it.

## Policy hypothesis

Use the strongest response-held horizon policy as the scaffold. Preserve its
far-field carrier, target-behind onset, response hold, yaw-selected posterior
brake, posterior phase modulation, and command reserve. Add one compact
recovery topology: a response-selected posterior counterbend and wave release.
While the near-target redirect is active, large target-ray/course error
requests the existing anterior C-bend; once measured yaw has the same sign as
that error and exceeds a bounded response threshold, add an opposite posterior
mean-bend component and continuously restore the posteriorly lagged traveling
wave. This is a state-feedback translation of bend, response, and release—
there is no clock, stage variable, route, or world-frame command. The product
of signed course error and yaw is reflection invariant, while the posterior
counterbend sign mirrors. Posterior-only allocation is evidence-led: the best
sample already occupies the anterior reserve on `0.727` of states but the
posterior reserve on only `0.101`.

Expected evidence is preservation of the coherent inbound wake and horizon
survival, followed by reduced same-sign yaw, a target-returning translational
leg, capture, or a material reduction of both closest and mean distance
without transferring persistent saturation to the posterior. Reject the
mechanism if it changes
release/cruise, produces a tight alternating curl, loses wake coherence,
increases load or clamp residence, exits the domain, or merely changes the
radius of the same noncapturing orbit.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: a strong C-bend is released through a posterior counterbend into a posteriorly emphasized traveling wave when measured turning response appears
transferable_invariant: large relative direction error requests bounded curvature, but established same-sign yaw should trigger counterbend and propulsive release rather than indefinite curvature
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequencies, clocked CPG phase, exact vortex phase, full-body kinematics, capture radius, and task-specific routes
policy_translation: normalized body-frame target-ray/course error signs measured yaw; their harmful product adds a bounded opposite posterior mean-bend component and restores the existing posterior wave during the active response-held recovery
falsification: reject if cruise changes, coherent horizon survival is lost, clamp/load residence rises, a tight curl appears, or closest and mean distance retain the same noncapturing orbit class
```

## Evaluation boundary

The current worker cannot claim a coupled-flow outcome. Trace replay and dry
controller probes after editing can establish only selector locality, response
sign, reflection equivariance, finite bounds, parameter ownership, and action
scale; formal CFD evidence belongs to the next worker.

## Implemented candidate and non-CFD probes

Counterfactual selector replay on the completed response-held trace makes the
new stage negligible through cruise (mean/maximum weight below
`9e-11/2e-8` through `12T`) but material in the diagnosed regime (mean
`0.260`, maximum `0.979`, active above `0.25` on `31.7%` of states inside
`3L`). Its weights are `0.337` at the first `2.377L` pass and about
`0.90--0.93` at representative later `2.60--2.88L` return states.

An initial two-joint equilibrium reversal was rejected during dry replay
because it drove the posterior action to the `+28 rad/T^2` reserve. The final
translation leaves the anterior C-bend unchanged and uses a `6 deg` maximum
posterior component plus wave release. On the same frozen states, it changes
the baseline posterior action from `-3.76` to `1.26 rad/T^2` at the first pass
and from about `-1.39-- -2.04` to `20.10--21.82 rad/T^2` on three later return
states. Release is unchanged to the displayed precision, the mirror residual
is zero, and the selected actions retain reserve. These algebraic probes are
not integrated body/fluid evidence.
