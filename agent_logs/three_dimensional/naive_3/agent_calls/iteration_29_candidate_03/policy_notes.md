# Bidirectional phase-local work-allocation candidate

## Evidence-led visual diagnosis recorded before the policy edit

All four sampled episodes report direct uniform still-water initialization
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm, and all terminate in
capture. I inspected the top-down and oblique rows of every combined keyframe
sheet from release through termination. Each top-down sequence shows an
advancing fish leaving a coherent alternating red/blue street rather than a
standing reciprocal wiggle. Each oblique sequence retains compact
three-dimensional Lambda2 structures behind the caudal region through the
terminal turn. Peak body speed is `1.374--1.402U` while peak local flow is
only `0.0313--0.0329U`, so the motion is self-propelled rather than ambient or
moving-window advection. There is no visible wake collapse, collision, domain
exit, or terminal coast in this sampled set.

The useful contrast is therefore mechanical and route-level. The unguarded
soft-envelope reference captures fastest at `16.943T`, with score
`-0.205386`, mean distance `2.08985L`, and force/yaw-moment peaks
`0.03609/0.01766`, but it spends `3.73/3.54%` of its samples exactly at the
anterior/posterior `260 deg/T` speed limits. The prefilled one-way
anterior-to-posterior transfer removes both contacts and retains the wake, but
regresses to `17.035T`, score `-0.207429`, and mean distance `2.09268L`.
Inherited completed results show the other one-way direction likewise
regresses to `17.060T`, `-0.208655`, and `2.09311L`, while a continuous
margin-rate speed barrier reaches `17.008T` but raises peak force to
`0.03775`. These results do not support another isolated transfer direction,
broader braking shell, or scalar carrier retune.

The two byte-identical sampled bidirectional rollouts are the positive
composition: both capture at `16.988T`, improve score to `-0.204764` and mean
distance to `2.08931L`, keep joint-speed peaks below the hard limit at
`258.91/259.19 deg/T`, and retain the same two-view wake topology. Their peak
force/yaw moment is `0.03634/0.01804`, and the anterior transfer reserve raises
peak acceleration to `31.102 rad/T^2`; those are explicit tradeoffs rather
than evidence for stronger drive.

## Single-candidate policy hypothesis

Replace the prefilled one-way ablation with the sampled bidirectional
phase-local composition. Preserve the demonstrated body-frame target/course
feedback, zero-centered anterior oscillator, posterior lag and steering
reserve, soft acceleration shoulder, high-onset positive-work speed guards,
and posterior stopping-risk projection. When a speed guard removes positive
work, offer only a bounded fraction to the other joint: anterior loss may
enter an agreeing posterior carrier stroke within its ordinary soft ceiling;
posterior loss may enter an anterior stroke already doing positive work within
the sampled sub-hard acceleration reserve. Both transfers require the receiver
to remain below its normalized speed headroom boundary. This changes one
mechanism composition and does not tune the established carrier gains.

Expected result: reproduce capture and the coherent alternating 3D wake,
retain zero exact speed-stop contact, and preserve the sampled improvement over
both one-way variants and the unguarded baseline's score/mean distance. Falsify
the mechanism if capture or wake coherence is lost, either speed limit is
touched, mean distance exceeds `2.0931L`, arrival exceeds `17.060T`, posterior
angle exceeds `0.5907 rad`, or force/yaw moment materially exceeds
`0.03634/0.01804`. Also revise the lesson if the `0.99` anterior reserve causes
persistent acceleration saturation or fails to reproduce the score advantage.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and robotic-fish sensor-modulated CPG control
source_mechanism: preserve a phase-coherent traveling bend while normalized state feedback redirects only temporarily unavailable rhythmic work
transferable_invariant: keep the established carrier phase and redirect bounded positive work only into an already phase-compatible receiver with measured actuator headroom
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, continuous-body kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized joint speed and joint-state power sign to guard each output near its limit, then allocate a bounded portion of removed acceleration into the other joint only when its existing carrier direction and receiver headroom are compatible
falsification: reject if capture or alternating three-dimensional shedding is lost, speed contact returns, route metrics regress beyond the one-way samples, or force, moment, posterior-angle, or acceleration use exceeds the sampled bidirectional envelope
```
