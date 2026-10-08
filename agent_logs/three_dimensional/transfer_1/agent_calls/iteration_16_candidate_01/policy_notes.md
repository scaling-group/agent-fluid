# Candidate diagnosis and hypothesis

The four sampled rollouts are direct-uniform still-water evaluations, and all
capture without instability.  The combined top-down/oblique sheets for the
strongest sample (`solver_915722c373dc`) and the most informative regression
(`solver_86374a6bd3ab`) show self-propulsion rather than advection: an
alternating wake appears by `4T`, remains coherent through the curved approach,
and has no visible collapse before capture.  The sheets are nearly
indistinguishable at their coarse sampling, so the remaining opportunity is a
route/propulsion allocation change, not a stronger global oscillation or wake
repair.

The trace supports that diagnosis.  Closing-response carrier release improves
the whole-wave-pose parent from capture at `18.99699T`, score `-0.18597`, and
distance integral `2.07455L` to `18.754995T`, `-0.17114`, and `2.05886L`.  It
is `0.026/0.138/0.240/0.212L` closer at `8/12/16/18T`, while any-joint
acceleration-limit residence falls from about `43.60%` to `42.08%`.  The cost
is a modest mean/max speed increase from `0.676/0.927` to `0.686/0.949L/T`
and essentially unchanged peak normalized force/moment (`0.03068/0.01564`).
Conversely, centering the half-cycle detector regresses capture to
`19.03549T` and the integral to `2.08993L` despite the same organized wake,
and bidirectional steering recovery reaches `18.87049T` but trails the
closing-response parent.  Therefore this candidate preserves raw
mean-informed half-cycle steering, one-way head-to-tail steering spillover,
whole-wave pose projection, and the successful closing-response cadence gate.

Policy hypothesis: a small posterior-lag residual, admitted only when positive
normalized closing response is established, the target is still outside the
approach region, and normalized steering load leaves route authority, should
turn part of the evidenced carrier release into posterior reactive thrust
without disturbing the mean bend.  This is a state-gated wave-shape mechanism,
not a global amplitude/frequency gain change.  It should beat the assigned
parent's arrival/integral while retaining capture, the coherent alternating
wake, and approximately its speed, saturation, and load envelope.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and closed-loop robotic-fish gait modulation
source_mechanism: Posterior wave kinematics supply much of reactive thrust, while sensor response gates the release from steering into stronger propulsion.
transferable_invariant: Preserve target-signed mean curvature and add posterior emphasis only after normalized state feedback shows useful closure with spare steering authority.
nontransferable_details: Published full-body envelopes, dimensional frequencies, oscillator gains, species kinematics, exact phases, and task routes are not used.
policy_translation: Add one bounded positive-closing posterior-lag residual using body-frame closing response, normalized distance, and turn load; keep the two-joint state-feedback oscillator and final actuator projection unchanged.
falsification: Reject if capture is lost, arrival or distance integral regresses, the alternating wake decoheres, or max speed, acceleration-limit residence, peak force, or peak moment materially exceeds the assigned parent's `0.949L/T`, `42.08%`, `0.03068`, and `0.01564` envelope.
