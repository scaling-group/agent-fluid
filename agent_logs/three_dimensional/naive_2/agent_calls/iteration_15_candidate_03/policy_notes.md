# Terminal posterior-pulse candidate

## Evidence and visual diagnosis before editing

The sampled and inherited rollouts use direct uniform still water with
`U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected the combined
top-down vorticity and oblique Lambda2 sheets for the sampled predicted-miss
capture, the late-turn posterior-bend failure, and the assigned parent's
completed response-gated rollout. The fish are self-propelled: each useful
trajectory leaves a body-connected alternating wake with compact 3D
structures. The relevant failures are interception/control failures rather
than passive advection, absent thrust, or numerical instability.

The sampled predicted-miss policy captured once at `16.01T` and `0.74772L`
with head `(9.656,9.140)L`; an inherited repeat of the identical policy and
configuration missed at `0.96311L` and escaped lower-left. The parent's next
response-gated handoff retained rhythmic steering until carrier-separated yaw
became corrective. Its current sheet shows the same coherent approach at
`16T`, a pass just below the capture circle, and then a strong downward escape;
the trajectory confirms a closest head position `(9.597,8.952)L`, distance
`0.81002L`, and world velocity about `(-1.092,-0.234)L/T`. Thus response gating
materially recovered `0.153L` of the repeated miss but did not change
termination. The inherited capture/repeat evidence also reports zero joint
angle dwell above `40 deg` and nearly identical low peak normalized planar
force/moment scales near `0.03/0.017`, so neither broad carrier braking nor
stronger carrier/load relief addresses the remaining `0.060L` margin.

At closest approach the target is still on the requested side in the body
frame and the measured course continues across its lower edge. The response
gate therefore improved when the rhythmic steering channel was released, but
it still relies on the same shared acceleration asymmetry plus persistent mean
curvature. Earlier tail-only far-field steering and static-curvature variants
were weak; that evidence does not test a terminal, joint-phase-gated posterior
wave-shape actuator layered on the proven intercept.

## Single candidate hypothesis

Start from the completed response-gated predicted-miss controller, preserving
its joint-state traveling bend, early body-frame time-to-closest/signed-miss
gate, bounded mean curvature, and yaw-confirmed half-cycle handoff. Add one
terminal actuator: while the target is still closing and the predictive or
proximity gate requests a turn, bias only the posterior lag target toward the
requested side in proportion to normalized anterior-joint speed. This creates
a smooth mid-stroke posterior bend pulse, but vanishes near beat reversal,
after closest approach, and outside the terminal intercept. Both carrier
half-cycles and the anterior oscillator remain intact.

Support requires repeat capture or a closest pass below `0.81002L` with a
better recovery/termination, while retaining the compact wake, zero `>40 deg`
dwell, and roughly `0.03/0.017` normalized load scale. Falsify on degradation
of the far-field predicted-miss approach, another lower-left escape without a
closer pass, posterior pinning, increased rate/angle dwell or loads, or loss of
the alternating wake. Because the current new CFD evaluation occurs only
after this worker exits, these are hypotheses rather than claimed outcomes.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal fish capture maneuvers
source_mechanism: preserve the propulsive rhythm while target feedback briefly reshapes posterior motion during the force-producing part of a beat
transferable_invariant: recruit bounded posterior wave-shape authority from measured target-relative miss and joint phase, then release it at beat reversal or when the target stops closing
nontransferable_details: published CPG gains, clock phase, robot linkage geometry, species-specific curvature and timing, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame target and velocity to retain the predicted-miss gate, and add a reflection-equivariant target-signed posterior offset scaled by normalized anterior-joint speed under the two-joint state-feedback contract
falsification: reject if capture margin or termination fails to improve together, or if wake coherence, joint reserve, load scale, reflection symmetry, or far-field translation degrades

## Dry validation only

The mandated guidance-materiality, lightweight Julia contract/schema, and
editable-boundary checks pass after removing a duplicated assigned-parent
marker from the rendered workspace `README.md`. All `28` direct
`params.FIELD` references are returned by `target_policy_params()`. A
`26,244`-state grid spanning fore/aft and lateral target geometry, body-frame
velocity, both joint angles/rates, and yaw response produced finite commands
strictly inside the smooth `30 rad/T^2` envelope and exact left/right
reflection (maximum error `0.0`). Switching only the new posterior pulse off
changed a constructed closing terminal action by `0.1753 rad/T^2`, while its
effect at a `12L` target was `2.7e-9 rad/T^2`. These checks establish schema,
boundedness, symmetry, and gate semantics only; no CFD was run here.
