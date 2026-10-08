# Candidate wake-policy diagnosis

## Evidence read before editing

- The assigned parent preserves the soft-enveloped acceleration-reserve
  velocity-course carrier and recommends a high-onset bidirectional speed
  allocation test after both isolated directions preserved capture.
- No inherited optimizer note file is present in this workspace; the durable
  inherited record is `guidance/control_experience.md`.
- All four sampled rollouts report `uniform_direct` initialization with zero
  background velocity. The duplicate unguarded soft-envelope samples capture
  at `16.943T`, score `-0.205386`, and mean distance `2.08985L`, but both
  joints sit exactly at the speed limit for about `3.73/3.54%` of samples.
- The posterior-to-anterior-only speed allocation remains viable but is the
  informative regression: capture moves to `17.060T`, mean distance to
  `2.09311L`, and score to `-0.208655`. It removes exact speed contact and
  lowers peak force to `0.03546`, but it does not recover the unguarded route.
- The bidirectional sample is the strongest finite policy: it captures at
  `16.988T`, improves mean distance to `2.08931L` and score to `-0.204764`,
  and holds joint speeds below the stops at `4.5189/4.5237 rad/T`. Its cost is
  a lower `1.3737U` peak speed and slightly higher peak force/yaw moment of
  `0.03634/0.01804` than the unguarded parent's `0.03609/0.01766`.
- In both the best bidirectional sheet and the regressive one-way sheet, the
  top-down row shows the same alternating self-propelled street through
  approach and capture, while the oblique row shows compact three-dimensional
  Lambda2 structures following the body. Peak local flow is only
  `0.0313--0.0315U` versus `1.374--1.383U` body speed, so neither the gain nor
  regression is passive advection or wake collapse.
- A phase audit of the unguarded trace finds 199 anterior high-speed,
  positive-work donor samples. The posterior joint is already braking in 198
  of them and doing positive work in only one. Therefore the successful
  anterior-to-posterior branch is evidenced as a counterphase traveling-wave
  correction, not as generic positive-work recycling.

## Policy hypothesis

Start from the sampled bidirectional high-onset controller. Preserve its
zero-centered anterior oscillator, posterior carrier/steering reserve, soft
acceleration envelope, posterior stopping-risk projection, and both normalized
speed guards. Make only the anterior-to-posterior cross-joint path explicitly
phase classified: transfer a bounded donor correction only when the posterior
carrier agrees with the assembled posterior command and that carrier direction
is braking the observed posterior motion. A C1 gate rises from zero posterior
speed to full authority at `0.30` of the speed limit, so a near-stationary
receiver does not receive a discrete carrier impulse. Retain the separately
evidenced posterior-to-anterior positive-work path.

The sampled bidirectional policy has 124 active anterior-to-posterior
correction rows; 90 have posterior speed below `0.30` of the limit, none have
the wrong braking sign, and their mean/minimum speed fractions are
`0.299/0.128`. Offline source-state replay changes 90 of 3,089 commands, with
a maximum delta of `0.434 rad/T^2` (`1.4%` of the acceleration envelope). The
smooth phase-confidence gate therefore makes a material but localized change
instead of reproducing the sampled policy exactly. It should preserve the
established counterphase correction while reducing low-speed posterior
impulses and preventing an
unevidenced positive-work pulse if a held-out route changes phase relation.
Reject the mechanism if CFD loses capture or the alternating/3D wake, restores
exact speed contact, arrives later than `16.988T`, worsens mean distance above
`2.08931L`, or exceeds the sampled bidirectional `0.03634/0.01804`
force/moment envelope. Even if viable, it has not fully recovered the
unguarded `16.943T` arrival and should not be called an efficiency improvement
without new evaluated evidence.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish CPG coupling
source_mechanism: use observed oscillator phase to condition inter-joint coordination without an external clock
transferable_invariant: cross-joint correction should be admitted only in a receiver phase compatible with the traveling bend
nontransferable_details: published gains, oscillator frequencies, duty ratios, body segmentation, and prescribed phase offsets
policy_translation: infer donor positive work and posterior counterphase braking confidence from normalized joint angle/velocity state, then retain bounded C1 phase and receiver-headroom gates inside the two-joint acceleration contract
falsification: reject if capture or coherent shedding is lost, a speed hard stop returns, route metrics regress from the bidirectional sample, or force and yaw moment exceed its envelope
