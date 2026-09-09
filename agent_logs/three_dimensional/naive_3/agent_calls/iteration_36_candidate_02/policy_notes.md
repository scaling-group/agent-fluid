# Counterphase terminal wave-propagation candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts and the relevant inherited rollouts use
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected the top-down mid-plane-vorticity and oblique body/Lambda2 rows.
  Every fish self-propels and retains a coherent alternating planar wake with
  compact three-dimensional structures; passive advection, wake collapse,
  collision, boundary exit, and instability do not explain the misses.
- The prefilled terminal course hold (`solver_6eb170b0d70a`) remains the best
  sampled trajectory at `1.241/4.158/2.082L` minimum/mean/final distance. Its
  visibly tight late return contrasts with the broad concentric loops of the
  rear selector, equilibrium unbend, and fixed-sign restart, which reach only
  `2.366L`, `2.215L`, and `2.369L`. At the three failed minima both joints are
  nearly stationary in a common negative C-bend, although vehicle speed and
  wake coherence remain finite.
- The inherited optimizer evidence closes the simplest shelf transfers. A
  requested-sign anterior half-cycle pulse reaches only
  `1.702/3.921/3.574L` and parks both joints. Low-activity feedback parallel to
  anterior velocity on both half-cycles is the sole later semantic
  improvement: it reaches `1.175/4.041/3.243L`, remains inside `1.25L` for
  about `2.35T`, preserves near-target mean `|phi_dot|` near
  `0.775/0.360 rad/T`, and lowers clamp/load residence relative to the
  course-hold sample. Preserve that phase-balanced mechanism rather than
  repeating a signed restart or static bend edit.
- The follow-ups delimit the missing capability. Biasing only the requested
  anterior half-cycle collapses back to a broad parked orbit at `2.362L`;
  a stronger radial activity regulator reaches `1.366L` but never enters
  `1.25L`; and an inherited posterior phase-response branch reaches `1.276L`
  with `2.881L` final distance but does not improve the sampled course hold.
  Thus scalar energy, one-joint duty asymmetry, direct target-ray acceleration,
  and posterior lag response do not jointly solve inward terminal steering.
- At the `1.175L` phase-balanced minimum, speed is `0.683U`, course error is
  `1.682 rad`, course dot is `-0.111`, target-behind weight is essentially
  one, and terminal weight is `0.533`. The joints are in a measured
  counterphase transition: `phi_dot_1=-0.394` moves into the requested negative
  turn while `phi_dot_2=+0.260 rad/T` releases the posterior bend. Commands
  remain modest at about `(5.50,0.43) rad/T^2`, so there is dynamic and command
  reserve for a coupled wave-propagation test rather than more equilibrium
  curvature.

## Policy hypothesis

Start from the completed `1.175L` phase-balanced terminal-energy controller,
preserving its body-frame course hold, moving C-turn equilibrium, symmetric
low-activity energy feedback, posterior lag/brake, wave envelope, and command
limit. Add one small compatible nonsteady mechanism: under the existing
target-behind terminal selector, require *both* measured counterphase motions
before applying a burst. Joint 1 must already move into the requested course
turn and joint 2 must already move in the opposite, bend-releasing direction.
Then apply equal-and-opposite bounded accelerations parallel to both motions.
The term is zero when either joint is stationary or on the wrong phase, so it
cannot create a static equilibrium and does not repeat the failed one-joint
duty bias. The unchanged phase-balanced regulator remains responsible for
preventing a parked bend.

Frozen replay on the completed `1.175L` trace predicts a
`0.0137/0.718 rad/T^2` mean/maximum paired action magnitude overall and only
`0.000023/0.00211 rad/T^2` beyond `3L`. Inside `1.5L` the mean/maximum is
`0.0814/0.646 rad/T^2`; at the `1.175L` minimum it changes the two actions by
about `(-0.328,+0.328) rad/T^2`. Estimated clamp residence stays near
`0.223/0.103`. These values establish locality, sign, and reserve only; the
new coupled CFD result is unavailable until this worker exits.

Support requires capture, a pass below `1.175L`, longer residence inside
`1.25L`, or a materially tighter final loop while preserving active joint
motion, the coherent wake, and comparable command/load residence. Reject if
the approach broadens, either joint parks, the pair disrupts posterior lag,
clamp/load residence rises materially, or minimum, near-target residence,
mean, and final distance fail to improve together.

```text
bookshelf_consulted: true
source_domain: nonsteady biological C-start redirection and sensor-modulated robotic-fish traveling-wave control
source_mechanism: a strong turn is produced by a state-triggered bend-to-counterbend transition whose posterior release remains coordinated with the anterior turn, rather than by a static bias or a clocked pulse
transferable_invariant: preserve the active anterior-to-posterior wave and add bounded energy only when measured joints already occupy the requested counterphase transition; release when either component of that propagation disappears
nontransferable_details: published gains, dimensional beat frequency, species-specific C-start kinematics, full-body joint count, robot duty ratios, clocked CPG phase, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-ray/course error supplies turn sign; normalized anterior and posterior joint velocities jointly select a reflection-equivariant equal-and-opposite acceleration pair inside the existing target-behind terminal gate
falsification: reject if cruise or wake coherence changes, either joint parks, the counterphase pair enlarges the orbit, command/load margins worsen, or closest approach, near-target residence, mean distance, and final distance do not improve over the phase-balanced scaffold
```

## Evaluation boundary

No formal CFD is run in this workspace. Dry contract, schema, reflection, and
frozen-trace probes can test implementation semantics but cannot establish a
hydrodynamic improvement.
