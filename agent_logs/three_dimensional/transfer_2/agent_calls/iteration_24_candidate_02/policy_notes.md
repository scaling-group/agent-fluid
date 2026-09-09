# Persistent-route gait-direction candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled evaluations satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  finite moving-window transport, stable dynamics, and `capture` termination.
  The three byte-identical response-aware samples span
  `19.1620--19.3380T`, distance integrals `2.06924--2.07983L`, and scores
  `-0.18047-- -0.19093`; the distance-only handoff captures at
  `19.3545T/2.07892L/-0.18968`. Exact-policy execution spread is therefore a
  harder acceptance boundary than one scalar rank.
- Both rows of the strongest response-aware sheet (`solver_bf9554cfba28`) and
  the informative weakest exact repeat (`solver_e59354c14c2c`) were inspected
  from clean release through capture. Their top-down views show self-propelled
  target-directed translation, an organized alternating posterior street, and
  the same shallow route followed by a late target-side hook. Their oblique
  views show compact three-dimensional Lambda2 structures shed behind the
  caudal region without passive advection, wake collapse, collision, or
  instability. The candidate must preserve that traveling-wake and capture
  class; the available opportunity is cleaner gait/steering composition.
- The response-aware handoff remains the supported scaffold: two inherited
  executions trace `12.309/12.304L` paths with approximately
  `0.0254/0.0136` peak planar force/yaw-moment coefficients, while replacing
  its route-response signal with course-response regressed to
  `19.398T/2.08187L/12.341L`. A speed-gated middle-field mean-redirect also
  failed catastrophically at `8.750T` after reaching only `11.895L`. This edit
  therefore neither changes the handoff response gate nor extends mean
  redirect outside the validated approach region.
- The inherited proprioceptive carrier governor is another concrete negative:
  attenuating common outward carrier drive near the joint-rate envelope kept
  capture but delayed it to `19.657T`, raised the distance integral to
  `2.09937L`, and scored `-0.20967`, outside both exact response-aware repeats.
  Do not tune that governor or use global amplitude/frequency relief as the
  next actuator fix.
- In the evaluated response-aware code, one rate-braked `turn_command` drives
  both mean steering and joint-phase gait asymmetry. Reconstructing it from
  the logged head, heading, and recent yaw histories shows that it opposes the
  geometry-only body-frame route direction in `1021/3484` (`29.3%`) samples
  for the strongest repeat and `992/3516` (`28.2%`) for the weakest exact
  repeat. The disagreement rises to about `30%` below `2L`. Yaw-rate braking
  can validly reverse mean curvature, but multiplying that fast stabilizing
  reversal by joint velocity also reverses the useful/return-stroke allocation
  inside an otherwise coherent traveling wave.

## One-candidate hypothesis

Preserve the complete evaluated response-aware capture scaffold, including
mean steering with yaw-rate braking, terminal velocity-course redirect,
distance/closing drive relief, posterior amplitude-to-lag endpoints, and the
validated route-request/yaw handoff. Add one channel-separation mechanism:
derive a bounded persistent gait-direction command from body-frame target
bearing alone, and use it only for anterior half-cycle and posterior phase
allocation. Keep the rate-braked command everywhere mean curvature, head bias,
steering acceleration, and response release need fast yaw stabilization.

Expected signature: preserve capture, early milestones, the `12.30--12.31L`
path class, stable load class, joint margin, and both coherent wake views while
reducing beat-to-beat reversals of the steering allocation; support requires
arrival/integral or command/rate residence beyond exact-parent variation or a
meaningfully cleaner useful trajectory without any compensating regression.
Falsify if the persistent gait direction feeds oversteer, lengthens the late
hook, worsens arrival/integral outside parent repeat spread, loses capture, or
regresses command residence, rate margin, loads, or wake coherence. If
falsified, restore the exact response-aware scaffold rather than tuning a
scalar strength for this separation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical asymmetric-flapping turning
source_mechanism: separate the persistent directional command that shapes a propulsive rhythm from the faster measured-yaw feedback that stabilizes mean turning
transferable_invariant: let normalized body-frame target geometry choose the useful half-cycle while measured yaw rate damps mean curvature in a separate feedback channel
nontransferable_details: published gains, dimensional cadence, robot motor models, species-specific duty ratios, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: retain the evaluated two-joint oscillator and mean steering, but compute joint-velocity phase alignment from a bounded target-bearing-only gait command while leaving the rate-braked mean command and route-response handoff unchanged
falsification: reject unless capture, short path, load class, actuator margins, and coherent top-down and oblique wakes are preserved while trajectory or actuator metrics improve beyond exact-parent variation
