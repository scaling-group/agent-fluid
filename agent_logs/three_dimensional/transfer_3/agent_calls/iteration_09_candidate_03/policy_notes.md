# Two-joint line-of-sight-rate allocation candidate

## Evidence diagnosis recorded before the policy edit

- Every sampled and inherited diagnostic reports direct uniform initialization
  in still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The
  combined sheets show self-generated motion: the useful long trajectories
  retain alternating top-down reverse-wake streets and finite oblique Lambda2
  structures rather than being advected by background flow.
- The sampled line-of-sight-rate controller is the only recent mechanism to
  improve the route materially. It retains the coherent carrier for `30.12T`,
  lowers the target-x-station pass from about `4.22L` high for the sampled
  slip controller to `3.495L` high, and reaches `3.369L` instead of
  `4.128--5.658L`. It remains finite, but passes the target and exits left with
  final range `8.689L`; this is useful route-response evidence, not success.
- The assigned parent's direct half-cycle asymmetry is a strong negative
  actuator test. Its top-down and oblique rows curl upward near the release
  point without forming the long downstream wake of the coherent carriers; it
  exits at `8.62T`, reaches only `12.175L`, and finishes at `12.479L`. The
  inherited response-damped half-cycle variant repeats the same topology at
  `8.70T` with a `12.072L` minimum. Half-cycle tuning should therefore not be
  continued on this carrier.
- The inherited geometry-gated common C-bend is also not a positive transfer:
  it retains propulsion but reaches only `4.467L`, exits left at `28.31T`, and
  finishes `10.299L` away. Recruiting a same-sign two-joint bend only after the
  target becomes abeam/behind is too late and regresses the useful route.
- In the line-of-sight-rate trace, positive route yaw is already clamped at
  `0.50 rad/T` from roughly `12T` through closest approach, yet posterior raw
  acceleration exceeds the `1800 deg/T^2` adapter envelope in `4053/5477`
  samples and posterior excursion reaches `0.584 rad`. At the `19.39T`
  target-station crossing the head is at `(9.002,12.995)L`; at the `20.43T`
  minimum it is at `(8.147,12.760)L`. The remaining miss is therefore
  consistent with late, posterior-only route authority, not a missing scalar
  bearing gain or a collapsed propulsive wake.

## Policy hypothesis recorded before editing

Start from the evidenced line-of-sight-rate controller without changing its
carrier, normalized body-frame bearing/rate geometry, response gate, or
phase-separated yaw estimate. Keep the bounded posterior mean-curvature
response, but allocate the same yaw-rate residual to a small anti-signed
anterior oscillator center. The inherited common-bend trace supplies the
polarity: positive anterior center produces negative rigid yaw, so the
anterior center must oppose the signed yaw residual while the posterior center
follows it. Centering the Van der Pol wave on that feedback bend preserves
oscillation and releases the added authority when measured yaw catches the
route demand.

This is one compact actuator-allocation mechanism, not a gain-only variation.
It should begin the useful downward route response before the posterior-only
loop saturates, cross the target station below `y=12.995L`, and retain the long
alternating wake. Accept stronger evidence as a minimum below `3.369L`, a
better termination class, or a meaningfully different return trajectory.
Reject it if either short upper-exit topology returns, the target-station pass
does not lower, anterior joint-angle saturation appears, or the coherent wake
and minus-x propulsion weaken.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological mean-curvature redirection
source_mechanism: sensory yaw-response feedback distributes a bounded mean bend across available joints while a propulsive rhythm remains active
transferable_invariant: when one steering joint is authority-limited, allocate the observed route-response residual across available bending joints and release the bend from measured response rather than elapsed time
nontransferable_details: published gains, species C-start kinematics, robot linkage geometry, clock phase, dimensional beat rates, exact vortex phases, and task-specific routes
policy_translation: preserve the joint-state traveling carrier and normalized body-frame bearing/line-of-sight-rate demand; map the phase-separated yaw residual to opposite-polarity bounded anterior and posterior centers in the two-joint state-feedback contract
falsification: reject if the target-station height does not improve on 12.995L, the 3.369L minimum or left-exit topology is not improved, joint saturation grows, or either visual row loses coherent self-propulsion
