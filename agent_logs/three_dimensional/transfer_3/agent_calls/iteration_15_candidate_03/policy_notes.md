# Near-range sign-coherent curvature-allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts use direct uniform `U_infinity=(0,0,0)`
  initialization without cylinders or prewarm, remain finite, and capture.
  The top-down rows show body-led translation with a coherent alternating
  vorticity street, while the oblique rows show corresponding compact
  three-dimensional Lambda2 structures. The fish is self-propelled; neither
  ambient advection nor moving-window transport explains its progress.
- The strongest sampled finite rollout is the acceleration-feasible
  response-triggered C-bend: it captures at `19.2335T`, score `-0.17657`,
  action RMS `25.19/28.56 rad/T^2`, force-magnitude RMS `0.01322`, moment RMS
  `0.00690`, and local-flow RMS `(0.01752,0.00405)U`. Its paired replication
  captures at `19.2830T`; the two unbounded-output replications capture at
  `19.5855--19.8880T`. Because the episode applies the same componentwise
  limit, this spread supports the completed topology but does not prove that
  a redundant policy clamp caused the timing difference.
- The assigned parent's gate-only posterior relief is the informative
  failure: it retains a visible alternating wake but removes route curvature,
  reaches only `3.191L`, crosses the target x station at `y=12.692L`, and
  exits left. In contrast, the inherited sign-coherent, curvature-conserving
  allocation captures at `20.0200T`. It reduces action RMS to `15.71/18.97`,
  force-magnitude RMS to `0.00816`, moment RMS to `0.00432`, and acceleration-
  boundary occupancy to `15.2%/31.2%` while retaining opposing posterior
  correction. This confirms allocation only when signed requests agree and
  their total slow bend is conserved.
- The conserving allocator is not an unqualified improvement. Its top-down
  and oblique terminal frames show a visibly weaker late wake, and its route
  diverges above the direct sampled path by about `4T`, arriving roughly
  `0.74--0.79T` later than the feasible sampled pair. On the sampled direct
  path the same-sign allocation is negligible near `8L` and `4L`, then rises
  inside roughly `2L`; unrestricted early closed-loop recruitment is therefore
  unnecessary for the useful terminal allocation and risks altering the
  propulsive far-field trajectory.

## Policy hypothesis recorded before editing

Start from the sampled acceleration-feasible response-triggered C-bend. Add
the inherited signed, curvature-conserving allocator, but recruit it only
through a smooth normalized-range gate centered at `3L`. Far from the target,
the evaluated LOS-rate steering and traveling carrier are exactly retained.
Near the target, only the same-sign portion of posterior mean curvature is
shifted into the anterior oscillator center; the opposing posterior yaw
correction, posterior anti-phase/velocity-lag carrier, damping, continuous
route closure, and componentwise physical acceleration projection remain
active.

Expected evidence is capture within the sampled `19.23--20.02T` band with the
strong far-field alternating wake, a terminal path inside the `0.75L`
corridor, and lower near-target action/load occupancy than the sampled feasible
baseline. Reject the mechanism if capture is lost or delayed beyond `20.02T`,
if the trajectory repeats the `3.191L` high pass, if the far-field wake weakens,
if effort does not fall, or if anterior position approaches the `45 degree`
bound.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation, sensor-modulated robotic-fish CPG steering, and continuous terminal-approach control
source_mechanism: retain posterior phase-lagged propulsion while reallocating only compatible slow steering near interception without opening the route loop
transferable_invariant: preserve the coherent traveling bend and total closed-loop route curvature; separate range-limited steering allocation from far-field propulsion
nontransferable_details: analytical force coefficients, published gains, species envelopes, robot linkage geometry, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame bearing and LOS response to form signed anterior/posterior mean-curvature requests, multiply only their same-sign conservative transfer by a smooth `distance_L` gate, and retain the two-joint state-feedback carrier and physical acceleration projection
falsification: reject if capture or route closure is lost, arrival exceeds the inherited `20.02T`, far-field wake coherence degrades, effort does not improve, or anterior position saturation appears

## Validation status

- The required guidance-delta and solver edit-boundary checks pass.
- Static schema checking confirms that every direct `params.FIELD` reference
  is returned by `target_policy_params()`. A 10,000-state property audit of the
  translated equations confirms finite bounded outputs, reflection equivariance,
  exact slow-curvature conservation, and zero allocation for opposing requests.
- The independent check-runner could not execute the Julia contract probe
  because this workspace image has no Julia executable or Julia HPC module.
  No CFD was run, and no outcome for this new candidate is claimed.
