# Carrier-separated terminal prediction candidate

## Visual and metric diagnosis before editing

All four sampled solver examples and the relevant inherited rollouts satisfy
the frozen contract: direct uniform initialization in still water with
`U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
termination. I inspected the combined keyframe sheets from release through
capture, including both the top-down mid-plane vorticity row and the oblique
body/Lambda2 row. The score-leading tail-only residual, directional-reserve
prefill, dual-absolute allocator, and assigned parent's envelope-sharing
candidate all visibly self-propel down-left on the same direct route. Each
retains a coherent alternating mid-plane wake and compact body-connected 3D
vortex train; none shows passive advection, wake breakup, boundary contact, or
instability. The carrier and broad navigation are therefore behavior to
preserve, while terminal observation/allocation is the informative difference.

The synchronized traces make that difference quantitative. Tail-only cubic
redirection is fastest and score-best (`15.1403T/-0.01094`) but crosses with a
`0.651L` head-relative constant-course miss, `0/1.269%` anterior/posterior
`>40 deg` dwell, and `0.04041/0.01902` peak normalized planar force/moment.
The directional prefill improves the compromise to `15.3385T/-0.01502`,
`0.461L`, `0/0.681%`, and `0.03959/0.01889`. The assigned parent's new
envelope-sharing anterior center shift does not survive its hypothesis: it
captures earlier at `15.2745T` and keeps loads at `0.03894/0.01874`, but
widens miss to `0.632L` and renews both anterior and posterior dwell at
`0.648/1.044%`. Its center displacement should not be combined with another
reserve or gain variation.

The sampled-guidance carrier-separated predictor is the positive mechanism:
relative to its approach-scheduled phase-space parent (`15.2650T`, `0.529L`,
`0/0.360%`, `0.03781/0.01864`), removing joint-rate-correlated sway only from
near-target miss prediction captures at `15.3668T/-0.01589`, improves miss to
`0.305L`, retains `0/0.358%` dwell, and stays at `0.03856/0.01846` loads.
Across five inherited direct captures, the fitted pre-terminal sway proxy was
stable (`R^2=0.842--0.927`), and offline subtraction reduced within-`3L` raw
miss variation from `0.709--0.739L` to `0.468--0.493L`. This is evidence for
an observation change, not a reason to alter the carrier or residual gain.

## Single candidate hypothesis

Materialize the completed carrier-separated controller as this workspace's one
candidate. Preserve its oscillator, posterior lag and pulse, raw body-frame
far-field pursuit/course blend, response-plus-miss handoff, cubic residual,
approach-scheduled phase-space reserve, and smooth acceleration envelope. Its
only distinct observation mechanism relative to the inherited reserve parent
is a normalized two-joint-rate estimate of carrier sway, faded in by the
existing near-target distance gate and subtracted only from lateral velocity
used for predicted miss. Raw measured velocity still controls broad course,
closing alignment, and time-to-closest. Re-evaluation here is a needed
robustness replicate because identical controllers have previously varied in
terminal margin.

Support requires capture on the direct compact-wake route, course miss at or
below the directional benchmark's `0.461L`, zero anterior dwell, posterior
dwell at or below `0.681%`, peak normalized force/moment no worse than about
`0.040/0.019`, and arrival close to the `15.14--15.37T` class. Strong support
would reproduce the sampled `0.305L` margin. Falsify on lost capture, wider
course, slower arrival without a margin gain, renewed joint/load exposure,
changed far-field motion, nonfinite action, or lost reflection equivariance.
Formal CFD remains deferred to EvE and is not evidence from this worker.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG control
source_mechanism: separate slow target-directed correction from fast carrier-linked lateral motion while preserving the autonomous traveling wave
transferable_invariant: terminal course feedback should act on motion residual to productive rhythmic sway rather than repeatedly reject the carrier itself
nontransferable_details: fitted coefficients under another carrier, published gains, dimensional frequencies, hardware geometry, species-specific kinematics, exact vortex phases, task coordinates, routes, and waypoints
policy_translation: normalize observed joint rates by the owned carrier rate, estimate reflection-equivariant lateral carrier sway, and remove it only from smoothly near-target predicted miss while leaving raw velocity in far-field course and approach timing
falsification: reject if capture, direct compact wake, margin, arrival, two-joint reserve, normalized loads, finite bounded action, or reflection equivariance worsens; refit or remove the proxy under a different carrier
