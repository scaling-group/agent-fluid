# One-sided carrier rate-envelope candidate

## Evidence diagnosis before the policy edit

- All four current sampled rollouts satisfy the frozen physical contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, active moving-window transport, and finite
  capture. Three contain byte-identical active policy code; the fourth changes
  only comments and the returned version label. All four therefore reproduce
  score `-0.5283387731`, capture at `25.11852T`, mean distance
  `2.429293780L`, and final distance `0.746410L`.
- I inspected the current combined sheets from release through capture,
  including the top-down mid-plane vorticity and oblique body/Lambda2 rows.
  They show self-propulsion along a compact target-directed arc, a coherent
  alternating posterior wake through the outer approach, and a smooth held
  terminal bend into the capture sphere. The fish is not advected by the
  zero-flow initialization, and there is no collision, boundary-exit
  precursor, or visible instability. Some early oblique panels are black and
  are treated as missing evidence rather than as an absent wake.
- No current sampled rollout is a termination failure. I therefore used the
  weakest available inherited finite comparator as the informative semantic
  failure: the bearing-convergence carrier-release candidate still captures
  at `25.10752T`, but regresses score to `-0.5312198481`, mean distance to
  `2.431539484L`, and crossing depth to `0.749477L`. Its two-view sheet keeps
  the same broad wake/path topology, so one earlier crossing step is not a
  useful improvement.
- The assigned-parent logs and sampled optimizer evidence now reject several
  further terminal-response refinements around the paired release. Added
  yaw-rate curvature, a joint-departure hold veto, a smaller shared yaw
  residual, body-alignment-triggered extra release, and bearing-convergence
  extra release all retain capture but regress to scores from about
  `-0.528782` through `-0.531220`. The closure-previewed paired handoff is
  therefore preserved without another terminal gate, joint-role split, or
  scalar retune.
- A distinct, repeatedly exposed limitation remains in the unchanged outer
  carrier. The strongest trace reaches the acceleration command cap on about
  `39.39%/31.49%` of samples and the `260 deg/T` joint-rate stop on `238/137`
  samples. On `237/137` of those rate-stop samples, the requested acceleration
  has the same sign as joint velocity and can only push farther into the hard
  stop. A soft one-sided predicate beginning at `92%` of the declared rate
  envelope is active on `446/262` parent samples, all outside `4L`; terminal
  force/moment maxima remain low at about `0.01548/0.007995`, so the captured
  terminal allocation is not the target of this edit.

## Policy hypothesis

Preserve the evaluated target geometry, oscillator, posterior lag, closure
preview, shared terminal curvature equilibrium, coordinated response release,
and command limits. Add one compact state-feedback mechanism after command
allocation: as a joint approaches its declared rate envelope, smoothly
attenuate only acceleration whose sign would increase that joint's absolute
rate. Reversal acceleration is untouched, so the governor should shorten hard
rate-stop dwell without delaying the posterior-lag reversal that sustains the
traveling wave. It uses only each joint's normalized velocity and command and
is equivariant under lateral reflection.

The formal CFD evaluation occurs after this worker exits. Falsify the
mechanism if capture is lost or delayed materially, the compact outer path or
alternating wake degrades, closure to `4L` slows, hard-rate dwell does not
fall, acceleration clipping grows, the posterior lag becomes reciprocal, or
terminal saturation/load spikes appear. An unchanged rollout would show that
the physical hard-rate clamp already makes the extra governor dynamically
dormant.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and state-feedback robotic-fish CPG control
source_mechanism: sustain a directed posterior-lag bend with joint-state feedback while treating actuator envelopes as gait guardrails rather than rhythm generators
transferable_invariant: near a joint-rate boundary, suppress only control effort that drives farther into saturation while preserving the reversal and inter-joint lag that generate a traveling propulsive bend
nontransferable_details: published frequencies, amplitudes, Strouhal ranges, oscillator gains, species-specific envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: normalize each observed joint rate by a policy-owned rate envelope and smoothly attenuate only same-sign acceleration near that envelope after the existing two-joint target allocation
falsification: reject if outer progress or wake coherence regresses, hard-rate dwell persists, the joint motion becomes reciprocal, capture worsens, or saturation, loads, instability, or low-drive loitering increase

## Non-CFD implementation audit

- The workspace guidance check passes with a material reusable update, the
  exact lightweight multi-wake contract state returns two finite commands,
  and the editable-boundary check passes. No CFD was run.
- A deterministic scan resolves all `70` direct `params.FIELD` references in
  the object returned by `target_policy_params()`.
- Direct governor checks confirm exact noninterference below its activation
  band, smooth attenuation from `12` to `6 rad/T^2` at `96%` of the rate
  envelope, zero outward command at the envelope, full preservation of a
  `-12 rad/T^2` reversal, and sign-reflected output under simultaneous command
  and joint-rate reflection. These establish schema, boundedness,
  one-sidedness, and equivariance only; coupled-flow benefit remains for the
  later evaluator.
