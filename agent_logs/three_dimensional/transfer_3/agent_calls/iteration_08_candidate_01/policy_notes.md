# Collective-curvature response-release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, active moving-window transport, and finite capture from
  `12.32772L` at about `25.11T`.
- I inspected the sampled combined sheets from release to capture, including
  their top-down mid-plane vorticity and oblique body/Lambda2 rows. The three
  repeated response-release rollouts show a compact self-propelled arc, an
  organized alternating posterior wake, finite three-dimensional shed
  structures, and a smooth terminal bend into the capture sphere without a
  collision, boundary-exit precursor, or visible instability. The
  phase-selective sheet has missing oblique panels, so its terminal visual
  behavior is not inferred from those blanks; its finite top-down row,
  trajectory, and diagnostics support only the quantitative comparison.
- The prefilled response release is reproduced exactly by three sampled
  policies. Each scores `-0.5283387731`, captures at `25.11852T`, reaches
  `0.746410L`, and has mean distance `2.429293780L`. It restores a bounded
  carrier fraction only after maximum individual joint-to-equilibrium error
  becomes small, while keeping the successful positive-closure preview and
  outer controller unchanged.
- The phase-selective alternative remains a compact low-load capture but is
  marginally weaker (`-0.5283756345`, mean distance `2.429298361L`), despite
  capturing one integration step earlier. Its inside-`4L` force/moment maxima
  are about `0.01426/0.00757`, versus `0.01547/0.00800` for response release;
  neither clips a command inside `4L` or dwells at a joint stop.
- Inherited completed results establish the informative mechanism failures.
  Stacking phase-departure and response-release triggers regresses to
  `-0.5309900794` with mean distance `2.431336802L`; releasing only the
  posterior joint regresses to `-0.5302882262` with mean distance
  `2.430852400L`. Both still capture on the same visible topology, so an
  earlier crossing or a similar wake sheet alone does not validate the
  allocation. The inherited `51.645T` broad-relief orbit further rules out a
  general terminal coast or low-drive hold.

## Policy hypothesis

Preserve every body-frame guidance, outer carrier, closure preview, terminal
equilibrium, carrier floor, and actuation parameter of the repeatedly
evaluated response-release parent. Change only the response coordinate that
gates the common two-joint handoff. The terminal steering task is the requested
tail tangent, so measure normalized error in the collective coordinate
`q1+q2` relative to the target-selected mean tail tangent. When that collective
bend is unsettled, retain full curvature allocation; after it forms, recover
the same bounded carrier share on both joints together. Opposed individual
joint errors that preserve the requested total bend are then treated as an
internal traveling-shape mode rather than as failed steering response.

The expected result is byte-equivalent commands outside active terminal
reallocation, the same outer path and wake, earlier but still coordinated
carrier recovery when the target-relative total bend has formed, and a mean
distance no worse than `2.429294L` without terminal clipping, joint-stop dwell,
or larger load spikes. Reject this coordinate change if it delays or loses
capture, worsens score/mean distance beyond repeat variation, changes the
pre-terminal wake, releases while the total bend is still wrong, or recreates
the broad low-drive orbit.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and Lighthill-inspired two-joint traveling-bend propulsion
source_mechanism: separate target-relative mean curvature for steering from coordinated internal joint redistribution that sustains a posterior-lag traveling bend
transferable_invariant: assess steering response in the collective actuation coordinate that controls the requested mean tail tangent, while preserving paired internal motion as a coordinated propulsive mode
nontransferable_details: published gains, dimensional cadence, species-specific amplitude envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame geometry and positive-closure gating; replace worst individual joint-position error with normalized total tail-tangent error to release the existing bounded carrier share on both joints together
falsification: reject if outer commands or wake change, compact capture or mean distance regresses, the collective coordinate releases before the requested bend forms, or terminal saturation and load spikes return

The new CFD evaluation occurs after this worker exits and is not claimed here.

## Non-CFD implementation audit

The deterministic schema audit resolves all 68 direct `params.FIELD`
references against the returned 69-field parameter object. The prescribed
contract state and a 135-state grid over distance, target angle, joint angle,
and joint rate return two finite commands inside the declared acceleration
limit. A synthetic far state produces commands exactly equal to the evaluated
parent. On a terminal state whose two individual errors are opposed by
`0.15 rad` but whose total tangent is exact, the collective error is numerical
zero and both candidate commands differ from the parent, confirming activation
of the intended common handoff rather than a split-joint edit. These checks
establish bounded activation and outer noninterference only, not coupled-flow
improvement.
