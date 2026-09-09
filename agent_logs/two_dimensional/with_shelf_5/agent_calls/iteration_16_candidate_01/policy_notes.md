# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  mature, interacting cylinder streets. It fixes the common release field but
  does not distinguish policies.
- All four sampled released sheets show the same useful topology: one decisive
  downward-left redirect, a sustained posterior traveling bend, upstream-left
  transit into the interacting wake corridor, and first crossing of the
  `0.75L` target circle without collision, domain exit, or route-scale yaw
  reversal. For the fastest sample, head velocity from displacement and elapsed
  time is about `(-0.269,-0.104)L/time`, versus mean local flow
  `(-0.149,-0.162)`, so the upstream transit is self-propelled rather than
  passive advection. No sampled solver supplies a released failure keyframe;
  the inherited naive-seed lower-boundary exit is retained only as metric-backed
  context, not given an unseen visual interpretation.
- The guarded, fully history-filtered parent is reproduced twice at `41.4205`
  release time, `2.0142L` mean distance, command energy `53377`, and RMS
  crossflow/force/moment `0.2253/63.05/872.36`. Its sheet shows a compact direct
  approach, but the strong alternating body wake agrees with the high measured
  load rather than demonstrating disturbance rejection.
- The fastest sample separates the circular-history route request from a
  current-bearing posterior half-cycle request and has no directional rate
  guard. Against the inherited matched unguarded, fully history-driven rollout,
  it preserves the direct topology while improving arrival from `41.5030` to
  `40.6285`, mean distance from `2.0216L` to `1.9759L`, and command energy from
  `53802.7` to `52374.2`. This isolates a useful route/effort effect from the
  sensory split. However, RMS force/moment rise from `61.80/862.48` to
  `63.65/868.82`, so the inherited claim that the split would also relieve
  loads is falsified.
- The lower-load unfiltered guarded sample reaches later at `43.9505` but has
  RMS crossflow/force/moment `0.2093/44.47/657.47`. Inherited logs show that the
  guard preserved every reversal and the unfiltered carrier's arrival, while
  amplitude transitions, extra beat-phase selectors, terminal localization,
  and a raw yaw-moment residual were negative or dominated directions.

## Policy hypothesis before the edit

Test one isolated observation-path change on the guarded parent. Preserve the
circular-history bearing for anterior mean curvature and for the guard's
large-error alignment decision, but drive posterior target-favored half-cycle
asymmetry from current body-frame bearing. Keep the oscillator, approach
envelope, posterior lag, directional outward-rate projection, all numerical
parameters, and every reversal equation unchanged. This assigns the slow
persistent target estimate to route curvature while letting posterior steering
release immediately as observed bearing converges. This tests whether the
isolated split benefit survives addition to the response-conditioned actuator
boundary already present in the assigned parent.

Expected evidence is preservation of target success and the direct route, with
arrival and mean distance approaching the split sample's `40.6285`/`1.9759L`
while effort or loads improve over its unguarded result. Falsify the mechanism
if capture is lost, arrival does not beat the guarded parent's `41.4205`, the
trajectory topology changes, or RMS load/effort remains no better than the
unguarded split. If falsified, do not tune the history blend, half-cycle width,
or rate thresholds; the completed comparisons would show that the individually
useful sensory split and directional projection do not compose.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and adaptive wake swimming
source_mechanism: separate slow persistent route estimation from fast bounded corrective steering while preserving a rhythmic carrier
transferable_invariant: distinct observed timescales should own distinct bounded control roles, with persistent target geometry selecting mean route and current target error releasing immediate steering
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, recurrent architecture, exact vortex phase, source history length, cylinder coordinates, and task-specific routes
policy_translation: circularly averaged normalized body-frame bearing drives anterior curvature and redirect gating; current normalized body-frame bearing drives posterior joint-state half-cycle asymmetry under the existing two-joint feedback contract
falsification: reject if direct target capture degrades, arrival and mean distance fail to improve over the guarded parent, or effort and load evidence remains no better than the unguarded split sample
