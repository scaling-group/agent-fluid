# Multi-wake target-policy candidate notes

## Visual and metric diagnosis

The shared prewarm sheet is common initial-condition evidence: the held fish
starts above and downstream of the four mature, interacting cylinder streets,
while the target lies between the second-row wakes. It does not distinguish
controllers. In the released sheets the best finite sample (`11 deg` static
posterior authority with `0.70/0.35` direct heading-rate feedback) actively
self-propels upstream above the useful wake corridor. Its mean head velocity
is `-0.141 L/time`, more negative than mean local flow `-0.0995`, and it
travels `-7.89L`, reaches `4.87L`, and makes `0.424` progress. The middle
frames show a nearly horizontal upstream leg, but the final frames show a
broad upward hook followed by an almost vertical upper-domain exit. This
agrees with `+1.792L` head-y displacement, posterior peak `0.781 rad`, both
joint rate/command caps, and RMS force/moment `406/4113`.

The assigned parent's measured `40--45 deg` posterior soft stop is an
informative failure: it preserves the same visible upper hook, does not lower
the posterior peak or either cap, worsens closest approach from the matched
`10 deg` anchor's `5.33L` to `5.77L`, and raises loads from `325/3331` to
`357/3779`. The sampled `11 deg` distance-relief candidate likewise retains
the upper exit and limit hits while losing upstream travel (`-7.19L`) and
progress (`0.393`). A fore-aft projection gate also retains the route and
reduces progress to `0.388`. These results reinforce the inherited negative
boundary around preemptive bias or waveform attenuation.

The newest inherited lateral-motion tests close a separate feedback branch.
Normalizing body-lateral velocity by total speed and subtracting it at gain
`0.30` still exits upward (`+1.766L`), worsens closest approach to `5.47L`,
and reaches the exact posterior angle limit. A raw body-lateral-velocity term
at gain `0.20` visibly disrupts the upstream leg, cuts upstream travel to
`-4.41L` and progress to `0.239`, raises RMS loads to `428/4648`, and still
exits upward at `+1.788L`. Lateral translation is therefore not a supported
proxy for the route error, and this candidate does not tune that channel.

## Single candidate hypothesis

Restore the complete best finite `11 deg`, `25 deg`, `0.70/0.35` controller.
Preserve its oscillator, traveling-wave lag, static far-field authority, and
actuator ceiling exactly while distance is closing. Add one symmetric recovery
mode driven only by negative normalized window closing speed: it is exactly
zero at release and throughout target approach, then smoothly reverses half of
the geometric bearing drive when the fish is measurably receding. Direct
heading-rate damping remains active and the command stays bounded. Unlike the
failed distance, phase, angle, forward-projection, and lateral-velocity gates,
this intervention does not weaken the sampled propulsion mechanism before a
demonstrated loss of target progress; unlike the failed bearing-rate channel,
radial distance rate is invariant to body-frame rotation.

The falsifiable expectation is that the rollout matches the `11 deg` anchor
through its upstream approach, then replaces the terminal upper hook with a
recovery turn and uses the large remaining horizon for another approach. It is
falsified if closest approach or upstream travel regresses before activation,
if the fish still exits near `+1.8L` head-y without a route change, or if the
recovery produces switching, higher loads, or lost propulsion without renewed
closing. A negative result should close receding-distance reversal, not invite
another derivative or relief-gain sweep.
