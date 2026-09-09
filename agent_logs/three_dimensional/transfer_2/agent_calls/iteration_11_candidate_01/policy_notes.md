# Candidate wake-policy notes

## Evidence diagnosis before the policy edit

- All four sampled episodes are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, finite moving-window
  shifts, stable dynamics, and `capture` termination. They capture in
  `19.706--20.207T`, reduce distance from `12.328L` to about `0.747L`, and
  score `-0.21598--(-0.22712)`. There is no semantic failure in this batch.
- Both rows of every sampled combined sheet were inspected. The strongest
  finite sample (`solver_1b6df3d71b19`) is self-propelled rather than advected:
  its top-down row develops an alternating mid-plane wake and a smooth
  left/down target arc, while its oblique row retains compact three-dimensional
  Lambda2 structures through capture. The weakest sampled capture
  (`solver_7b0034b927d0`) is the available failure-side visual comparator; it
  has the same coherent wake class but makes a later, sharper terminal hook.
  No sampled domain-exit keyframe exists, so the inherited `2.127L` near-miss
  and outward-curl failure is used only as logged scalar/trajectory evidence,
  not as a newly claimed visual observation.
- Metrics and joint histories expose a limitation hidden by the persistent
  wake trail. In the strongest LOS-led sample, distance reaches `3.615L` at
  `16T`, but joint state is already nearly stationary (`q=(0.118,0.173) rad`,
  command magnitude below `1.5 rad/T^2`); near `19T`, it is
  `q=(0.025,0.016) rad` with commands about `(0.22,0.05) rad/T^2`. Capture at
  `19.706T` is therefore largely an inertial coast after the approach damping
  extinguishes fresh tail beats, even though the earlier alternating wake
  remains visible. This follows structurally because the added damping reaches
  nearly `3.0`, while the oscillator's maximum self-excitation coefficient is
  only `0.35`; the configured `0.58` amplitude floor cannot remain an active
  rhythmic floor under that unconditional velocity damping.
- The current samples and inherited logs argue against extending steering
  asymmetry again. Applying the half-cycle factor to the LOS redirect still
  captured, but regressed to `20.168T`, distance integral `2.13279L`, and score
  `-0.24199` versus the base LOS sample's `19.706T`, `2.10594L`, and
  `-0.21598`. Response-release (`19.850T`) and course-gated relief (`19.949T`)
  are capture-safe but remain within the two LOS replicas' `19.706--20.036T`
  spread. The reusable target is thus the approach carrier, not another scalar
  redirect or asymmetry adjustment.

## One-candidate hypothesis

Preserve the strongest sampled LOS-led scaffold: the traveling-bend
oscillator and posterior lag, fore/aft-aware body-frame target geometry,
distance/closing amplitude schedule, velocity-course redirect, LOS lead,
half-cycle route steering, and smooth command bounds. Replace only the
always-on approach velocity damping with an orbit-selective brake. Form a
dimensionless oscillator radius from centered anterior angle and anterior
velocity normalized by the scheduled angle-speed scales. Apply the existing
approach damping only to radius above the scheduled orbit, with a bounded
smooth excess gate; below that orbit, leave the state-feedback oscillator free
to rebuild the reduced-amplitude traveling bend.

Expected signature: preserve capture and the coherent far/mid-field wake,
retain a bounded lower-amplitude tail beat after `16T`, and improve arrival or
distance integral by replacing passive terminal coasting with controlled
propulsion. Falsify the mechanism if capture is lost, the terminal path whips
or passes outside the radius, a fresh beat does not appear, residence above
90% of the `31 rad/T^2` command bound materially exceeds the sampled
`35.2%/32.7%`, joint margin worsens from the sampled `0.530/0.587 rad` maxima,
or peak planar force/yaw moment rises materially beyond about `0.0246/0.0131`.

bookshelf_consulted: true
source_domain: classical reactive fish swimming and terminal-approach control
source_mechanism: preserve a posterior-lagged traveling bend while shedding only oscillation-envelope excess during approach
transferable_invariant: reduce excess propulsive amplitude without damping the entire rhythmic state to a static curvature
nontransferable_details: published Strouhal ranges, species envelopes, dimensional cadence, exact vortex phase, source gains, and task-specific routes
policy_translation: compute a bounded excess-orbit gate from centered anterior angle and velocity normalized by scheduled body-frame oscillator scales, and use it to gate only approach damping inside the existing two-joint feedback law
falsification: reject if the reduced-amplitude terminal beat fails to appear, capture timing or distance integral regresses, the path overshoots, or command, joint, force, moment, and wake-coherence bounds worsen
