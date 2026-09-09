# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance and inherited worker logs establish that the
  joint-state oscillator is self-propelling in direct-uniform still water and
  that restrained target-relative mean curvature changes the seed's early
  upper exit into a useful left/down approach. All sampled evaluations use
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm snapshot, so the route
  differences are controller evidence rather than advection or initialization.
- Both the top-down vorticity and oblique body/Lambda2 rows were inspected for
  the four sampled solvers. They all retain long alternating wakes and finite
  motion. The prefilled half-cycle booster reaches `3.587L` and exits below at
  `25.872T`; its two acceleration commands each clamp for roughly `75%` of
  logged steps, so adding effort on the toward-bend half-cycle is not supported.
- The alignment-gated posterior carrier is the strongest completed comparator:
  it improves distance from `12.328L` to `2.443L`, retains a coherent 3D wake,
  and survives to `31.097T`. At its closest approach (`17.869T`) the target is
  mostly lateral in the body frame (full direction about `1.42 rad`) while
  forward speed remains about `0.669 U`; distance then rises and the fish
  continues to the lower boundary. This is a powered cross-track near miss,
  not wake collapse, passive drift, or numerical instability.
- Three completed variants did not change that topology. A distance-only
  approach envelope reaches `2.845L`; full target-direction posterior gating
  reaches `2.494L`; and an away-half-cycle brake reaches `2.501L`. All recede
  from the target and exit the lower boundary near `29--31T`. Full direction
  fixes the acute-bearing alias after pass-behind, but its negative result
  shows that preserving error and lowering posterior thrust alone do not
  supply the missing redirect. The distance result likewise shows that
  proximity without measured approach response coasts too soon or too weakly.

## Policy hypothesis

Preserve the strongest sample's `7 deg` cruise curvature, evidenced yaw-rate
release, state-feedback phase carrier, posterior alignment gate, and command
reserve. Add one response-gated redirect: compute the full signed target
direction from normalized `target_body_L`, and continuously recruit a higher
bounded curvature limit only when large direction error coincides with stalled
or negative observed closing speed. During the successful far-field approach,
positive closing speed suppresses the redirect and leaves the sampled carrier
nearly unchanged. At the near miss, the response gate supplies turning
authority rather than merely reducing drive; full direction keeps that request
active if the target passes behind.

Expected evidence is the same coherent left/down approach through the current
near-target neighborhood, then a decisive correct-sign heading change as
closing speed vanishes, with a closest approach below `2.443L` and no repeated
lower exit. Falsify the mechanism if early wake or progress deteriorates, it
recreates the inherited short-wake tight curl, the same powered pass-below
trajectory remains, or acceleration/rate-limit residence materially worsens.

```text
bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish direction tracking
source_mechanism: large target-direction error recruits a bounded redirect only when observed approach response is inadequate, then releases into the propulsive rhythm as alignment and closing recover
transferable_invariant: combine body-frame direction error with measured closing response to gate extra curvature while preserving the successful cruise carrier
nontransferable_details: biological C-start timing, published gains, dimensional beat settings, species kinematics, clocked CPG phase, exact vortex phase, and task-specific routes
policy_translation: full direction from normalized target_body_L and the body-frame target-ray projection of velocity_body_U form a continuous redirect weight that interpolates between evidenced cruise curvature and a finite redirect limit under the two-joint state-feedback contract
falsification: reject if far-field propulsion changes materially, the redirect has the wrong sign or recreates a tight release-time curl, closest approach does not beat 2.443L, the lower exit persists, or actuator-limit residence worsens
```
