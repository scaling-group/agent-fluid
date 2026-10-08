# Response-gated target-ray half-cycle candidate

## Evidence-led visual diagnosis recorded before the policy edit

- The four sampled solvers satisfy the frozen direct-uniform still-water
  contract with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite traces,
  and capture termination. Three reproduce the established reference policy,
  trajectory, and keyframe hashes exactly: they capture at `16.93205T`, score
  `-0.20004481`, have mean distance `2.08513085L`, and cross at `0.74389035L`.
- The assigned parent is the one-sided matched-window target-ray continuation.
  It preserves capture at `16.93206T` and improves score, mean distance, and
  crossing distance narrowly to `-0.19999072`, `2.08508726L`, and
  `0.74383789L`. Its whole-trace joint-angle, joint-speed, action, force,
  moment, fish-speed, and local-flow maxima are unchanged from the reference.
  This is a small positive distance-quality result, not a new termination or
  wake regime.
- I inspected both rows of the combined sheets for the assigned parent and
  replicated reference and compared them with the inherited symmetric
  target-ray and point-consistent carrier-relief failures. The top-down rows
  show continuous target-directed translation with a coherent alternating
  red/blue street; the oblique rows retain compact caudal Lambda2 structures
  through the capture sphere. None shows held-joint coasting, passive
  advection, collision, boundary exit, wake collapse, or instability. Peak
  fish speed is `1.39123U` while peak sampled local flow is only `0.03270U`,
  supporting self-propulsion rather than background transport.
- The visually similar failures isolate allocation semantics. The symmetric
  target-ray residual strengthened the base course request in 86 terminal
  samples but relaxed it in 136; it captured at `16.92622T` yet regressed to
  `-0.20442999`, `2.08865523L`, and `0.74813604L`. The terminal carrier-relief
  policy also arrived slightly sooner at `16.92657T` but worsened to
  `-0.20618842`, `2.09007336L`, and `0.74984097L`. Identical whole-trace
  mechanical maxima and coherent wakes make both negative results failures of
  terminal work placement, not propulsion or safety failures.
- A replay audit of the completed assigned-parent trace sharpens the surviving
  mechanism: all 86 one-sided corrections coincide with positive posterior
  joint work, and 83 also oppose measured yaw moment. The only three
  favorable-moment corrections occur in the final `0.019T` before capture.
  Thus the marginally positive residual already behaves almost entirely like
  target-signed half-cycle work, but the policy does not encode that response
  boundary explicitly.

## Single-candidate policy hypothesis

Preserve the assigned parent's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course loop, one-sided target-ray
geometry and forward-target release, posterior acceleration reserve, C1
acceleration envelope, high-onset positive-power speed guards, signed
adverse-yaw work transfer, receiver taper, and stopping-risk projection.
Refine only the terminal target-ray residual into a response-gated half-cycle
primitive. Form its incremental turn request relative to the unchanged base
course request, then admit that increment only while it would add positive
posterior joint work and while measured normalized yaw moment opposes it. A C1
gate reaches full authority at an evidence-calibrated adverse moment magnitude;
favorable response, negative-work phases, and the base steering signal pass
unchanged.

This tests whether the one-sided target-ray benefit comes from placing
corrective work on a target-compatible propulsive half-cycle rather than from
generic terminal steering magnitude. Expect the broad route to remain exactly
inherited, retain capture and the alternating three-dimensional wake, and
remove the three response-incompatible parent corrections without weakening
the established course loop. Seek a score, mean distance, or crossing depth
better than the parent's `-0.19999072/2.08508726L/0.74383789L`, with no joint
contact and no increase beyond its `0.59922 rad` posterior angle or
`0.03694/0.01836` force/moment envelope. Falsify the mechanism if response
gating loses capture, changes the route outside `2.25L`, erases the useful
positive-work interventions, worsens distance quality without a mechanical
benefit, or disrupts coherent shedding.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: sensor feedback schedules corrective work on the compatible half-cycle while preserving the coupled propulsive rhythm
transferable_invariant: add target-signed corrective work only in a joint-state phase that performs useful work and only until the measured body response agrees
nontransferable_details: published gains, dimensional beat rates, species-specific envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: compare the bounded one-sided target-ray turn request with the unchanged body-frame velocity-course request; project only its increment through posterior positive-work and adverse normalized-yaw-moment gates before the existing two-joint allocation and safety layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; if useful parent interventions are suppressed; or if score, mean/crossing distance, posterior angle, or force/moment loads regress without a new semantic or mechanical benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the new projection over the assigned parent's 3,079 recorded states
retains 79 of its 86 target-ray increments exactly, smoothly attenuates four,
and removes three whose measured yaw moment already agrees with the correction.
The candidate remains active in 83 samples from `15.718T/2.243L` through
capture; every retained increment performs positive posterior joint work and
opposes measured yaw moment. Its response gate averages `0.969` while active,
the maximum turn-request increment remains the parent's `0.11679`, and the
total absolute increment falls only from `1.85476` to `1.85116`. It changes no
sample at or beyond `2.25L`. This establishes a non-inert phase/load projection
with preserved useful overlap; it does not evolve the fish or fluid and is not
evidence for the unevaluated candidate's CFD outcome.
