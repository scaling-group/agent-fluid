# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting cylinder wakes. Every sampled rollout starts
  from this common flow state, so it is an initial condition rather than a
  candidate-specific advantage.
- All four released sheets reach the `0.75L` capture circle on the same useful
  topology: a sharp targetward redirect followed by a coherent, self-propelled
  upstream traverse through the merged wakes. The approximately `-10.92L`
  head displacement while mean local flow is only about `-0.20U` rules out
  passive advection as the main transport mechanism. No sampled failure sheet
  is present; the inherited informative failures remain the bearing-trend
  residual that exited right after `18.304` with negative progress and the
  wholesale slower carrier that became unstable with force/moment RMS
  `16749.8/290421`. These boundaries require preserving the carrier and raw
  bearing's ownership of persistent route authority.
- The phase-restricted yaw-credit prefill reaches in `34.8535` with
  `1.62678L` mean distance, `47153` total command energy, `0.24201` RMS
  relative crossflow, and `82.35/1231.74` RMS force/moment. The strongest
  sampled policy instead credits assisting yaw on either half-cycle and uses
  the maximum normalized two-joint speed to release only surplus redirect
  burst. It preserves the visible route and improves every comparison to
  `34.7105`, `1.62283L`, `46986`, `0.24023`, and `68.96/1036.40`.
- Localizing that same speed release independently to each joint is now an
  evaluated negative result: capture remains, but arrival regresses to
  `34.8590`, mean distance to `1.62681L`, total energy to `47177`, and
  force/moment to `74.24/1105.81` relative to the globally coupled speed gate.
  Thus a fast partner is useful evidence of body-level maneuver pressure; per-
  joint speed alone should not split the coordinated asymmetry. The best
  global policy still touches both joint-speed and `30.0` command limits,
  leaving explicit command headroom as a distinct untested cue.

## Policy hypothesis

Start from the strongest sampled globally coupled speed/yaw-release policy and
add one sign-aware command-headroom reflex. Normalize the previous two-joint
command by the policy-owned acceleration envelope, accept pressure only when a
near-envelope command is aligned with the persistent targetward residual, and
use the maximum pressure across the coupled pair to release only the optional
response burst. Combine this smoothly with the existing speed release. Do not
change the state-feedback carrier, raw-bearing mean steering and reserve,
course-slip correction, base half-cycle asymmetry, posterior lag, or command
envelope.

The prior command is a direct actuator-pressure observation rather than a wake
load estimate. Sharing its maximum across both joints preserves the coordinated
traveling bend that the independent-speed child weakened, while sign gating
avoids treating recovery-side carrier acceleration as redundant targetward
authority. The later CFD rollout must preserve capture and the visible
redirect/upstream topology. Falsify the mechanism if arrival or mean distance
materially regresses without force/moment or limit-contact relief, if load
exceeds the sampled global baseline `68.96/1036.40` without a route benefit, or
if propulsion/capture is lost. This worker does not claim the unevaluated
candidate as evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and adaptive swimming in organized wakes
source_mechanism: retain a coupled rhythmic carrier while observed actuator response releases only surplus maneuver modulation
transferable_invariant: persistent route and propulsion remain authoritative, while bounded state feedback may reduce optional modulation when the coupled actuator response approaches its envelope
nontransferable_details: published gains, robot actuator ratings, dimensional thresholds, species-specific kinematics, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: preserve body-frame bearing, course response, assisting normalized yaw credit, and the established two-joint carrier; combine global normalized joint-speed pressure with sign-aligned prior-command pressure to attenuate only extra response-gated asymmetry
falsification: reject if target capture or coherent upstream propulsion is lost, or if command-pressure relief worsens route, effort, or load against the sampled globally coupled speed-release policy without compensating benefit
