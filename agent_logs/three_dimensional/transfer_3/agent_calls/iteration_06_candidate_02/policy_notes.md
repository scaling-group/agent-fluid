# Candidate diagnosis and policy hypothesis

## Evidence read before the policy edit

- All four sampled solver rollouts satisfy the frozen initialization contract:
  direct uniform still water (`U_infinity=(0,0,0)`), no cylinders, no prewarm
  snapshot, and finite capture at about `25.11 T`. The prefilled v23
  response-released policy is the strongest scalar result (score
  `-0.52833877`, mean distance `2.42929378 L`, capture at `25.1185 T`). The
  phase-selective v23 comparator scores `-0.52837563` with mean distance
  `2.42929836 L` and capture at `25.1130 T`; the duplicated v22 closure-preview
  baseline scores `-0.53006032`, with mean distance `2.43063592 L` and capture
  at `25.1130 T`.
- I inspected every sampled combined sheet, including the top-down vorticity
  and oblique body/Lambda2 rows, from release to capture. The fish are
  self-propelled rather than advected: each grows a coherent alternating
  posterior wake through the broad target-directed arc, keeps a finite 3D
  vortex chain, then replaces the visible oscillation with a smooth curved
  approach into the capture circle. There is no collision, boundary-exit
  precursor, or visible instability. The nearly identical sheets localize the
  v23 differences to the narrow terminal allocation rather than the outer
  trajectory or wake mechanism.
- The inherited slow approach-hold result is the informative failure topology.
  Its valid two-view sheet shows a coherent early wake but broad drive relief
  turns the fish past the target into a large orbit before eventual capture at
  `51.6450 T` (score `-1.197386`, mean distance `3.150771 L`, 622 moving-window
  shifts). This rules out generic braking, broad near-target drive relief, or
  another low-drive hold.
- All three current fast policies remove inside-`4 L` command incidence above
  `30 rad/T^2` and avoid joint-stop dwell. On the prefilled response-release
  rollout, terminal acceleration maxima remain `29.605/26.724 rad/T^2`, joint
  excursions `0.755/0.662 rad`, and lateral-force/yaw-moment coefficient
  magnitudes `0.01548/0.00800`. Thus the remaining opportunity is not more
  curvature magnitude or a larger actuation envelope.
- The evaluated response release is positive but mixed: relative to v22 it
  lowers the mean-distance integral by `0.001342 L`, yet restores carrier on
  both joints and delays capture by one `0.0055 T` step. The phase-selective
  alternative reaches the circle at the v22 time and has slightly smaller
  terminal loads, but does not beat response release on mean distance. These
  results support retaining state-triggered release while testing whether the
  anterior and posterior joints should receive different roles.

## Policy hypothesis

Preserve v23's closure preview, body-frame geometry redirect, two-joint
curvature equilibrium, response trigger, carrier floor, and all outer commands.
Split only the settled response release by joint role: keep the anterior joint
at the fully allocated closure-previewed curvature blend, while allowing the
posterior joint to use the existing normalized equilibrium-tracking response
to recover bounded carrier authority. The anterior joint therefore continues
to anchor the target-directed mean bend; the posterior joint receives the
extra rhythmic allocation where tail-end motion is most likely to retain the
v23 progress benefit. This changes no turn sign, route, clock, target identity,
world coordinate, or observation adapter.

Expected evidence is byte-equivalent commands before terminal reallocation,
the same coherent outer wake, no return of joint-stop dwell or clipping, mean
distance no worse than the v22 baseline, and capture no later than the current
v23 response release. Reject the mechanism if posterior-only recovery loses
the v23 mean-distance gain, delays or loses capture, produces the inherited
low-drive orbit, disrupts the alternating wake, or materially increases
terminal joint excursion, force, or moment.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and carangiform robotic-fish joint-role allocation
source_mechanism: anterior bending sustains and steers the body wave while posterior lag and motion carry greater propulsive authority
transferable_invariant: when two joints share terminal steering and rhythmic propulsion, preserve anterior mean-curvature authority and place recovered oscillatory authority preferentially at the posterior joint
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame geometry and closure gates; after normalized two-joint tracking error shows the bend has formed, apply the existing bounded response release only to posterior carrier-versus-curvature allocation while anterior allocation remains on the validated curvature blend
falsification: reject if pre-terminal commands change, mean-distance or capture regresses, wake coherence is lost, or terminal saturation and load spikes return

The new CFD result is intentionally not claimed here; it becomes evidence for
a later worker.

## Non-CFD implementation audit

The deterministic contract state returns two finite bounded commands and the
parameter-schema check resolves every direct `params.FIELD` reference. A
synthetic comparison against the evaluated v23 parent confirms exact command
equality outside the terminal band and while the terminal equilibrium is
unsettled. On a settled terminal state, the posterior command remains exactly
equal to v23 while only the anterior command changes (from `0.13946` to
`0.11640 rad/T^2`), confirming the intended joint-role split. This is an
activation and noninterference audit, not coupled-flow evidence.
