# Wake-policy candidate diagnosis

## Evidence read before policy edit

- All four sampled rollouts and the assigned-parent rollout report direct
  uniform initialization at `U_infinity=[0,0,0]`, no cylinders, and no
  prewarm. Translation and the wakes are therefore produced by the released
  swimmer rather than ambient advection.
- I inspected both the top-down vorticity row and oblique 3D Lambda2 row in
  every sampled combined keyframe sheet, then compared the highest-scoring
  finite rollout (`solver_6b0e320e2f55`) with the assigned-parent
  half-cycle-steering failure (`solver_eabef54fa5c2`). The three exact-byte
  prefill repeats sustain an alternating vorticity street and compact paired
  3D wake structures through captures at `0.7466--0.7494L` and
  `18.2050--18.6010T`. Their terminal paths vary visibly, but the carrier does
  not collapse or coast.
- The assigned parent's state-synchronous half-cycle allocation also retains
  an active alternating wake and remains numerically stable. It nevertheless
  enters the `2.75L` intercept region with projected miss about `2.24L`
  (versus about `0.59--0.99L` for the three prefill captures), reaches only
  `1.6860L`, and bends below the target into a `left_domain` termination at
  `10.3091L`. Its action clamp fractions are about `70.0%/71.5%`, slightly
  above the sampled prefill range `68.5--68.7%/70.6--71.0%`, even though its
  exact speed-limit residence falls to about `8.5%/9.5%` from
  `10.4--11.6%`. This is a terminal steering-path failure, not deficient
  propulsion, advection, numerical instability, or a useful saturation cure.
- The three successful prefill repeats cross the capture boundary at roughly
  `0.83--0.91L/T`, while their final target/course geometry ranges from a
  nearly aligned pass to a large residual bearing. Together with the coherent
  wake, this supports preserving the repeat-proven achieved-course request,
  projected-intercept release veto, cadence, and conditional carrier reserve.
  The remaining testable weakness is beat-scale yaw during the last approach,
  not another route error or carrier allocation.
- The inherited parent log supplies the evaluated negative result above. Its
  score alone would not identify the mechanism, so the accompanying inherited
  candidate, notes, trace, diagnostics, and two-view sheet were used before
  assigning the failure to half-cycle steering.

## One candidate hypothesis

Retain the prefilled controller byte-for-byte in its guidance, turn-response,
drive, and carrier-reserve mechanisms. Add one bounded inner yaw-damping
residual only inside `1.5L`: use the already phase-compensated observed yaw
rate, with the sign convention established by the evaluated response-release
loop, to oppose rotation while leaving the propulsive traveling bend active.
Ramp the residual smoothly to full authority by `0.9L`; cap it at a small
fraction of the existing steering command so it cannot become a new route
controller. This is distinct from the failed carrier-acceleration-signed
half-cycle redistribution and changes no far-field output.

Expected test: preserve broad closure, the three-repeat capture topology, and
both coherent wake views while reducing terminal heading-rate excursions and
capture-path variability. A useful result must retain capture without raising
action/speed saturation or peak force/moment outside the sampled prefill
envelope; improved arrival or distance integral is secondary evidence.

Falsification: reject terminal yaw damping if it changes output outside
`1.5L`, turns a repeat-supported capture into the below-target lower exit,
weakens the alternating wake, increases clipping or loads, or merely lowers
yaw while worsening closest approach. Formal CFD occurs after this worker, so
the candidate remains a hypothesis rather than same-worker evidence.

bookshelf_consulted: true
source_domain: terminal approach control and sensor-modulated robotic-fish direction tracking
source_mechanism: retain the rhythmic propulsion controller while adding bounded feedback that damps measured yaw during final approach
transferable_invariant: separate the slow body-frame route request from a small inner rotational-damping residual so heading energy can be reduced without suppressing the traveling propulsive wave
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, prescribed paths, exact beat or vortex phase, and task-specific coordinates
policy_translation: preserve normalized achieved-course and intercept feedback plus both joint-state carrier loops; inside a normalized distance gate, add a reflection-equivariant bounded residual from phase-compensated body yaw rate to the existing two-joint steering command
falsification: reject if far-field commands change, capture is lost, the wake weakens, or terminal distance, saturation, force, or yaw-moment loads worsen relative to the repeat-supported speed-reserve envelope
