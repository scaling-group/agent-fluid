# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet confirms the same held fish, four developed and
  interacting vortex streets, and target location for every sampled policy.
- All four current solver examples reach the target. Three copies of the base
  half-cycle controller reproduce `36.4705` arrival, `1.68603L` mean distance,
  `48700.1` total command energy, and `63.586/953.415` force/moment RMS. Their
  keyframes show an immediate clockwise redirect followed by a coherent,
  self-propelled leftward traverse into the second-row wake and capture.
- The distinct response-scheduled child preserves that route topology but is
  visibly farther along at comparable frames. It improves arrival to `34.8205`,
  mean distance to `1.62700L`, and total command energy to `47151.5`, while
  worsening mean command energy to `1354.13` and force/moment RMS to
  `77.090/1142.74`. With `L=64`, the latter moment RMS is about `0.279` in the
  policy's `moment_z_L2` units versus about `0.233` for the replicated base.
- No sampled failure keyframe exists in this workspace. The inherited log for
  the predictive-bearing child is therefore used only as a scalar/topology
  boundary: putting bearing trend into the mean route residual exited the
  domain after `18.304` with negative progress. Response feedback should stay
  localized to the extra redirect mechanism rather than rewrite persistent
  bearing-owned steering.

## Policy hypothesis

Preserve the evaluated response-scheduled child except for one fast-response
release: when the signed, normalized body-frame yaw moment is already turning
the fish in the direction requested by raw bearing, attenuate only the extra
redirect-burst asymmetry. Opposing moment must not withdraw redirect authority,
and base half-cycle asymmetry, mean steering, reserve scheduling, and the
traveling-bend carrier remain unchanged. Use a soft moment scale of `0.25`,
which is bracketed by the two observed rollout RMS levels in normalized units,
as an empirical transition scale rather than a published gain.

Expected result: retain target reach and the compact redirect/upstream route,
with arrival near the `34.8205` parent but lower force/moment RMS and no worse
total effort than the `36.4705` base. Falsify the mechanism if capture is lost,
arrival materially regresses, or force/moment do not fall; a later worker
should then avoid using instantaneous assisting moment as a proxy for useful
yaw response and test joint-limit- or history-gated release instead.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and wake-adaptive swimming
source_mechanism: bounded asymmetric-flapping redirect with sensor-feedback release when the environment already supplies useful yaw
transferable_invariant: keep persistent route error separate from fast observed yaw response, and remove only surplus burst authority when that response assists the requested turn
nontransferable_details: species kinematics, published CPG gains, dimensional timing, exact vortex phase, and any fixed route or cylinder-relative maneuver
policy_translation: raw body-frame bearing retains mean steering and reserve; joint-state phase retains half-cycle steering; same-sign moment_z_L2 softly attenuates only the response-scheduled extra asymmetry
falsification: reject if target reach or compact route is lost, arrival materially regresses, or normalized force/moment load is not reduced relative to the response-scheduled parent
