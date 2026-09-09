# Candidate diagnosis and hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm snapshot, and capture termination. The
combined sheets were inspected in both rows. From release through `12T`, the
top-down views show each fish generating a coherent alternating vortex street
while translating under its own propulsion rather than being advected. From
`12T` to capture, the street bends smoothly with the target-directed route; it
does not collapse into a standing lateral wiggle. The oblique Lambda2 views
confirm compact three-dimensional structures shed behind the caudal fan and a
continuous approach to the green capture sphere, with no collision, domain
exit, or visible instability.

The strongest finite example is `solver_625a1e7347f1`: its smoothly recruited
posterior phase response captures at `18.799T`, scores `-0.14330`, and has mean
distance `2.0311L`. The weakest scalar example is the always-on phase response
in `solver_3ca4e16bfde3`: it still captures, but at `18.997T`, score
`-0.15967`, and mean distance `2.0480L`. The prefilled response-reversing
half-cycle baseline captures at `18.931T` with score `-0.15357`. Relative to
that baseline, smooth phase recruitment reduces anterior/posterior
acceleration-limit occupancy from `44.77%/76.09%` to `41.54%/73.96%`, force
RMS from `0.01357` to `0.01315`, and moment RMS from `0.00707` to `0.00684`,
while leaving speed RMS nearly unchanged (`0.70370U` versus `0.70485U`).
Local-flow RMS stays small and comparable
(`0.01823U` versus `0.01843U`), so the route difference is controller-led, not
external advection. A hard activation based only on the previous applied
posterior action also captures (`18.892T`, score `-0.14930`) but does not match
the smoothly predicted-headroom route.

No failure termination is present in this assigned four-run sample. Therefore
the informative contrast is the best and weakest finite captures plus the
prefilled baseline, not an invented failure diagnosis.

## Candidate hypothesis

Adopt the sampled smooth predicted-headroom phase recruitment as the single
candidate. Preserve LOS-rate pursuit, distributed C-bend steering, and the
response-reversing half-cycle. Compute the baseline feasible posterior demand,
use its normalized magnitude to recruit a bounded coefficient-norm-preserving
phase rotation, and let yaw-rate error reverse that rotation. This is a
mechanism selection, not a scalar-only gain change: outside the high-demand
region it approaches the captured baseline traveling wave, while near clipping
it changes when posterior curvature is delivered without increasing the wave
coefficient norm.

Expected evidence is another finite capture with the coherent top-down and
oblique wake retained, arrival no later than the `18.931T` prefill, and
anterior/posterior acceleration-limit occupancy no worse than
`44.77%/76.09%`. Falsify the selection if it loses capture, exceeds either
baseline occupancy without a route benefit, increases force/moment RMS above
`0.01357/0.00707`, or visibly breaks the alternating traveling wake. Replication
is still informative because the inherited guidance reports that identical
earlier C-bend hashes have split between capture and a high left miss.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and two-joint phase-lag steering
source_mechanism: preserve the rhythmic carrier while bounded feedback changes posterior wave phase to redirect the swimmer
transferable_invariant: steering authority can be recruited through response-dependent phase modulation without replacing the propulsive traveling wave
nontransferable_details: published oscillator gains, dimensional frequencies, robot geometry, species kinematics, exact phases, and source-task routes
policy_translation: use normalized body-frame LOS and yaw response with joint-state phase; recruit bounded posterior coefficient rotation from normalized predicted acceleration demand
falsification: reject if capture robustness, route integral, load history, or wake coherence worsens relative to the captured response-reversing baseline
