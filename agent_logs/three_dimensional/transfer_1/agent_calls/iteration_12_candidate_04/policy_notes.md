# Wake-policy candidate diagnosis

## Evidence read before editing

- The sampled and inherited episodes report direct uniform initialization in
  still water with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their
  translation and wakes are therefore self-propelled, not ambient advection.
- Both rows of the combined keyframe sheets were inspected for the sampled
  `0.74934L` capture and the `1.26695L` opposing-half failure. The capture
  sustains an alternating top-down vortex street and compact oblique Lambda2
  structures through its `18.6065T` crossing. The opposing-half candidate
  initially has the same useful wake, but joint excursion and new vortex
  release collapse after its lower pass and it coasts to `left_domain`.
  Their metrics agree with the visual distinction: capture versus a lower
  `1.26695L` pass, not instability or imposed flow.
- The assigned parent's newest posterior-lag transfer was also inspected in
  both views. It retains a substantial alternating wake but makes a sharp
  lower pass, reaches only `1.68181L`, and exits low. The other inherited
  joint-phase weighting similarly reaches only `1.74558L` and exits low.
  These two completed regressions close the inherited proposal to test a
  separately bounded phase-selective wave-shape actuator: neither beats the
  earlier `0.9532L` carrier-aligned pass or changes termination class.
- At closest approach the sampled capture has yaw moment `-0.00550` with its
  positive course-turn request, whereas the two new phase-selective failures
  have opposing moments `+0.01047` and `+0.01329`. Across terminal rows, not
  just those points, replaying the sampled LOS-release calculation shows that
  release-active rows in the two failures have median signed assisting load
  about `-0.0104`, compared with `-0.0042` in the capture. Thus the existing
  phase-compensated rate can declare a response while the instantaneous
  hydrodynamic yaw load is strongly undoing that response.
- A conservative trace replay using a smooth adverse-load interval
  `0.004--0.010` retains about `64.8%` of the capture's release integral but
  only `17.5--20.6%` in the two newest failures. This is state
  discrimination on fixed traces, not a CFD prediction; closed-loop dynamics
  can invalidate it.

## Candidate mechanism and falsification

Start from the sampled LOS-guarded achieved-course controller, preserving its
state-feedback traveling carrier, cadence, outer course error, shared bounded
steering, yaw-response release, and inertial LOS miss guard. Add one measured
hydrodynamic-response coherence veto inside the existing terminal release:
when normalized yaw moment strongly opposes the current body-frame course-turn
request, smoothly re-engage the already-existing steering. Neutral or
assisting load leaves the response release unchanged. This does not amplify
steering, attenuate a carrier half-cycle, change posterior lag, add a route, or
use a clock or mutable phase.

Expected test: retain the captured controller's far-field route and coherent
wake while preventing a beat-phase yaw-rate response from releasing steering
into a strongly adverse hydrodynamic load; improve capture repeatability or at
least beat the `0.9532L` carrier-aligned pass without raising saturation or
loads.

Falsification: reject the load-coherence veto if behavior outside the existing
terminal gate changes, minimum distance does not beat `0.9532L`, the same
lower-exit topology remains, the alternating wake weakens, or action
saturation and hydrodynamic loads increase. Then instantaneous moment is too
phase-contaminated for this release decision; later workers should test a
genuinely slow yaw/slip response observable rather than another moment scale,
joint-phase allocation, collision corridor, or scalar course gain.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish direction control
source_mechanism: separate fast alternating hydrodynamic yaw disturbances from persistent target-directed route response
transferable_invariant: release a bounded route correction only when measured hydrodynamic response does not strongly oppose the requested body-frame turn
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact vortex phases, wake layouts, and task-specific routes
policy_translation: multiply the existing terminal response release by a smooth veto from the reflection-even product of body-frame turn request and normalized yaw moment, while preserving the two-joint carrier and steering envelope
falsification: reject if far-field closure changes, the sub-0.9532L pass or termination class does not improve, saturation or loads rise, or the coherent alternating wake deteriorates
