# Posterior follower-coast promotion candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=[0,0,0]`, no cylinders or
  prewarm, finite dynamics, and inertial moving-window transport. The assigned
  v27 prefill captures at `24.5795T`, minimum/final distance `0.746968L`, mean
  distance `2.360439L`, and score `-0.460673`. The other three samples are
  byte-identical v34 posterior-coast policies and therefore replicate one
  architecture; each captures at `25.0635T`, minimum/final distance
  `0.749973L`, mean distance `2.352216L`, and the better score `-0.452083`.
- Both rows of the combined v27 and v34 sheets were inspected. Their top-down
  rows start wake-free, show self-propelled diagonal translation with a
  spatially coherent alternating mid-plane wake, and finish with a bounded
  redirect through the capture circle. Their oblique rows independently show
  compact three-dimensional Lambda2 structures persisting through the turn.
  The v34 terminal hook remains in the successful trajectory family; it is
  neither passive advection nor a numerical wake breakup.
- The inherited v33 dual-joint braking failure was also inspected in both
  views. It initially retains an organized self-generated wake but passes the
  capture circle, curls away, and exits the virtual domain at `37.2735T` after
  reaching only `0.9332L`. Thus coherent propulsion alone does not make a
  lower rate-limit statistic useful when feasibility feedback disturbs the
  realized route.
- Trace metrics distinguish the successful narrow mechanism. Relative to the
  inherited v32 stopping-stroke reserve, v34 reduces posterior/any-joint exact
  rate occupancy from `5.806/15.163%` to `4.586/13.869%`, retains zero sampled
  posterior hard-stop occupancy, and keeps peak absolute body-frame
  force/yaw-moment coefficients in the low `0.0244/0.0337/0.0162` class. It
  coasts only velocity-increasing posterior commands; it does not brake the
  anterior phase anchor or reverse the traveling wave.
- The completed v35 anterior analogue is a boundary, not support for broader
  filtering. It lowers posterior/any-joint exact-rate occupancy further to
  `4.087/10.808%` and still captures, but worsens mean distance and score to
  `2.369728L/-0.470373` and leaves only `0.000483L` of sampled crossing margin.
  The v32 terminal collision-cone residual is also dominated by v34: it
  captures with mean distance `2.360964L` and score `-0.461276` without
  improving the inherited rate statistic. Do not combine either residual
  with the fragile v34 capture absent new evidence.

## Policy hypothesis

Replace the v27 prefill with the fully evaluated v34 architecture. Preserve
the course-preview route and anterior state-feedback oscillator, add the
validated posterior stopping-stroke reserve, and taper only posterior
velocity-increasing acceleration to coast across the owned `250--260 deg/T`
rate band. This is a role-separated feasibility layer: the anterior joint
continues to anchor phase and steering while the posterior follower gives up
only command that would deepen measured rate saturation.

The expected evaluation is the sampled v34 class: capture with the coherent
diagonal wake, zero posterior hard-stop occupancy, peak planar force and yaw
moment below `0.04`, and posterior/any-joint exact-rate occupancy below the v32
`5.806/15.163%` baseline. Falsify the transfer if capture is lost, the route
diverges into the inherited pass-and-turn topology, the tail hard stop returns,
or the low-load class is lost. The new CFD run occurs after this worker exits;
the sampled v34 result is prior evidence, not a claim about that future run.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior phase anchor and traveling bend while adapting the posterior follower from observed joint state
transferable_invariant: actuator-feasibility feedback should preserve the direction and phase organization of the propulsive wave, removing only constraint-conflicted follower work
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body kinematics, exact vortex phases, capture radius, and task-specific routes
policy_translation: retain the body-frame course-preview controller and anterior oscillator; use normalized posterior joint rate, position, command sign, and the owned actuator envelope for stopping-stroke protection plus a sign-symmetric non-braking coast guard
falsification: reject if capture, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, and do not generalize the guard to anterior or inward-braking control without new evidence

## Pre-evaluation validation

- The materialized candidate is byte-identical to the sampled v34 policy
  (`SHA-256 4d61189c407f3b21b116792a50c5b7b7e0557a44d1c6e12b4b32ba79e1b5a818`).
  This makes the promotion auditable without treating the pending evaluation
  as completed evidence.
- The exact Julia public-contract probe returns two finite accelerations. A
  separate deterministic schema audit confirms that all `84` direct
  `params.FIELD` references resolve among the `86` fields returned by
  `target_policy_params()`.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account; its three declared no-CFD commands were run
  directly and separately and all passed. No formal CFD was run.
