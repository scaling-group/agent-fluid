# Candidate wake-policy notes

## Evidence read before editing

All four sampled rollouts satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`, no cylinders, no prewarm) and capture from the same
upper-right pose.  Their top-down sheets show self-propelled, target-directed
motion with a coherent alternating wake from release to capture; there is no
visible advection source.  The parent v41 controller captures at `17.9190 T`
with score `-0.09321`, total/observed distance integrals
`1.97941/1.36531 L`, mean/max speed `0.7128/0.9675 L/T`, any-joint
acceleration-limit residence `43.92%`, and peak normalized lateral
force/yaw moment `0.03182/0.01608`.

The energy-governed posterior child is the strongest finite sample: it
captures at `17.8090 T`, score `-0.08840`, and integrals
`1.97415/1.35824 L`, remains closer than v41 at every `2 T` checkpoint, and
reduces maximum speed and acceleration-limit residence to `0.9590 L/T` and
`42.90%`; its force/moment peaks rise slightly to `0.03225/0.01657`.  The
axial-response child independently remains closer at every checkpoint,
captures at `17.8310 T`, and improves the integrals to
`1.97468/1.36003 L`.  By contrast, phase allocation retains capture and
improves the integral to `1.97609 L` but does not improve the `17.9190 T`
arrival and is slightly farther away at `16 T`, so exact outstroke allocation
is not the next authority to stack.

The parent, axial-response, and energy-governed oblique rows are black and
cannot support a 3D wake-structure comparison.  The phase-allocation sample's
readable oblique row shows compact alternating Lambda2 structures behind the
caudal body and no visible instability, consistent with its bounded force and
successful closure, but not with a semantic arrival improvement.  The
candidate therefore preserves the common coherent carrier rather than
claiming a new 3D wake benefit.

## Policy hypothesis

Start from the best sampled energy-governed posterior-wave controller, but
release its launch emphasis with observed positive body-axis speed instead of
total speed.  Early v41 motion is sway-dominated (mean forward/absolute sway
`0.0118/0.0892 L/T` over `0-1 T` and `0.0793/0.1736 L/T` over `1-2 T`), so
total speed is not a selective proxy for propulsive response.  The sampled
axial child shows that excluding sway preserves capture and improves every
checkpoint and both distance integrals.  Combining the two observations
inside the same bounded posterior wave-scale mechanism should retain the
energy child's early lead while releasing only after axial self-propulsion
and target closure appear.  Route/redirect means, steering allocation,
carrier cadence, and all approach/turn gates remain unchanged.

Falsify this candidate if it loses capture, gives back the parent's lead at
multiple middle/late checkpoints, exceeds roughly `0.97 L/T`, `44%`
acceleration-limit residence, or `0.033/0.017` normalized force/moment, or if
a readable oblique evaluation shows a less coherent wake.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated low-dimensional swimming rhythms
source_mechanism: posterior traveling-wave kinematics generate thrust, while measured locomotor response should modulate rather than replace the carrier
transferable_invariant: keep propulsion authority in a bounded zero-mean posterior traveling wave and release extra authority when axial self-propulsion is observed
nontransferable_details: published gains, dimensional cadence and amplitude, species-specific envelopes, full-body kinematics, exact wake phase, and prescribed routes
policy_translation: gate a joint-state posterior energy deficit by normalized positive body-frame forward speed, closing response, distance, and turn load; do not alter commanded mean curvature
falsification: reject if capture or checkpoint-wide closure regresses, saturation or loads exceed the sampled envelope, or a readable two-view rollout shows wake degradation
