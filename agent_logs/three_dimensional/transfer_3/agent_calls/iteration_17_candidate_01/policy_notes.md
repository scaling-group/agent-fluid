# Response-reversing half-cycle tail-wave candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver examples satisfy the direct-uniform still-water
  contract and capture at `19.2335--19.8880T`. Their top-down rows show a
  coherent alternating mid-plane vorticity street, while the oblique rows show
  compact tail-associated three-dimensional structures through capture. The
  motion is body-led self-propulsion, not background-flow advection or moving-
  window transport. The fastest sampled policy is the explicitly acceleration-
  feasible response-triggered C-bend (`19.2335T`, score `-0.17657`).
- The assigned parent's post-exit rollout is the decisive informative failure:
  the exact same policy hash that captured twice in the sampled set instead
  misses at `1.845L` and exits left at `28.875T`. Its two visual rows retain an
  alternating propulsive wake and show no numerical collapse, but the body
  follows a high, nearly straight pass with the target below it. At `16T` its
  head is near `(11.60,11.95)L`, versus `(11.83,10.50)L` in the fastest
  capture; by `20T` it is still about `1.87L` from the target and has already
  passed high.
- The histories agree with that visual diagnosis. During the failed approach,
  normalized bearing/LOS demand is already saturated and the anterior C-bend
  remains recruited, yet applied acceleration occupies the physical bound in
  about `60.8%/76.4%` of anterior/posterior rows. This is more, not less, than
  the fastest capture's `44.9%/73.6%`; force-magnitude and moment RMS also rise
  from `0.01322/0.00690` to `0.01574/0.00810`. More persistent clipped mean-
  bend demand therefore does not reliably recover the route.
- Inherited allocation logs bound two tempting alternatives. Moving only
  same-sign posterior mean curvature forward while conserving total slow bend
  captures at `20.020T` and materially lowers action/load RMS, but weakens the
  late wake and arrives later. Applying that allocation only near the target
  is a negative result: it passes at `1.62L`, loops to `7.35L`, and captures at
  `49.742T`. Earlier posterior-relief and safe-intercept release also lost
  capture. Route closure must remain continuous on both joints; another range,
  predicted-miss, or static-allocation gate is not supported.

## Policy hypothesis recorded before editing

Start from the sampled acceleration-feasible response-triggered distributed
C-bend, not the weaker collision-course gate. Preserve its normalized body-
frame bearing, rotation-invariant LOS rate, recoil-conditioned yaw response,
anterior oscillator-center redirect, posterior mean correction, traveling-wave
lag, and componentwise physical projection.

Add one mechanism: response-reversing posterior half-cycle modulation. Form the
existing posterior traveling-wave target separately from its slow mean bend.
Bound the signs of that wave and of the observed yaw-rate error, then scale the
wave slightly up when its half-cycle agrees with unmet yaw response and down
when it opposes that response. Because both signs reverse under a reflected
trajectory, their product and the scale are invariant while the resulting
target remains odd. If yaw response outruns demand, the error reverses and so
does the half-cycle preference. No clock, hidden state, route coordinate,
range gate, or extra static curvature is introduced.

The expected result is a coherent carrier with phase-selective steering
authority that can close the inherited high-pass branch without asking for a
larger acceleration limit. Falsify the mechanism if capture is lost or delayed
beyond the `20.020T` conservative-allocation reference, the same more-than-
`1.845L` high pass remains, wake coherence weakens, posterior limit occupancy
or loads materially exceed the failed baseline, or reflection/finite-output
checks fail. Replicated CFD is required before calling any resulting capture
robust.

bookshelf_consulted: true
source_domain: asymmetric robotic-fish CPG turning combined with Lighthill-style posterior traveling-wave propulsion
source_mechanism: steer by modulating the useful and opposing halves of a propulsive tail beat from observed directional response while retaining posterior wave lag
transferable_invariant: preserve the traveling wave and reverse phase-selective imbalance when observed yaw response crosses route demand, rather than opening route closure or copying a fixed beat schedule
nontransferable_details: published gains, robot linkage geometry, species envelopes, dimensional beat frequencies, analytical force coefficients, exact vortex phases, and task-specific routes
policy_translation: multiply the posterior wave target by a bounded factor formed from the product of normalized phase-conditioned yaw error and normalized instantaneous tail-wave target; retain the existing normalized body-frame route law, two slow curvature paths, and physical output projection
falsification: reject if replicated capture is not restored, arrival exceeds `20.020T`, the high-pass branch persists, the alternating wake degrades, posterior limit occupancy or hydrodynamic loads worsen, or reflection equivariance fails

## Validation status

- The required guidance semantic check and solver edit-boundary check pass.
  Static schema auditing confirms that every direct `params.FIELD` reference is
  owned by `target_policy_params()` and the candidate remains non-empty.
- The lightweight Julia contract probe was invoked by the configured check
  runner, but this environment has no `julia` executable. No CFD was run and
  no post-edit capture, timing, load, or wake result is claimed.
