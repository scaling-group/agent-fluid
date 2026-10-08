# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled solver rollouts are finite captures from the required
  direct-uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, moving-window transport, and no instability. Three independently
  evaluated velocity-quadrature phase-lag policies reproduce exactly the
  `23.122009T` capture, `0.749507L` crossing, `2.133413L` scored mean distance,
  and `-0.237071` score. The prefilled whole-carrier parent captures later at
  `23.331013T`, with `2.135772L` mean distance and score `-0.239045`.
- In the best complete combined sheet, the fish advances through quiescent
  water along the established S-shaped route while shedding an attached,
  alternating red/blue mid-plane street. The oblique row for
  `solver_4e1a15b275ab` shows discrete three-dimensional Lambda2 structures
  following the moving tail through capture, confirming self-propulsion rather
  than background advection. The prefilled whole-carrier sheet retains the
  broad top-down wake and route class, but its oblique row is blank; that is a
  render failure and supplies no independent 3D-wake claim.
- The numerical histories agree with the visual comparison. Relative to the
  whole-carrier parent, velocity-quadrature recovery is behind through about
  `8T`, becomes better over `9--12T`, and reaches `2.029L` rather than
  `2.158L` at `20T`. It lowers peak normalized force/moment from
  `0.030861/0.016213` to `0.030360/0.015861`, while mean action rises from
  `59.044` to `60.062` and anterior/posterior exact rate-cap occupancy rises
  from about `11.34/6.27%` to `11.92/7.06%`. The improvement is therefore a
  later traveling-bend and route-allocation effect, not faster launch, lower
  effort, or permission to increase recovery gain.
- The assigned parent's inherited speed-crossfade test falsifies the tempting
  composition of the two positive intervals. It preserves capture and leads
  the phase-lag policy at `8T` (`8.704L` versus `8.822L`), but is behind by
  `12T` (`6.347L` versus `6.171L`) and `20T` (`2.218L` versus `2.029L`). It
  captures at `23.215511T`, raises mean distance to `2.146268L`, and scores
  `-0.249630`; its oblique row is also blank. Thus early whole-carrier wake
  history changes the later route even after the speed gate has returned to
  pure phase lag. Inherited tail-rate unloading, angle-quadrature recruitment,
  and half-cycle redistribution likewise reduce the phase-lag advantage, so
  none supplies evidence for another posterior composition in this candidate.

## One candidate hypothesis

Replace the prefilled whole-carrier posterior recovery with the independently
reproduced `0.12` anterior-velocity quadrature of posterior tail lag, preserving
the through-water observation, anterior recovery, target geometry, reactive
rudder, terminal relief, and all established gains exactly. This selects the
only posterior recovery allocation that survives the sampled and inherited
matched controls; it is a mechanism change from the assigned prefill, not a
scalar-only tune. The new evaluation should reproduce the `23.122009T` capture
and `2.133413L` mean-distance boundaries while retaining the complete
alternating two-view wake and the established effort, saturation, force, and
moment envelopes. Reject the translation if any of those bounds worsen.

bookshelf_consulted: true
source_domain: elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: sustain a posterior-delayed traveling bend while locomotor feedback recruits the phase-lag component without adding a standing-wave amplitude term
transferable_invariant: posterior wave lag and whole-carrier amplitude are distinct actuator allocations, and measured evidence should select the allocation that preserves later propulsive route quality
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, distributed-body envelopes, exact vortex phases, prescribed startup timing, and task-specific routes
policy_translation: use normalized body-frame through-water speed only to gate the established recovery response, and place its fixed 0.12 posterior share solely in the anterior-velocity tail-lag quadrature while leaving steering and terminal paths unchanged
falsification: reject if capture is later than 23.122009T or lost, mean distance exceeds 2.133413L, or the complete two-view wake, action, saturation, force, moment, or established S-route envelope worsens
