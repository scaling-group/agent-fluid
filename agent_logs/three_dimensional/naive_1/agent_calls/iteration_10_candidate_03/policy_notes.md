# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
  instability. In the combined sheets, the top-down rows show sustained
  alternating red/blue caudal streets and the oblique rows retain discrete
  three-dimensional Lambda2 structures through the approach and boundary
  exit. Motion is self-propelled; the common failure is planar route control,
  not advection or loss of the propulsive wake.
- The strongest sampled approach remains the whole-body half-cycle policy
  (`solver_24724bc7bb0b`): `3.691L` at `20.46T`, with `1.364 rad` of full
  head-relative target error. It then follows the same long lower-going path
  and exits at `33.27T`. Its mean anterior/posterior angles over `18--22T` are
  approximately `+0.243/-0.103 rad`, so its phase-selected carrier still forms
  an S-shape rather than sustained same-sign curvature during the miss.
- The assigned parent's live one-sided-envelope test
  (`solver_237089f89ff4`) is the informative negative result. Its two visual
  rows keep the alternating wake, and its anterior mean over `18--22T`
  increases to about `+0.282 rad`, but the posterior mean remains oppositely
  signed at about `-0.076 rad`. Minimum distance slightly worsens to `3.712L`,
  the lower exit remains at `32.95T`, and full error is still `1.291 rad` at
  closest approach. Trading the cancelling anterior excursion did not create
  enough whole-body yaw authority.
- The parent does modestly reduce rate-cap occupancy from about `13.36/5.47%`
  to `12.34/5.01%`, and its wake does not decay like the earlier damped
  terminal-curvature failure. Its better scalar score (`-10.346` versus
  `-10.384`) comes from slightly better mean/final distance, not capture or a
  different trajectory topology. More envelope shift, redirect gain, tail
  relief, or observation-gate tuning would therefore ignore the surviving
  falsification.
- The inherited optimizer logs also contain an evaluated same-sign posterior
  C-bend (`solver_94750f47d14e`). This is a narrow positive mechanism result
  but a task failure. Its `1.35 rad` gate starts at `19.83T`, only `0.63T`
  before the closest approach, so the minimum is effectively unchanged at
  `3.692L` and lower exit advances to `32.23T`. After activation, however, its
  posterior mean changes from the reference's `-0.065` to `+0.120 rad` over
  `24--28T`; mean heading rate over `28--32T` rises from `0.126` to
  `0.320 rad/T`, and mean full error there falls from `2.558` to `1.893 rad`.
  The visual carrier remains alternating in both rows. Same-sign curvature can
  generate yaw, but post-miss recruitment is too late to capture.
- Full target error first exceeds `0.9 rad` near `14.36T` and `5.55L` in the
  reference, well before the `20.46T` minimum. A proximity-and-error schedule
  can therefore recruit the evidenced C-bend progressively in the middle
  approach instead of merely lowering one angle threshold or changing its
  amplitude. The inherited rate/load boundary remains roughly `13.7/5.5%`
  joint-rate occupancy and `0.032/0.016` force/moment peaks.

## One candidate hypothesis

Start from the sampled `3.691L` whole-body half-cycle policy. Preserve its
anterior oscillator, slip-aware anterior center, phase-selected redirect, and
posterior carrier redistribution. Reuse the C-bend's demonstrated shape
change, but replace its post-miss angle-only recruitment with one middle-
approach semantic: normalized distance and moderate full target error jointly
ramp an early same-sign posterior offset, while the evaluated high-error gate
remains available after a miss. A smooth union of those gates recruits the
bend before closest approach without switching it off merely because distance
starts rising. The normalized lateral target component supplies a continuous,
reflection-equivariant direction, including after the target passes abeam;
realignment continuously removes the offset and restores the inherited
traveling wave. This is an approach-conditioned controller mechanism, not a
scalar-only increase to the already tested offset.

The falsifiable expectation is unchanged far-field motion and wake formation,
followed by same-sign joint means and target-side yaw before `20T`, rather
than only after the reference miss. Reject the mechanism if closest approach
does not beat `3.691L`, full error there does not fall below `1 rad`, the
coherent wake is lost, posterior mean remains opposite-signed in the scheduled
approach, the lower exit is not meaningfully delayed or avoided, joint cycling
collapses into coasting, or rate/load envelopes materially exceed the sampled
bounds.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish mean-curvature turning
source_mechanism: sensor-conditioned amplitude and offset modulation recruits a bounded whole-body bend during approach, then realignment releases the asymmetry back to a propulsive traveling wave
transferable_invariant: recruit target-signed curvature across the available body joints early enough to alter the miss while preserving the rhythmic carrier and continuous release
nontransferable_details: species-specific C-start shapes, published gains, dimensional frequencies, clock-driven phase, robot linkage geometry, prescribed maneuver duration, exact vortex phase, and task-specific routes
policy_translation: a smooth union of a normalized distance-and-moderate-error approach gate with the evaluated high-error gate schedules same-sign posterior curvature; normalized lateral target displacement supplies continuous direction while joint state retains the inherited anterior oscillator and lagged posterior carrier
falsification: reject if the 3.691L minimum or 1 rad error boundary is not improved, target-signed posterior mean and yaw do not appear before the miss, the wake or cycling decays, the lower exit persists without meaningful delay, or rate and yaw-load envelopes worsen materially
