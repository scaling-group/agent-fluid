# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`U_infinity=[0,0,0]`, no cylinders, no prewarm snapshot, and no numerical
instability. Their motion is self-propelled. The combined top-down sheets show
the fish laying down a long southwest-going wake, and the oblique sheets show
three-dimensional alternating caudal structures rather than passive
advection.

The assigned parent's anterior-only mean center with a zero-mean posterior
carrier is still the useful base. In `solver_f6a7d17d24de` it retains a
discrete alternating wake through `28.59T`, changes the old upper hook into a
long lower-going trajectory, and reaches `5.033L`. It then passes below the
target and exits at `9.084L`; bearing grows from `0.155 rad` initially to
`1.455 rad` near `18T` even though the `14--20T` mean anterior angle is already
about `0.153 rad`. This confirms the inherited diagnosis that an `8 deg`
anterior center preserves propulsion but exhausts its turning authority.

The prefilled posterior-relief descendant `solver_c039fddba4d9` is the
strongest scalar and closest-distance sample. Relative to the base, it lowers
minimum distance from `5.033L` to `4.233L`, lowers mean distance from `8.729L`
to `8.611L`, extends the episode from `28.59T` to `31.87T`, and reduces tail
rate-cap occupancy from about `13.4%` to `5.2%`. The views and trace show the
intended loss of late tail authority without an unstable wake. This is a
narrow positive result, but not route control: it still exits below the
target, and at the `19.25T` closest approach bearing is `1.405 rad`; it reaches
`1.512 rad` near `20T` before distance reverses. Posterior relief slows the
miss but does not supply the missing yaw moment.

The target-signed slip variant independently reaches `4.252L` and the same
lower-exit topology, so changing slip rectification alone is not a reliable
escape. The yaw-response descendant reaches `4.376L`, but its top-down wake
becomes nearly steady and its oblique Lambda2 structures disappear after
roughly `18T`; joint motion and commanded acceleration decay nearly to zero
while inertia carries it to the lower boundary. Direct recent-yaw unloading
therefore risks settling the state-feedback carrier and is not retained.

## One candidate hypothesis

Preserve the prefilled slip-aware anterior center, zero-mean posterior lag,
and evidence-positive large-bearing tail relief. Add one large-bearing
phase-selective anterior redirect. The same smooth geometric-bearing gate that
reduces posterior propulsion recruits a bounded acceleration in the target
bend direction, scaled by observed anterior joint speed. It strengthens the
requested stroke and brakes the opposing stroke, but vanishes at stroke
reversal and at small bearing. This adds redirect authority without copying a
clocked C-start, imposing posterior mean curvature, or using the recent-yaw
feedback that collapsed one sampled gait.

The expected semantic change is that the coherent early approach remains,
but once bearing enters the sampled `0.45--0.90 rad` miss regime, anterior
stroke asymmetry and tail relief act together to reduce bearing before the
fish passes below the target. Reject the mechanism if minimum distance does
not beat `4.233L`, bearing stays above about `1 rad`, the same lower-domain
exit remains, the alternating wake collapses, or anterior rate saturation and
load spikes materially worsen.

bookshelf_consulted: true
source_domain: biological burst redirects and closed-loop robotic-fish asymmetric flapping
source_mechanism: persistent route error recruits a phase-selective steering stroke while cruise propulsion is temporarily unloaded
transferable_invariant: when bounded mean curvature is already saturated, observed large target bearing may strengthen the requested stroke and brake its opposite while posterior thrust yields, with both effects released by restored alignment
nontransferable_details: species-specific C-start shapes, published gains, dimensional beat frequency, robot linkage geometry, prescribed maneuver timing, exact vortex phase, and task-specific routes
policy_translation: smoothly gate a target-signed anterior acceleration residual by normalized observed joint speed and absolute body-frame bearing, using the same gate to retain the sampled posterior-carrier relief
falsification: reject if closest approach does not beat 4.233L, large bearing and lower exit persist, the posterior wake or carrier collapses, or rate-cap occupancy and hydrodynamic loads materially worsen
