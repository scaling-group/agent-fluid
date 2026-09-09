# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. The target lies in the merged
  second-row wake, so every controller begins in established asymmetric
  crossflow; the shared sheet is initial-condition evidence, not a
  candidate-specific advantage.
- All four sampled solver examples are exact finite repeats of the coordinated
  allocator: target reach at `34.7105`, mean distance `1.62283L`, total/mean
  command energy `46985.9/1353.65`, RMS relative crossflow `0.240234`, and RMS
  force/moment `68.963/1036.40`. Their released sheets show a sharp active
  redirect, a coherent leftward traverse through the merged wake, and direct
  capture from the right. Head displacement `(-10.923,-4.166)L`, mean fish
  velocity `-0.3132U` in x, and mean local flow `-0.2018U` establish
  self-propulsion rather than passive advection.
- No current sampled sheet is a semantic failure. The inherited negative
  boundary is the bearing-trend residual that took route authority and exited
  right with negative progress. The most informative current regression is
  the assigned parent's paired phase-selective moment credit: it preserves the
  visually indistinguishable route and target reach but regresses arrival to
  `34.8370`, mean distance to `1.63062L`, total energy to `47147.5`, and RMS
  force/moment to `78.707/1184.745`. Phase coincidence is therefore not earned
  as a hydrodynamic unloading proxy.
- The coordinated baseline reaches the policy's `30.0` acceleration envelope
  on both joints and the `260 deg/time` joint-speed limit. Earlier inherited
  evidence shows global speed release dominates actuator-local release across
  arrival, route, total effort, crossflow, and load. Yet the final residual
  allocator still clips the two joint commands independently, which can alter
  the traveling-bend relationship precisely when either command exhausts its
  reserved headroom.

## Candidate policy hypothesis

Replace only the two independent final residual clamps with one coupled
headroom projection. Compute the established raw-bearing steering reserve for
each joint, then apply one common scale to both carrier-plus-unreserved-steering
residuals so neither command exceeds its remaining envelope. This preserves
each persistent steering reserve while preventing saturation at one joint from
independently reshaping the two-joint traveling bend. Keep the oscillator,
posterior lag, steering sign, course-slip correction, bearing reserve schedule,
half-cycle asymmetry, bearing-closure response, assisting-sign moment credit,
and globally coordinated speed release unchanged.

Expected later evidence is target capture with the same redirect/upstream
topology, less independent envelope contact, and lower force/moment or command
effort without material arrival regression. Reject the allocator if capture or
leftward propulsion is lost, if arrival/mean distance regress beyond the
assigned phase-gate parent, or if load and limit contact do not improve. A
held-out wake in which common scaling repeatedly suppresses useful authority
from the unconstrained joint would also falsify the coordination translation.

bookshelf_consulted: true
source_domain: coupled rhythmic locomotion, elongated-body traveling-wave propulsion, and sensor-modulated robotic-fish control
source_mechanism: preserve inter-segment coordination of a propulsive traveling bend while bounded feedback modulates maneuver authority
transferable_invariant: when a coupled multi-joint propulsive wave meets an actuator envelope, preserve its inter-joint command direction while reserving persistent body-frame steering authority
nontransferable_details: published gains, dimensional frequencies, actuator ratings, species-specific body envelopes, full-body phase relations, clocked oscillator phases, exact vortex phases, and source-task routes
policy_translation: use raw body-frame bearing to reserve steering per joint, then scale the two carrier residuals by one common headroom factor computed from both joint commands and the owned acceleration envelope
falsification: reject if target capture or coherent upstream propulsion is lost, if route/load metrics regress against the coordinated baseline and assigned parent, or if held-out wake evidence shows common scaling unnecessarily removes useful authority from the unconstrained joint
