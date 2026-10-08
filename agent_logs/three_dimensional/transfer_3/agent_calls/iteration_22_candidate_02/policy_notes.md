# Phase-2 wake-policy diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is the prefilled v33 partially coupled saturation
  policy. All four sampled solver examples contain the same policy,
  trajectory, and combined keyframe sheet; only evaluation path and wall-time
  metadata differ. They therefore provide four deterministic reproductions of
  capture at `23.435516 T`, score `-0.4079736071`, distance integral
  `2.305032573 L`, and final distance `0.749060333 L` from direct uniform
  still water.
- In the top-down row the fish is self-propelled along a compact, gently
  curving target approach. Alternating signed vortices remain organized behind
  the body through the outer path, and the terminal frame shows a quiet bent
  body crossing the capture circle rather than a loop, coast, or wake breakup.
  In the oblique row the body remains planar and finite alternating Lambda2
  structures persist from release through the final approach; there is no
  visible volume blow-up or loss of the fish.
- The trajectory cross-check gives center travel `13.656897 L`, peak absolute
  lateral force `0.026471`, peak absolute yaw moment `0.015200`, and maximum
  joint excursions `0.766708/0.737988 rad`. Below `4 L`, neither command
  exceeds `30 rad/T^2` and the maxima are `29.888221/27.942390 rad/T^2`, so
  the inherited terminal reallocation remains separate from outer limiter
  coupling.
- The parent evidence bank and sampled inherited guidance provide the matched
  v29 control: independent outer clipping captured at `25.11852 T`, score
  `-0.528077`, distance integral `2.429087 L`, center travel `13.70935 L`, and
  peak lateral force/moment about `0.02620/0.01499`. Thus the v33 outer-only
  `12%` common-scale blend produced a large, reproduced improvement in arrival
  and distance integral with only a small load increase.
- No sampled solver in this workspace is a failed trajectory, so a direct
  two-view success/failure comparison is unavailable. The inherited completed
  negative controls are used instead: terminal cadence recovery, a
  reconstructed head-point predictor, instantaneous-force vetoes, broader
  carrier release, and joint-role splitting all preserved or regressed the
  prior captured topology. This candidate therefore leaves the validated
  terminal controller untouched.

## Candidate hypothesis

Independent component clipping is harmful only when it rotates the requested
two-joint acceleration vector; if clipping preserves its direction, blending
toward common scaling cannot recover additional traveling-bend geometry. The
candidate keeps v33's `12%` coupling ceiling and its normalized outer-distance
gate, but multiplies the blend by a smooth, normalized cross-product measure
of the angle between the raw and independently clipped command vectors. The
gate reaches full support at a small but material direction error and is zero
when there is no clipping or no direction change. This is a response-dependent
control-allocation mechanism, not a gain increase: every upstream body-frame
target cue, steering equilibrium, cadence term, terminal gate, and actuator
limit is unchanged.

Expected result: preserve v33's earlier compact capture and coherent two-view
wake while avoiding unnecessary coupling during nearly direction-preserving
clips, with no increase in outer load peaks. Reject the mechanism if capture
is lost or delayed relative to `23.435516 T`, distance integral exceeds
`2.305033 L`, the outer trajectory or wake topology changes materially,
terminal commands differ, a joint stop appears, or force/moment peaks rise.

bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave swimming and low-dimensional coupled-oscillator control
source_mechanism: propulsive bending retains a directed anterior-to-posterior wave and posterior lag rather than collapsing into reciprocal or coincident joint motion
transferable_invariant: actuator limiting should preserve the signed two-joint command direction that encodes the traveling bend when saturation would otherwise rotate it
nontransferable_details: published gains, dimensional frequencies, full-body envelopes, species kinematics, exact vortex phase, and prescribed routes
policy_translation: retain body-frame target feedback and the terminal policy; outside the terminal band, use normalized raw-versus-clipped two-joint command distortion to gate the existing bounded common-scale blend
falsification: reject on lost or delayed capture, worse distance integral, changed terminal commands, degraded wake coherence, joint-stop dwell, instability, or higher force and moment peaks
