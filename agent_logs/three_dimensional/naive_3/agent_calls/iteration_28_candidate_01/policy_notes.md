# Candidate wake-policy notes

## Evidence diagnosis before the edit

All four sampled evaluations satisfy the direct-uniform still-water contract
(`U_infinity=[0,0,0]`, no prewarm) and terminate in capture.  The combined
keyframe sheets for the unguarded soft-envelope carrier
(`solver_bb2a1c7cb2a0`/`solver_ba8bbe9216df`) and the best finite guarded
sample (`solver_9c72bd94b27c`) show the same useful topology: an alternating,
downstream top-view vortex street develops during approach, while compact
three-dimensional Lambda2 structures follow the beating tail through the
terminal turn.  The fish therefore remains self-propelled rather than advected;
the traces put peak local flow near `0.032U` while body speed reaches
`1.37--1.39U`.  There is no visible collision, wake collapse, or terminal
coasting before capture.

The distinction is actuator use.  The unguarded carrier captures at `16.943T`
and touches both `260 deg/T` joint-speed limits in `3.73/3.54%` of samples.
Posterior-to-anterior-only guarded transfer removes exact speed contact but
regresses to score `-0.208655`, arrival `17.060T`, and mean distance `2.0931L`.
The bidirectional phase-local sample also stays below the limits
(`258.91/259.19 deg/T`) yet improves to the best sampled score `-0.204764`,
arrival `16.988T`, and mean distance `2.0893L`.  Its peak force coefficient
`0.03634` is essentially the unguarded `0.03609`, although peak yaw moment
rises modestly from `0.01766` to `0.01804`.  The visual wake remains coherent,
so the score gain is consistent with reallocating temporarily blocked carrier
work rather than adding drive or changing the route observation.

## Policy hypothesis

Adopt the sampled bidirectional high-onset speed governor and bounded
cross-joint carrier-work allocation as the single candidate mechanism.  Keep
the demonstrated velocity-course steering, acceleration reserve, soft command
envelope, and posterior angle viability unchanged.  Each speed guard removes
only positive-power acceleration in the final normalized speed shell; removed
anterior work can enter only the compatible posterior carrier direction, and
removed posterior work can enter only an anterior stroke already doing
positive work.  Receiver-speed and acceleration-headroom gates prevent either
transfer from moving a hard contact to the other joint.

This candidate should reproduce capture and alternating shedding, eliminate
exact speed-limit occupancy, and retain or improve the unguarded mean-distance
score.  Falsify the mechanism if capture is lost, either speed reaches
`260 deg/T`, mean distance exceeds `2.0931L`, the alternating/3D wake breaks
down, posterior angle exceeds the unguarded `0.5907 rad`, or force/yaw-moment
peaks materially exceed `0.03634/0.01804`.  The remaining `0.045T` arrival
cost versus the unguarded carrier and the small moment increase remain real
tradeoffs; this evidence does not justify a broader guard or larger gains.

bookshelf_consulted: true
source_domain: classical fish-swimming reactive-thrust and sensor-modulated CPG control
source_mechanism: preserve a lagged traveling bend with posterior emphasis, and modulate rhythmic work through observed state rather than an external clock
transferable_invariant: retain wave direction and rhythm while redistributing only phase-compatible propulsive work into measured actuator headroom
nontransferable_details: published gains, dimensional beat frequency, species-specific envelopes, full-body kinematics, external oscillator phase, and exact vortex timing
policy_translation: use normalized joint speed and joint-state work sign to guard the final speed shell and offer blocked acceleration to a compatible receiving stroke without changing body-frame target-course feedback
falsification: reject if capture or coherent shedding is lost, speed contact returns, route metrics regress beyond the one-way guarded sample, or load and posterior-angle bounds above are exceeded
