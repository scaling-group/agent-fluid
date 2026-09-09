# Multi-wake target-policy candidate

## Visual diagnosis and inherited evidence

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets.  The target corridor is already
  unsteady at release, so exact wake phase is a common initial condition, not
  a transferable route or timing signal.
- The assigned-parent anterior-only response reaches the target in `135.019`
  released units with `3.685L` mean distance and `110448` total command energy.
  Its keyframes show active upstream propulsion and an alternating bend, while
  `-11.081L` head displacement against only `-0.0631` mean local streamwise
  flow rules out passive advection.  It nevertheless reaches the anterior
  acceleration cap and carries `0.1535/18.53/362.61` RMS relative crossflow,
  force, and moment.
- The inherited course-alignment extension is a concrete negative result.
  Stacking positive-closing-speed-gated body-course correction onto the parent
  preserves semantic success but prolongs the sheet's midcourse zig-zag,
  delays capture to `162.222`, worsens mean distance to `4.433L`, and raises
  total command energy to `136964`; RMS crossflow and force also rise to
  `0.1577/18.63`.  Course alignment was mildly useful on the direct-action
  scaffold (`137.247`, `4.077L`) but is incompatible with the anterior history
  response under this wake snapshot.  Do not stack it here or scalar-tune it.
- The strongest sampled solver instead conditions the short action response on
  signed joint power.  Relative to the assigned parent it advances capture to
  `123.018`, lowers mean distance to `3.594L`, energy to `95084`, and RMS
  crossflow/force/moment to `0.1429/17.03/334.45`.  Its sheet retains the
  alternating posterior wave while taking a visibly shorter targetward path.
  Relative to the unguarded both-joint response, it also lowers both bend and
  acceleration peaks; only anterior acceleration still touches the cap.

## Policy hypothesis

Use the sampled signed-power guard as one compact actuator-coordination
mechanism on the assigned-parent route and traveling-wave scaffold.  Compute
raw state-feedback acceleration for both joints, form the same short
timestep-aware previous-action response, and continuously bypass that response
only when its lag adds positive normalized joint kinetic power relative to the
raw command.  This preserves neutral or energy-removing command continuity and
restores direct phase feedback when history would postpone braking.  No scalar
gait, steering, wake-rejection, or route gain changes.

The sampled result is evidence for selecting the mechanism, not same-worker
evidence for this candidate.  Falsify the transfer if formal evaluation loses
capture, upstream translation, or the alternating wave; if arrival or mean
distance regresses beyond the assigned parent's `135.019/3.685L`; or if effort,
load, bend peaks, and anterior cap contact fail to remain jointly improved.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG actuator control
source_mechanism: preserve a coherent posterior-emphasized traveling wave while sensory state feedback shapes rhythmic actuator commands
transferable_invariant: command continuity may shape a traveling bend, but it should yield to current joint-state feedback when lag continues adding joint kinetic energy after less drive is requested
nontransferable_details: published gains, servo time constants, species-specific envelopes, dimensional beat settings, exact vortex phases, cylinder layout, and task-specific routes
policy_translation: retain normalized body-frame route and moment feedback plus joint-state phase; blend each previous-action response toward raw two-joint acceleration using normalized positive lag-added joint power
falsification: reject if capture, upstream translation, or alternating propulsion is lost, or if arrival, distance, effort, load, bend peaks, and actuator-cap contact do not remain jointly better than the anterior-only parent
