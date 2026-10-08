# Response-confirmed adverse-yaw allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertially still fluid
  inserted by the moving window. All capture, so the informative failure is a
  mechanism or route regression rather than a failed termination.
- I inspected the combined sheets from release through capture for the
  strongest target-signed sample, the repeated bidirectional reference, and
  the receiver-headroom contrast. In every top-down row the translating fish
  leaves a coherent alternating red/blue street. The oblique rows retain
  compact three-dimensional caudal Lambda2 structures through the terminal
  turn. None shows a standing wiggle, passive coast, collision, boundary exit,
  or wake collapse. Peak body speed is `1.391U` in the strongest sample while
  peak sampled local flow is only `0.0327U`, confirming self-propulsion rather
  than ambient or moving-window advection.
- The prefilled target-signed adverse-yaw policy is reproduced byte-for-byte
  by two sampled trajectories. It captures at `16.932T`, scores `-0.200045`,
  has mean distance `2.08513L`, and stays below both speed stops at
  `4.5192/4.5239 rad/T`. This improves the repeated bidirectional reference at
  `16.988T`, `-0.204764`, and `2.08931L` while retaining the same wake
  topology. Its bounded tradeoff is larger posterior excursion and loads:
  `0.59921 rad`, `0.03693` force, and `0.01835` yaw moment versus the
  reference's `0.569996 rad`, `0.03634`, and `0.01804`.
- The headroom-isolated residual is the useful negative comparison. Giving
  the adverse-yaw increment full authority below a separate `0.75` receiver-
  speed onset preserves capture and the wake, but regresses to `16.960T`,
  score `-0.204089`, and mean distance `2.08869L`; it does not improve joint-
  speed clearance or the peak yaw-moment envelope. Thus the inherited
  all-speed receiver taper is doing useful phase allocation, not merely
  providing remote hard-limit protection. Stronger residual work is not the
  next supported direction.

## Single-candidate policy hypothesis

Preserve the evidenced zero-centered anterior oscillator, posterior traveling
lag, body-frame target/velocity-course steering, terminal posterior
acceleration reserve, smooth acceleration envelope, high-onset positive-power
speed guards, base bidirectional transfer, conservative receiver taper, and
posterior stopping-risk projection. Change only the extra target-signed
posterior-to-anterior residual: require its signed adverse yaw moment to be
confirmed continuously by actual body yaw rate opposite the requested turn.
Normalize yaw rate by the existing beat period and apply a C1 gate, so no new
world-frame direction, clock phase, route stage, or scalar carrier gain is
introduced.

This is a response-confirmed half-cycle allocation mechanism. It should
withdraw moment-only intervention near the start of an eligible donor stroke
and retain correction later in that stroke when the body is measurably turning
the wrong way. The base reclaimed-work channel remains unchanged, so loss of
the extra gate cannot stop the traveling carrier. Falsify the mechanism if it
loses capture or alternating three-dimensional shedding, touches either joint
speed stop, arrives later than the repeated `16.988T` base allocator, has mean
distance above `2.08931L`, or fails to reduce the signed parent's
`0.59921/0.03693/0.01835` posterior-angle/force/yaw-moment tradeoff. Also
reject it if policy-level replay shows no overlap with the sampled residual
events; a measured signal without changed commands is not a mechanism.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and wake-disturbance rejection
source_mechanism: preserve the coupled traveling rhythm while measured response gates bounded corrective work within the target-correcting half-cycle
transferable_invariant: distinguish a signed target-relative correction from fast load oscillation by requiring the commanded turn and the observed body response to identify the same adverse phase before reallocating work
nontransferable_details: published gains, dimensional beat frequency, species-specific kinematics, duty ratios, full-body oscillator networks, exact vortex phase, and task-specific routes
policy_translation: multiply the existing normalized target-signed adverse-moment gate by a C1 gate on body yaw rate opposite the body-frame turn request, normalized by the owned control period, inside the existing posterior donor, receiver-speed, and acceleration-headroom constraints
falsification: reject if the response gate is behaviorally inert, loses capture or coherent alternating shedding, restores a speed stop, regresses beyond the repeated base allocator, or cannot reduce posterior excursion and load without surrendering the signed parent's route benefit
```

## Non-CFD activation check after the edit

A policy-level replay on the 3,079 recorded states of the duplicated signed-yaw
rollout changes 23 joint-1 outputs from `7.040T` through `14.262T`. The maximum
and median absolute acceleration differences are `0.3465` and
`0.0549 rad/T^2`; the response gate spans `0.000015--0.7824`. Joint 2 is
unchanged by construction. This confirms selective overlap rather than another
inactive observation gate. The replay does not evolve the body or fluid and is
not evidence for capture, route, wake, load, or score improvement.
