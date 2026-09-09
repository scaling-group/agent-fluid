# Wake-policy candidate notes

## Prior-evidence visual diagnosis

The shared prewarm sheet establishes the common initial condition: the held
fish is above and downstream of four developed, interacting vortex streets.
The released sheets then distinguish controller mechanisms. The inherited
slower, smaller, curvature-centered policy remains to the right of the useful
wake corridor, loops without a targetward transit, and ends in a compact
body/vortex blow-up after `121.517` released time. That visible failure agrees
with `unstable_dynamics`, only `0.227` progress, `9.238L` closest approach,
RMS relative crossflow `1.138`, lateral force `16749.8`, and yaw moment
`290421`. Its low mean command energy is therefore not useful efficiency.

In contrast, the direct bearing-to-acceleration residual produces an immediate
targetward turn and preserves a coherent posterior-lagged traveling bend. The
unmixed residual reaches the `0.75L` capture boundary after `62.304` time with
head displacement `(-10.922,-4.153)L`, mean distance `2.460L`, and modest
force/moment RMS `27.25/525.79`. The steering-reserved `30.0` acceleration
envelope retains the same trajectory topology but reaches after `49.142` time,
improves mean distance to `2.156L`, and reduces mean command energy from
`1436.3` to `1272.3`. This is the strongest finite sampled policy. Its
acceleration maxima are bounded at `30.0`, but both joint speeds still touch
the episode cap `4.538`; the evidence reports maxima, not saturation duty.

The successful and failed examples do not calibrate a signed flow, force, or
moment residual: the aggregate signals mix route, wake phase, and terminal
dynamics. The next candidate therefore uses only the proven normalized
body-frame bearing plus normalized current joint-speed feedback.

## Candidate policy hypothesis

Preserve the best sampled `0.55`-period, `28`-degree joint-state oscillator,
posterior lag, positive body-frame bearing residual, `30.0` acceleration
envelope, and `0.20` steering reservation. Add one compatible closed-loop gait
mechanism: normalize each observed joint speed by a candidate-owned soft speed
envelope and smoothly attenuate only the carrier acceleration that has the
same sign as an already fast joint. Opposing carrier acceleration remains
available for braking, and target-bearing steering keeps its reserved share.
This is a state-dependent actuator allocation change, not scalar-only gain
tuning.

Expected test: retain target reach, coherent left/down self-propulsion, and the
best policy's direct wake traversal while reducing speed-cap contact and
command effort. Falsify the guard if capture is lost or materially delayed,
leftward progress weakens, the steep lower exit or instability returns,
braking is impaired, or effort/load does not improve enough to justify any
arrival penalty. The new CFD result is unavailable to this worker and is not
claimed as evidence.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and residual path-following control
source_mechanism: sensor-conditioned locomotor-carrier modulation with explicit bounded steering authority
transferable_invariant: when actuator-state headroom shrinks, attenuate the rhythmic component that would drive farther into a limit while preserving braking and finite body-frame direction feedback
nontransferable_details: published gains, robot actuator ratings, dimensional beat rates, clocked phases, species kinematics, exact vortex phases, and source-task routes
policy_translation: normalize each current joint speed by a candidate-owned envelope, smoothly gate only same-direction carrier acceleration, then combine it with the proven bearing residual through the successful steering-reserved two-joint mixer
falsification: reject if target reach, direct targetward displacement, or coherent traveling-bend propulsion is lost, or if speed contact, effort, and loads do not improve enough to offset any slower arrival
