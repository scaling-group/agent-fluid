# Wake-policy candidate notes

## Evidence read before the policy edit

The assigned guidance, all four sampled policies and scores, each compact wake
observation and metrics row, the common prewarm sheet, and the released sheets
for the strongest approach and the most diagnostic regression were inspected.
No inherited `logs/` tree was present when this workspace was rendered; the
inherited result history available here is the curated parent guidance plus the
four sampled evaluation bundles.

The prewarm sheet shows the common held fish above the developed, interacting
four-cylinder streets and well to the upper right of the target. It is an
initial-condition control, not a policy comparison. After release, the static
`11 deg` posterior-bias sample visibly self-propels left/upstream, with a clear
body-generated alternating wake, rather than merely following local advection.
That agrees with `-7.89L` head-x displacement and mean head velocity `-0.141`,
whose magnitude exceeds the `-0.0995` mean local-flow component. It made the
strongest sampled approach (`4.87L` minimum distance and `0.424` progress), but
never entered the central target/wake neighborhood. The path then folded into
a steep upper curl immediately before domain exit. Its `+1.79L` head-y
displacement, `6.08L` maximum lateral target offset, posterior peak `0.781
rad`, exact rate/acceleration-cap hits (`4.538` and `28.798`), and RMS
force/moment `406/4113` corroborate the visible failure.

The newer comparisons do not change that topology. Reducing the `11 deg` bias
toward a `0.70` floor based only on distance still curls out above, while
losing upstream head travel (`-7.19L`) and progress (`0.393`); its `4.93L`
closest approach is only marginally different and its posterior peak, rate,
and command remain saturated. On the static `10 deg` anchor, a soft stop that
acts only during measured `40--45 deg` outward posterior motion also makes the
same final upper curl. It worsens closest approach to `5.77L` and upstream
travel to `-6.88L`, despite lower loads (`357/3779`), and still reaches the
same rate/command caps. The static `10 deg` anchor itself reaches `5.33L` with
`0.380` progress. Thus distance is not a useful trigger for this repair, and
measured near-limit braking begins too late to redirect the gait.

## Single candidate hypothesis

Keep the inherited `0.90`-period anterior oscillator, direct body-rate
feedback, static `10 deg` steering anchor, posterior lag servo, and final
capture fade. Change only how the posterior servo allocates that bias within
the joint-state-encoded gait phase. Before adding steering, compute the nominal
posterior traveling-wave target `-q1 - tail_lag_gain * qd1 / omega`. Smoothly
reduce steering to an `0.80` floor only when the signed steering request
reinforces that nominal posterior excursion; retain full steering through the
opposing half-cycle. This acts on the commanded phase before the joint is at
its boundary, without using time, coordinates, a route, bearing rate, or the
anterior propulsion oscillator.

The expected result is less posterior peak/saturation and a weaker terminal
upper curl while retaining more upstream motion than distance-wide or global
bias reduction. The mechanism is falsified if it repeats the upper exit
without lowering posterior peak/load, or if upstream travel/progress regresses
to the distance-relief or globally weakened regime. Later workers should then
restore the static `10 deg` anchor and test a different posterior-servo
saturation mechanism rather than retuning this phase gate.
