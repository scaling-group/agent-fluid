# Carrier-protected terminal curvature-allocation candidate

## Evidence diagnosis recorded before the policy edit

- All four assigned examples report direct uniform `U_infinity=(0,0,0)`
  initialization, no cylinders, and finite capture. Their top-down sheets show
  body-led translation with coherent alternating vorticity, and the oblique
  sheets show matching compact three-dimensional Lambda2 structures. Progress
  is self-propelled rather than ambient advection or moving-window transport.
- The strongest assigned finite example is the acceleration-feasible
  response-triggered C-bend. It captures at `19.2335T` with score `-0.17657`;
  its exact-policy replication captures at `19.2830T`. The unclamped-output
  variants capture at `19.5855--19.8880T`. The collision-course-gated prefill
  also captures, but later at `19.7835T` with score `-0.20824`, so its extra
  interception gate provides no sampled semantic or timing improvement.
- The inherited unrestricted sign-coherent allocation is useful but bounded:
  it conserves total slow curvature, retains opposing posterior correction,
  and captures at `20.0200T` while reducing action and load RMS relative to the
  feasible baseline. Its weaker late wake and `0.74--0.79T` delay establish it
  as a load-saving mechanism, not a faster route.
- The assigned parent's range-restricted version is the informative completed
  failure. It remains finite and eventually captures, but only at `49.7420T`
  with score `-1.38708`. Both visual rows retain the alternating propulsive
  wake through roughly `16T`, then show wake extinction and a large coasting
  loop. The trace agrees: commands fall from `(-28.81,12.87) rad/T^2` near
  `17.99T` to about `(0.033,-0.032) rad/T^2` near `20.99T`; the first pass
  bottoms out at `1.455L` at `21.043T`, with action about
  `(-0.001,-0.017) rad/T^2`. The joints have settled near a shifted static
  center, so distance gating did not preserve the carrier even though it left
  the far-field equations unchanged.

## Policy hypothesis recorded before editing

Start from the parent's smooth near-range, sign-coherent, curvature-conserving
allocator and add one state-feedback safety mechanism. Measure the anterior
carrier radius from joint angle and normalized joint velocity around the
unallocated route center. Smoothly withdraw only the transferred posterior
mean curvature when this radius becomes small. This moves the oscillator center
back toward the already completed route controller before the state can remain
near the unstable zero-amplitude equilibrium. Far from the target the range
gate is still inactive; with a healthy carrier, allocation still adds and
subtracts the same signed curvature and therefore conserves total slow bend.
Opposing posterior correction, the posterior phase lag, damping, target
feedback, and componentwise acceleration projection remain active.

Expected evidence is a coherent wake through the first approach, no near-zero
command plateau around `19--21T`, and capture no later than the inherited
unrestricted allocator's `20.020T`, while retaining at least some of its load
relief. Reject the mechanism if the first pass remains outside `0.75L`, capture
is later than `20.02T`, the carrier still collapses into a long coast, total
slow curvature is not conserved while allocation is active, opposing posterior
correction is removed, or action/load occupancy is no better than the sampled
feasible baseline.

bookshelf_consulted: true
source_domain: Lighthill reactive-thrust allocation and sensor-modulated robotic-fish CPG control
source_mechanism: keep steering allocation subordinate to an observed self-sustaining propulsive rhythm while retaining posterior phase-lagged thrust
transferable_invariant: a slow steering-center change must preserve the traveling carrier; if observed carrier energy collapses, release the optional allocation before propulsion disappears
nontransferable_details: published oscillator gains, dimensional frequencies, species envelopes, robot linkage geometry, analytical force coefficients, exact vortex phases, and task-specific routes
policy_translation: compute a normalized carrier radius from anterior joint angle and velocity around the body-frame route center, smoothly gate only the near-range same-sign curvature transfer by that radius, and retain the two-joint state-feedback carrier and physical acceleration projection
falsification: reject if wake or command amplitude still collapses, first-pass capture is lost, arrival exceeds `20.02T`, conserved curvature or opposing correction is broken, or sampled load relief disappears

## Validation status

- The guidance semantic-delta, parameter-schema, public policy-contract, and
  solver edit-boundary checks pass.
- A deterministic 10,000-state audit confirms finite acceleration-bounded
  output, reflection equivariance, exact slow-curvature conservation, and zero
  allocation for opposite-sign steering requests.
- Replaying the parent's observed `20.993T` stall state reproduces its near-zero
  command, while the new controller measures carrier radius `0.193`, reduces
  allocation weight to `0.010`, and requests a bounded restoring anterior
  acceleration of `-12.10 rad/T^2`. This checks mechanism activation only.
- No CFD rollout was run, and no outcome is claimed for this new candidate.
