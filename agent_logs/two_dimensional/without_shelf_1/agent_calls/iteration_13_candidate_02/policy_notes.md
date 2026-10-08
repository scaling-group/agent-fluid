# Multi-wake candidate visual diagnosis and hypothesis

## Evidence diagnosis before the policy edit

The shared prewarm sheet shows the common held fish above and downstream of
four fully developed interacting wakes; it is initial-condition evidence, not
a candidate difference.  The released sheets show that the useful candidates
self-propel upstream into the wake rather than merely drift with it.  They also
show the same unresolved topology: after a descending/upstream approach above
the target corridor, the fish turns into a sharp upper hook and exits the top
of the domain.

The sampled `0.35` opposing-phase headroom boost is the strongest finite
far-field anchor.  Relative to the plain static `11 deg` policy, it improves
head-x travel from `-7.89L` to `-11.33L`, minimum distance from `4.87L` to
`3.03L`, progress from `0.424` to `0.517`, and mean distance from `7.52L` to
`6.44L`.  Its mean head velocity x (`-0.171`) remains more upstream than the
mean local flow x (`-0.119`), confirming active propulsion.  This improvement
does not solve steering: both policies still leave through the upper boundary,
their center-y displacements at termination are both about `+1.20L`, and the
boost still reaches both joint rate/command caps.  It also raises RMS
force/moment from `406/4113` to `511/5305`.  The phase boost is therefore a
far-field approach mechanism with a load cost, not evidence that the terminal
curl is repaired.

The globally active receding-speed reversal contains a complementary but
incomplete mechanism.  It produces the best sampled closest approach
(`2.67L`), survives `73.85` release units, lowers posterior peak angle to
`0.713 rad`, and lowers RMS force/moment to `367/3880`.  Yet it loses far-field
head-x travel (`-7.45L`), mean distance (`7.59L`), and progress (`0.405`), and
still ends at the same upper boundary.  Its recovery signal is thus worth
testing only after the stronger phase-headroom anchor has already entered the
near-target region; allowing intermittent receding episodes to reverse the
bearing drive throughout the upstream leg is falsified by the sampled loss of
approach.

## Single candidate hypothesis

Preserve the complete `11 deg`, `25 deg`, `0.70/0.35` controller and its
sampled `0.35` opposing-phase boost.  Add the sampled bounded receding-speed
bearing reversal, but multiply it by a smooth distance gate that is zero at
and beyond `3.75L` and reaches full strength at `2.75L`.  The gate cannot alter
the far-field phase-headroom behavior, and receding speed is rotation-invariant
radial evidence that the fish has begun to depart after a close approach.  No
elapsed time, global coordinates, route, prescribed flow, or remote wake probe
is used.

The expected rollout should retain roughly the boosted anchor's upstream leg
and first approach, then use recovery only after a near-target miss starts to
open.  Support requires a second approach, capture, or a clear reduction of the
terminal upper hook without materially regressing the `-11.33L` travel and
`3.03L` closest approach.  Falsify this synthesis if it never enters the
distance/receding gate, repeats the same upper exit, loses the boosted
far-field approach, or increases loads without changing route topology.  In
that case later workers should keep the phase boost only as propulsion evidence
and should not stack broader recovery or approach attenuation onto it.
