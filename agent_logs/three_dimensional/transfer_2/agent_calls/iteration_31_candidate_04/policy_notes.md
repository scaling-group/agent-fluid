# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent guidance establishes v41 as the best sampled terminal
  allocator and v42/v43 as complementary negative controls: moving posterior
  rejected effort into the anterior phase anchor or scaling the anterior
  increment down to match posterior survival both retained capture but worsened
  distance, score, and crossing margin. The inherited workspace contains no
  `logs/optimize/` provenance from those parents, so no absent log is treated
  as evidence.
- All four current solver samples contain the same v41 policy, byte-identical
  `4480`-row trajectory, and byte-identical combined keyframe sheet. They
  independently report direct uniform `U_infinity=[0,0,0]` initialization,
  capture at `24.6400146T` and `0.748356L`, mean distance `2.347937L`, zero
  sampled posterior hard-stop occupancy, about `13.84%` exact-rate exposure,
  and low peak planar force/yaw-moment coefficients near
  `0.0254/0.0319/0.0156`. The samples provide replicated positive evidence,
  but no distinct failure keyframe; failure-topology comparisons are therefore
  limited to the assigned parent's completed textual evidence.

## Two-view visual diagnosis

- In the top-down vorticity row, the fish leaves the release under its own
  power and develops an alternating, spatially coherent wake rather than being
  advected by background flow. The long approach is smooth; the wake and body
  path bend materially only in the final hook around the target. There is no
  visible collision or domain-exit precursor.
- In the oblique Lambda2 row, the alternating planar lobes correspond to
  discrete three-dimensional loop structures that persist behind the moving
  fish. The terminal hook remains coherent instead of breaking into a broad
  unstable plume. This agrees with monotone distance progress, capture, the
  low force/moment class, and `unstable=false` in diagnostics.
- The narrow `0.001644L` crossing margin and high posterior occupancy near
  `-44 deg` make terminal actuator allocation—not missing propulsion or wake
  coherence—the remaining local weakness. A fixed-trace audit finds v41's
  extra terminal residual active only from `2.099L` inward. Across its 245
  active parent samples, the posterior velocity has the residual's sign on 148
  samples (the terminal increment adds motion toward the occupied side) and
  the opposite sign on 97 samples (the increment opposes the inward stroke).

## One candidate hypothesis

Preserve v41's route request, course/miss corridor, anterior phase allocation,
carrier, stroke braking reserve, and posterior rate coast. Split only the
already-bounded terminal increment at the actuator: keep the anterior
increment exactly as v41, while multiplying the posterior increment by a
smooth gate derived from posterior angle and velocity. The gate approaches one
on the observed inward stroke and zero on the outward stroke as predicted
stroke enters the existing reserve; away from that reserve it is exactly one
and restores v41. It cannot add terminal authority or transfer rejected effort
to the other joint. This is intended to retain the coherent captured hook
while avoiding a terminal follower pulse that the joint-local stroke reserve
must immediately reject.

Falsify the mechanism if it changes any command outside `2.10L`, loses
capture, fails to improve the `0.001644L` crossing margin or load/rate class,
materially enlarges either joint's command envelope, or changes the coherent
far trajectory. Even a nominal improvement would not establish reflected-pose
or disturbed-flow robustness.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and asymmetric flapping
source_mechanism: infer the useful steering half-cycle from observed joint state and modulate the rhythmic follower without replacing the propulsive carrier
transferable_invariant: a bounded steering residual should be phase-aware, and a stroke-limited follower should receive it preferentially when the observed joint motion is returning inward rather than spending positive work farther toward the occupied side
nontransferable_details: published CPG gains, duty ratios, dimensional frequencies, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: retain v41 on the anterior joint; as predicted posterior stroke enters the existing reserve, multiply only the posterior terminal residual by a smooth mirror-even gate from posterior angle and velocity normalized by the owned carrier and actuator scales, then retain the existing joint-local stroke and rate safety filters
falsification: reject if capture or far-route identity is lost, crossing margin or load/rate class fails to improve, the command envelope grows materially, or reflected tests show the gate suppresses necessary corrective steering

## Static and contract audits

An initial fixed-trace audit of the inward-motion gate, before adding the final
stroke-pressure blend, changed 238 rows from `2.098608L` through `0.765356L`;
the anterior output and every output outside `2.10L` were exactly identical.
Its maximum posterior output difference was `0.19137 rad/T^2`, only `0.61%` of
the owned acceleration envelope. Withdrawing an outward terminal counter-
steer exposed up to `0.16353 rad/T^2` more of the inherited inward braking
command on 143 fixed-trace rows; this is not new steering authority, but it
means the proper falsification boundary is material envelope growth rather
than literal pointwise nonincrease of total command. The final blend
multiplies that withdrawal by bounded predicted stroke pressure and therefore
restores v41 away from the reserve. Direct probes confirm a centered posterior
state has motion gate `1.0`, an outward state at `44 deg` has gate `0.0481`,
and its reflected state has the identical even gate with opposite signed
terminal outputs. The formal finite-action/schema and boundary checks pass;
no CFD result is claimed for this unevaluated candidate.
