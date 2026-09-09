# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting vortex streets.  It is common initial-condition
evidence: all sampled policies see the same cylinder layout and mature wake at
release, so it cannot distinguish controller quality.

The three byte-identical strongest sampled carriers immediately redirect
toward the target, sustain a coherent posterior traveling bend, and actively
swim a compact upstream-left diagonal to the `0.75L` boundary in `43.9505`.
Their mean velocity `(-0.2471,-0.1020)` differs materially from mean local
flow `(-0.1342,-0.1556)`, especially in the upstream component, so the route
is not passive advection.  The released sheets nevertheless show strong
joint-scale alternating vorticity late in the approach, while diagnostics put
both joint rates and both accelerations on their hard envelopes and report RMS
crossflow/force/moment `0.2111/49.44/701.26`.

No current sampled solver is a semantic failure.  The informative sampled
negative contrast adds anterior-rate phase lead to the target-favored
half-cycle.  It preserves the visible direct topology and still captures at
`43.9780`, but increases RMS crossflow/force/moment to
`0.2136/53.18/736.58` and mean command to `1209.49`; using joint rate to
shift the steering phase is therefore rejected.  The inherited domain-exit
failure is available only through its retained observation and notes, not a
materialized failure sheet in this workspace: excessive static curvature
suppressed the targetward traveling bend, produced only `0.0154U` streamwise
motion relative to local flow, and exited right after `16.7914`.  That rules
out either a larger fixed bend or global weakening of the carrier.

The assigned parent's direction-aware posterior rate projection is the best
load tradeoff in inherited logs.  Across successive completed generations it
repeats the same direct `44.0220` capture and reduces crossflow/force/moment to
`0.2102/44.86/663.89`, but it remains slightly slower than the sampled carrier
and both accelerations still touch the hard cap.  Repeating that candidate or
tuning its rate threshold would not test a new explanation for the remaining
componentwise saturation.

## Policy hypothesis before the edit

Preserve the sampled oscillator, body-frame bearing curvature, target-favored
posterior half-cycle, posterior lag, and range envelope.  Add one new
alignment-gated, coordination-preserving actuator mechanism: when raw joint
accelerations exceed the policy-owned hard envelope after the fish is broadly
aligned, scale the two-command vector together instead of allowing the episode
to clip its components independently.  Full large-bearing redirect authority
is unchanged.  Near alignment, the dominant command can still reach the
envelope, but the anterior/posterior ratio and sign pattern of the intended
traveling bend are retained.

Expected evidence is continued direct target capture with less componentwise
acceleration-cap contact and lower force/moment, without the phase shift that
regressed the sampled rate-lead variant.  Falsify the mechanism if the early
redirect changes, capture is lost or materially delayed, the joint-pair wave
loses its coherent posterior lag, or saturation and load histories are not
improved.  The current worker does not claim this unevaluated candidate's CFD
outcome.

bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and coupled-oscillator robotic-fish control under actuator constraints
source_mechanism: preserve the inter-joint proportions of a posterior-emphasized traveling bend when the actuator envelope engages
transferable_invariant: after normalized body-frame direction error is small, constrain a coupled rhythmic command without independently distorting its joint amplitudes or signs, while retaining full bounded authority during a large redirect
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, exact actuator models, clock phase, vortex phase, cylinder coordinates, and task-specific routes
policy_translation: use bounded body-frame bearing demand as a smooth alignment gate and uniformly rescale the raw two-joint acceleration vector only when its largest component exceeds a policy-owned envelope
falsification: reject if the direct route or target capture weakens, posterior lag loses coherence, or acceleration-cap contact and force/moment evidence fail to improve

## Pre-evaluation verification

The required guidance semantic check and solver editable-boundary check pass.
Static schema inspection found all `14` direct `params.FIELD` references among
the `14` fields returned by `target_policy_params()`, with no policy-owned `L`
or prohibited time, route, random, or file constructs.  A deterministic sweep
of `44,100` states spanning approach range, both bearing signs, joint-angle
and joint-rate envelopes, and aligned/redirect regimes returned finite
actions; `14,008` cases exercised coordinated scaling.  The sweep confirmed
exact large-error inactivity, a bounded aligned acceleration envelope,
reflection symmetry, preserved command ratios, and zero action at the zero
state.  The prescribed Julia include/assertion could not start because this
runtime has no `julia` executable; this is an environment limitation rather
than a detected policy failure.  No formal CFD was run.
