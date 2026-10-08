# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the fish held above and downstream of four
interacting, fully developed vortex streets; all sampled released sheets start
from that same wake state.  Each of the four sampled policies is self-propelled,
makes the same sharp targetward redirect, then maintains a coherent leftward
traverse through the wake and enters the `0.75L` capture circle.  There is no
sampled failure keyframe in this workspace, so the visual comparison uses the
strongest finite variants and the inherited documented failure boundary: a
bearing-trend residual placed in persistent steering destroyed upstream
propulsion and exited right after `18.304`.

The two ungated response-burst copies are identical (`34.8205` arrival,
`1.62700L` mean distance, `47151` total command energy, `77.09/1142.74`
force/moment RMS).  Crediting every assisting-sign yaw moment preserves the
visible route and gives up only `0.1210` arrival time while reducing load to
`71.86/1064.16`.  Restricting that moment credit to the anterior joint's
targetward half-cycle recovers `0.0880` arrival time and slightly improves mean
distance/mean effort, but raises load to `82.35/1231.74`, worse than both the
ungated burst and all-moment credit.  All three variants still touch the
`30.0` acceleration envelope and the joint-speed limit.  Thus joint targetward
phase is not an evidenced unloading proxy; the remaining testable opportunity
is to release only the extra response burst as joint-speed headroom disappears,
without changing carrier, mean steering, reserve, course feedback, base
half-cycle asymmetry, or signed moment credit.

## Policy hypothesis

Add a smooth joint-state speed-headroom reflex to the existing extra redirect
burst.  Normalize the largest observed joint speed by the carrier's endogenous
`omega * amplitude` speed scale, leave the burst unchanged below a soft onset,
and progressively withdraw only a bounded share above it.  This is a structural
limit-aware release, not a scalar gait retune.  It should preserve the sampled
redirect/upstream topology because persistent bearing authority and base
asymmetry remain untouched, while reducing high-speed overlap between surplus
burst and the saturated carrier.  The later CFD evaluation falsifies the
hypothesis if capture is lost, arrival/mean distance materially regress without
a load or limit-contact benefit, or force/moment and saturation do not improve.

bookshelf_consulted: true
source_domain: Karman-wake fish interaction and sensor-modulated robotic-fish CPG control
source_mechanism: organized wake loading can reduce active effort, while closed-loop feedback modulates a rhythmic controller without replacing its propulsive phase generator
transferable_invariant: preserve propulsion and persistent route ownership, and use bounded observed-state feedback to release only surplus turning modulation when endogenous response approaches its envelope
nontransferable_details: exact vortex phase, single-cylinder synchronization, trout muscle timing, robot morphology, published gains, dimensional frequencies, and task-specific routes
policy_translation: normalize two-joint speed by the state-feedback carrier speed scale and smoothly attenuate only the extra response-gated half-cycle burst; retain raw body-frame bearing steering, signed normalized yaw-moment credit, and the established carrier
falsification: reject if target reach or coherent leftward propulsion is lost, or if later evaluation shows no meaningful load/limit benefit for any arrival or route cost
