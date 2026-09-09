# Envelope-sharing anterior spillover candidate

## Visual and metric diagnosis before editing

All four sampled rollouts satisfy the frozen evidence contract: direct uniform
initialization in still water with `U_infinity=(0,0,0)`, no cylinders, no
prewarm, finite dynamics, and capture termination. I inspected each combined
sheet from release through capture, including the top-down mid-plane vorticity
row and the oblique body/Lambda2 row. The policies visibly self-propel on the
same direct down-left route; they leave coherent alternating mid-plane wakes
and compact body-connected three-dimensional vortex trains. None shows passive
advection, wake breakup, boundary interaction, or numerical instability. The
carrier, posterior lag, far-field steering, and response-plus-miss handoff are
therefore useful behavior to preserve. The informative failure is allocation
quality inside an otherwise successful capture class.

The synchronized trajectories isolate that failure. Tail-only cubic residual
allocation is score-best and fastest at `15.1403T/-0.01094`, but crosses with a
`0.651L` head-relative constant-course miss, `0/1.269%` anterior/posterior
`>40 deg` dwell, and `0.04041/0.01902` peak normalized planar force/moment.
Dual absolute reserve improves loads to `0.03872/0.01876` but reaches only
`0.556L` miss with `0/0.898%` dwell at `15.2957T`. The assigned prefill's
absolute posterior reserve plus unconditional anterior spillover is uniquely
centered (`0.362L` miss), but slows to `15.4464T` and exchanges exposure into
`0.285/0.996%` dwell at `0.03970/0.01889` loads. The newest approach-scheduled
phase-space reserve recovers the fast class (`15.2650T`), reduces loads to
`0.03781/0.01864`, and improves dwell to `0/0.360%`, yet widens miss to
`0.529L`; it does not meet the established `0.461L` directional baseline or
the inherited fixed projection's `0.421L`. Combined with inherited failures
of receiver shedding, delayed/analytic carrier-phase gates, and the posterior
wave target, this argues against another gate, phase proxy, projection scalar,
or posterior offset. It instead identifies the prefill's reserve-blocked
anterior acceleration spillover as a plausible source of both its centering
and its anterior limit exposure.

## Single candidate hypothesis

Keep the prefilled absolute-posterior-reserve allocator, including its target-
relative cubic request and posterior acceleration residual. Replace only the
reserve-blocked anterior `residual * abs(carrier_acceleration)` spillover with
an anterior oscillator-center displacement. Contract the anterior rhythmic
amplitude by the displacement magnitude so the steering center and traveling
excursion share the inherited angular envelope, and subtract the displacement
when forming the posterior lag target so posterior thrust and residual remain
the sampled prefill mechanism. The displacement is bounded by the owned
oscillator amplitude, inherits the normalized body-frame predicted-miss sign,
and activates only where observed posterior angle/rate reserve already moved
authority anteriorly. It adds no clock, route, world coordinate, case identity,
mutable state, or vortex-phase inference.

Support requires capture on the direct compact-wake route with terminal course
miss at or below the fully directional baseline's `0.461L`, zero anterior
`>40 deg` dwell, posterior dwell no worse than the prefill's `0.996%`, peak
normalized planar force/moment no worse than about `0.040/0.019`, and arrival
within the sampled `15.14--15.45T` class. Stronger support would retain the
prefill's `0.362L` margin while matching the scheduled projection's joint/load
quality. Falsify on lost capture, wider course, renewed head dwell, posterior
translation loss, higher loads, changed far-field behavior, nonfinite action,
or loss of reflection equivariance. Formal CFD is deferred to EvE and is not
evidence available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG turning
source_mechanism: couple bounded rhythm offset and amplitude modulation while preserving the autonomous posterior-emphasized propulsive carrier
transferable_invariant: steering displacement and rhythmic excursion should share a fixed actuator envelope rather than adding steering acceleration on top of an already large carrier
nontransferable_details: published gains, dimensional beat frequencies, hardware duty ratios, linkage geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: map normalized body-frame cubic predicted miss and observed posterior reserve loss to an anterior wave-center displacement; contract only the anterior carrier excursion by that displacement and remove it from the posterior lag input so posterior thrust remains intact
falsification: reject if capture margin, arrival, direct compact wake, anterior dwell, posterior translation, normalized loads, boundedness, or reflection equivariance worsens

## Dry validation boundary

The configured guidance-materiality/parameter-schema check, lightweight Julia
policy contract, and solver editable-boundary check pass without running CFD.
A deterministic `21,870`-state grid spanning normalized body-frame target and
course geometry, approach distance, heading response, and both joint angles
and rates produced finite commands inside the owned `30 rad/T^2` smooth
envelope with exact left/right reflection (maximum error `0.0`). The new
anterior wave-center channel changed `13,970` grid states from the assigned
prefill, with maximum command difference `3.65592 rad/T^2`, confirming an
active feedback/actuator change rather than a comment or scalar-only edit.
These algebraic checks do not establish capture, wake, terminal margin, loads,
joint histories, or arrival; those remain falsifiable in EvE's formal CFD.
