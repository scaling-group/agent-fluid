# Candidate visual diagnosis and policy hypothesis

## Evidence read before the edit

All four sampled rollouts and the assigned-parent inherited rollout satisfy the
experiment contract: direct uniform `U_infinity=[0,0,0]` initialization, no
cylinders, no prewarm snapshot, and stable CFD until virtual-domain exit. The
combined sheets show that each policy self-propels rather than being advected.
Their top-down rows contain a strong alternating caudal vortex street, and the
oblique Lambda2 rows retain discrete three-dimensional posterior structures.
The missing capability is therefore route redirection, not wake formation or
basic thrust.

The assigned parent's durable guidance identifies the anterior-only moving
center and centered posterior lag as the first architecture to replace the
early upper exit with a long southwest trajectory. The corresponding sampled
policy `solver_f6a7d17d24de` retains its coherent wake to `28.59T`, but its
bearing grows above `1.2 rad`, distance bottoms at `5.033L`, and it passes below
the target before leaving at `y=0.800L`. Its two-second mean joint-1 angle is
already about `0.15--0.16 rad` during the miss, so the `8 deg` mean center is
exhausted while the broad carrier continues producing thrust.

The four later mechanisms all preserve the same lower-exit topology. The
assigned-parent phase-speed residual reaches `4.859L` and raises mean joint-1
bend to about `0.19 rad`, but heading remains near `0.73 rad` and the visible
wake/course are materially unchanged. Target-signed slip unloading and
yaw-response unloading reach `4.252L` and `4.376L`; neither prevents bearing
from climbing above `1 rad`. The most informative current sample is posterior
carrier relief (`solver_c039fddba4d9`): it improves closest approach to
`4.233L`, extends survival to `31.87T`, halves much of the late acceleration-cap
occupancy, and briefly moves the two-second mean heading in the corrective
direction from about `0.663` to `0.625 rad` between `14T` and `16T`. But its
error-only 65% tail relief never establishes a redirect; mean bearing still
rises to about `1.42 rad`, heading then grows past `1 rad`, and the fish exits
below. This supports temporarily yielding propulsive authority to curvature,
but falsifies another small phase residual, slip algebra change, or scalar-only
tail-relief adjustment as the next architectural test.

## One candidate hypothesis

Retain the evidenced state-feedback oscillator, anterior-only steering center,
and posterior lag built from the centered carrier. Add one continuous C-bend
gait transition. Modest bearing retains the inherited `8 deg` mean center and
full traveling wave. Large absolute body-frame bearing smoothly recruits
additional bounded anterior curvature while shrinking the oscillatory carrier
about that center; because the posterior target is derived from the same
shrunk carrier, posterior thrust also yields without acquiring a steering
mean. Falling bearing continuously restores the cruise wave. At full redirect,
the `24 deg` center and `7 deg` carrier remain comfortably inside the `45 deg`
joint envelope; the acceleration and rate guards remain owned by the episode.

The expected semantic change is a visible turn back toward the target before
the current `4.2--4.9L` fly-by, rather than merely a later point on the same
southwest arc. Reject the mechanism if it loses the early alternating 3D wake,
fails to beat the `4.233L` sampled minimum, retains a bearing plateau above
`1 rad` and the lower exit, creates persistent angle/rate saturation or load
spikes, or quiets the carrier without producing corrective yaw. The new
candidate's CFD outcome is not yet available and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological C-start redirection and closed-loop robotic-fish gait modulation
source_mechanism: large target error recruits a bounded high-curvature low-amplitude redirect, then alignment releases the body back into its propulsive rhythm
transferable_invariant: when a stable traveling wave outruns bounded cruise steering, persistent body-frame target error may temporarily trade oscillatory propulsion for stronger curvature and must restore propulsion continuously as that error falls
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat frequencies, robot linkage geometry, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: absolute body-frame bearing smoothly increases only the anterior oscillator center while shrinking the centered joint-state carrier that drives both the anterior oscillator and zero-mean posterior lag; decreasing bearing reverses that scheduling without a clock or hidden stage
falsification: reject if the coherent wake is lost before redirection, closest approach fails to improve on 4.233L, bearing remains above 1 rad through the fly-by, the same lower-domain exit persists, or joint saturation and hydrodynamic loads materially worsen
