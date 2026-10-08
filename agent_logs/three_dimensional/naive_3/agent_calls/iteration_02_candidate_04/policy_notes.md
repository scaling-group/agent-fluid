# Candidate wake-policy notes

## Evidence diagnosis

- The assigned parent is the fresh-lineage guidance copied from
  `optimizer_72ea68ac2cad`. Its four inherited worker notes all proposed the
  first target-relative mean-curvature extension of the common naive carrier;
  their now-completed sampled rollouts provide the evidence for this later
  candidate. All four evaluations satisfy the lane contract: direct uniform
  still water at `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot.
- The top-down and oblique rows of the strongest finite rollout
  (`solver_7afa3aa3b5d0`) agree that posterior-only bearing/trend curvature
  preserves self-propulsion. It leaves a coherent alternating mid-plane and
  three-dimensional Lambda2 wake, travels from `x=21.00L` to `16.40L`, and
  reduces distance from `12.328L` to `9.141L`. This is a materially useful
  trajectory despite its `left_domain` termination at `13.129T`.
- The same views expose the remaining failure: the path is nearly horizontal
  through about `8T`, then bends upward while the lower-left target remains
  below the fish. Center y rises from `13.96L` at `7T` to `15.20L` at exit;
  bearing is already negative at `7T` and reaches `-1.33 rad`. The trajectory
  cross-check shows repeated away-from-target body lateral velocity during
  that recovery (`+0.353U` at `7T`, `+0.303U` at `10T`, and `+0.496U` at
  `12T`) and beat-scale yaw excursions up to about `3.10 rad/T`.
- This is not fixed by another scalar increase to the same mean-bend channel.
  The strongest controller's bounded negative curvature is already near its
  limit through much of the late recovery, while raw posterior acceleration
  exceeds the `1800 deg/T^2` envelope in about 62% of samples and posterior
  joint-rate contact occurs in about 6% of samples. The wake nevertheless
  remains coherent, so the needed change is how steering is distributed over
  the observed beat phase.
- The informative regression is `solver_54567b011e84`. Moving both joint
  centers with target bearing reduces the anterior excursion to about
  `+/-8 deg`, leaves only `0.036L` best progress, and ends farther away at
  `13.403L`. Its top-down sheet shows little early wake translation followed
  by a large upward hook; the oblique row likewise lacks the long coherent
  trail of the posterior-only case. Later workers should not move the center
  of this weakly self-excited anterior oscillator merely to obtain more
  steering authority.
- The other posterior-only variants with a wider `0.35 rad` bearing scale
  (`solver_7125e140ff9f` and `solver_f222e3379ba1`) preserve the wake but exit
  earlier, at `9.35T` and `9.19T`, with minima `11.642L` and `11.824L`.
  Therefore the sharper `0.20 rad` bearing/trend controller is the carrier to
  preserve; the evidence does not support slowing that target response.

## Policy hypothesis

Retain the strongest sampled controller's anterior oscillator, posterior lag,
and bounded bearing/trend mean curvature. Add one phase-conditioned steering
primitive only in the posterior carrier target: preserve the half-cycle on
the requested turn side and attenuate the opposing half-cycle, with a smooth
joint-state phase signal and a bounded multiplier. This one-sided form is
chosen because the sampled posterior command is already frequently clipped;
it creates asymmetry without raising the carrier's peak target. Unlike the failed
two-joint center shift, this leaves the anterior oscillator centered at zero;
unlike a larger static curvature cap, it supplies additional mean yaw through
beat asymmetry when the existing recovery channel is saturated.

The next CFD evaluation should retain the long alternating wake and leftward
surge while keeping center y below the upper boundary long enough to reduce
distance materially past `9.141L` or improve termination class. Falsify the
hypothesis if the added asymmetry collapses x progress or wake coherence,
increases rate-limit occupancy materially, produces the same upper exit
without a longer useful trajectory, or reverses the initial correct steering
sign.

bookshelf_consulted: true
source_domain: robotic-fish turning by asymmetric flapping, combined with classical traveling-bend propulsion
source_mechanism: bounded half-cycle amplitude asymmetry superposed on a phase-lagged propulsive rhythm
transferable_invariant: when a static mean bend has insufficient turn authority, observed oscillator phase can make the requested and opposing half-cycles unequal while preserving the traveling carrier
nontransferable_details: published gains, duty ratios, clock-driven phase, species-specific kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: infer posterior carrier phase only from current joint angle and velocity; smoothly attenuate only the bearing/trend-opposing half-cycle while retaining the sampled posterior mean-curvature command and its requested-side peak
falsification: reject if turn sign is wrong, the coherent wake or leftward progress collapses, joint-limit occupancy rises materially, or the same upper-boundary exit persists without a longer and closer trajectory
