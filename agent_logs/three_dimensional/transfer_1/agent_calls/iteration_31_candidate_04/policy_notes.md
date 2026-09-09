# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled solver rollouts are finite captures from direct uniform
  still-water initialization with `U_infinity=(0,0,0)` and no cylinders. They
  reach `0.7480--0.7494L` at `18.1995--18.7495T`; no prewarm, advection, or
  instability artifact explains success.
- I inspected every sampled combined keyframe sheet. In both top-down
  vorticity and oblique Lambda2 views, the fish advances under its own
  oscillation, grows a coherent alternating three-dimensional wake, and keeps
  the traveling bend active through a smooth target-directed arc and capture.
  The fixed anterior transfer and posterior wave-shape variants do not create
  a visibly distinct useful wake topology. The open distinction is terminal
  interception and allocation, not propulsion.
- The assigned speed-reserve parent has two sampled exact-policy captures at
  `18.2875T` and `18.6010T`; the broader evidence bank records both further
  captures and lower exits. Its sampled head/tail action clipping is about
  `68.45--68.48%/70.62--70.64%`, exact speed-limit residence about
  `10.41%/11.30--11.49%`, and peak speed about `0.922--0.923L/T`.
- The inherited step-29 burden-conditioned allocator is the informative visual
  failure. Its sheet retains an active alternating top-down street and
  bilateral oblique structures, but after a `1.1961L` lower pass it continues
  self-propelling into a broad turn and exits at `10.8967L`. That controller
  treated absolute speed/action activity as burden and allowed transfer without
  checking whether previous action or the current steering residual pushed the
  tail farther outward.
- The inherited step-30 refinement instead defines burden from normalized
  current joint speed and outward previous action, requires posterior burden
  to exceed anterior burden, requires anterior margin, and transfers only when
  the current steering residual also pushes the tail outward. Its combined
  sheet retains the same coherent wake and it captures at `0.7474L` in
  `18.3040T`. This is a semantic improvement over step 29, but one rollout is
  not robustness evidence: clipping (`68.69%/70.61%`), speed-limit residence
  (`10.61%/11.60%`), peak speed (`0.9215L/T`), force (`0.0313`), and yaw moment
  (`0.0163`) remain in rather than improve the sampled speed-reserve envelope.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and closed-loop robotic-fish turning
source_mechanism: preserve posterior traveling-wave thrust while applying bounded steering asymmetry only where observed actuator state shows usable anterior authority
transferable_invariant: separate posterior propulsion from anterior steering conditionally without changing the traveling bend or total steering request
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body splines, exact vortex phases, and task-specific routes
policy_translation: in the existing body-frame unsafe-intercept gate, use normalized joint speed and previous action to transfer steering tail-to-head only when posterior outward burden exceeds anterior burden, the requested residual would worsen posterior motion, and the anterior joint has margin
falsification: reject robustness if this exact-policy repeat misses or exits; reject actuator improvement unless repeated captures also lower posterior clipping or speed-limit residence without worse arrival, closure, wake coherence, speed, force, or moment
```

## Single candidate hypothesis

Materialize an exact-policy repeat of the inherited step-30
`dogfish3d_burden_conditioned_steering_transfer_v1` controller. Preserve the
raw achieved-course route error, response/intercept scaffold, state-feedback
carrier, sparse carrier reserve, steering magnitude, and total steering-share
sum. Add no new terminal observer, gain change, or second mechanism. Exact
repetition is the necessary test because the conditional allocator has only
one capture and this lineage contains multiple mechanisms whose threshold
captures failed on replay. A second capture would support repeat-worthiness,
not superiority; a miss would classify this transfer as another branch-
sensitive terminal allocation and favor restoration of the speed-reserve
baseline.
