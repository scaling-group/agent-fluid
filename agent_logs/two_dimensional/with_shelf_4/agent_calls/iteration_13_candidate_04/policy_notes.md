# Multi-wake candidate diagnosis

## Evidence read before editing

- The shared prewarm sheet shows the fish held in the upper-right while four
  staggered cylinder streets develop and merge around the target corridor.
  It is a common release condition, not a transferable vortex phase or route.
- All four sampled solvers are deterministic replications of one strong finite
  trajectory: they reach the target after `137.357` released units with
  `4.184L` mean distance, `-10.914L/-4.371L` head displacement, `90228` total
  command energy, and `0.12955/14.75/303.02` RMS relative crossflow, lateral
  force, and yaw moment. The released sheet shows an active redirect from the
  upper-right, an alternating posterior-lagged bend, a broad but controlled
  lower-midcourse wake crossing, and final capture from the right. Mean body
  velocity `(-0.0791,-0.0330)` versus mean local flow
  `(-0.0542,-0.0521)` and the large upstream displacement confirm that this is
  self-propelled targetward motion rather than passive advection.
- The anterior acceleration reaches `30.846 rad/time^2` against its `31.416`
  hard cap, while the posterior reaches `25.552 rad/time^2`. Additional
  unconditioned anterior steering authority is unsupported, but bounded use of
  the posterior actuator has some observed headroom.
- The assigned-parent guidance already rejects slow bearing-divergence gating
  of the direct moment residual: that one-change rollout preserves capture but
  deepens the lower excursion, delays arrival to `149.490`, and worsens mean
  distance, energy, and RMS crossflow/force/moment to
  `4.428L/97418/0.13148/16.38/318.46`.
- Two inherited step-12 rollouts supply newer negative structural evidence.
  Unqualified slow-route sharing through posterior half-cycle asymmetry makes
  several visible loops before capture at `196.317`, with `5.718L` mean
  distance, `131294` energy, and `0.13498/15.48/310.21` RMS
  crossflow/force/moment. Combining route and moment inside one smooth
  saturation envelope produces still larger looping and capture at `223.746`,
  with `6.429L` mean distance, `144686` energy, and
  `0.13399/16.79/324.37` RMS crossflow/force/moment. Thus neither persistent
  posterior route sharing nor weaker smooth arbitration preserves the
  replicated baseline's route; the existing route, direct load residual, and
  hard arbitration should remain intact.

## Policy hypothesis

Make one feedback-mechanism change from the replicated successful prefill:
add a response-released posterior redirect to the otherwise unchanged
controller. During large body-frame misalignment with no confirmed positive
windowed closing speed, use a bounded target-consistent half-cycle asymmetry
on the lagged posterior wave. Scale the assistance continuously by absolute
route request and by the complement of the existing normalized closing-speed
response, so it releases as targetward translation develops. This differs
from the failed unqualified posterior sharing: it cannot persist through an
already productive midcourse approach, and it never adds a static offset,
elapsed-time mode, new route signal, or extra anterior authority.

The formal expectation is a quicker initial redirect followed by recovery of
the baseline posterior traveling wave, capture no later than `137.357`, and no
increase in mean distance, effort, load, or actuator-cap contact. Falsify the
mechanism if it causes the inherited looping topology, delays or loses
capture, weakens upstream translation, leaves posterior asymmetry active while
closing, erases alternating propulsion, or worsens distance, effort,
crossflow, force, or moment. CFD is run only after this worker exits, so these
are expectations for an unevaluated candidate rather than result claims.

bookshelf_consulted: true
source_domain: nonsteady biological redirect control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: a strong bounded curvature response to large observed route error is released into the ordinary posterior beat when useful target response appears
transferable_invariant: body-frame misalignment may recruit temporary posterior steering, but measured target-distance closure must release that assistance so rhythmic propulsion recovers
nontransferable_details: species-specific C-start kinematics, robot linkage geometry, published gains, dimensional beat settings, exact vortex phases, cylinder layout, and source-task routes
policy_translation: retain the evidenced anterior half-cycle route and direct normalized moment residual; modulate only the lagged posterior half-cycle by bounded route magnitude while positive normalized windowed closure is absent
falsification: reject if capture or upstream translation is lost or delayed, the alternating posterior wave does not recover with closure, loops persist, posterior acceleration contacts its cap, or mean distance, effort, crossflow, force, and moment fail to improve together
