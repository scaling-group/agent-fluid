# Smooth phase-local reserve-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

All four sampled evaluations report direct uniform still water with
`U_infinity=(0,0,0)`, zero cylinders, no prewarm snapshot, and capture. I
inspected the combined sheets from release through termination. In both the
best finite bidirectional sample and the informative one-way regression, the
top-down row shows an advancing fish leaving a coherent alternating red/blue
street, while the oblique row retains compact three-dimensional Lambda2
structures behind the caudal region through the final turn. Peak body speed in
the bidirectional sample is `1.374U` while peak local flow is only `0.0313U`,
so the motion and approach are self-propelled rather than moving-window or
ambient advection. The sheets show no wake collapse, collision, domain exit,
or terminal coast.

The trajectory and mechanical diagnostics separate the policies more clearly
than the coarse images. The one-way anterior-to-posterior allocation captures
at `17.035T`, scores `-0.207429`, and has mean distance `2.09268L`. Adding the
phase-compatible posterior-to-anterior route improves those values to
`16.988T`, `-0.204764`, and `2.08931L`, while keeping speed peaks below the
hard limit at `258.91/259.19 deg/T`. All four current samples reproduce that
bidirectional trajectory exactly. One sampled candidate additionally gates
both transfers between yaw-moment magnitudes `0.016--0.018 L^2`; its different
policy hash nevertheless yields byte-identical trajectory and keyframe files.
That is a concrete null result: the load threshold does not overlap meaningful
transfer activity and cannot regularize this trace.

The useful bidirectional composition has one remaining avoidable plateau. Its
posterior-to-anterior transfer is hard-limited by a `0.99` acceleration
headroom, placing the anterior raw command at exactly
`31.10177 rad/T^2` (`99%` of the physical envelope) for 54 samples. The
posterior stays within the ordinary `0.95` soft envelope, and the current force
peak remains modest (`0.02987`), so evidence supports reshaping only the
special transfer reserve rather than adding broad load rejection, changing
carrier gains, or suppressing the demonstrated transfer direction.

## Single-candidate policy hypothesis

Preserve the captured body-frame velocity-course observation, zero-centered
anterior oscillator, posterior lag and steering reserve, soft routine command
envelope, phase-local joint-speed guards, bidirectional positive-work
allocation, and posterior kinetic angle barrier. Replace only the hard
posterior-to-anterior reserve cap with an identity-to-asymptote C1 shoulder:
the assembled anterior command remains unchanged through the established
`0.95` soft ceiling, then approaches the owned `0.99` reserve continuously.
The transfer remains proportional to rejected posterior work and retains its
existing positive-work and normalized receiver-speed gates; only boundary
pile-up is removed.

A non-CFD replay on the sampled bidirectional trace reproduces the logged
parent commands within `1.6e-4 rad/T^2`. The new shoulder preserves all 72
posterior-to-anterior transfer samples while changing mean accepted transfer
from `1.075` to `0.953 rad/T^2`; it removes exact `0.99`-reserve occupancy and
reduces the replayed peak fraction to `0.98996`. This establishes that the
projection is selective and material but does not predict its closed-loop CFD
trajectory.

Expected result: retain capture, the coherent alternating wake, the sampled
route advantage over either one-way allocation, and zero exact speed-stop
contact, while eliminating the 54-sample `0.99` acceleration plateau and
reducing peak acceleration below `31.10177 rad/T^2`. Falsify the mechanism if
capture or wake coherence is lost, arrival exceeds `17.060T`, mean distance
exceeds `2.09311L`, either speed limit is touched, or force/yaw moment exceeds
the sampled bidirectional envelope `0.02987/0.01804` without a compensating
route improvement.

```text
bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and bounded residual actuation
source_mechanism: preserve a low-dimensional rhythmic carrier while state feedback adds only a smooth bounded residual within measured actuator headroom
transferable_invariant: phase-compatible recovered work should enter continuously and remain strictly interior to the actuator envelope without changing the established traveling-bend carrier
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body oscillator networks, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speed and positive joint-work signs as before, but pass posterior-to-anterior recovered acceleration through a C1 shoulder from the routine soft ceiling toward the owned sub-hard reserve ceiling
falsification: reject if capture or alternating three-dimensional shedding is lost, speed contact returns, the route regresses beyond the one-way samples, or the acceleration plateau and load envelope do not improve
```
