# Candidate diagnosis and hypothesis

The four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=(0,0,0)`, no prewarm, and no cylinders. Three are exact repeats of
the assigned rate-governed policy (`002a5b...`) and capture at `23.3640T` with
score `-0.51274776`; they are repeatability evidence, not three distinct
controller mechanisms. The informative comparison is the earlier captured
cadence policy (`710675...`), which reaches the radius one `0.0055T` step sooner
but scores worse (`-0.51527750`). The inherited scalar-only optimizer logs also
show later captures at `-0.52318`, `-0.53004`, and `-0.53312`, but contain no
policy or trajectory evidence from which to assign those regressions to a
specific mechanism.

In both the best and weaker combined keyframe sheets, the top-down row grows a
coherent alternating wake from quiescent water and the fish advances under its
own actuation along a broad, target-directed curve. The oblique Lambda2 row
shows the same traveling three-dimensional wake persisting through the final
turn; there is no visible passive advection, collision, wake breakup, or
instability before capture. The sheets are nearly indistinguishable, consistent
with the small numerical change. Metrics resolve that change: selective
rate-envelope feedback shortens center path from `13.4189L` to `13.3177L`,
reduces RMS yaw rate from `1.5749` to `1.5537 rad/T`, and eliminates sampled
`99.9%` joint-rate residence while retaining capture and wake coherence. It does
not remove actuator pressure: rates remain above `96%` for `15.68%/3.58%` of
samples and policy accelerations sit at the `1800 deg/T^2` ceiling for
`69.61%/50.68%`.

The candidate therefore preserves the proven odd body-frame
target-to-curvature map, approach logic, traveling-wave lag, steering, and
direction-selective rate governor. It adds one mechanism: a smooth shared
carrier-load gate computed from normalized two-joint angle/rate state. As
carrier load rises, the gate modestly lowers the common oscillator cadence
before head and tail accelerations are constructed. Sharing the gate preserves
their relative traveling-wave timing; using both displacement and rate keeps
relief active at stroke ends as well as mid-stroke. This is intended to reduce
acceleration-ceiling residence and oscillatory path/yaw without removing full
deceleration/reversal or target steering authority. Reject it if capture or the
coherent two-view wake is lost, if high-rate/acceleration residence does not
fall, or if arrival, distance integral, path, or loads regress materially.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPGs and classical traveling-wave amplitude-envelope control
source_mechanism: feed observed locomotor state back into a coupled rhythmic carrier while retaining posterior lag
transferable_invariant: modulate shared carrier energy continuously from normalized joint load so the traveling bend remains coordinated inside the actuator envelope
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific envelopes, prescribed phases, and task routes
policy_translation: apply one bounded body-independent gate from normalized two-joint angle and rate state to the common state-feedback cadence before constructing either joint acceleration; preserve the evidenced odd body-frame steering map
falsification: reject if capture or coherent top-down and oblique wake is lost, actuator-limit residence is unchanged, or integrated distance, path, arrival, yaw, or loads worsen materially
