# Wake-policy candidate notes

## Evidence diagnosis

All four sampled evaluations satisfy the experiment contract: direct uniform
initialization, `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite dynamics,
and `capture` termination. The combined sheets were inspected from release to
termination in both the top-down vorticity and oblique Lambda2 rows. They show
the same self-propelled, body-led alternating wake and a smooth target crossing;
there is no visible wake breakup, passive advection, collision, domain exit, or
numerical instability. Because this sample contains no semantic failure, the
slowest distinct stress-gated residual is the informative negative control,
not a failed rollout.

The two exact actuator-consistent parent replicas both capture at `18.6725T`,
while score varies from `-0.13362` to `-0.13219`. Their local-flow RMS is
`0.01809--0.01816U`, anterior/posterior acceleration-limit occupancy is
`40.8--42.2% / 75.5--76.1%`, and force/moment RMS is
`0.01331--0.01350 / 0.00693--0.00703`. Helpful-moment relief is only `0.0165T`
faster and remains inside inherited same-policy timing variability. The
stress-confirmed moment residual instead delays capture to `18.7440T`; its
`41.5% / 75.5%` occupancy and `0.01343 / 0.00699` force/moment RMS do not
separate from the parent. These metrics agree with the nearly indistinguishable
wake sheets: another instantaneous moment allocator is not supported.

The useful trajectory still contains broad carrier-correlated yaw excursions.
The existing recoil-conditioned response is
`heading_rate + 0.82*phi_dot1 + 0.12*phi_dot2`. As an offline diagnostic only,
I compared it with a centered `0.55T` yaw average computed from each completed
trace. Its RMSE is `0.756--0.768 rad/T`. A compact odd phase-conditioned model
using normalized anterior angle and velocity reduces that diagnostic RMSE to
`0.123--0.127 rad/T` across both exact-parent replicas and both actuator
controls. The centered average is not read by the policy; it only falsifiably
supports an instantaneous joint-state observer that separates fast recoil from
route-scale yaw.

## Policy hypothesis

Preserve the evaluated normalized LOS C-bend, traveling carrier, persistent
same-side posterior phase recruitment, and feasible action projection exactly.
Change only the measured-yaw observer: use rollout-supported linear joint-rate
recoil terms plus two reflection-odd anterior phase terms formed from
`phi1/A` and `phi_dot1/(omega*A)`. This should stop the inner yaw loop from
treating a predictable portion of carrier recoil as route error, reducing
unproductive steering reversals without suppressing the coherent wake. It is a
model-form test, not scalar-only gain tuning.

Reject the hypothesis if the new CFD rollout loses capture, leaves the sampled
`18.656--18.744T` arrival band, weakens either wake view, or exceeds the exact
parent's `42.2% / 76.1%` acceleration occupancy or
`0.01350 / 0.00703` force/moment RMS. Also reject it if the offline beat-average
fit proves non-causal in closed loop and creates a meaningfully different but
less useful route.

bookshelf_consulted: true
source_domain: robotic-fish CPG feedback and wake-interaction signal separation
source_mechanism: condition sensed body response on oscillator phase so fast carrier recoil is not treated as slow route error
transferable_invariant: compare slow route demand with a carrier-conditioned response while preserving a directed posterior-lag traveling bend
nontransferable_details: published gains, species kinematics, exact CPG or vortex phase, dimensional frequency, and task-specific routes
policy_translation: add normalized reflection-odd anterior joint-phase features only to the existing yaw-response observer; retain the two-joint carrier, LOS route law, phase actuator, and limits
falsification: reject on lost or delayed capture, incoherent wake, increased saturation or load, or evidence that the offline beat-average proxy does not improve causal closed-loop response
