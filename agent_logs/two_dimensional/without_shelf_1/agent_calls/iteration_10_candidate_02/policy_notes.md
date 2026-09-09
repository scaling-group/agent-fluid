# Candidate wake-policy diagnosis

The common prewarm sheet shows the fish held in the upper-right while the four
cylinders develop overlapping staggered vortex streets; it is shared
initial-condition evidence, not a policy difference. After release, all four
sampled sheets show the fish producing its own alternating wake and moving
upstream, but they also show the same broad upper arc: the fish approaches only
the upper edge of the developed wake region, turns nearly horizontal, then
curls upward immediately before `left_domain`. The trajectory never enters
the target circle or the useful central corridor behind the second cylinder
row. This interpretation agrees with negative head-x displacement
(`-5.62L` to `-7.89L`) and negative mean local-flow x, yet nearly invariant
positive head-y drift (`+1.77L` to `+1.80L`) and center-y exit near `+1.20L`.

The `10 deg`, `25 deg` bearing-scale, `0.70/0.35` direct-turn-rate anchor is the
clean finite baseline. Raising static bias to `11 deg` improves progress from
`0.380` to `0.424` and closest approach from `5.33L` to `4.87L`, but leaves the
upper loop unchanged, raises posterior peak angle from `0.770` to `0.781 rad`,
and raises RMS force/moment from `325/3331` to `406/4113`. Increasing turn-rate
damping to `0.80` or reducing bearing scale to `20 deg` also leaves the loop
unchanged while regressing progress. The inherited phase-selective-relief
descendant is negative as well: compared with the anchor it reaches only
`0.250` progress, `6.88L` closest approach, and `-4.59L` upstream head travel,
despite a modest load reduction to `302/3197`, before the same `left_domain`
termination. The assigned-parent descendant's still lower `215/2535` loads
coincide with only `0.102` progress and `8.37L` closest approach, so reduced
effort without retained approach is not a repair.

## Policy hypothesis

Restore the supported `10 deg`, `25 deg`, `0.70/0.35` steering anchor and leave
the anterior oscillator, lag, and acceleration ceiling unchanged. Add only a
parameter-owned `40 deg` clamp to the posterior servo target after the
traveling-wave and steering terms are combined. The present unbounded target
can ask the posterior joint to exceed its `45 deg` physical envelope, while
sampled rollouts already reach `44.1--44.7 deg` plus both rate and acceleration
caps. A target margin should preserve the mid-range phase and geometric
steering signal rather than weakening bearing authority according to gait
phase, while preventing the servo from continually pursuing an infeasible
posterior bend.

The next CFD evaluation should retain roughly the anchor's `0.380` progress
and upstream displacement while reducing posterior peak angle, cap residence,
and force/moment load; a lower or non-upper route would be stronger evidence.
Loss of upstream progress like the phase-selective descendant, unchanged
posterior saturation, or the same upper exit without load relief falsifies the
target-margin mechanism. No current-worker CFD outcome is claimed here.
