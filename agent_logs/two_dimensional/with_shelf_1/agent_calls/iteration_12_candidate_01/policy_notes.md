# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting cylinder wakes, with the target inside the merged
  second-row wake. This is the common initial condition, not evidence for a
  controller difference.
- All four sampled released sheets reach the target on the same compact
  redirect-and-upstream topology; no sampled released failure sheet exists.
  Their coherent posterior trails, about `-10.91L` head displacement in x,
  and mean upstream body speed near `-0.31U` against mean local flow near
  `-0.20U` show active propulsion rather than passive advection. The inherited
  bearing-trend failure remains the semantic boundary: moving a fast response
  term into persistent route steering produced negative progress and a right
  domain exit after `18.304`, so raw-bearing mean authority and the carrier
  must remain intact.
- The ungated response-scheduled parent is the best arrival baseline:
  `34.8205` release time, `1.6270L` mean distance, `47151` total command
  energy, and `77.09/1142.74` RMS force/moment. Its keyframes show a sharp
  initial redirect, sustained upstream swimming, and direct first entry into
  the `0.75L` target circle, so terminal scheduling is not the missing role.
- A phase-agnostic signed assisting-moment gate preserves the visible route
  and gives back only `0.1210` arrival time while reducing RMS force/moment to
  `71.86/1064.16` (about `6.8%` each). In contrast, multiplying the same yaw
  credit by anterior-joint targetward phase reaches at `34.8535` but raises
  RMS force/moment to `82.35/1231.74`, above even the ungated parent. Joint
  phase already defines half-cycle steering; using it again to decide whether
  observed yaw counts as response is therefore contradicted by the sampled
  load evidence.
- Both the ungated parent and moment-gated siblings touch the joint-speed and
  `30.0` acceleration limits. The current evidence supports preserving the
  posterior traveling bend and targetward burst while testing whether useful
  environmental yaw can relieve surplus anterior redirect authority only.

## Candidate policy hypothesis

Preserve the parent's oscillator, posterior lag, course-slip correction,
raw-bearing reserve, mean steering, base half-cycle asymmetry, and
bearing-response-scheduled burst. Add one joint-role-separated response-credit
mechanism: classify normalized body-frame yaw moment by the smooth raw-bearing
sign, and use assisting yaw to attenuate only the extra anterior-joint burst.
The posterior joint retains its complete response-scheduled asymmetry so tail
propulsion and targetward wave shaping are not withdrawn. Opposing moment does
not remove authority, and neither the carrier nor mean steering is gated.

Expected test: preserve capture and the coherent redirect/upstream traverse,
recover route and arrival toward the ungated parent's `34.8205` while retaining
a material part of the signed gate's load reduction from `77.09/1142.74`.
Reject the mechanism if capture or upstream propulsion is lost, arrival exceeds
the fixed-half-cycle `36.4705` baseline, load returns fully to or exceeds the
ungated parent, or joint-role separation adds effort without a route or load
benefit. The new CFD evaluation happens after this worker exits, so no
same-worker improvement is claimed.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG turning in wake interaction
source_mechanism: posterior motion sustains reactive thrust while measured directional response relieves only surplus anterior maneuver authority
transferable_invariant: keep posterior propulsion and persistent body-frame route authority active while environmental yaw earns bounded credit only in the actuator role responsible for redirect rather than thrust
nontransferable_details: published gains, dimensional moment scales, robot actuator ratings, species kinematics, clocked phases, exact vortex phases, and source-task routes
policy_translation: use the smooth raw-bearing sign and normalized `moment_z_L2` to attenuate only response-scheduled asymmetry above the base value on joint 1; retain the full joint-2 asymmetry, both carriers, mean steering, and raw-bearing reserve
falsification: reject if capture or coherent leftward propulsion is lost, if arrival exceeds the fixed-asymmetry baseline, or if force/moment return to the ungated parent without a compensating route or effort benefit
