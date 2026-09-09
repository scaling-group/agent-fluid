# Actuator-feasible half-cycle allocation candidate

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen rollout contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` termination.
  They capture in `19.701--19.723T`, score from `-0.21675` to `-0.21449`, and
  hold mean distance to `2.10438--2.10634L`. There is no semantic failure, so
  the weakest sample is an informative mechanism underperformer rather than a
  failed trajectory.
- Both rows of the combined and view-specific sheets for the strongest sample
  (`solver_12a0e2e3745e`) and weakest sample (`solver_86d4118b6d89`) were
  inspected from release to capture. Their top-down rows show self-propelled,
  coherent alternating vorticity through the middle field and a smooth late
  arc into the target. Their oblique rows retain compact three-dimensional
  Lambda2 structures along the route. Neither shows passive advection,
  collision, domain exit, wake collapse, disordered lateral motion, or
  instability, and the completed intercept-corridor gate creates no visibly
  distinct terminal topology.
- Metrics agree with the visual comparison. The completed intercept-corridor
  release is the best scalar sample at `19.701T/2.10438L/-0.21449`, versus
  `19.706T/2.10594L/-0.21598` for the plain LOS-led half-cycle controller and
  `19.723T/2.10565L/-0.21601` for projected-miss geometry alone. Those timing
  differences are far inside the inherited identical-policy repeat span of
  about `0.182T`, so the release gate establishes coherent retention rather
  than a proven geometric improvement.
- The release gate also raises anterior mean absolute command from `18.20` to
  `18.53 rad/T^2` and anterior residence above 90% of the smooth command bound
  from `35.25%` to `36.63%`; both joints still reach the `260 deg/T` rate
  limit. Peak planar force and yaw-moment coefficients remain in the inherited
  class at about `0.0230/0.0129`, and joint angles remain below `34 deg`.
  Therefore another corridor scalar, response gate, middle-distance window,
  or posterior phase-lag gate is unsupported; completed inherited variants of
  those mechanisms preserved capture but failed to beat repeat variation.
- The plain LOS-led controller is the clean evaluated baseline for a new
  actuator mechanism. It preserves the supported carrier, fore/aft-aware
  target geometry, distance/positive-closing relief, continuous posterior
  redirect, LOS-rate lead, and joint-state half-cycle steering without the
  unproven corridor layer. Its actionable deficiency is high anterior
  command/rate usage during the same useful half-cycle that receives extra
  steering authority.

## One-candidate hypothesis

Start from the evaluated plain LOS-led half-cycle scaffold. Split its common
half-cycle multiplier into anterior and posterior allocations while preserving
the same signed joint-state phase. Keep the full bounded posterior useful-
stroke modulation. Reduce only positive anterior useful-stroke reinforcement
when the magnitude of the previous anterior command approaches the normalized
smooth acceleration envelope; preserve anterior return-stroke relaxation,
mean target steering, the carrier, and all posterior redirect continuously.
The command magnitude is reflection invariant, and the signed turn/phase
product preserves left-right equivariance.

Expected signature: retain capture and the coherent top-down and oblique wake
classes, lower anterior near-bound command residence without increasing
posterior residence, and improve or preserve arrival and distance integral
beyond executable repeat variation. Falsify the mechanism if capture is lost;
arrival or integral regresses; previous-command feedback chatters; the late arc
or lateral excursion grows; either joint spends more time near its envelope;
or joint margin, force, moment, or wake coherence worsens. If falsified, later
workers should restore the plain LOS-led half-cycle allocation and test a
different observation/actuator primitive rather than tune the feasibility
threshold or stack another redirect gate.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG turning
source_mechanism: preserve posterior traveling-wave emphasis while allocating anterior useful-stroke steering according to observed actuator feasibility
transferable_invariant: keep posterior wave support continuous and avoid asking an already near-bound anterior actuator for additional useful-stroke authority
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phase, clock phase, morphology-specific kinematics, and task-specific routes
policy_translation: use normalized previous anterior-command magnitude to smoothly attenuate only positive anterior half-cycle reinforcement while leaving posterior reinforcement, anterior return-stroke relief, body-frame steering, and two-joint bounds intact
falsification: reject if capture timing or distance integral fails to improve beyond repeat variation, command feedback chatters, anterior or posterior envelope residence grows, or joint margin, loads, terminal topology, or either wake view regresses
