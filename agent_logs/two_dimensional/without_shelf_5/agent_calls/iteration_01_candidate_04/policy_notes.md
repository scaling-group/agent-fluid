# Candidate wake-policy notes

## Evidence read before editing

The assigned parent is the deliberately naive, target-blind state oscillator
in `solver_899193877bf6`; no inherited optimizer log is present in this fresh
workspace. The sampled set contains only this failed rollout, so the useful
finite portion of that rollout is the comparison point rather than a separate
successful example.

The shared prewarm sheet shows the common held fish at the upper-right start
and four developed, interacting vortex streets reaching downstream through the
target corridor. In released frames 1--3 the fish initially points and moves
diagonally toward the target and sheds a compact body wake. This agrees with a
minimum distance of `8.61495L` and head displacement `-3.545L` in x: the seed
does have some upstream propulsive effect. Released frames 4--6 then show an
abrupt turn into a nearly vertical descent, away from the green target ring,
followed by lower-domain exit at only `50.1269/300` time units. It never reaches
the central useful wake/target region.

The terminal visual failure is consistent with the diagnostics rather than
being only a dramatic vortex pattern. Head y displacement is `-13.300L` while
x displacement is only `-3.545L`; mean fish y velocity (`-0.2633`) nearly
matches mean local-flow y (`-0.2414`), so the lateral plunge is substantially
advection-dominated despite the upstream propulsion. RMS relative crossflow is
`0.1747`, RMS force y is `21.94`, and RMS moment is `541.70`. Both joints reach
about 26 degrees, both angular velocities hit the `260 deg/time` cap, and both
accelerations hit the `1800 deg/time^2` cap. For the seed's 28-degree,
0.55-time gait, the simple oscillator scales are about `320 deg/time` and
`3655 deg/time^2`, already beyond both envelopes before wake loads or tail
tracking are considered. The high-frequency target-blind gait therefore
spends the steering headroom needed to resist the crossflow and yaw toward the
target.

## Policy hypothesis

Use one slower, cap-respecting state oscillator and add a bounded target-bearing
tail-curvature bias. The Van der Pol amplitude parameter is a nonlinear scale,
with a small-mu free limit cycle near twice that scale, so a 15-degree scale
and `0.95` period target roughly a 30-degree cycle. Its nominal peak velocity
and acceleration are about `198 deg/time` and `1313 deg/time^2`, below the
fixed caps rather than relying on cap clipping to shape the gait. A tail-lag
gain of `0.55` keeps the unsteered posterior target near 34 degrees; even its
maximum 8-degree steering offset is intended to remain inside the 45-degree
joint envelope. The posterior joint retains the seed's lagged traveling-bend
target, but higher damping should reduce load-driven ringing.

The steering signal combines body-frame bearing with bounded heading-rate and
lateral-velocity damping, then passes through `tanh`; it cannot command more
than an 8-degree posterior offset. Positive body-frame bearing calls for a
negative posterior offset, matching the turn-direction convention in the
testbed's two-joint turn diagnostic. This uses neither coordinates nor elapsed
time. The falsifiable expectation is survival beyond 50 time units with joint
rates/accelerations below their hard limits, retained upstream progress, and a
trajectory whose y descent bends back toward the target instead of continuing
to the lower boundary. If it instead loses the seed's early distance gain, the
slower gait is under-driven; if it exits with unsaturated joints, the steering
sign or authority rather than actuator headroom is the next variable to test.
