# Wake-policy candidate notes

## Evidence diagnosis

All four sampled rollouts use direct uniform still-water initialization and
capture with a self-propelled, coherent alternating wake in both the top-down
mid-plane and oblique Lambda2 views. The strongest two source variants are
trajectory-identical at `15.735508T`, distance integral `1.919818L`, and score
`-0.037222`. Their carrier-demodulated adverse-moment correction advances every
`8/6/4/2/1.25L` milestone relative to the inherited no-moment result at
`15.768509T` and `1.924067L`. The informative failure is the added
moment-plus-lateral-force consensus curvature: it preserves the visible wake
but delays every milestone, reaches `15.746509T`, and regresses the integral to
`1.921600L`. The odd-harmonic veto also delays all milestones and reaches
`15.741009T`, `1.920970L`; refining or corroborating the disturbance estimate
does not justify more steering authority.

The assigned parent adds translational terminal damping to the positive
moment-only controller, but its sampled trajectory and wake sheet are exactly
identical to moment-only. The reusable carrier, axial-response wave allocator,
base redirect, and established terminal shaping should therefore remain
unchanged. No inherited optimizer-log artifact is present under `logs/` in the
rendered workspace; the parent guidance retains its distilled inherited-log
comparisons, and the current solver traces provide the candidate-specific
cross-check.

## Policy hypothesis

Hand the existing anticipatory moment-residual correction back to the base
redirect as soon as carrier-demodulated yaw response is target-aiding.
Specifically, attenuate only `moment_redirect_curvature` by the complement of
a bounded, reflection-even gate on target-signed yaw residual. If target-aiding
non-carrier yaw disappears, the moment correction reopens continuously. A raw
heading-rate version is rejected by the parent trace: carrier motion masks it
at the final action selector, leaving only `76/2861` changed outputs with a
maximum difference of `0.0046 rad/T^2`, mostly during startup. Subtracting the
existing joint-phase yaw prediction gives genuine route support: replaying the
candidate law pointwise changes `80/2861` posterior actions, by as much as
`0.566 rad/T^2`, mainly from `4T` to `8T`. It changes neither the anterior
carrier nor posterior wave command directly. This should reduce oversteer
after the anticipatory moment signal has done its job without repeating the
failed extra-curvature or terminal-slip branches.

Accept the mechanism only if it preserves capture and the coherent two-view
wake while advancing a route milestone or lowering distance integral. Reject
it if the moment correction releases before a useful yaw response, delays any
established milestone, increases force/limit exposure materially, reproduces
the parent trajectory, or loses capture.

bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed course error opens bounded curvature, then measured target-aiding yaw releases supplemental redirect authority
transferable_invariant: anticipatory steering should hand off continuously to measured body response instead of persisting after the requested response appears
nontransferable_details: species-specific C-start shape, published CPG gains, dimensional timing, exact tail-beat or vortex phase, and task-specific routes
policy_translation: preserve the normalized joint-state traveling bend and base body-frame redirect; subtract the existing joint-phase yaw prediction and multiply only the carrier-demodulated moment-residual curvature by one minus a smooth gate of target-signed normalized yaw residual
falsification: reject if capture, wake coherence, milestones, distance integral, force envelope, or limiting regresses, or if the gate is trajectory-equivalent
