# Response-gated distributed C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled evaluations used direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their wakes
  and translation are self-generated; the moving-window shifts preserve
  inertial coordinates and do not advect the fish toward the target.
- Both rows of every combined keyframe sheet were inspected. The assigned
  parent (`solver_3b6bd84298a5`) sustains a coherent alternating top-down
  street and compact oblique Lambda2 structures through `30.12T`, but it
  crosses the target x station near `y=12.89L`, misses by `3.369L`, and exits
  left. The shorter phase-conditioned failure (`solver_adc862529891`) also
  self-propels with a coherent wake, but turns upward and exits after only
  `16.77T` with a `5.658L` minimum. These are route-control failures rather
  than wake collapse, imposed advection, or numerical instability.
- The two sampled distributed C-bend children independently change the
  termination class to capture while preserving the carrier. The bounded
  route-response gate (`solver_d2c490cfb432`) captures at `19.585T` with
  score `-0.20397`; the constant-velocity predicted-miss gate
  (`solver_dca1b5640cb9`) captures at `19.784T` with score `-0.20824`.
  Their top-down sheets retain the alternating street through approach and
  their oblique rows retain compact three-dimensional wake structures up to
  the target sphere.
- The response-gated capture is the stronger completed candidate on more than
  scalar score: it arrives about `0.20T` sooner, has lower raw acceleration-
  envelope occupancy (`39.5%/71.6%` versus `41.5%/72.9%`), and lower force
  and yaw-moment RMS (`0.01261/0.00661` versus `0.01314/0.00690`). Local-flow
  RMS remains small in both (`0.0182U` and `0.0184U`), confirming that capture
  comes from target-response steering rather than passive wake transport.
- The success isolates the missing parent capability. Posterior LOS-rate
  curvature alone leaves a high pass despite `57.7%/74.0%` raw acceleration
  occupancy. Recruiting a bounded `6 degree` anterior oscillator-center shift
  while the already-bounded bearing-plus-LOS yaw demand remains large shares
  a slow C-bend across both joints without replacing the `28 degree`, `0.55T`
  propulsive rhythm. A separate predicted-miss formulation also succeeds, so
  the durable mechanism is sustained response-gated actuator distribution,
  not a single threshold or scalar gain.

## Policy hypothesis recorded before editing

Use the completed response-gated distributed C-bend as the candidate. Preserve
its evaluated joint-state traveling wave, normalized body-frame bearing,
rotation-invariant LOS rate, phase-conditioned posterior curvature, and smooth
large-bearing/large-route-response recruitment of the bounded anterior mean
bend. This is a mechanism-level replacement of the assigned LOS-only parent;
no unevaluated gain change is justified after two sampled captures.

Expected evidence is reproducible capture with the long coherent wake, arrival
near `19.6T`, finite force and moment histories, and no increase from the
sampled `39.5%/71.6%` raw acceleration occupancy. Falsify the transfer if the
same source and task contract does not reproduce capture, if the route returns
to the parent's more-than-`3L` high pass, or if the anterior redirect produces
an early upper/lower curl under a held-out initial pose. In that case retain
the LOS carrier but prefer the independently successful predicted-miss gate
before altering carrier gains.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG direction tracking
source_mechanism: observed direction and route response recruit bounded distributed mean curvature on a persistent propulsive rhythm and release it continuously as response demand falls
transferable_invariant: preserve the traveling wave while a bounded sensory response recruits and releases steering authority across the available joints
nontransferable_details: published gains, species-specific C-start shapes and timing, robot linkage geometry, dimensional rates, clock phase, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing plus rotation-invariant LOS rate to gate and sign an anterior oscillator-center shift while retaining phase-conditioned posterior curvature in the two-joint state-feedback contract
falsification: reject if capture does not reproduce, the more-than-3L high pass or an early curl returns, wake coherence degrades, or acceleration and load occupancy materially worsen

## Validation status

- The required check-runner was invoked. Its guidance check passes after
  disambiguating the duplicated assigned-parent marker in the rendered root
  `README.md`, and its solver boundary check passes with only
  `candidate_target_policy.jl` changed under `solver/`.
- The deterministic parameter-field comparison finds every direct
  `params.FIELD` reference in `target_policy_params()`. The candidate is also
  byte-for-byte identical to the sampled capture policy, whose completed L64
  evaluation supplies prior execution evidence.
- The check-runner's Julia contract probe cannot start because this worker
  image has no `julia` executable in `PATH` or standard host runtime paths.
  This environment limitation is not reported as a passed runtime check.
- No CFD rollout is run or claimed by this worker. This workspace will be
  evaluated only after exit.
