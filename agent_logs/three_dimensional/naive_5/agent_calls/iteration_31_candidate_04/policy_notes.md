# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled solver rollouts, the assigned carrier-relief parent, and
  the two inherited completed mechanism rollouts satisfy the direct-uniform
  still-water contract (`U_infinity=[0,0,0]`, no cylinders, no prewarm) and
  terminate in capture. The strongest sampled translation-consistent policy
  reaches `0.748338L` at `26.2460T`; the assigned parent reaches `0.748792L`
  at `26.3615T` with a slightly larger mean distance (`2.519735L` versus
  `2.518971L`).
- The combined sheets were inspected from release through termination for the
  strongest sample, the assigned parent, the inherited duty-ratio descendant,
  and the inherited force-response descendant. Both visual rows show genuine
  self-propulsion, an orderly alternating top-down wake, and a coherent
  oblique three-dimensional wake through the same late upward hook. None shows
  imposed advection, wake breakup, boundary interaction, or moving-window yaw.
- Metrics confirm that the two inherited mechanisms are informative failures,
  not new trajectory classes. Target-side return dwell captures at
  `0.749723L` and `26.3395T` with mean distance `2.520380L`; the adverse-force
  residual captures at `0.748796L` and `26.3725T` with mean distance
  `2.520014L`. The best sample, assigned parent, and both descendants all have
  identical `8T/16T` distances (`10.461883/6.229297L`), zero angle/rate/action
  contacts, the same `29.72585 rad/T^2` peak command, and the same peak planar
  force/yaw moment (`0.018834/0.009789`). Their first visible separation is
  late and remains inside the established shallow-capture topology.
- The strongest sampled trajectory exposes a different response mismatch.
  From `2T` through capture its velocity/target course error keeps the same
  sign and is about `0.68--0.95` through `8T`, while the body is already nearly
  pointed toward the target by `8T`; the head remains near `y=13.44L` rather
  than descending toward `y=9.5L`. Thus body-yaw or attained-bend release can
  report an adequate turn while the translational course still slides across
  the target line. Reweighting late response magnitude, gait duty, carrier
  energy, or instantaneous force has not corrected this earlier route defect.

## Policy hypothesis

Start from the strongest sampled translation-consistent controller and retain
its traveling-bend carrier, calibrated steering side, terminal miss veto,
line-of-sight response closure, capture-gated posterior wave shape, coordinated
command projection, and angle/rate viability guards. Add one bounded
slip-qualified redirect mechanism: when translation is reliable and closing,
the body-frame target bearing is small but the normalized velocity/target
course error remains large, retain a partial same-sign two-joint redirect on
the course-selected side. Smooth bearing/course gates make startup, genuinely
aligned translation, large-bearing redirect behavior, non-closing motion, and
the established safety envelope pass through continuously.

This changes the release criterion rather than increasing any carrier or
steering gain. It should turn the translational course earlier, visibly lower
the high middle corridor, and improve arrival or distance integral while
preserving the coherent wake. Falsify it if CFD loses capture or coherent
three-dimensional propulsion, raises actuator contacts or the sampled
force/moment envelope, weakens travel, or once again changes only the grazing
terminal hook. If rejected, later workers should not tune its gates or partial
redirect fraction; they should seek a history-backed translational curvature
observation instead of another command-side transformation.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish direction tracking
source_mechanism: release strong rhythmic curvature only after observed route response, then recover the propulsive traveling wave
transferable_invariant: body orientation and translational course are distinct responses, so persistent target-line slip should qualify turn release without increasing peak authority
nontransferable_details: burst duration, published gains, duty ratios, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, and prescribed routes
policy_translation: use normalized body-frame bearing/course disagreement, speed observability, and positive closing to retain only a bounded fraction of the existing same-sign two-joint redirect
falsification: reject on lost capture or wake coherence, new limit or load exposure, slower travel, or another milliscale-equivalent late-hook trajectory

## Non-CFD implementation audit

- Replaying the strongest sample and candidate laws on reconstructed states
  from all `4772` strongest-sample trajectory rows changes `1392` post-guard
  commands, including `1227` before `16T` and `1338` while distance is at
  least `4.5L`. Activation begins only after translation becomes observable at
  about `0.429T` and ends near `20.988T`; the maximum command difference is
  `8.147 rad/T^2` at `10.016T`, while the candidate frozen-state peak remains
  below the parent's at `29.703 rad/T^2`. This establishes a material early-
  route test rather than another terminal perturbation, but it is not CFD
  evidence of improvement.
- A deterministic `20,000`-state joint/route probe returns finite two-joint
  actions inside the `30 rad/T^2` policy envelope and has zero numerical
  lateral-reflection error. The five new direct parameter references are all
  owned by `target_policy_params()`.
