# Candidate diagnosis and hypothesis

## Evidence diagnosis

- The four sampled rollouts and the assigned parent are contract-valid,
  direct-uniform still-water evaluations. All capture at `18.0070--18.0125T`.
  In both the top-down vorticity and oblique Lambda2 rows, each fish is visibly
  self-propelled along the same gently curved route and leaves a compact,
  coherent alternating three-dimensional wake through capture. There is no
  advection, collision, instability, or wake collapse to repair; the remaining
  defect is terminal cross-course motion and carrier-locked yaw.
- The sampled v31 course-consensus duty controller has the best score and mean
  distance (`-0.064000/1.950346L`), but ends at only `0.1297` course alignment
  and `0.8077 rad/T` absolute yaw, with a `13.2149L` center path and `0.7327L`
  head cross-track. The sampled v26 one-sided slip feathering improves those
  terminal quantities to `0.1728/0.6545 rad/T` and
  `13.2064L/0.7265L`, but loses closure (`-0.064149/1.950469L`). The sampled
  v25 phase-free force-power allocation and v20 parent capture with the same
  visible wake class but do not resolve both closure and terminal direction.
- The assigned parent's v32 balanced slip-synchronous amplitude redistribution
  is the decisive new negative result. It retains capture and the coherent
  two-view wake, but regresses score/mean distance to
  `-0.064212/1.950513L`; final alignment/yaw (`0.1236/0.9654 rad/T`) are worse
  than both v31 and v26, and cross-track remains `0.7325L`. Its near posterior
  acceleration-ceiling residence (`75.83%`) also remains in the v20/v31 class.
  Direct slip selection therefore does not become useful merely by balancing
  amplitude between half-cycles, and another duty-factor gain change is not
  supported.
- The inherited phase evidence still identifies useful timing information:
  in the v20 approach, summed joint rate correlates `0.415` with target-normal
  force and `0.301` with target-normal speed change `0.022T` later; same-sign
  tail/slip samples increase cross-course speed while opposite-sign samples
  reduce it. A state replay of the v31 approach further shows that a positive
  rotation of its normalized anterior phase vector has the desired work sign:
  it opposes posterior-rate work on the slip-reinforcing samples and adds it on
  the opposing samples. This establishes the rotation sign, not a CFD outcome.

## Policy hypothesis

Start from the best sampled v31 route, v20 terminal envelope, odd mean
curvature, conserved anterior mean-bend allocation, cadence, and posterior
amplitude. Replace only v31's half-cycle amplitude multiplier with a bounded
quadrature rotation of the normalized anterior `phi/phi_dot` phase vector used
to form the posterior target. Retain v31's approach/misalignment/speed and
turn/course-consensus gates. When requested turn and measured course slip
agree, the observed joint-rate half-cycle sets the signed rotation; the
coefficient-vector norm is unchanged, so the mechanism changes posterior
timing without intentionally scaling the carrier amplitude or adding mean
curvature. All gates and the signed rotation are body-frame,
reflection-equivariant state feedback and are exactly inactive outside the
approach.

The candidate is falsified if it loses capture or wake coherence; changes the
far/middle trajectory; regresses score, mean distance, arrival, path, or
cross-track to the v26/v32 class; fails to improve final alignment and yaw over
v31 together; or raises posterior rate/acceleration residence. A null result
would show that changing the two-joint posterior phase target has insufficient
realized authority under the existing terminal acceleration ceiling.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and two-joint wave-shape control
source_mechanism: sensor-gated posterior phase-lag modulation of a traveling carrier
transferable_invariant: redirect a rhythmic swimmer by bounded state-dependent timing changes while preserving the carrier amplitude, posterior emphasis, and cycle-mean route authority
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, exact vortex phases, and task-specific routes
policy_translation: rotate the normalized anterior joint angle/rate phase vector by a bounded body-frame course-consensus and observed-half-cycle command before constructing the posterior target; retain the vector norm and all established transit control
falsification: reject if capture or coherent propulsion is lost, transit changes, closure regresses, terminal alignment and yaw do not improve together, or actuator-limit residence rises
