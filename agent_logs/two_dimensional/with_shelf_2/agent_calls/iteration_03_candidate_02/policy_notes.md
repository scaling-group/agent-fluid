# Multi-wake target-policy candidate notes

## Prior evidence and visual diagnosis

- The assigned parent identifies the target-blind seed's saturated lower exit
  as a steering failure, while its inherited notes show that bearing-dependent
  mean-curvature equilibria erased the initialized traveling bend and were
  advected out of the downstream boundary within `17.04--18.11` release-time
  units. Those completed negative results rule out another equilibrium-shift
  or scalar-only gait adjustment as the next test.
- The common held-fish prewarm sheet shows the same developed interacting
  four-cylinder wake and upper-right release pose for every candidate; it is
  initial-condition evidence, not candidate credit.
- The sampled seed sheet shows active propulsion but an almost monotone dive:
  it moves `(-3.545,-13.300)L`, reaches only `8.615L` minimum distance, hits
  both joint velocity and acceleration caps, and leaves the lower boundary at
  `50.127`. The posterior-only half-cycle variants reproduce essentially the
  same topology. `solver_785c44ad57e0` lasts `54.896`, reaches `8.203L`, and
  moves `(-4.557,-13.291)L`; `solver_ab5b90e78e2b` lasts `52.536`, reaches
  `9.294L`, and moves `(-4.240,-13.366)L`. Their released sheets show no
  durable target-directed yaw, so posterior asymmetry alone did not supply
  enough steering authority.
- In contrast, `solver_928f830d4c45` applies bearing-selected half-cycle
  asymmetry to both joints while retaining the zero-centered traveling bend.
  Its sheet visibly changes trajectory topology: by the middle frames the fish
  has turned into a sustained upstream traverse toward the target/wake corridor
  instead of immediately diving. The metrics agree: release survival rises to
  `91.245`, upstream displacement to `-9.726L`, progress to `0.2575`, and
  minimum distance improves to `4.621L`; mean command energy falls from the
  seed's `1496.25` to `853.18`.
- That improvement is incomplete. The last two keyframes show a sharp
  nose-down turn followed by lower-boundary exit, and vertical displacement is
  still `-13.313L`. Joint 1 reaches `0.732 rad` and the velocity cap, while RMS
  force/moment rise from the seed's `21.94/541.70` to `314.32/3430.21`.
  Relative-crossflow RMS rises only from `0.175` to `0.212`, so the available
  compact evidence does not justify attributing the whole late turn to a
  larger wake signal or adding uncalibrated force/flow rejection. It instead
  supports retaining the useful bearing asymmetry and testing whether its
  persistent, position-only request fails to anticipate the rapid turn.

## Policy hypothesis

Use the evaluated `solver_928f830d4c45` controller as the propulsive and
steering scaffold, but replace instantaneous-bearing steering with a bounded
short-horizon bearing prediction formed from the observed bearing and its
windowed body-frame rate. When the target bearing is already moving toward
zero, the rate term should release the half-cycle bias before the fish crosses
the desired heading; when bearing is diverging, it should retain or strengthen
the corrective request. Clamp the rate contribution below the static bearing
scale so wake-driven short-window motion cannot dominate the route command.
Both joints keep the same asymmetry composition, posterior lag, and smooth
acceleration limit, isolating the new predictive damping mechanism.

Expected evidence after evaluation is preservation of the early upstream
traverse and improvement beyond the `4.621L` closest approach without the same
late nose-down exit. Preferably joint-1 angle/velocity occupancy and RMS
force/moment also fall. Falsify the addition if it weakens early propulsion,
recreates the short downstream exit, leaves the late lower-boundary topology
unchanged, or reduces steering so much that closest approach regresses toward
the seed and posterior-only variants.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking combined with asymmetric-flapping turning
source_mechanism: use observed direction-error trend to modulate a bounded half-cycle steering bias before heading error overshoots
transferable_invariant: a persistent body-frame bearing sets turn direction while its observed rate can continuously reduce or counter-steer a rhythmic gait as alignment is approached
nontransferable_details: published controller gains, robot and species geometry, dimensional beat frequencies, prescribed CPG phase, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: preserve the normalized joint-state traveling bend and two-joint half-cycle asymmetry; add a clamped bearing-window-rate contribution to body-frame bearing before its smooth steering saturation
falsification: reject if early upstream propulsion is lost, closest approach regresses, the late nose-down lower exit remains, or load and cap occupancy do not improve despite a materially different bearing response
