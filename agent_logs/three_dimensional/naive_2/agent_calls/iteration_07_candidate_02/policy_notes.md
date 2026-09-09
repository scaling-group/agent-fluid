# Course-error half-cycle candidate

## Evidence diagnosis before edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, and no cylinders. The combined top-down and
oblique sheets show self-propulsion with an alternating, compact three-dimensional
tail wake rather than passive advection. The control failure is trajectory
topology, not absence of thrust.

The prefilled approach-redirect policy makes the best sampled close pass. At
`18.032T` its head is `(8.489,11.762)L`, still `2.319L` from capture; when the
head first crosses target x at `17.39T`, it is `2.595L` high and moving
`(-1.206,-0.084)U`. It therefore reaches the target station with too little
downward course correction. The later sharp arc visible in both views does not
recover: at least one joint is near its angle limit for `23.6%` of samples,
both are near the limit for `11.7%`, peak planar force magnitude is `0.688`,
and the fish exits the upper boundary at `27.23T` with distance back at
`8.534L`.

The sampled alternatives sharpen the diagnosis. Bend-triggered carrier release
removes simultaneous joint pinning and lowers peak planar force to `0.488`, but
worsens closest approach to `2.664L` and repeats the upper-boundary exit.
Continuous distance/target-plane hold pins both joints for `18.8%` of samples,
reaches only `2.703L`, and repeats the exit. Joint-angle phase separation has
the best scalar score (`-7.405`) and final distance (`5.706L`), but crosses
target x at `y=14.555L`, never gets closer than `4.650L`, and still exits the
upper boundary. Neither mechanical release nor a better scalar score is
evidence of terminal interception.

## Policy hypothesis

Preserve the evidenced traveling-bend carrier and shared-joint half-cycle
actuator. Replace bearing-gated terminal relief with a course-to-target error
formed from `target_body_L` and `velocity_body_U`. Their dot and cross products
are rotation invariant, so the resulting signed course correction is
insensitive to carrier yaw even though both vectors are expressed in the
current body frame. Blend it in continuously only after measured speed
establishes a course, and use its magnitude to gate the existing bounded
redirect authority and a near-target miss slowdown.

A dry recorded-state command replay rejected the initial no-relief composition:
on the prefilled trace it raised near-target mean action norm from `28.50` to
`37.78` and occupancy above `95%` of the command cap from `36.1%` to `86.4%`.
That is not CFD evidence, but it directly violates the effort boundary and is
sufficient to reject that composition before evaluation. The retained design
therefore scales the complete carrier-plus-asymmetry command together when a
near target remains off course. This keeps the asymmetric term smaller than
the restorative carrier on every reverse half-cycle, rather than scaling only
the carrier as the failed approach schedulers did. Replaying the retained
composition on the same recorded states leaves near-target mean action norm
essentially unchanged (`28.91` versus `28.50`) and reduces above-95%-cap
occupancy to `15.1%`; these are dry contract diagnostics, not a claimed rollout
improvement.

Expected result: earlier sustained downward interception, a target-x crossing
closer to `y=9.5L`, and either capture or a closest pass below `2.319L`, while
retaining the coherent wake and avoiding simultaneous joint pinning. Falsify
the mechanism if it repeats an upper-boundary exit without improving the close
pass, weakens pre-approach leftward translation, or produces rate/angle
occupancy or force peaks worse than the prefilled policy.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking
source_mechanism: bounded directional residual over a stable rhythmic carrier
transferable_invariant: preserve the propulsive rhythm and modulate its half-cycle authority from measured course-to-target error
nontransferable_details: published gains, clock-driven oscillator phase, robot-specific kinematics, species envelopes, and task routes
policy_translation: blend a normalized body-frame target/velocity course error into shared-joint half-cycle asymmetry and co-scale the complete rhythmic command only for a near predicted miss
falsification: reject if closest approach does not beat 2.319L or termination does not improve without loss of wake coherence, translation, actuator margin, and load quality
