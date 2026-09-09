# Saturation-recruited posterior phase candidate

## Evidence diagnosis

All four sampled evaluations satisfy the experiment contract: direct uniform
`U_infinity=(0,0,0)`, no cylinders or prewarm snapshot, finite dynamics, and
capture. In the combined sheets, the top-down row shows a self-generated,
alternating wake from `4T` through capture, while the oblique Lambda2 row shows
compact paired three-dimensional structures following the body rather than an
external flow advecting it. The trajectories remain broadly direct, with
tail-beat-scale lateral waviness but no pre-capture loop or boundary excursion.

The inherited response-reversing half-cycle policy is replicated under the
same policy hash: it captures at `18.931T` and `19.052T`, scores `-0.15357` and
`-0.16031`, and has local-flow RMS `0.01825--0.01843U`. This establishes the
semantic baseline and also shows about `0.12T` same-policy timing variation.
Its posterior acceleration is at least `99%` of the envelope for
`75.4--76.4%` of samples; combined action RMS is `38.00--38.32 rad/T^2`, while
force/moment RMS is `0.01330--0.01357` / `0.00692--0.00707`.

The response-reversing phase variant retains the visibly coherent wake and
captures at `18.997T` with score `-0.15967`, inside the replicate timing band,
while lowering posterior acceleration occupancy to `74.3%`, combined action
RMS to `37.69 rad/T^2`, and force/moment RMS to `0.01317` / `0.00685`. The
demand-allocated variant also captures but is the informative counterexample:
it reduces anterior occupancy to `34.0%`, speed RMS to `0.679U`, and loads to
`0.01250` / `0.00654`, yet arrives later at `19.239T` with the worst sampled
score, `-0.17198`. Thus wholesale instantaneous curvature reallocation buys
effort by slowing the useful route, whereas phase steering supplies a smaller
load benefit without a resolved arrival penalty.

## Policy hypothesis

Keep the replicated LOS-rate, distributed C-bend, and response-reversing
half-cycle path unchanged when it has acceleration headroom. Predict the raw
posterior acceleration from current joint state; as its normalized magnitude
approaches the actuator envelope, continuously recruit the sampled
response-reversing posterior phase rotation. Rotation preserves the norm of
the traveling-wave position/velocity coefficients, so this should retain the
coherent carrier while moving some steering authority from amplitude into
phase only where clipping otherwise erases amplitude differences.

The next evaluation falsifies the candidate if it loses capture, arrives
outside the sampled `18.931--19.239T` capture band, disrupts the alternating
top-down or oblique wake, or fails to reduce posterior saturation/load relative
to the two inherited-policy replications. Since current local-flow RMS is only
about `0.018U`, any disturbance-rejection claim remains out of scope until a
stronger-flow evaluation exists.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and phase-lag steering
source_mechanism: sensory feedback modulates posterior oscillator phase while retaining a traveling propulsive rhythm
transferable_invariant: route-response error can rotate a posterior wave in observed joint phase without increasing its coefficient norm
nontransferable_details: published gains, clock phase, species-specific envelopes, exact tail kinematics, and task routes
policy_translation: use normalized body-frame target geometry, LOS rate, phase-conditioned yaw error, joint state, and normalized predicted posterior acceleration to recruit a bounded phase rotation under low headroom
falsification: reject if capture or wake coherence is lost, arrival leaves the sampled capture band, or posterior saturation and hydrodynamic loads do not improve over the replicated half-cycle baseline
