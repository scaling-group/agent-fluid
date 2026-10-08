# Multi-wake candidate diagnosis

## Evidence read before the edit

- The assigned parent contains only the generic fresh-lineage guidance; no
  inherited `logs/optimize/` result was materialized in this workspace. The
  only sampled controller is therefore the deliberately naive seed, so its
  early finite motion and its terminal failure are the available comparison.
- The shared prewarm sheet shows the held fish at the upper-right release pose
  after the four cylinder streets have developed and merged across the target
  corridor. This is common initial-condition evidence, not policy evidence.
- In the released sheet the seed visibly self-propels, but turns from its
  initially useful diagonal pose into a steep descent along the right side. It
  never enters the wake corridor around the target. Its closest approach is a
  transient `8.61495L`; it then exits the lower boundary after `50.1269` time
  units at `12.1226L` from the target. The corresponding progress is only
  `0.02425`, with head displacement `(-3.545, -13.300)L`.
- The JSON diagnostics and metrics agree with the visible lateral ejection:
  maximum lateral target offset reaches `9.007L`, while both joints hit the
  exact `260 deg/time` velocity and `1800 deg/time^2` acceleration caps.
  Command-energy mean is `1496.25`, RMS lateral force is `21.94`, and RMS
  moment is `541.70`. Thus the large motion is not evidence of useful wake
  traversal; it is saturated target-blind propulsion followed by domain exit.

## Policy hypothesis

Retain a state-only joint oscillator because the seed establishes that it can
produce upstream motion, but reduce its period/amplitude combination enough
that nominal joint accelerations fall below the hard cap. Add target-relative
steering through a bounded mean tail-curvature bias driven by body-frame
`bearing` plus the windowed bearing rate. The rate term should ease the bias as
the target line rotates toward the nose and strengthen it when the bearing is
diverging, without using time, coordinates, cylinder identities, or remote
flow probes.

The candidate is expected to remain in the domain beyond `50.1`, keep the
target bearing bounded, and turn the initial transient closest approach into
sustained distance reduction while materially reducing joint saturation. The
hypothesis is falsified if the tail-bias sign increases bearing/lateral exit,
if reduced oscillation cannot overcome the wake/inflow, or if the steering
transition still drives repeated acceleration clipping.
