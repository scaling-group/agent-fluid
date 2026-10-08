# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

The assigned parent and all four sampled solver examples contain the same
policy (`452903db...`), byte-identical trajectories, and byte-identical
combined keyframe sheets. They are one deterministic direct-uniform
still-water experiment, not four independent control mechanisms. Each captures
at `16.604496T`, reaches `0.743958L`, has a `1.998146L` scored distance
integral, and scores `-0.113729`. The diagnostics confirm
`U_infinity=(0,0,0)`, no cylinders or prewarm, and 237 lossless moving-window
shifts.

In the top-down row, the fish advances toward the target under its own motion
while shedding an alternating red/blue wake; the wake remains attached to the
tail region and does not show a storage-shift discontinuity before capture. In
the oblique row, finite three-dimensional Lambda2 structures appear behind the
body and remain connected to the oscillatory route through the final target
crossing. This is productive propulsion and target-directed steering, not
passive advection. The final sample has substantial translation and yaw, but
the task terminates on the first crossing and therefore supplies no hold or
post-capture failure. All sampled visual evidence is the same successful
trace; no distinct failed keyframe sheet was supplied. The closest informative
failed control in inherited guidance is the closure-qualified yaw-response
release: it crossed one integration step earlier but made the crossing
shallower and worsened distance integral and score to
`0.744276L/1.998380L/-0.114037` without a meaningful feasibility or load
benefit. Other terminal, target-rate, moment, and local-flow residual changes
also failed to improve the demonstrated carrier.

The 237 moving-window shifts are consequently bookkeeping events rather than
observed wake disturbances: four exact trajectories and a visually continuous
two-view wake survive them. A control residual keyed to apparent window motion
would have no evidenced physical error to reject.

## Policy hypothesis

Retain the prefilled response-demodulated full-wave controller exactly as the
single candidate. The current evidence contains neither a noncapturing rollout
nor a repeatable response deficit that can identify a new primitive. A new
terminal gate would repeat a completed negative family, while a scalar-only
gain edit would violate the bookshelf protocol and confound a deterministic
plateau with an optimization signal. Formal evaluation should therefore
reproduce the known capture envelope; any mismatch would itself be new
evidence about determinism or integration. A later mechanism change is
justified only by a completed nonduplicate or held-out pose, target, or flow
that exposes a body-frame route, slip, or load deficit.

bookshelf_consulted: true
source_domain: classical undulatory propulsion and closed-loop robotic-fish steering
source_mechanism: preserve a posterior-emphasized traveling bend and add bounded asymmetry only for an observed directional deficit
transferable_invariant: a coherent traveling-wave carrier should be preserved unless body-frame evidence isolates a propulsion or steering error
nontransferable_details: published gains, dimensional frequencies, species kinematics, exact vortex phase, and task-specific routes
policy_translation: null translation for this candidate; keep the exact full-wave response-demodulated policy because the nominal trace captures and every supplied sample is the same physical trajectory
falsification: reopen one bounded primitive if a nonduplicate or held-out rollout loses capture or repeats a measurable body-frame route, slip, feasibility, or load deficit without an existing negative result
