# Target-signed counter-yaw recovery candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertially still fluid in
  newly exposed moving-window cells. All four capture at `16.988T`, reach
  `0.74717L`, and have byte-identical combined keyframes and trajectories.
  Three use the assigned bidirectional policy verbatim; the fourth adds an
  absolute-yaw-moment gate but produces the same rollout. Thus there is no
  failed termination in this sampled set; the informative negative contrast is
  an inactive observation gate, while the inherited one-way captures provide
  the useful finite regression.
- I inspected the combined sheets for the sampled bidirectional capture and the
  inherited anterior-to-posterior-only `17.035T` capture from release through
  termination. In both, the top-down row shows forward translation with a
  coherent alternating red/blue street, and the oblique row shows compact
  three-dimensional Lambda2 structures shed from the caudal region. Neither
  shows standing oscillation, wake collapse, collision, passive coast, or
  boundary exit. The traces agree that this is self-propulsion: peak body speed
  is about `1.39U`, versus only `0.031--0.033U` peak sampled local flow.
- The bidirectional parent is the best sampled viable route: score `-0.204764`,
  mean distance `2.08931L`, capture at `16.988T`, no exact `260 deg/T` speed
  contact, posterior angle at most `0.5700 rad`, and peak force/yaw-moment
  coefficients `0.03634/0.01804`. The inherited one-way allocator captures at
  `17.035T` with mean distance `2.09268L`; the unguarded soft-envelope carrier
  is faster at `16.943T` but occupies both exact speed stops for about
  `3.73/3.54%` of its trace. Preserve the bidirectional carrier, narrow
  positive-power speed guard, and receiver-headroom constraints.
- Replaying the parent policy on the stored pre-step states reproduces the
  logged actions within `4.2e-6/1.6e-4 rad/T^2`. Its posterior-to-anterior
  transfer is active at 72 stored states. At 70 of them the anterior-angle sign
  opposes the body-frame target-course turn request, and at all 72 the added
  acceleration is directed toward neutral. This co-occurrence is consistent
  with the inherited phase calibration that mean yaw-moment sign follows
  anterior-angle sign. It distinguishes a target-useful counter-yaw release
  from the failed earlier anterior stiffness/asymmetry, which acted broadly and
  increased limit occupancy.
- The sampled absolute-moment-gated variant is a concrete null result: although
  its trace reaches `0.01804` yaw moment, its policy and the ungated parent have
  identical actions and outcome because the threshold does not materially
  overlap discretionary transfer with receiver headroom. Do not infer control
  authority from a signal's whole-trace peak; activation must co-occur with the
  mechanism it gates.

## Single-candidate policy hypothesis

Keep the demonstrated zero-centered anterior oscillator, posterior traveling
lag, body-frame target/velocity course error, terminal posterior steering
reserve, soft acceleration envelope, bidirectional high-onset speed governor,
and posterior angle stopping-risk projection unchanged. Add one target-signed
phase-local residual to the already useful posterior-to-anterior allocation:
when posterior positive work is removed at its speed shell, the anterior
receiver is doing positive work toward neutral, and its angle sign opposes the
requested target-course turn, increase only the transferable fraction with a
smooth normalized counter-yaw gate. Receiver speed and acceleration headroom
still bound the result, and no extra work is created when the donor guard is
inactive.

This tests whether shortening an evidenced counter-yaw half-cycle recovers the
remaining `0.045T` guard cost without repeating broad anterior gain asymmetry.
Expect capture, the same alternating 3D wake, no exact speed contact, mean
distance no worse than `2.08931L`, and arrival closer to or earlier than the
unguarded `16.943T` reference. Falsify the mechanism if capture or coherent
shedding is lost, either speed limit is reached, arrival/mean distance regress
beyond the one-way references, posterior angle exceeds `0.5700 rad`, raw
acceleration exceeds its envelope, or force/yaw moment materially exceed
`0.03634/0.01804`.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric-flapping turn control and sensor-modulated CPG control
source_mechanism: allocate bounded corrective work to the turn-useful part of a continuing propulsive cycle using observed state rather than an external clock
transferable_invariant: preserve the traveling rhythm and alter only the joint-state half-cycle whose evidenced yaw sign opposes the current body-frame course request
nontransferable_details: published gains, dimensional beat frequencies, species-specific kinematics, external clock phase, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: form a smooth gate from normalized anterior angle, target-course turn request, and toward-neutral positive work; use it only to increase posterior-speed-blocked work transferred into measured anterior speed and acceleration headroom
falsification: reject if the alternating wake or capture is lost, speed contact returns, route metrics regress, load or posterior-angle envelopes grow, or the gated channel fails to differ materially from the ungated parent
```

## Non-CFD contract check after the edit

- Static comparison finds all 27 direct `params.FIELD` references in the
  returned parameter schema, with no unused candidate parameters.
- Algebraic replay over the parent's recorded pre-step states makes the new
  residual nonzero at 16 of the 72 existing posterior-to-anterior transfer
  states. Its largest added acceleration is `0.535 rad/T^2`; the replayed
  output remains at or below the existing `0.99` receiver ceiling
  (`31.102 rad/T^2` versus the `31.416 rad/T^2` physical envelope).
- Julia is unavailable in this worker image, so syntax and public-contract
  validation are delegated to the required repository check-runner. No formal
  CFD was run; the new physical outcome remains evidence for the next worker.
