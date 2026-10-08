# Wake-policy candidate notes

## Evidence diagnosis

The assigned parent is the speed-guarded line-of-sight-response controller in
`solver_f269448a491b`.  Its direct-uniform still-water rollout is valid
(`U_infinity=(0,0,0)`, no prewarm, no cylinders) and captured at `0.749366L`
and `27.5770T`.  The three other sampled rollouts are byte-identical executions
of the preceding angle-only guard and each captured at `0.749992L` and
`27.7695T`; there is no sampled non-capture in this batch, so these repeated
weaker captures are the informative comparator rather than trajectory-diverse
failure evidence.

Both combined keyframe sheets show self-propulsion rather than advection: the
fish translates through quiescent water while shedding a coherent alternating
top-down vortex street, and the oblique Lambda2 row confirms a compact 3D wake
that remains organized through the late target-directed turn.  Neither sheet
shows a collision, a domain escape, or wake breakdown before capture.  The
speed governor leaves that visible route nearly unchanged but bends into the
capture circle slightly earlier.  Metrics agree: relative to the angle-only
guard, it changes peak joint angles from `0.76555/0.76324` to
`0.76359/0.76085 rad`, removes sampled `260 deg/T` residence from
`17.83%/4.48%` to zero, preserves peak planar force/yaw moment
(`0.02218/0.01034` versus `0.02212/0.01041`), and improves score from
`-0.709920` to `-0.707508`.  Acceleration-limit residence remains high at
`21.62%/12.05%`, so the carrier should not receive more drive or steering
authority.

## Policy hypothesis

Retain the successful traveling-bend carrier, target/course redirect,
anterior-only positive line-of-sight response deficit, terminal miss veto,
posterior allocation, and symmetric angle stopping guard exactly.  Replace
only the fixed `250--260 deg/T` speed-band blend to an opposite acceleration
with a continuous one-sided velocity-barrier projection.  For a command that
would increase joint speed, cap its signed magnitude by a rate proportional to
the remaining normalized distance to the speed limit; pass every speed-reducing
command unchanged.  This removes the arbitrary band edge and injected reverse
pulse while preserving a smooth invariant speed boundary.  The next CFD result
must retain capture and the coherent two-view wake while avoiding speed contact;
reject the mechanism if capture is lost, the route or wake changes materially,
or acceleration residence and peak force/moment worsen.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual control over rhythmic locomotion
source_mechanism: preserve a phase-coupled propulsive rhythm while applying the smallest state-gated corrective residual
transferable_invariant: constraint feedback should modify only motion that is carrying a productive rhythm toward an actuator boundary
nontransferable_details: published gains, dimensional beat rates, species envelopes, full-body kinematics, exact vortex phases, and task routes
policy_translation: retain the evidenced body-frame target response and two-joint traveling bend; project only speed-increasing joint acceleration through a normalized remaining-speed barrier
falsification: reject if repeat capture fails, either joint touches the speed cap, propulsion or wake coherence degrades, or acceleration/load exposure rises
