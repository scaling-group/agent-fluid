# Wake-policy candidate notes

## Evidence diagnosis

- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. All four sampled release sheets
  begin from that same flow state, execute a sharp targetward redirect, sustain
  a coherent self-propelled upstream traverse, and enter the `0.75L` capture
  circle. Their roughly `-10.92L` head displacement in x and mean fish velocity
  near `-0.31U`, compared with mean local flow near `-0.20U`, rule out passive
  advection as the main transport mechanism. No sampled sheet is a semantic
  failure, so the inherited bearing-trend controller that exited right after
  `18.304` with negative progress remains the failure boundary for putting a
  fast response signal into persistent route authority.
- The two ungated response-burst copies reproduce `34.8205` arrival,
  `1.62700L` mean distance, `47151` total command energy, `0.24143` RMS relative
  crossflow, and `77.09/1142.74` force/moment RMS. Restricting assisting-moment
  credit to the anterior targetward half-cycle reaches at `34.8535` but raises
  load to `82.35/1231.74`; joint phase alone is not an unloading signal.
- The sampled speed-pressure plus assisting-moment policy preserves the same
  visible route while improving every listed comparison with the ungated
  response burst: `34.7105` arrival, `1.62283L` mean distance, `46986` total
  energy, `0.24023` relative crossflow, and `68.96/1036.40` force/moment RMS.
  It still touches the joint-speed and `30.0` acceleration limits, so the
  evidence supports normalized speed as a cue for releasing only surplus
  redirect burst, not a claim that saturation is solved or that speed measures
  hydrodynamic load.

## Policy hypothesis

Use the best sampled speed-pressure/assisting-moment controller as the
evaluated baseline and change one actuator-allocation mechanism. The sampled
version uses the maximum absolute speed of either joint to withdraw extra burst
from both joints. Instead, compute the same normalized speed pressure per
joint, then attenuate only that joint's optional response burst. Raw-bearing
mean steering and reserve, course-slip feedback, the base half-cycle
asymmetry, the propulsive carrier, and assisting-moment credit remain shared
and unchanged. This should retain unloading where a joint approaches its
response envelope without allowing a fast posterior or anterior joint to
silence useful redirect modulation on its partner.

Expected evidence is target capture with the same redirect/upstream topology,
arrival and mean distance no worse than the sampled `34.7105/1.62283L`
baseline, and force/moment remaining below the ungated `77.09/1142.74` pair.
Falsify actuator-local allocation if capture is lost, route or effort
materially regresses without a load benefit, or independent asymmetries raise
crossflow/load above the sampled global-release baseline. A changed wake phase
is still required before claiming robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and adaptive swimming in organized wakes
source_mechanism: preserve the propulsive rhythm and route request while observed actuator response releases only surplus maneuver modulation
transferable_invariant: bounded state feedback should unload the actuator approaching its response envelope without withdrawing persistent route authority or unrelated propulsive authority
nontransferable_details: published gains, dimensional speed thresholds, robot actuator ratings, species-specific kinematics, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: normalize each joint speed by the endogenous `omega * amplitude` carrier scale and attenuate only that joint's extra bearing-response half-cycle burst; retain body-frame bearing, course, and signed normalized yaw response in their evaluated roles
falsification: reject if target capture or coherent upstream propulsion is lost, or if actuator-local relief worsens route, effort, or load against the sampled global-release controller without a compensating benefit
