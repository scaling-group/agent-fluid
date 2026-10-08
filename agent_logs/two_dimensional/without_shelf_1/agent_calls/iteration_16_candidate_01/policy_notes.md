# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet is common initial-condition evidence: the fish is held
above and downstream of four already developed, interacting vortex streets.
After release, the `0.35` and `0.50` opposing-headroom sheets both show active
upstream swimming into the disturbed wake, not passive advection.  For the
stronger `0.50` policy, mean head velocity x is `-0.174` while mean local flow
x is `-0.123`; it travels `-12.28L` and approaches to `2.13L`.  The trajectory
passes the target station well above the capture circle and then curls sharply
upward immediately before a non-collision, finite upper-domain exit.  The
diagnostics agree with that visible controlled-route failure: head-y drift is
`+1.78L`, both joint rates and commands reach their caps, posterior angle peaks
at `0.778 rad`, and RMS force/moment are `535/5416`.

The sampled close continuation closes the phase-gain direction.  Adding up to
`0.05` boost below `2.75L` preserves and slightly increases upstream travel
(`-12.66L`), but closest approach regresses from `2.13L` to `2.21L`, progress
remains essentially unchanged (`0.5090` to `0.5092`), and the same upper hook
and exit remain.  RMS force/moment rise to `566/5660`, with the same posterior,
rate, and command-limit behavior.  Thus the terminal failure is not missing
close phase authority.  Inherited receding, fore-aft, bearing-rate, lateral
velocity, yaw-moment, and posterior-target-clipping trials likewise either
preserved the hook or destroyed the useful upstream leg, so none supplies a
supported companion signal.

## Single candidate hypothesis

Restore the complete sampled `0.50` policy at `3L` and beyond.  Inside `3L`,
smoothly replace only the angular bearing component of its posterior steering
command with a bounded body-frame lateral-offset component, reaching the pure
lateral form at `1.5L`.  The existing bearing uses a positive, floored
fore-aft denominator; when the fish crosses the target's streamwise station
with an order-one lateral miss, that ratio can keep demanding nearly full turn
authority even though the relevant spatial error is no longer growing.  The
normalized lateral offset instead remains finite, preserves the correct turn
sign without the failed fore-aft reversal, and tends to zero at the target.
The anterior oscillator, traveling-wave lag, static `11 deg` request, `0.50`
phase allocation, direct heading-rate damping, and action cap remain unchanged.

This uses only target-relative body-frame distance and lateral offset; it has no
elapsed time, global coordinates, prescribed flow, remote wake probe, or route.
Support requires preserving approximately the `0.50` anchor's upstream leg and
`2.13L` approach while reducing the late upward hook, producing a second
approach/capture, or materially lowering lateral drift and loads.  It is
falsified if the blend weakens the first approach, repeats the same upper exit,
or changes loads without changing route topology.  A negative result should
restore the plain `0.50` anchor and retire close lateral-offset substitution,
not prompt another phase-boost or receding-distance retune.
