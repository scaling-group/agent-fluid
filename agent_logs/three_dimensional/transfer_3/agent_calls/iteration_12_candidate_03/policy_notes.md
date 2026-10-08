# Crossflow-admittance mean-curvature candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm state, a finite moving window, and capture from
  `12.32772 L`. Three reproduce the coordinated response-release baseline at
  score `-0.5283387731`, mean distance `2.4292937801 L`, and capture at
  `25.118522644 T`; one of those three differs only in version/comment text.
- The strongest sampled controller is the crossflow-supported release
  (`solver_44f6e53e7268`). It captures on the same solver step but improves
  score to `-0.5281078349`, mean distance to `2.4291113720 L`, and final
  distance to `0.7461675406 L`. Its combined sheet shows self-propulsion along
  the same compact outer arc, a coherent alternating top-down wake, finite
  three-dimensional Lambda2 structures, and a smooth low-wake terminal crab;
  there is no collision, domain-exit precursor, joint-stop dwell, or visible
  instability.
- I compared that sheet from release through capture with the replicated
  baseline and the inherited stronger carrier-release rollout
  (`solver_f2a2dd408e40`). The weaker inherited rollout keeps the same visible
  wake topology and captures one step earlier at `25.113021851 T`, but regresses
  to score `-0.5304331185`, mean distance `2.4309369794 L`, and a shallower
  `0.7486109138 L` crossing. Thus an earlier discrete crossing does not make
  restoration of more terminal carrier a useful mechanism.
- The inherited notes establish that below `1.6 L` the baseline has a
  `0.654--0.772` normalized body-frame lateral target component,
  target-helpful relative crossflow of about `-0.279` to `-0.258 U`, and
  `0.674--0.712 L/T` range closure while the two-joint equilibrium is settled.
  This supports the crossflow cue itself. However, the prior 10% version
  regressed to `-0.5285807072`, the evaluated 14% version improved only the
  continuous distance terms, and several convergence/yaw/carrier additions
  scored `-0.528782` to `-0.531220`. The evidence therefore rejects another
  scalar relief edit and motivates separating mean bend from rhythmic carrier.

## Policy hypothesis

Start from the evaluated best sampled controller and preserve its outer
traveling-wave carrier, target-relative redirect, closure preview, actuator
limits, crossflow/closure/settling gate, and coordinated terminal allocation.
Change only what that gate modulates: instead of reducing terminal-equilibrium
allocation and thereby restoring extra carrier, smoothly relax both components
of the existing mean-curvature target toward neutral while keeping the inherited
carrier/equilibrium blend fixed. Compute settling from the unrelieved target so
the new command cannot manufacture its own support condition.

This is one two-joint admittance mechanism, not a gain-only variant. It should
be command-exact outside `1.6 L`, without positive range closure, for
wrong-sign relative crossflow, and while the established bend is unsettled.
Inside the supported terminal crab it should yield corrective static curvature
without injecting an extra beat. Accept only if capture remains finite and the
distance integral or crossing improves with the same outer wake and no renewed
clipping, joint-stop dwell, load spike, loop, or instability.

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-modulated robotic-fish rhythmic control
source_mechanism: retain useful flow-induced motion while modulating the corrective component of an existing rhythmic controller through observed state
transferable_invariant: when body-frame target geometry, relative crossflow, range closure, and joint settling agree that lateral response is useful, yield the slow corrective equilibrium without increasing rhythmic carrier authority
nontransferable_details: published gains, species-specific kinematics, dimensional cadence, full-body waves, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: a smooth bounded gate from normalized target lateral sign, body-frame relative crossflow, closing speed, range, and two-joint tracking error scales both mean-curvature targets while leaving the response-conditioned carrier allocation unchanged
falsification: reject if the cue is dormant, affects the outer route, slows or loses capture, restores carrier-driven oscillation, reduces helpful closure, or increases saturation, joint-stop dwell, force/moment loads, wake disruption, or instability

The new candidate's coupled CFD evaluation occurs only after this worker exits;
no outcome is claimed here.

## Non-CFD implementation audit

The candidate loads successfully in Julia, all 74 direct `params.FIELD`
references resolve against the returned 75-field parameter object, and the
two commands remain finite and bounded on every stored state of the strongest
sampled trajectory. Replaying candidate algebra on those states gives exactly
zero command difference from the evaluated v26 controller at and above
`1.6 L`. All 226 stored states below `1.6 L` activate the admittance; its mean
is `0.0220`, its maximum is `0.03735` under the declared `0.04` bound, and the
largest per-joint command difference from v26 is `0.0327 rad/T^2`. Synthetic
paired states also confirm exact noninterference for wrong-sign crossflow,
zero closure, and unsettled curvature. These checks establish schema
completeness, gate activity, sign, boundedness, and outer noninterference only,
not hydrodynamic improvement.
