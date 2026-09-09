# Candidate diagnosis and policy hypothesis

All sampled and inherited rollouts use direct uniform still-water initialization
with `U_infinity=(0,0,0)`, no cylinders, and no prewarm, so their motion and
wakes are self-generated. I inspected both the top-down vorticity and oblique
Lambda2 rows for the four sampled solvers and the assigned parent's completed
half-cycle candidate. The `28 degree`, `0.55T` carrier in
`solver_adc862529891`, `solver_b22e8cf1f277`, and
`solver_4c50eba7cd00` produces a coherent alternating street and compact 3D
structures throughout substantial world-minus-x translation; there is no
visual wake collapse before their exits. The weak mean-curvature sample
`solver_97bc3c03d55b` instead curls upward and leaves at `11.13T`, having only
reached `9.175L`.

The strongest finite score (`solver_adc862529891`, `-7.550`) preserves the
carrier but exits through the upper boundary at center `y=15.202L`; it reaches
only `5.658L`. The two closest samples preserve the same carrier much longer:
the two-joint slip/yaw projection reaches `4.158L`, and the phase-separated
course variant reaches `4.128L`. Their top-down and oblique rows show sustained
self-propulsion, but both cross the target abscissa near head `y=13.7L`, about
`4.2L` above the `y=9.5L` target, then reverse the body-frame bearing only after
the target is behind and exit on the left near `y=12.1L`. At closest approach,
the phase-separated course sample still has body-lateral velocity `0.197U` and
is already past the target laterally. Thus the missing behavior is earlier
cross-track course authority, not more propulsive amplitude or a terminal
capture schedule.

The assigned parent's fast half-cycle amplitude mechanism is a concrete
negative result. Despite retaining the nominal carrier parameters, its
posterior half-cycle scaling accumulated a `0.645 rad` mean posterior joint
offset, visibly curled the body and wake, generated only `0.015` final progress,
and exited upward at `8.657T` with minimum distance `11.994L`. This contradicts
the hypothesis that small per-half-cycle scaling would preserve the evidenced
carrier, so this candidate does not retune or reuse half-cycle asymmetry.

Policy hypothesis: retain the best sampled phase-separated target-course and
yaw-residual feedback, but translate its slow bounded curvature request into a
curved traveling-wave backbone. The anterior oscillator runs on the centered
coordinate `q1 - head_bias`; the posterior wave is generated from that centered
coordinate and oscillates about a compatible `tail_bias`. Splitting one total
mean-curvature request across both joint equilibria is a new steering actuator
relative to every sampled posterior-only controller. It should apply persistent
turning over more body length while preserving the same centered traveling bend
and its posterior lag. The total bias remains at the evidenced `10 degree`
bound, so this tests distribution rather than a larger scalar steering command.

Expected evidence: retain the long alternating wake and strong world-minus-x
translation of the two closest samples, but cross head `x=9L` materially below
`y=13.7L` and improve minimum distance below `4.128L`. Falsify the translation
if it repeats the upper exit, leaves the same more-than-4L high pass, drives
either joint into persistent hard-limit behavior, accumulates a large posterior
offset like the half-cycle candidate, or weakens the coherent carrier.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and mean-curvature turning
source_mechanism: a slow bounded backbone offset superposed on a centered propulsive rhythm
transferable_invariant: separate the slow target-directed mean shape from the fast traveling-wave coordinates so steering can act over multiple joints without replacing propulsion
nontransferable_details: published gains, dimensional frequencies, linkage geometry, species-specific envelopes, clock phase, exact vortex phase, and task-specific routes
policy_translation: form course and yaw residuals only from normalized body-frame target and velocity observations, then split one bounded total curvature request between centered anterior and posterior joint equilibria
falsification: reject if carrier coherence or forward translation degrades, the head still crosses x=9L above y=13.5L, minimum distance does not beat 4.128L, or joint-limit occupancy becomes persistent
