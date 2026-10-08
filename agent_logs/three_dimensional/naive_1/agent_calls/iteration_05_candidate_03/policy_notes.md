# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled rollouts satisfy the direct-uniform still-water contract:
`U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. Their top-down
and oblique sheets show self-propelled motion with an alternating,
three-dimensional posterior wake, so this iteration is not a thrust-recovery
experiment.

The anterior-only mean-curvature policy `solver_f6a7d17d24de` is the strongest
finite example. Its top-down row shows a long down-left trajectory rather than
the common early upward hook, and the oblique Lambda2 row retains a coherent
posterior vortex chain through `28.59T`. It reaches `5.033L`, versus
`9.402--10.062L` for the other current samples, but passes below the target and
leaves the lower boundary with distance back at `9.084L`. The trace explains
the miss: from about `10T` onward its one-second mean bearing grows from about
`28 deg` to `66--80 deg`, while the mean-curvature request is already pinned
near its `+8 deg` limit. The cycle-mean heading then remains roughly
`42--48 deg`; distance bottoms at `17.56T` and reverses. Both joint rates still
touch `260 deg/T`, so simply enlarging the static center is not a clean answer.

The three informative failures preserve the wake but leave through the upper
boundary near `10.64--11.20T`. The signed half-cycle rectifier
`solver_882a60521f5f` reaches `10.062L`; the two policies that hand authority
from rectification to a large-error mean center reach `9.955L` and `9.402L`.
Their mean-curvature gates are inactive at the initial `0.155 rad` bearing and
all retain the early high-exit topology. The assigned-parent logs show the
same progression: common or posterior mean offsets suppressed or distorted
the useful carrier, anterior phase-selective steering improved progress, and
the inherited rectifier-to-center handoff still exited high. Thus the evidence
supports the strong sample's always-available anterior center and centered
posterior lag, but falsifies turning that center off at modest route error.

## One candidate hypothesis

Preserve the strong sample's state-feedback carrier, slip-unloaded target
request, always-available bounded anterior mean curvature, and zero-mean
posterior lag. Add one large-error, phase-speed-demodulated signed residual on
joint 1. The residual is absent for modest bearing and rises smoothly only
when geometric bearing shows that the static center has run out of turning
authority; it strengthens the requested stroke and brakes the opposing stroke
without adding posterior mean bend or a clock. This is the shelf's bounded
burst-redirect/asymmetric-flapping invariant translated as state feedback,
not a larger static-bias gain.

The expected semantic change is that the fish retains the long coherent wake
and early down-left progress of `f6a7d17d24de`, but bearing no longer plateaus
near `65--80 deg`: the phase-selective boost should bend the course back toward
the target before distance reverses. Reject the mechanism if it recovers the
common upper exit, leaves below with the same large bearing plateau, loses the
alternating posterior wake, worsens rate saturation or load spikes, or fails
to match the `5.033L` sampled minimum. The new candidate's CFD outcome is not
available in this worker and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish asymmetric flapping
source_mechanism: large route error recruits phase-selective stroke asymmetry on top of a continuing bounded mean bend
transferable_invariant: when bounded static curvature preserves propulsion but exhausts its turning authority, persistent body-frame target error may recruit a bounded phase-selective redirect that releases as the error falls
nontransferable_details: published gains, dimensional beat settings, species-specific C-start kinematics, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: smooth absolute body-frame bearing gates a signed anterior acceleration residual demodulated by observed joint speed, while bearing-minus-normalized lateral velocity retains the bounded mean center and the posterior joint retains only the centered lagged carrier
falsification: reject if bearing remains on the sampled 65--80 degree plateau, the same lower or upper boundary exit persists without a better minimum, the posterior wake collapses, or joint-rate saturation and loads materially worsen
