# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent (`solver_2f617353199f`) and all three sampled
  comparisons satisfy the frozen rollout contract: direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm, and
  inertial moving-window transport. All four capture without angle, speed, or
  applied-acceleration contact, so trajectory response, distance integral,
  wake organization, and loads are more informative than termination class.
- Both visual rows were inspected from release through capture for the
  strongest finite samples (`solver_b3cc38ade37a` and its byte-identical
  replicate `solver_7e2b89182e53`) and the informative assigned-parent
  mechanism failure. The top-down sheets show genuine self-propulsion, an
  orderly alternating wake, and a targetward upstream route followed by the
  same shallow terminal hook. The oblique body/Lambda2 sheets retain compact,
  coherent three-dimensional vortices throughout. There is no passive
  advection, boundary interaction, wake breakup, numerical instability, or
  moving-window-induced body rotation. The parent's posterior-duty addition
  changes response within the same productive visual family rather than
  supplying a new trajectory topology.
- The replicated anterior-only duty sample captures at `0.748598L` and
  `25.5090T`, with score `-0.556475`, mean distance `2.457773L`, and distances
  `10.308/5.898/1.475L` at `8/16/24T`. Propagating an opposite-bend duty change
  into joint 2 in the assigned parent worsens these to `0.749956L`, `25.6080T`,
  `-0.560723`, `2.461948L`, and `10.326/5.909/1.513L`. It retains zero actuator
  contacts and slightly lowers peak planar force/yaw moment from
  `0.02063/0.01065` to `0.02023/0.01043`, so the regression is not a saturation
  or wake-collapse effect.
- The posterior-duty response is not simply useless. Relative to the
  anterior-only trace, it lowers normalized course error/projected miss from
  about `0.645/6.65L` to `0.628/6.48L` at `8T`, `0.683/4.03L` to
  `0.657/3.88L` at `16T`, and `0.786/1.16L` to `0.657/0.99L` at `24T`.
  However, it is already allowed during the low-speed startup: on the parent
  trace, target-projected body-center closing speed averages only `0.020U`
  over `0--2T` and `0.182U` over `2--4T`, then rises to `0.343U` over
  `4--6T` and `0.455U` over `6--8T`. Applying posterior duty before the
  propulsive carrier establishes translation therefore trades away the
  anterior duty mechanism's evidenced positional gain even though later
  alignment improves.
- The cleaner sampled policy (`solver_ab218bebf730`) removes the inherited
  middle slip/instantaneous-force residuals as well as posterior duty. It
  retains the same coherent two-view wake and zero-contact load regime and
  captures earlier at `25.3605T`, but does not isolate which removed branch
  causes the finite change. The inherited step-34--37 logs already classify
  the middle residual family as phase-confounded or milliscale tie-breaks.
  This candidate therefore leaves those branches unchanged and tests only a
  response qualification of the newly evaluated posterior-duty mechanism.

## Policy hypothesis

Preserve the assigned parent's state-feedback traveling bend, anterior course
duty, posterior lag and vectoring, course/miss-triggered response-released
redirect, target-line response, middle load response, capture modulation,
coupled acceleration projection, and angle/rate viability guards. Retain the
posterior opposite-bend duty component, but engage it only after normalized
target-projected body-center velocity shows that useful translational closing
has developed. A smooth kinematic readiness gate is zero during startup,
transitions across the measured carrier-acquisition band, and is full at the
parent's sustained cruise response. Because it uses the body-center velocity
rather than instantaneous head-distance change, the gate does not confuse
joint-driven head oscillation with whole-body target progress. Geometry still
owns steering side, joint position still supplies within-beat phase, and all
existing far/middle/near distance handoffs remain continuous.

The falsifiable expectation is to recover the replicated anterior-duty
sample's early `8T` distance and mean-distance benefit while preserving the
assigned parent's lower `16--24T` course error and projected miss, coherent
two-view wake, capture, zero actuator contacts, and approximately its
`0.02023/0.01043` load regime. Reject the mechanism if it still follows the
slower assigned-parent distance trace, loses the parent's alignment response,
creates beat-scale switching or wake disorder, loses capture, or increases
actuator/load exposure. Fixed-pose CFD after handoff is required to determine
the outcome; the current trace audit can establish engagement and boundedness
only.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG steering and wake-response separation
source_mechanism: preserve a traveling-wave carrier while engaging bounded asymmetric steering only after observed whole-body response is established
transferable_invariant: separate persistent target-directed translation from fast beat-synchronous motion before allocating a second-joint steering component
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific kinematics, clock phase, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame target geometry and body-center velocity form a smooth target-projected closing-speed readiness gate on the existing posterior joint-state duty component
falsification: reject if early distance progress is not recovered, later course error or projected miss rebounds, capture or coherent three-dimensional wake is lost, or actuator and load exposure exceed the parent regime

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 68-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic audit of 50,000 paired stress states spanning lateral
  reflections, target geometry, velocity, force, response rates, and
  beyond-limit joint angles/rates remains finite and within the `30 rad/T^2`
  policy envelope; paired reflection command error is exactly zero. At the
  readiness-band endpoints, the candidate exactly matches the sampled
  anterior-only allocation below the band and the assigned-parent allocation
  above it.
- Re-evaluating the assigned parent and candidate on all 4,656 reconstructed
  parent-trace states changes 674 post-guard command pairs, including 168 by
  more than `0.05 rad/T^2`; maximum separation is `0.56486 rad/T^2`.
  Differences are confined to the established upstream duty window and end by
  `17.952T`/`4.810L`. This establishes a material bounded response-gate test,
  not CFD evidence of improvement.
- The material-guidance check, lightweight Julia contract check, and solver
  editable-boundary check all pass. The guidance check first exposed two
  identical copied-parent markers in the rendered workspace `README.md`;
  removing only one duplicate marker restored an unambiguous assigned parent.
  The required independent check runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account, so the three
  prescribed commands were run directly as the inherited fallback. No formal
  CFD was run.
