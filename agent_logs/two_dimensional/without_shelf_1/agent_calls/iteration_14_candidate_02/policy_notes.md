# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet confirms the common initial condition: the held fish
starts above and downstream of four developed, interacting cylinder wakes,
while the target lies in the second-row wake corridor.  Every sampled released
sheet shows active self-propulsion rather than passive advection.  In the
strongest finite sample the mean head velocity is `-0.171` while mean local
flow is `-0.119`, and the head travels `-11.33L` upstream.  The fish descends
toward the target during that leg, but never enters the useful corridor; a
sharp upper hook immediately precedes the upper-boundary exit.  Its `3.03L`
closest approach and `0.517` progress are the best overall sampled anchor, but
both joint rates and acceleration commands reach their caps, the posterior
angle reaches `0.780 rad` (within about half a degree of the hard limit), and
RMS force/moment rise to `511/5305`.

The two sampled close-gated receding reversals do not repair that topology.
Gating from `4L` to full authority at `3L` gives `3.13L` closest approach,
`0.495` progress, and `-10.15L` head-x travel; tightening the gate to
`3.75--2.75L` gives `3.10L`, `0.507`, and `-10.83L`.  Both retain the same
upper hook, exact joint-rate/command maxima, and roughly `+1.79L` head-y exit.
They therefore shave the far-field anchor without producing the hypothesized
second approach.  The inherited globally active receding relief was still
worse (`4.93L` closest approach and `0.444` progress), and the sampled signed
fore-aft gate also repeats the hook while regressing to `3.45L` and `0.449`.
Memoryless receding and longitudinal sign gates are exhausted by these
comparisons; closest approach alone did not survive as a positive mechanism.

## Single candidate hypothesis

Restore the complete `11 deg`, `25 deg`, `0.70/0.35` phase-headroom anchor and
remove every receding or longitudinal gate.  The new candidate changes one
structural element: clamp the posterior *target* to a policy-owned soft
`42 deg` envelope before the posterior PD law.  The sampled controller's
unbounded traveling-wave target can continue demanding outward acceleration
after the actual posterior joint is already near its `45 deg` hard stop; a
setpoint envelope acts only on those extreme phases and leaves the anterior
oscillator, target-relative bearing feedback, phase-headroom allocation, and
command limit unchanged.  It is state-phased and contains no time, global
coordinate, target identity, or case-specific route.

The next CFD result supports this anti-saturation hypothesis only if it retains
approximately the phase anchor's upstream leg and `3.03L` approach while
reducing posterior-limit contact, command/load peaks, or the terminal upper
hook.  It is falsified if clipping destroys upstream propulsion, if the actual
joint still reaches the hard stop and command caps, or if the same upper exit
persists without a material load reduction.  In that event later workers
should restore the unclipped phase anchor and avoid treating desired-angle
clipping as a navigation repair.
